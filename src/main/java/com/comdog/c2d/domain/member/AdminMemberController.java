package com.comdog.c2d.domain.member;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.comdog.c2d.domain.member.dto.MemberDto;

@Controller
@RequestMapping("/admin/member")
public class AdminMemberController {
	
	@Autowired
	AdminMemberService service;
	
	/* -- 조회 -- */
	@GetMapping("/list")
	public String getMemberListPage(Model model) {
		List<MemberDto> memberList;
		memberList = service.findAllMembers();
		model.addAttribute("viewMemberList", memberList);
		return "admin/member/list";
	}
	
	// "데이터베이스(DB)에서 전체 상품 목록을 가져와서, 화면(HTML)에 뿌려주는 역할"
	// '상품 목록 조회 화면'을 만들어주는 핵심 관문
	
	 /* -- 추가 --*/
	 @GetMapping("/add")
	 public String showAddForm() {
		 return "admin/member/add";
	 }
	 
	 @PostMapping("/add")
	 String addMember(MemberDto item) {
		 service.add(item);
		 
		 return "redirect:/admin/member/list";
	 }
	 

 
	 /* -- 변경 -- */
	 @GetMapping("/update/{id}")
	 public String showUpdateForm(@PathVariable Long id, Model model) {
		 MemberDto member = service.findMemeberById(id);
		 model.addAttribute("viewMember", member);
		 
		 return "admin/member/update";
	 }
	 
	 @PostMapping("/update/{id}")
	 String updateMember(@PathVariable Long id, MemberDto member) {
		 member.setId(id);
		 service.update(member);
		 
		 return "redirect:/admin/member/list";
	 }
	 
	 
	 /*---삭제---*/
	 
	 @GetMapping("/delete/{id}")
	 public String delete(@PathVariable Long id) {
		service.delete(id);
		
		return "redirect:/admin/member/list";
 	}
	 
	 
	 
	 
	 
}
	
	
	
