(function () {
    'use strict';
    class PageGroups {
        constructor(totalPages, page = 1, remembered = {}) {
            this.total = Math.max(1, totalPages);
            this.page = this.clamp(page);
            this.remembered = { ...remembered };
        }
        clamp(page) { return Math.min(this.total, Math.max(1, Number.isSafeInteger(page) ? page : 1)); }
        get start() { return Math.floor((this.page - 1) / 5) * 5 + 1; }
        get end() { return Math.min(this.total, this.start + 4); }
        select(page) {
            this.page = this.clamp(page);
            this.remembered[this.start] = this.page;
        }
        next() {
            if (this.end >= this.total) return;
            this.remembered[this.start] = this.page;
            this.select(this.start + 5);
        }
        previous() {
            if (this.start === 1) return;
            this.remembered[this.start] = this.page;
            const start = this.start - 5;
            const saved = Number(this.remembered[start]);
            this.select(saved >= start && saved <= start + 4 ? saved : start);
        }
    }
    if (typeof module !== 'undefined' && module.exports) module.exports = PageGroups;
    if (typeof document === 'undefined') return;
    document.querySelectorAll('[data-pagination]').forEach(nav => {
        if (nav.dataset.initialized) return;
        nav.dataset.initialized = 'true';
        const items = Array.from(document.querySelectorAll(nav.dataset.items));
        const size = Math.max(1, Number(nav.dataset.pageSize) || 12);
        const total = Math.max(1, Math.ceil(items.length / size));
        const url = new URL(window.location.href);
        const filters = new URLSearchParams(url.search);
        filters.delete('page');
        filters.sort();
        const key = 'comdog-pagination:' + url.pathname + '?' + filters + ':' + nav.dataset.items;
        let remembered = {};
        try {
            const saved = JSON.parse(sessionStorage.getItem(key) || '{}');
            if (saved && typeof saved === 'object' && !Array.isArray(saved)) remembered = saved;
        } catch (_) { /* Storage can be unavailable. In-memory navigation still works. */ }
        const state = new PageGroups(total, Number(url.searchParams.get('page') || 1), remembered);
        function render() {
            items.forEach((item, index) => item.toggleAttribute('data-page-hidden',
                index < (state.page - 1) * size || index >= state.page * size));
            nav.replaceChildren();
            nav.hidden = false;
            function button(label, action, disabled, current) {
                const button = document.createElement('button');
                button.type = 'button';
                button.textContent = label;
                button.disabled = disabled;
                button.className = current ? 'page-num page-num--active' : /^\d+$/.test(label) ? 'page-num' : 'page-btn';
                if (current) button.setAttribute('aria-current', 'page');
                button.addEventListener('click', () => {
                    action();
                    try { sessionStorage.setItem(key, JSON.stringify(state.remembered)); } catch (_) {}
                    const target = new URL(window.location.href);
                    target.searchParams.set('page', state.page);
                    history.pushState(null, '', target);
                    render();
                    nav.querySelector('[aria-current="page"]')?.focus({ preventScroll: true });
                    const search = document.querySelector('.filter-bar')
                        || document.querySelector('main form input[name="keyword"]')?.closest('form');
                    const anchor = search || items[0];
                    if (anchor) {
                        const header = document.querySelector('.site-header');
                        const headerHeight = header ? header.getBoundingClientRect().height : 0;
                        const top = anchor.getBoundingClientRect().top + window.scrollY - headerHeight - 24;
                        window.scrollTo({ top: Math.max(0, top), behavior: 'smooth' });
                    }
                });
                nav.append(button);
            }
            button('이전', () => state.previous(), state.start === 1, false);
            for (let p = state.start; p <= state.start + 4; p++) {
                button(String(p), () => state.select(p), p > state.total, p === state.page);
            }
            button('다음', () => state.next(), state.end === state.total, false);
        }
        state.select(state.page);
        render();
        window.addEventListener('popstate', () => {
            state.select(Number(new URL(window.location.href).searchParams.get('page') || 1));
            render();
        });
    });
})();
