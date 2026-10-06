package com.comdog.c2d.domain.b2b;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class B2bController {

	
	@GetMapping("/b2b")
	public String b2bLanding() {
	    return "user/b2b_landing"; // 별도 데이터 없이 정적 페이지로 사용 가능
	}
}
