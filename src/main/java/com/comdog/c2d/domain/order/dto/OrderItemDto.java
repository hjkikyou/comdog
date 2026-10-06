package com.comdog.c2d.domain.order.dto;


/* 상세 화면이나 장바구니에 들어갈 개별 상품 정보 */
public class OrderItemDto {
    
    private String productName; // 상품명
    private Integer orderPrice; // 구매 가격
    private Integer count;      // 수량

    // 기본 생성자 (MyBatis나 스프링이 객체를 생성할 때 필요할 수 있습니다)
    public OrderItemDto() {
    }

    // --- 아래부터는 Getter와 Setter 입니다 ---

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public Integer getOrderPrice() {
        return orderPrice;
    }

    public void setOrderPrice(Integer orderPrice) {
        this.orderPrice = orderPrice;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }
}