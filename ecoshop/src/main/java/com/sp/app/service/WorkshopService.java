package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.Participant;
import com.sp.app.model.Workshop;
import com.sp.app.model.WorkshopReview;

public interface WorkshopService {
	// 카테고리
	public void insertCategory(Workshop dto, String categoryName);
	public List<Workshop> listCategory(Map<String, Object> map);
	
	// 프로그램
	public void insertProgram(Workshop dto) throws Exception;
	public List<Workshop> listProgram(Map<String, Object> map);
	public Workshop findProgramById(long num);
	public void updateProgram(Workshop dto) throws Exception;
	public void deleteProgram(long num) throws Exception;
	
	// 담당자
	public void insertManager(Workshop dto) throws Exception;
	public List<Workshop> listManager(Map<String, Object> map);
	public Workshop findManagerById(long num);
	public void updateManager(Workshop dto) throws Exception;
	public void deleteManager(long num) throws Exception;
	
	// 워크샵
	public void insertWorkshop(Workshop dto) throws Exception;
	public List<Workshop> listWorkshop(Map<String, Object> map);
	public Workshop findWorkshopById(long num);
	public void updateWorkshop(Workshop dto) throws Exception;
	public void deleteWorkshop(long num) throws Exception;
	public int workshopDataCount(Map<String, Object> map);
	
	// 워크샵 사진
	public void insertWorkshopPhoto(Workshop dto) throws Exception; // workshopImagePath로 수정
	public List<Workshop> listWorkshopPhoto(Map<String, Object> map);
	public Workshop findWorkshopPhotoById(long photoId);
	public void deleteWorkshopPhotoById(long photoId, String uploadPath) throws Exception;
	public void deleteWorkshopPhotosByWorkshopId(long workshopId, String uploadPath) throws Exception;
	public int workshopPhotoDataCount(Map<String, Object> map);
	
	// 참가자 관리
	public List<Participant> listParticipant(Map<String, Object> map);
	public int participantDataCount(Map<String, Object> map);
	public int markAttendance(Map<String, Object> map) throws Exception;
	
	// 신청/취소
	public int hasApplied(Map<String, Object> map);
	public Workshop findWorkshopStatusAndCapacity(long workshopId) throws Exception;
	public void applyWorkshop(Map<String, Object> map) throws Exception;
	public void cancelApplication(Map<String, Object> map) throws Exception;
	
	// (사용자) 워크샵 목록 상세
	public List<Workshop> listUserWorkshop(Map<String, Object> map);
	public int userWorkshopDataCount(Map<String, Object> map);
	public Workshop findWorkshopDetail(long workshopId);
	
	// 사용자 FAQ
	public List<Workshop> listUserFaq(Map<String, Object> map);
	
	// 사용자 리뷰
	public List<WorkshopReview> listUserReview(Map<String, Object> map);
	public int reviewDataCount(Map<String,Object> map);
	public void insertReview(WorkshopReview dto) throws Exception;
	public void updateReview(WorkshopReview dto) throws Exception;
	public void deleteReview(long num) throws Exception;
	
	// 관리자 FAQ
	public List<Workshop> listAdminFaq(Map<String,Object> map);
	public int faqDataCount(Map<String,Object> map);
	public boolean isParticipantOfMember(long participantId, long memberId);
	
}
