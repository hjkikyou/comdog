package com.comdog.c2d.domain.order.dto;

import java.util.List;

/* OrderListDto, OrderDetailDto, OrderItemDto => 조회용(Select) : DB에서 데이터를 꺼내서 화면에 보여줄 때" 사용하는 조회용 DTO
   -> DTO(Response/View)
 
 * OrderRequestDto => 등록용(Insert) : 고객이 결제 버튼을 눌렀을 때 클라이언트(웹 브라우저)에서 서버로 날아오는 데이터 처리
 * 데이터를 깔끔하게 받기 위한 '수신 전용 택배 상자'
 	-> DTO(Request)
 	
 */

// 여러 개의 상품을 한 번에 받기 위한 구조 (List)
// 고객이 장바구니에서 여러 상품을 한 번에 결제한다고 가정 -> 
// 프론트엔드에서는 아래와 같이 데이터를 묶어서 서버로 보냅니다.
// 누가 결제했나? (memberId)
// 총 얼마인가? (totalAmount)
// 어떤 상품들인가? (items 리스트) -> 여기에 OrderItemDto가 활용


public class OrderRequestDto {
    private Long memberId;
    private Integer totalAmount;
    
    // 핵심 포인트: 여러 개의 상품을 리스트 형태로 한 번에 받습니다.
    private List<OrderItemDto> items; 

    public OrderRequestDto() {}

    // Getter & Setter
    public Long getMemberId() { return memberId; }
    public void setMemberId(Long memberId) { this.memberId = memberId; }

    public Integer getTotalAmount() { return totalAmount; }
    public void setTotalAmount(Integer totalAmount) { this.totalAmount = totalAmount; }

    public List<OrderItemDto> getItems() { return items; }
    public void setItems(List<OrderItemDto> items) { this.items = items; }
}