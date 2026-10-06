package com.comdog.c2d.domain.member;

import java.util.List;

import com.comdog.c2d.domain.member.dto.MemberDto;

public interface AdminMemberDao {

	//조회
	List<MemberDto> findAllMembers();

	//추가
	void add(MemberDto item);

	//변경
	MemberDto findMemberById(Long id);

	void update(MemberDto member);

	//삭제
	void delete(Long id);
	


}
