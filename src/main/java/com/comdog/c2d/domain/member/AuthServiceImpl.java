package com.comdog.c2d.domain.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.comdog.c2d.domain.member.dto.MemberDto;

@Service
public class AuthServiceImpl implements AuthService {
	
	@Autowired
	private AuthDao authDao;
	
	/*--로그인--*/
	@Override
	public MemberDto login(MemberDto memberDto) throws Exception {
		// 1) 이메일로 회원 조회
		MemberDto findMember = authDao.login(memberDto);
		
		// 2) 회원이 없으면 로그인 실패
		if (findMember == null) {
			return null;
		}
		
		// 3) 평문 비밀번호 '1234' 비교
		boolean matched = "1234".equals(memberDto.getPassword());
		
		// 일치하면 회원정보 반환, 아니면 null
		return matched ? findMember : null;
	}
	
	/*--회원가입--*/
	@Transactional
	@Override
	public void signup(MemberDto memberDto) throws Exception {
		// 비밀번호를 강제로 '1234'로 설정
		memberDto.setPassword("1234");
		
		// DB에 저장
		authDao.insertMember(memberDto);
	}

	@Override
	public boolean isEmailDuplicated(String email) throws Exception {
		// 같은 이메일 회원 수를 세서 1 이상이면 중복
		return authDao.countByEmail(email) > 0;
	}
}