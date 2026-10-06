package com.comdog.c2d.domain.member;

import com.comdog.c2d.domain.member.dto.MemberDto;

public interface AuthDao {
	
	/*--로그인--*/
	MemberDto login(MemberDto memberDto) throws Exception;

	/*--회원가입--*/
	// 회원 정보 저장
	void insertMember(MemberDto memberDto) throws Exception;

	//이메일로 회원 수 카운트 (중복 확인용)
	int countByEmail(String email) throws Exception;

}
