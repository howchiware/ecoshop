package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.Notice;

public interface NoticeService {
	public int dataCount(Map<String, Object> map);
	public List<Notice> listNoticeTop();
	public List<Notice> listNotice(Map<String, Object> map);
	
	public void updateHitCount(long noticeId) throws Exception;
	public Notice findById(long noticeId);
	public Notice findByPrev(Map<String, Object> map);
	public Notice findByNext(Map<String, Object> map);

	public List<Notice> listNoticeFile(long noticeId);
	public Notice findByFileId(long noticefileId);
	public void deleteNoticeFile(Map<String, Object> map) throws Exception;
	
	public boolean deleteUploadFile(String uploadPath, String filename);
}
