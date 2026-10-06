package com.comdog.c2d.domain.member;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.comdog.c2d.domain.member.dto.MemberDto;

@Service
public class AdminMemberServiceImpl implements AdminMemberService {

	@Autowired
	AdminMemberDao memberDao;
	
	
	//조회
	@Override
	public List<MemberDto> findAllMembers() {		
		return memberDao.findAllMembers();
	}

	//추가
	@Override
	public void add(MemberDto item) {
		memberDao.add(item);
		
	}

	//변경
	@Override
	public MemberDto findMemeberById(Long id) {
		return memberDao.findMemberById(id);
	}

	@Override
	public void update(MemberDto member) {
		memberDao.update(member);
		
	}

	//삭제
	@Override
	public void delete(Long id) {
		memberDao.delete(id);
		
	}
	
	
	
	
	
	

}
