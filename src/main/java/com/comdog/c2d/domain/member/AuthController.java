package com.comdog.c2d.domain.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.comdog.c2d.domain.member.dto.MemberDto;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/user/auth")
public class AuthController {
    
    @Autowired
    AuthService authService;
    
    /*-- 로그인 기능 (URL: /user/auth/log-in) --*/

    // 로그인 페이지 매핑
    @GetMapping("/log-in")
    public String loginForm(Model model) {
        model.addAttribute("showHeader", false); // 로그인 페이지에서는 헤더를 숨김 처리!
        return "user/auth/log-in"; // templates/user/auth/log-in.html
    }

    // 실제 로그인 처리 매핑
    @PostMapping("/log-in")
    public String loginProcess(MemberDto memberDto, HttpSession session, Model model) throws Exception {
        // email과 password가 담긴 memberDto를 서비스로 전달
        MemberDto loginMember = authService.login(memberDto);
        
        if (loginMember != null) {
            // 보안을 위해 세션 저장 전 패스워드는 소거
            loginMember.setPassword(null);
            // 로그인 성공 시 세션에 회원 정보 저장
            session.setAttribute("loginMember", loginMember);
            return "redirect:/"; // 메인 페이지로 리다이렉트
        } else {
            // 로그인 실패 시 에러 메시지와 함께 다시 로그인 페이지로 
        	// 비번 틀림 + 회원 없음(DB에 정보 없음) 둘 다 여기로 옴
        	// 비번 틀림과 회원 없음(DB에 정보 없음)은 둘 다 login()이 null을 반환하는 같은 경우라,
        	//메시지 하나로 처리하면 돼요. 보안상으로도 "이메일이 없다" / "비번이 틀리다"를 구분해서 알려주지 않는 게 좋아요
        	// (공격자에게 힌트가 되니까요).
        	
            model.addAttribute("loginError", "※이메일 또는 비밀번호가 일치하지 않습니다※");
            model.addAttribute("showHeader", false); // 실패해서 다시 돌아갈 때도 헤더 숨김 유지
            return "user/auth/log-in";
        } 
    }

    /*-- 로그아웃 기능 (URL: /user/auth/log-out) --*/
    @GetMapping("/log-out")
    public String logout(HttpSession session) {
        session.invalidate(); // 현재 세션에 저장된 모든 정보(로그인 정보 등)를 삭제
        return "redirect:/"; // 로그아웃 후 메인 페이지로 이동
    }
    
    /*-- 회원가입 기능 (URL: /user/auth/sign-up) --*/
    
    // 회원가입 페이지 매핑
    @GetMapping("/sign-up")
    public String signupForm(Model model) {
    	model.addAttribute("showHeader", false); // 회원가입 페이지도 헤더 숨김
    	return "user/auth/sign-up-form"; // templates/user/auth/sign-up-form.html
    }
    
    // 실제 회원가입 처리 매핑
    @PostMapping("/sign-up")
    public String signupProcess(MemberDto memberDto, Model model) throws Exception {
    	
    	//이메일 중복 확인
    	if (authService.isEmailDuplicated(memberDto.getEmail())) {
    		model.addAttribute("signupError", "이미 사용 중인 이메일입니다.");
    		model.addAttribute("showHeader", false);
    		return "user/auth/sign-up-form";
    	}
    	
    	// 회원가입 처리(비밀번호 암호화는 Service에서)
    	authService.signup(memberDto);
    	
    	// 가입 성공 시 로그인 페이지로 이동 
    	// return "user/auth/sign-up-ok"; // forward 없이 뷰 직접 반환
    	return "redirect:/user/auth/sign-up-ok"; // 아래 GET 매핑으로 리다이렉트 , 리다이렉트 (새로고침 시 중복가입 방지, 더 안전)
    	
    }
    
    // PRG(Post-Redirect-Get) 패턴. 가입 완료 페이지를 보여주는 GET 매핑을 따로 만들고, POST는 그쪽으로 리다이렉트
    // GET: 가입 완료 페이지 보여주기
    @GetMapping("/sign-up-ok")
    public String signupOk(Model model) {
        model.addAttribute("showHeader", false);
        return "user/auth/sign-up-ok"; // templates/user/auth/sign-up-ok.html
    }
    

    
}