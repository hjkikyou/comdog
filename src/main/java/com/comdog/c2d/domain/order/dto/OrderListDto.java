package com.comdog.c2d.domain.order.dto;

import java.time.LocalDateTime;

/* 목록 화면용 (주문자명, 결제일시 등) */

public class OrderListDto {
 private Long orderId;
 private LocalDateTime createdAt;
 private Integer totalAmount;
 private String orderStatus;
 private String paymentMethod;
 
 private String memberName;        // 회원 테이블에서 가져올 데이터
 private String productName;       // 상품 테이블에서 가져올 데이터
 private String trackingNumber;   // 배송 테이블에서 가져올 데이터

 public Long getOrderId() {
	return orderId;
}
public void setOrderId(Long orderId) {
	this.orderId = orderId;
}
public LocalDateTime getCreatedAt() {
	return createdAt;
}
public void setCreatedAt(LocalDateTime createdAt) {
	this.createdAt = createdAt;
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
public String getMemberName() {
	return memberName;
}
public void setMemberName(String memberName) {
	this.memberName = memberName;
}
public String getProductName() {
	return productName;
}
public void setProductName(String productName) {
	this.productName = productName;
}
public String getTrackingNumber() {
	return trackingNumber;
}
public void setTrackingNumber(String trackingNumber) {
	this.trackingNumber = trackingNumber;
}
 
 // 보안상 위험한 billingKey, memberId 등은 애초에 넣지 않음!
}
