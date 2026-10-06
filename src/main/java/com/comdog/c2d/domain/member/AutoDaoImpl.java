package com.comdog.c2d.domain.member;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.comdog.c2d.domain.member.dto.MemberDto;

@Repository
public class AutoDaoImpl implements AuthDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	// Mapper XML의 namespace와 일치해야 합니다.
    private static final String NAMESPACE = "member";
    
    
    /*--로그인--*/
    @Override
    public MemberDto login(MemberDto memberDto) throws Exception{
    	return sqlSession.selectOne(NAMESPACE + ".login", memberDto);
    }
    
    /*--회원가입--*/
    @Override
    public void insertMember(MemberDto memberDto) throws Exception {
    	sqlSession.insert("member.insertMember", memberDto);
    }
    
    @Override
    public int countByEmail(String email) throws Exception {
    	return sqlSession.selectOne("member.countByEmail", email);
    }
    
    

}
