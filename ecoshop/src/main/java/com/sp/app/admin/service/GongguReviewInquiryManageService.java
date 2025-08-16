package com.sp.app.admin.service;

import java.util.List;

import com.sp.app.admin.model.GongguInquiryManage;
import com.sp.app.admin.model.GongguReviewManage;

public interface GongguReviewInquiryManageService {
	public List<GongguReviewManage> getReviewList();
	public List<GongguInquiryManage> getInquiryList();
}
