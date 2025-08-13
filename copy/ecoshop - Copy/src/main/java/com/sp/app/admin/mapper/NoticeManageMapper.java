package com.sp.app.admin.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.NoticeManage;

@Mapper
public interface NoticeManageMapper {
	public long noticeSeq();
	public void insertNotice(NoticeManage dto) throws SQLException;
	public void updateNotice(NoticeManage dto) throws SQLException;
	public void deleteNotice(long noticeId) throws SQLException;
	
	public int dataCount(Map<String, Object> map);
	public List<NoticeManage> listNoticeTop();
	public List<NoticeManage> listNotice(Map<String, Object> map);
	
	public NoticeManage findById(long noticeId);
	public void updateHitCount(long noticeId) throws SQLException;
	public NoticeManage findByPrev(Map<String, Object> map);
	public NoticeManage findByNext(Map<String, Object> map);

	public void insertNoticeFile(NoticeManage dto) throws SQLException;
	public List<NoticeManage> listNoticeFile(long noticeId);
	public NoticeManage findByFileId(long noticefileId);
	public void deleteNoticeFile(Map<String, Object> map) throws SQLException;
}
