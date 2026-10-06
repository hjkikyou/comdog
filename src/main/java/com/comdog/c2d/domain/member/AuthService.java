package com.comdog.c2d.domain.member;

import com.comdog.c2d.domain.member.dto.MemberDto;

public interface AuthService {
	
	//로그인
	MemberDto login(MemberDto memberDto) throws Exception;

	//회원가입
	void signup(MemberDto memberDto) throws Exception;
	

	//이메일 중복 확인(true:중복됨)
	boolean isEmailDuplicated(String email) throws Exception;

}
