package com.comdog.c2d;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class UserRootController {

	
	 @GetMapping("/log-in")
	    public String loginForm(Model model) {
	        model.addAttribute("showHeader", false); // 로그인 페이지에서는 헤더를 숨김 처리!
	        return "user/auth/log-in";
	    }
	 
	 @GetMapping("/find-account")
	    public String findAccount(){
	        return "user/auth/find-account";
	    }
	 
	 
	 @GetMapping("/sign-up-first")
	    public String signUpFirst(){
	        return "user/auth/sign-up-first";
	    }
	 
	 @GetMapping("/sign-up-form")
	    public String signUpForm(){
	        return "user/auth/sign-up-form";
	    }
	 



	 @GetMapping("/reset-password")
	    public String resetPassword(){
	        return "user/auth/reset-password";
	    }
	    
}
