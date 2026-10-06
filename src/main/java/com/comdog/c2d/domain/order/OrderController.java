package com.comdog.c2d.domain.order;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.comdog.c2d.domain.order.dto.OrderDetailDto;
import com.comdog.c2d.domain.order.dto.OrderListDto;


@Controller
@RequestMapping("/admin/order")
public class OrderController {
	
	@Autowired
	OrderService service;
	
	
	// 1. 주문 목록 조회 (검색 추가)
	
	@GetMapping("/list")
    public String orderList(Model model) { 
		// Map을 서비스(그리고 DAO)로 넘겨주기
		List<OrderListDto> orderList;
    	orderList = service.findAllOrders();
		
		// 타임리프 화면(list.html)에서 사용할 수 있도록 model에 담아준다.
		// HTML에서 th:each="item : ${viewOrderList}"
		model.addAttribute("viewOrderList", orderList);
		
		// 뷰(화면) 페이지 이동
		return "admin/order/list";
		
	// 컨트롤러에서 search(예: 주문자명)와 keyword(예: 홍길동)를 받아서 서비스로 넘기도록 세팅
    
	}
	
	
	// 2. 주문 상세 조회 
	
	// 상세 페이지는 orderId 하나 단 1건의 데이터(DTO)만 가져옴. 
	// "주문 1건 당 상세 페이지기 때문에 orderId"
    
	@GetMapping("/detail/{orderId}")
	public String orderDetail(@PathVariable("orderId") Long orderId, Model model) {
	    
	    // 1. DB에서 진짜 데이터 가져오기 시도
	    OrderDetailDto orderDetail = service.findOrderDetail(orderId);
	    
	    /* 데이터가 없으면 가짜 데이터를 만드는 게 아니라, 목록으로 돌려보냅니다.
	    if (orderDetail == null) {
	    	return "redirect:/admin/order/list";
	    }*/
	    
	    
	    // 2. 완성된 바구니를 화면으로 넘기기
	    model.addAttribute("viewOrderDetail", orderDetail);
	    
	    return "admin/order/detail";
	}
	// 3. 주문 상태 변경 (또는 송장번호 입력)
	
	// 컨트롤러에서 받은 데이터를 데이터베이스까지 보내서 수정(UPDATE)하는 전체 흐름
	// SqlSession은 파라미터를 하나만 받을 수 있으므로, 컨트롤러에서 데이터를 Map으로 묶어서 던져주는 방식을 사용 
	// 받아온 3개의 파라미터(orderId, orderStatus, trackingNumber)를 Map에 담아 서비스로 넘겨줌
	
    @PostMapping("/updateStatus")
    public String updateOrderStatus
	    (@RequestParam("orderId") Long orderId, 
	     @RequestParam("orderStatus") String orderStatus,
	     @RequestParam(value = "trackingNumber", required = false) String trackingNumber) {
        
    	// TODO: DB에서 해당 주문의 상태(배송중 등)와 송장번호를 Update 처리
    	// 파라미터들을 Map에 담기 (Value 타입이 Long과 String이 섞여 있으므로 Object로 받습니다)
        Map<String, Object> params = new HashMap<>();
        params.put("orderId", orderId);
        params.put("orderStatus", orderStatus);
        params.put("trackingNumber", trackingNumber);
        
        // 서비스 단으로 Map 넘겨서 Update 실행
        service.updateOrderStatus(params);
        
        // 처리가 끝나면 다시 해당 주문의 상세 페이지로 새로고침(redirect)
        return "redirect:/admin/order/detail/" + orderId;
        
        
        //@GetMapping은 왜 없냐?
        // 회원 수정은 '수정 전용 화면'이 따로 필요하지만, 주문 상태 변경은 '상세 페이지' 안에서 바로 처리하기 때문
        // 관리자 페이지에서 주문 상태(결제완료 ➡️ 배송중)를 바꿀 때는 별도의 '주문 수정 전용 페이지'로 이동 X  
        // 고객의 주문 내역을 확인하는 '주문 상세 페이지(Detail)' 안에서 상태를 바꾸고 저장하는 것
        // 주문 상세 조회 메서드가 get의 역할 대신 함, 상세 페이지 안에서 상태 변경 처리
        // 요약 => 주문 수정: [주문 상세 (이게 GET 역할을 겸함!)] ➡️ [상태만 변경해서 저장 (POST)]
    }
	
    
    // 4. 주문 취소 (삭제 대신 상태 변경)
    // 소프트 딜리트(Soft Delete) 방식, 결제나 주문 관련 데이터는 문제가 생겼을 때 추적해야 하므로
    
    @GetMapping("/cancel/{orderId}")
    public String cancelOrder(@PathVariable("orderId") Long orderId) {
        
        // 1. 서비스로 orderId를 넘겨 상태 업데이트 실행
        service.cancelOrder(orderId);
        
        // 2. 처리가 완료되면 주문 목록 화면으로 되돌아감
        return "redirect:/admin/order/list";
    }
}
