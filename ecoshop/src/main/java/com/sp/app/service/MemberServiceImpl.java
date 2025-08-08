package com.sp.app.service;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.MemberMapper;
import com.sp.app.model.Member;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class MemberServiceImpl implements MemberService {
	
	private final MemberMapper mapper;
	
	@Override
	public Member loginMember(Map<String, Object> map) {
		Member dto = null;
		
		try {
			dto = mapper.loginMember(map);
		} catch (Exception e) {
			log.info("loginMember: ", e);
		}
		
		return dto;
	}

	@Override
	public void insertMember(Member dto) throws Exception {
		// TODO Auto-generated method stub
		
	}
	
	@Override
	public void updateMember(Member dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Member findById(Long memberId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteMember(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void generatePwd(Member dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	
}
