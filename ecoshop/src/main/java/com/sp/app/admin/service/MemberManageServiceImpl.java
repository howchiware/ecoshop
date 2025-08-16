package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sp.app.admin.mapper.MemberManageMapper;
import com.sp.app.admin.model.MemberManage;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class MemberManageServiceImpl implements MemberManageService {

	private final MemberManageMapper mapper;
	
	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = mapper.dataCount(map);
		} catch (Exception e) {
			log.info("dataCount : " , e);
		}
		return result;
	}

	@Override
	public List<MemberManage> listMember(Map<String, Object> map) {
		List<MemberManage> list = null;
		
		try {
			list = mapper.listMember(map);
		} catch (Exception e) {
			log.info("listMember : ", e);
		}
		
		return list;

	}

	@Override
	public MemberManage findById(Long memerId) {
		MemberManage dto = null;
		
		try {
			dto = Objects.requireNonNull(mapper.findById(memerId));
		} catch (NullPointerException e) {
		} catch (ArrayIndexOutOfBoundsException e) {
		} catch (Exception e) {
			log.info("findById : ", e);
		}
		return dto;
	}


	@Override
	public List<MemberManage> listMemberStatus(Long memerId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public MemberManage findByStatus(Long memerId) {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public void updateMember(Map<String, Object> map) throws Exception {
		try {
			mapper.updateMember1(map);
			mapper.updateMember2(map);
		} catch (Exception e) {
			log.info("updateMember : ", e);
			
			throw e;
		}
		
	}

	@Override
	public void updateMemberEnabled(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Transactional(rollbackFor = {Exception.class})
	@Override
	public void insertMember(MemberManage dto) throws Exception {
		try {
			
			long memberId = mapper.selectMemberId();
	        dto.setMemberId(memberId);
	        
	        
			mapper.insertMember3(dto);
			mapper.insertMember4(dto);
		} catch (Exception e) {
			log.info("insertMember : " , e);
			
			throw e;
		}
		
	}

	@Override
	public MemberManage findById1(String userId) {
		MemberManage dto = null;
		
		try {
			dto = Objects.requireNonNull(mapper.findById1(userId));
			
		} catch (NullPointerException e) {
		} catch (ArrayIndexOutOfBoundsException e) {
		} catch (Exception e) {
			log.info("findById1 : ", e);
		}
		
		return dto;
	}

	@Override
	public MemberManage findByNickname(String nickname) {
		
		MemberManage dto = null;
		
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
	public void generatePwd(MemberManage dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	
}
