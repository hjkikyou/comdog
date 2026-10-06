package com.comdog.c2d.domain.member;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.comdog.c2d.domain.member.dto.MemberDto;

@Repository
public class AdminMemberDaoImpl implements AdminMemberDao {

	@Autowired 
	SqlSession sql;
	
	//조회
	@Override
	public List<MemberDto> findAllMembers() {
		return sql.selectList("member.findAllMembers");
	}

	//추가
	@Override
	public void add(MemberDto item) {
		sql.insert("member.insertMember", item);
	}

	
	// 변경
	@Override
	public MemberDto findMemberById(Long id) {
		return sql.selectOne("member.findMemberById", id);
	}

	@Override
	public void update(MemberDto member) {
		sql.update("member.update", member);
	}

	//삭제
	@Override
	public void delete(Long id) {
		sql.delete("member.delete", id);
		
	}

	

}
