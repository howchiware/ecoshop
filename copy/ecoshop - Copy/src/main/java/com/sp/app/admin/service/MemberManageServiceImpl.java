package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

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
	public MemberManage findById(Long member_id) {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public void insertMemberStatus(MemberManage dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<MemberManage> listMemberStatus(Long member_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public MemberManage findByStatus(Long member_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Map<String, Object>> listAgeSection() {
		// TODO Auto-generated method stub
		return null;
	}

}
