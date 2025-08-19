package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sp.app.admin.model.MemberManage;
import com.sp.app.model.Participant;
import com.sp.app.model.Workshop;
import com.sp.app.model.WorkshopFaq;
import com.sp.app.model.WorkshopReview;

@Mapper
public interface WorkshopMapper {
	/* ──────────────── 관리자 ──────────────── */
	// 카테고리
	public void insertProgramCategory(Workshop dto);
	public void updateProgramCategory(Workshop dto) throws SQLException;
	public void deleteProgramCategory(long num) throws SQLException;
	public List<Workshop> listProgramCategory(Map<String, Object> map);
	
	// 프로그램
	public void insertProgram(Workshop dto);
	public void updateProgram(Workshop dto);
	public void deleteProgram(long num);
	public int programDataCount(Map<String, Object> map);
	public List<Workshop> listProgram(Map<String, Object> map);
	public Workshop findProgramById(long num);
	
	// 워크샵
	public void insertWorkshop(Workshop dto) throws SQLException;
	public void updateWorkshop(Workshop dto) throws SQLException;
	public void deleteWorkshop(long num) throws SQLException;
	public int workshopDataCount(Map<String, Object> map);
	public List<Workshop> listWorkshop(Map<String, Object> map);
	public Workshop findWorkshopById(long num);
	
	// 워크샵 사진
	public void insertWorkshopPhoto(Workshop dto) throws SQLException;
	public Workshop findWorkshopPhotoById(long num) throws SQLException;
	public void deleteWorkshopPhotoById(long num) throws SQLException;
	public void deleteWorkshopPhotosByWorkshopId(long num) throws SQLException;
	public List<Workshop> listWorkshopPhoto(Map<String, Object> map);
	public int workshopPhotoDataCount(Map<String, Object> map);
	
	// 담당자
	public void insertManager(Workshop dto) throws SQLException;
	public void updateManager(Workshop dto) throws SQLException;
	public void deleteManager(long num) throws SQLException;
	public int managerDataCount(Map<String, Object> map);
	public List<Workshop> listManager(Map<String, Object> map);
	public Workshop findManagerById(long num);
	
	// FAQ
	public void insertFaq(WorkshopFaq dto) throws SQLException;
	public void updateFaq(WorkshopFaq dto) throws SQLException;
	public void deleteFaq(long num) throws SQLException;
	public List<WorkshopFaq> listFaq(Map<String, Object> map);
	public Long findProgramIdByWorkshopId(long workshopId);
	public WorkshopFaq findFaqById(long faqId);
	
	// 참가자
	public List<Participant> listParticipant(Map<String, Object> map);
	public int updateParticipantStatus(Map<String, Object> map);
	public int updateAttendance(Map<String, Object> map);
	
	/* ──────────────── 사용자 ──────────────── */
	// 워크샵 목록/상세
	public List<Workshop> listUserWorkshop(Map<String, Object> map);
	public int userWorkshopDataCount(Map<String, Object> map);
	public Workshop findWorkshopDetail(long workshopId);
	
	// 워크샵 신청/취소
	public int hasApplied(Map<String, Object> map);
	public int countAppliedByWorkshop(long workshopId);
	public void applyWorkshop(Map<String, Object> map);
	public int cancelApplication(Map<String, Object> map);
	int isParticipantOfMember(@Param("participantId") long participantId,
            @Param("memberId") long memberId);
	public MemberManage findMemberById(long memberId);
	
	// 워크샵 후기
	public void insertReview(WorkshopReview dto) throws SQLException;
	public int reviewDataCount(Map<String, Object> map);
	public List<WorkshopReview> listUserReview(Map<String, Object> map);
	public Workshop findReviewById(long num);
	Long findParticipantById(@Param("memberId") long memberId,
            @Param("workshopId") long workshopId);
	
	// 워크샵 상태 검증
	public Workshop findWorkshopStatusAndCapacity(long workshopId);
	
	public void updateWorkshopStatus(Workshop dto);
	
}
