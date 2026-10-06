package com.comdog.c2d.domain.order.dto;

import java.time.LocalDateTime;
import java.util.List;

/* 상세 화면용 (연락처, 배송지 등) */
public class OrderDetailDto {
    // 1. 주문 정보
    private Long orderId;
    private Integer totalAmount;
    private String orderStatus;
    private String paymentMethod;
    private String billingKey; // 리스트에서 숨겼던 빌링키를 상세에서 보여줌
    private String trackingNumber;
    private LocalDateTime createdAt;
    
    // 2. 회원 정보 -- member table과 join 필요
    private Long memberId;
    private String memberName;
    private String memberPhone; // 연락처 추가
    private String memberEmail; // 이메일 추가
    
    // 3. 상품 정보 -- product table과 join 필요
    private List<OrderItemDto> orderItems; // 주문한 상품 목록
    
    /* getter & setter */

	public Long getOrderId() {
		return orderId;
	}

	public void setOrderId(Long orderId) {
		this.orderId = orderId;
	}

	public Integer getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(Integer totalAmount) {
		this.totalAmount = totalAmount;
	}

	public String getOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}

	public String getPaymentMethod() {
		return paymentMethod;
	}

	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}

	public String getBillingKey() {
		return billingKey;
	}

	public void setBillingKey(String billingKey) {
		this.billingKey = billingKey;
	}
	
	public String getTrackingNumber() {
        return trackingNumber;
    }

    public void setTrackingNumber(String trackingNumber) {
        this.trackingNumber = trackingNumber;
    }

	public LocalDateTime getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}

	public Long getMemberId() {
		return memberId;
	}

	public void setMemberId(Long memberId) {
		this.memberId = memberId;
	}

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}

	public String getMemberPhone() {
		return memberPhone;
	}

	public void setMemberPhone(String memberPhone) {
		this.memberPhone = memberPhone;
	}

	public String getMemberEmail() {
		return memberEmail;
	}

	public void setMemberEmail(String memberEmail) {
		this.memberEmail = memberEmail;
	}

	public List<OrderItemDto> getOrderItems() {
		return orderItems;
	}

	public void setOrderItems(List<OrderItemDto> orderItems) {
		this.orderItems = orderItems;
	}
    
  
}