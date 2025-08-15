package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.admin.mapper.GongguManageMapper;
import com.sp.app.admin.model.GongguManage;
import com.sp.app.admin.model.GongguReviewManage;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class GongguManageServiceImpl implements GongguManageService {
	private final GongguManageMapper gongguManageMapper;
   
	@Override
	public void insertGongguProduct(GongguManage dto, String uploadPath) throws Exception {
		// TODO Auto-generated method stub
    }
    
	@Override
	public void updateGongguProduct(GongguManage dto, String uploadPath) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteGongguProduct(long gongguProductId, String uploadPath) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteGongguDetailPhotoFile(long fileNum, String pathString) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public boolean deleteUploadFile(String uploadPath, String filename) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<GongguManage> listProduct(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public GongguManage findById(long gongguProductId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<GongguReviewManage> getReviewList() {
        List<GongguReviewManage> list = null;
        try {
            list = gongguManageMapper.findAllReviews();
        } catch (Exception e) {
            log.error("gongguReviewList :", e);
        }
        return list;
    }

}