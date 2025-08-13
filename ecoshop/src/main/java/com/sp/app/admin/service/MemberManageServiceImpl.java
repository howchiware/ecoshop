package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Service;

import com.sp.app.admin.mapper.MemberManageMapper;
import com.sp.app.admin.model.MemberManage;
import com.sp.app.editor.QuillEditorController;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class MemberManageServiceImpl implements MemberManageService {

    private final QuillEditorController quillEditorController;
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
	public void updateMember(Map<String, Object> map) throws Exception {
		try {
			mapper.updateMember1(map);
			mapper.updateMember2(map);
		} catch (Exception e) {
			log.info("updateMember : ", e);
			
			throw e;
		}
		
	}


}
