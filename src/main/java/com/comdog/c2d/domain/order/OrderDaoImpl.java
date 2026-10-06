package com.comdog.c2d.domain.order;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.comdog.c2d.domain.order.dto.OrderDetailDto;
import com.comdog.c2d.domain.order.dto.OrderListDto;

@Repository
public class OrderDaoImpl implements OrderDao {
	
	@Autowired
	SqlSession sql;
	
	// 조회 [검색]
	@Override
	public List<OrderListDto> findAllOrders() {
		return sql.selectList("order.findAllOrders");
	}


	// 상세 조회
	@Override
	public OrderDetailDto findOrderDetail(Long orderId) {
		
		// 주의: List가 아니라 단 1건이므로 sql.selectOne()을 사용합니다!
		return sql.selectOne("order.findOrderDetail", orderId);
		// 범인: orderId인썼음...
	}


	// 주문 상태 변경
	@Override
	public void updateOrderStatus(Map<String, Object> map) {
		
		sql.update("order.updateOrderStatus", map);
		
	}


	// 주문 취소
	@Override
	public void cancelOrder(Long orderId) {
		
		sql.update("order.cancelOrder", orderId);
		
	}
	
}
