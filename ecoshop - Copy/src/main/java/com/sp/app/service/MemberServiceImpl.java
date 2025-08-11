package com.sp.app.service;

import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

	@Transactional(rollbackFor = {Exception.class})
	@Override
	public void insertMember(Member dto) throws Exception {
	    try {
	        long memberId = mapper.selectMemberId();
	        dto.setMemberId(memberId);
	        
	        mapper.insertMember1(dto);
	        
	        mapper.insertMember2(dto);
	        
	    } catch (Exception e) {
	        log.info("insertMember: ", e);
	        throw e;
	    }
	}
	
	@Override
	public Member findById(String userId) {
		
		Member dto = null;
		
		try {
			dto = Objects.requireNonNull(mapper.findById(userId));
			
		} catch (NullPointerException e) {
		} catch (ArrayIndexOutOfBoundsException e) {
		} catch (Exception e) {
			log.info("findById : ", e);
		}
		
		return dto;
	}

	@Override
	public Member findByNickname(String nickname) {
		
		Member dto = null;
		
		try {
			dto = Objects.requireNonNull(mapper.findByNickname(nickname));
			
		} catch (NullPointerException e) {
		} catch (ArrayIndexOutOfBoundsException e) {
		} catch (Exception e) {
			log.info("findByNickname : ", e);
		}
		
		return dto;
	}
	
	@Override
	public void updateMember(Member dto) throws Exception {
		// TODO Auto-generated method stub
		
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
