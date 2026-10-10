package com.comdog.c2d.domain.category;

import java.util.List;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.Context;
import com.comdog.c2d.domain.product.dto.ProductDto;
import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class ProductCategoryTemplateTest {
    @Autowired TemplateEngine templateEngine;
    @Test
    void paginationFragmentRendersOnStandaloneAdminAndUserPages() {
        var servletContext = new org.springframework.mock.web.MockServletContext();
        var request = new org.springframework.mock.web.MockHttpServletRequest(servletContext);
        request.setRequestURI("/admin/product/list");
        var response = new org.springframework.mock.web.MockHttpServletResponse();
        var application = org.thymeleaf.web.servlet.JakartaServletWebApplication.buildApplication(servletContext);
        var context = new org.thymeleaf.context.WebContext(application.buildExchange(request, response));
        context.setVariable("items", "tbody > tr[data-page-item]");
        context.setVariable("size", 10);
        String fragment = templateEngine.process("fragments/pagination", context);
        assertTrue(fragment.contains("data-pagination"));
        assertTrue(fragment.contains("data-page-size=\"10\""));
        assertTrue(fragment.contains("/js/pagination.js"));
        context.setVariable("viewProductList", List.of());
        String admin = templateEngine.process("admin/product/list", context);
        assertTrue(admin.contains("data-pagination"));
        assertTrue(admin.contains("data-page-size=\"10\""));
    }
    @Test
    void sortingFormKeepsSearchAndCategoryAndMarksTheSelectedButton() {
        var servletContext = new org.springframework.mock.web.MockServletContext();
        var request = new org.springframework.mock.web.MockHttpServletRequest(servletContext);
        request.setRequestURI("/user/product/purchase_list");
        var response = new org.springframework.mock.web.MockHttpServletResponse();
        var application = org.thymeleaf.web.servlet.JakartaServletWebApplication.buildApplication(servletContext);
        var context = new org.thymeleaf.context.WebContext(application.buildExchange(request, response));
        context.setVariable("route", "/user/product/purchase_list");
        context.setVariable("selectedCategory", 3L);
        context.setVariable("searchKeyword", "삼성");
        context.setVariable("selectedSort", "price_asc");
        String html = templateEngine.process("fragments/product-sort", context);
        assertTrue(html.contains("action=\"/user/product/purchase_list\""));
        assertTrue(html.contains("name=\"categoryId\" value=\"3\""));
        assertTrue(html.contains("name=\"keyword\" value=\"삼성\""));
        assertTrue(html.contains("value=\"price_asc\" class=\"sort-btn sort-btn--active\""));
        assertTrue(html.contains("↑"));
        assertTrue(html.contains("↓"));
    }
    @Test
    void sharedSelectorRendersCategoryOptionsAndValidationError() {
        CategoryDto category = new CategoryDto();
        category.setCategoryId(8L);
        category.setName("PC 부품/업그레이드");
        ProductDto product = new ProductDto();
        product.setProductId(1L);
        product.setCategoryId(8L);
        Context context = new Context();
        context.setVariable("categories", List.of(category));
        context.setVariable("viewProduct", product);
        context.setVariable("selectedId", 8L);
        context.setVariable("categoryError", "하위 카테고리까지 선택하세요.");
        // Context-relative URLs need an IWebContext; inspect the fragment itself here.
        String html = templateEngine.process("fragments/product-category", context);
        assertTrue(html.contains("PC 부품/업그레이드"));
        assertTrue(html.contains("data-level=\"2\""));
        assertTrue(html.contains("name=\"categoryId\""));
        assertTrue(html.contains("하위 카테고리까지 선택하세요."));
    }
}
