package com.sp.app.admin.mapper;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.GongguInquiryManage;
import com.sp.app.admin.model.GongguReviewManage;

@Mapper
public interface GongguReviewInquiryManageMapper {
	public List<GongguInquiryManage> findAllInquirys() throws SQLException;
	public List<GongguReviewManage> findAllReviews() throws SQLException;
}
