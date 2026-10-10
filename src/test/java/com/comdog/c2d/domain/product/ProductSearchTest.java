package com.comdog.c2d.domain.product;

import java.util.UUID;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.transaction.annotation.Transactional;
import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
@Transactional
class ProductSearchTest {
    @Autowired JdbcTemplate jdbc;
    @Autowired ProductService service;

    @Test
    void searchMatchesNamesAndIncludesDescendantsButExcludesUnavailableProducts() {
        String marker = "search-" + UUID.randomUUID();
        jdbc.update("INSERT INTO category(name, parent_id) VALUES (?, NULL)", marker);
        Long root = jdbc.queryForObject("SELECT LAST_INSERT_ID()", Long.class);
        jdbc.update("INSERT INTO category(name, parent_id) VALUES (?, ?)", marker + "-middle", root);
        Long middle = jdbc.queryForObject("SELECT LAST_INSERT_ID()", Long.class);
        jdbc.update("INSERT INTO category(name, parent_id) VALUES (?, ?)", marker + "-leaf", middle);
        Long leaf = jdbc.queryForObject("SELECT LAST_INSERT_ID()", Long.class);
        add(leaf, marker + " 삼성 모니터", "Y", "N");
        add(null, marker + " 삼성 노트북", "Y", "N");
        add(leaf, marker + " 구매불가", "N", "N");
        add(leaf, marker + " 삭제상품", "Y", "Y");
        add(leaf, marker + " 100%_모니터", "Y", "N");
        assertEquals(3, service.searchPurchasableProducts(null, marker).size());
        assertEquals(2, service.searchPurchasableProducts(root, marker).size());
        assertEquals(2, service.searchPurchasableProducts(middle, marker).size());
        assertEquals(1, service.searchPurchasableProducts(root, "  " + marker + " 삼성  ").size());
        assertEquals(1, service.searchPurchasableProducts(root, marker + " 100%_").size());
        assertEquals(0, service.searchPurchasableProducts(root, marker + " 없는상품").size());
    }

    @Test
    void allSortModesUseTheirOwnMetricsAndUnknownSortFallsBackToRecommended() {
        String marker = "sort-" + UUID.randomUUID();
        add(null, marker + " A", "Y", "N");
        Long a = jdbc.queryForObject("SELECT LAST_INSERT_ID()", Long.class);
        add(null, marker + " B", "Y", "N");
        Long b = jdbc.queryForObject("SELECT LAST_INSERT_ID()", Long.class);
        add(null, marker + " C", "Y", "N");
        Long c = jdbc.queryForObject("SELECT LAST_INSERT_ID()", Long.class);
        jdbc.update("UPDATE product SET base_price=300, is_recommended='Y', created_at='2020-01-01' WHERE product_id=?", a);
        jdbc.update("UPDATE product SET base_price=100, created_at='2022-01-01' WHERE product_id=?", b);
        jdbc.update("UPDATE product SET base_price=200, created_at='2021-01-01' WHERE product_id=?", c);
        Long member = jdbc.queryForObject("SELECT MIN(member_id) FROM member", Long.class);
        Long contract = jdbc.queryForObject("SELECT MIN(contract_id) FROM contract", Long.class);
        jdbc.update("INSERT INTO orders(member_id,total_amount,order_status,payment_method) VALUES (?,100,'결제완료','TEST')", member);
        Long paidOrder = jdbc.queryForObject("SELECT LAST_INSERT_ID()", Long.class);
        jdbc.update("INSERT INTO order_item(order_id,product_id,order_price,count) VALUES (?,?,100,2)", paidOrder, b);
        jdbc.update("INSERT INTO order_item(order_id,product_id,order_price,count) VALUES (?,?,200,5)", paidOrder, c);
        jdbc.update("INSERT INTO orders(member_id,total_amount,order_status,payment_method) VALUES (?,100,'주문취소','TEST')", member);
        Long cancelledOrder = jdbc.queryForObject("SELECT LAST_INSERT_ID()", Long.class);
        jdbc.update("INSERT INTO order_item(order_id,product_id,order_price,count) VALUES (?,?,300,100)", cancelledOrder, a);
        jdbc.update("INSERT INTO review(member_id,product_id,contract_id,rating,content) VALUES (?,?,?,5,'test')", member, a, contract);
        jdbc.update("INSERT INTO review(member_id,product_id,contract_id,rating,content) VALUES (?,?,?,3,'test')", member, a, contract);
        jdbc.update("INSERT INTO review(member_id,product_id,contract_id,rating,content) VALUES (?,?,?,5,'test')", member, c, contract);
        assertOrder(marker, "recommended", a, b, c);
        assertOrder(marker, "newest", b, c, a);
        assertOrder(marker, "sales", c, b, a);
        assertOrder(marker, "rating", c, a, b);
        assertOrder(marker, "price_desc", a, c, b);
        assertOrder(marker, "price_asc", b, c, a);
        assertOrder(marker, "invalid", a, b, c);
        assertOrder(marker, null, a, b, c);
    }

    private void assertOrder(String keyword, String sort, Long... ids) {
        assertEquals(java.util.List.of(ids), service.searchPurchasableProducts(null, keyword, sort)
                .stream().map(p -> p.getProductId()).toList());
    }

    private void add(Long categoryId, String name, String purchasable, String deleted) {
        jdbc.update("INSERT INTO product(category_id,name,brand,model_name,is_purchasable,is_deleted) VALUES (?,?,?,?,?,?)",
                categoryId, name, "검색 테스트", "테스트 모델", purchasable, deleted);
    }
}
