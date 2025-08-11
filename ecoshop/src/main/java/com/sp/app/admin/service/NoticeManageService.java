package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import com.sp.app.admin.model.NoticeManage;

public interface NoticeManageService {
	public void insertNotice(NoticeManage dto, String uploadPath) throws Exception;
	
	public int dataCount(Map<String, Object> map);
	public List<NoticeManage> listNoticeTop();
	public List<NoticeManage> listNotice(Map<String, Object> map);
	
	public void updateHitCount(long noticeId) throws Exception;
	public NoticeManage findById(long noticeId);
	public NoticeManage findByPrev(Map<String, Object> map);
	public NoticeManage findByNext(Map<String, Object> map);
	
	public void updateNotice(NoticeManage dto, String uploadPath) throws Exception;
	public void deleteNotice(long noticeId, String uploadPath) throws Exception;
	
	public List<NoticeManage> listNoticeFile(long noticeId);
	public NoticeManage findByFileId(long noticefileId);
	public void deleteNoticeFile(Map<String, Object> map) throws Exception;
	
	public boolean deleteUploadFile(String uploadPath, String filename);
}
