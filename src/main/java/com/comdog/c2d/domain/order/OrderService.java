package com.comdog.c2d.domain.order;

import java.util.List;
import java.util.Map;

import com.comdog.c2d.domain.order.dto.OrderDetailDto;
import com.comdog.c2d.domain.order.dto.OrderListDto;

public interface OrderService {

	//조회
	// Controller가 던진 걸 DAO로 
	List<OrderListDto> findAllOrders();
	
	//상세 조회
	OrderDetailDto findOrderDetail(Long orderId);

	//주문 상태 변경
	// 반환값이 굳이 필요 없으므로 void나 int(수정된 행의 개수)를 사용
	// 업데이트 결과값이 굳이 필요 없을 때 => void, 제대로 수정되었는지 확인이 필요할 때 => int 
	void updateOrderStatus(Map<String, Object> params);

	// 주문 취소
	void cancelOrder(Long orderId);

}
