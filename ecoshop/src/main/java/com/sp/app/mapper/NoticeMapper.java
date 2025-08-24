package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Notice;

@Mapper
public interface NoticeMapper {
	public long noticeSeq();
	public void insertNotice(Notice dto) throws SQLException;
	public void updateNotice(Notice dto) throws SQLException;
	public void deleteNotice(long noticeId) throws SQLException;
	
	public int dataCount(Map<String, Object> map);
	public List<Notice> listNoticeTop();
	public List<Notice> listNotice(Map<String, Object> map);
	
	public Notice findById(long noticeId);
	public void updateHitCount(long noticeId) throws SQLException;
	public Notice findByPrev(Map<String, Object> map);
	public Notice findByNext(Map<String, Object> map);

	public void insertNoticeFile(Notice dto) throws SQLException;
	public List<Notice> listNoticeFile(long noticeId);
	public Notice findByFileId(long noticefileId);
	public void deleteNoticeFile(Map<String, Object> map) throws SQLException;
}
