package com.sp.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.common.MyUtil;
import com.sp.app.common.StorageService;
import com.sp.app.mapper.FreeMapper;
import com.sp.app.model.Free;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class FreeServiceImpl implements FreeService {
	
	private final FreeMapper mapper;
	private final StorageService storageService;
	private final MyUtil myUtil;
	
	
	@Override
	public List<Free> dairyList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public Free findByDairy(long freeId) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public int dataCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}
	@Override
	public void updateHitCount(long freeId) throws Exception {
		// TODO Auto-generated method stub
		
	}
	@Override
	public Free findByPrev(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public Free findByNext(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public void insertDairy(Free dto, String uploadPath) throws Exception {
		try {
			if(! dto.getSelectFile().isEmpty()) {
				
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	@Override
	public void updateDairy(Free dto, String uploadPath) throws Exception {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void deleteDairy(long freeId, String uploadPath, Long memberId, int userLevel) throws Exception {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void insertReply(Free dto) throws Exception {
		// TODO Auto-generated method stub
		
	}
	@Override
	public List<Free> listReply(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public int replyCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}
	@Override
	public void deleteReply(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}
	@Override
	public List<Free> listReplyAnswer(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public int replyAnswerCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}
	@Override
	public boolean deleteUploadFile(String uploadPath, String filename) {
		// TODO Auto-generated method stub
		return false;
	}
	
	
}
