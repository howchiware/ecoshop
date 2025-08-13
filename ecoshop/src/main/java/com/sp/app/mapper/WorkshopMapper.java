package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Workshop;

@Mapper
public interface WorkshopMapper {
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
	
	// 후기
	public void insertReview(Workshop dto) throws SQLException;
	public void updateReview(Workshop dto) throws SQLException;
	public void deleteReview(long num) throws SQLException;
	
	public int reviewDataCount(Map<String, Object> map);
	public List<Workshop> listReview(Map<String, Object> map);
	
	public Workshop findReviewById(long num);
	
	// FAQ
	public void insertFaq(Workshop dto) throws SQLException;
	public void updateFaq(Workshop dto) throws SQLException;
	public void deleteFaq(long num) throws SQLException;
	
	public int faqDataCount(Map<String, Object> map);
	public List<Workshop> listFaq(Map<String, Object> map);
	
	public Workshop findFaqById(long num);
}
