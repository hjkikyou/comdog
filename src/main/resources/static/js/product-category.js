document.querySelectorAll('.category-selector').forEach(container => {
    const categories = Array.from(container.querySelector('[data-category-source]').options)
        .map(o => ({ id: o.value, parent: o.dataset.parent || '', name: o.text }));
    const selects = Array.from(container.querySelectorAll('[data-level]'));
    const hidden = container.querySelector('[name="categoryId"]');
    const initialId = hidden.value;
    const message = container.querySelector('[data-category-message]');
    const children = parent => categories.filter(c => c.parent === parent);
    function populate(level, parent) {
        const select = selects[level];
        const items = children(parent);
        select.replaceChildren(new Option('선택하세요', ''));
        items.forEach(c => select.add(new Option(c.name, c.id)));
        select.disabled = items.length === 0;
        select.required = items.length > 0;
    }
    function sync() {
        const chosen = selects.filter(s => s.value).at(-1);
        hidden.value = chosen ? chosen.value : '';
        const legacy = initialId && hidden.value === initialId && children(initialId).length > 0;
        selects.forEach(s => { s.required = !s.disabled && !legacy; });
        message.textContent = legacy ? '기존 분류를 유지하거나 하위 분류를 선택할 수 있습니다.' : '';
    }
    populate(0, '');
    const path = [];
    let current = categories.find(c => c.id === initialId);
    const visited = new Set();
    while (current && !visited.has(current.id)) {
        visited.add(current.id);
        path.unshift(current);
        current = categories.find(c => c.id === current.parent);
    }
    path.slice(0, 3).forEach((c, level) => {
        populate(level, level === 0 ? '' : path[level - 1].id);
        selects[level].value = c.id;
        if (level < 2) populate(level + 1, c.id);
    });
    sync();
    selects.forEach((select, level) => select.addEventListener('change', () => {
        for (let i = level + 1; i < selects.length; i++) {
            selects[i].replaceChildren(new Option('선택하세요', ''));
            selects[i].disabled = true;
        }
        if (select.value && level < 2) populate(level + 1, select.value);
        sync();
    }));
    container.closest('form').addEventListener('submit', event => {
        sync();
        if (!hidden.value || (children(hidden.value).length > 0 && hidden.value !== initialId)) {
            event.preventDefault();
            message.textContent = '하위 카테고리까지 선택하세요.';
        }
    });
});
