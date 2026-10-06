package com.comdog.c2d.domain.order;

import java.util.List;
import java.util.Map;

import com.comdog.c2d.domain.order.dto.OrderDetailDto;
import com.comdog.c2d.domain.order.dto.OrderListDto;


public interface OrderDao {
	
	// 조회 
	
	// Service가 던진 걸 map으로 받아서 MyBatis로 최종 전달!
	List<OrderListDto> findAllOrders();

	
	
	//자료형인 Map<String, String>만 동일하게 맞춰주면 됩니다.
	//변수명은 각 파일에서 부르기 편한 이름으로 마음대로 지으셔도 자바가 알아서 척척 데이터를 넘겨줍니다.
	//"Map이라는 바구니에 담긴 데이터를 다음 메서드로 계속 던져준다"는 흐름만 이어줌
		
	//상세 조회
	OrderDetailDto findOrderDetail(Long orderId);


	//주문 상태 변경
	void updateOrderStatus(Map<String, Object> map);


	//주문 취소
	void cancelOrder(Long orderId);

}
