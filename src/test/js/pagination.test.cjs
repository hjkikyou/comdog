const { test } = require('node:test');
const assert = require('node:assert/strict');
const PageGroups = require('../../main/resources/static/js/pagination.js');
const fs = require('node:fs');
const vm = require('node:vm');

test('next starts at six and previous restores the selected page', () => {
    const pages = new PageGroups(68);
    pages.select(3);
    pages.next();
    assert.equal(pages.page, 6);
    assert.equal(pages.start, 6);
    assert.equal(pages.end, 10);
    pages.select(8);
    pages.previous();
    assert.equal(pages.page, 3);
    pages.next();
    assert.equal(pages.page, 6);
});
test('history is maintained independently for several groups', () => {
    const pages = new PageGroups(68);
    pages.select(4);
    pages.next();
    pages.select(9);
    pages.next();
    assert.equal(pages.page, 11);
    pages.previous();
    assert.equal(pages.page, 9);
    pages.previous();
    assert.equal(pages.page, 4);
});
test('boundaries and a partial final group never navigate out of range', () => {
    const pages = new PageGroups(12);
    pages.previous();
    assert.equal(pages.page, 1);
    pages.select(999);
    assert.equal(pages.page, 12);
    assert.equal(pages.start, 11);
    assert.equal(pages.end, 12);
    pages.next();
    assert.equal(pages.page, 12);
    const empty = new PageGroups(0, -1);
    assert.equal(empty.page, 1);
});
test('a direct visit uses the previous group first page without saved history', () => {
    const pages = new PageGroups(20, 13);
    pages.previous();
    assert.equal(pages.page, 6);
    const restored = new PageGroups(20, 6, { 1: 5 });
    restored.previous();
    assert.equal(restored.page, 5);
});

function mountPagination(count) {
    const scrollCalls = [];
    const search = { getBoundingClientRect() { return { top: 400 }; } };
    const header = { getBoundingClientRect() { return { height: 180 }; } };
    const items = Array.from({ length: count }, () => ({
        hidden: false,
        toggleAttribute(name, hidden) { this.hidden = hidden; }
    }));
    const nav = {
        dataset: { items: '.items', pageSize: '12' }, children: [],
        replaceChildren() { this.children = []; },
        append(button) { this.children.push(button); },
        querySelector() { return this.children.find(b => b.attributes['aria-current']); }
    };
    const location = { href: 'http://localhost/user/product/purchase_list?categoryId=3&keyword=삼성&sort=price_asc' };
    const storage = new Map();
    const document = {
        querySelector(selector) { return selector === '.filter-bar' ? search : selector === '.site-header' ? header : null; },
        querySelectorAll(selector) { return selector === '[data-pagination]' ? [nav] : items; },
        createElement() {
            return { attributes: {}, setAttribute(k, v) { this.attributes[k] = v; },
                addEventListener(event, callback) { this.click = callback; }, focus() {} };
        }
    };
    vm.runInNewContext(fs.readFileSync('src/main/resources/static/js/pagination.js', 'utf8'), {
        document, URL, URLSearchParams, window: { location, scrollY: 500, addEventListener() {}, scrollTo(options) { scrollCalls.push(options); } },
        history: { pushState(state, title, url) { location.href = String(url); } },
        sessionStorage: { getItem(k) { return storage.get(k); }, setItem(k, v) { storage.set(k, v); } }
    });
    return { items, nav, location, scrollCalls };
}

test('the DOM shows actual page items, five numbers and restores previous selection', () => {
    const { items, nav, location, scrollCalls } = mountPagination(132);
    const labels = () => nav.children.map(b => b.textContent);
    const click = label => nav.children.find(b => b.textContent === label).click();
    assert.deepEqual(labels(), ['이전', '1', '2', '3', '4', '5', '다음']);
    click('3');
    assert.equal(items.filter(i => !i.hidden).length, 12);
    assert.equal(items[24].hidden, false);
    assert.equal(items[23].hidden, true);
    click('다음');
    assert.deepEqual(labels(), ['이전', '6', '7', '8', '9', '10', '다음']);
    assert.equal(new URL(location.href).searchParams.get('page'), '6');
    assert.equal(items[60].hidden, false);
    click('이전');
    assert.equal(new URL(location.href).searchParams.get('page'), '3');
    assert.equal(new URL(location.href).searchParams.get('keyword'), '삼성');
    assert.equal(new URL(location.href).searchParams.get('sort'), 'price_asc');
    assert.equal(scrollCalls.length, 3);
    assert.equal(scrollCalls[1].behavior, 'smooth');
    assert.equal(scrollCalls[1].top, 696);
});

test('empty and small lists always show five numbers and disable unavailable pages', () => {
    for (const count of [0, 1, 12]) {
        const { nav } = mountPagination(count);
        assert.equal(nav.hidden, false);
        assert.deepEqual(nav.children.map(b => b.textContent), ['이전', '1', '2', '3', '4', '5', '다음']);
        assert.equal(nav.children[0].disabled, true);
        assert.equal(nav.children[6].disabled, true);
        assert.equal(nav.children.slice(2, 6).every(b => b.disabled), true);
        assert.equal(nav.children[1].attributes['aria-current'], 'page');
        assert.equal(nav.children[1].className, 'page-num page-num--active');
    }
});
