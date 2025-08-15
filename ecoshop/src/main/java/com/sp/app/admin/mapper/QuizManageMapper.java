package com.sp.app.admin.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.QuizManage;

@Mapper
public interface QuizManageMapper {

	public List<QuizManage> listQuiz(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	public QuizManage findByQuiz(Long quizId);
	
	public void insertQuiz(QuizManage dto) throws SQLException;
	public void updateQuiz(QuizManage dto) throws SQLException;
	public void deleteQuiz(long quizId) throws SQLException;
	
	public QuizManage findByOpenDate(String openDate);
	public QuizManage findTodayQuiz();
	
}
