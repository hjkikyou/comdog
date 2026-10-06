package com.comdog.c2d.domain.cart.dto;

import java.math.BigDecimal;

public class CartItemDto {

    private Long cartId;        // 장바구니 고유번호 (cart.cart_id)
    private Long memberId;      // 사용자 고유번호
    private Long productId;     // 상품 고유번호

    private String rentalType;  // 'RENTAL' | 'SUBSCRIPTION'
    private Integer duration;   // 약정 기간(개월) - RENTAL일 경우
    private Integer quantity;   // 수량

    // ── 화면 표시용 (JOIN으로 가져올 product 정보) ──
    private String name;        // 상품명 (product.name)
    private String brand;       // 브랜드 (product.brand)
    private String modelName;   // 모델명 (product.model_name)
    private BigDecimal basePrice; // 기본 가격 (product.base_price)

    // ── Getters & Setters ──

    public Long getCartId() { return cartId; }
    public void setCartId(Long cartId) { this.cartId = cartId; }

    public Long getMemberId() { return memberId; }
    public void setMemberId(Long memberId) { this.memberId = memberId; }

    public Long getProductId() { return productId; }
    public void setProductId(Long productId) { this.productId = productId; }

    public String getRentalType() { return rentalType; }
    public void setRentalType(String rentalType) { this.rentalType = rentalType; }

    public Integer getDuration() { return duration; }
    public void setDuration(Integer duration) { this.duration = duration; }

    public Integer getQuantity() { return quantity; }
    public void setQuantity(Integer quantity) { this.quantity = quantity; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getBrand() { return brand; }
    public void setBrand(String brand) { this.brand = brand; }

    public String getModelName() { return modelName; }
    public void setModelName(String modelName) { this.modelName = modelName; }

    public BigDecimal getBasePrice() { return basePrice; }
    public void setBasePrice(BigDecimal basePrice) { this.basePrice = basePrice; }
}
