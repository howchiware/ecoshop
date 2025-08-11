package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import com.sp.app.admin.model.QuizManage;

public interface QuizManageService {
	
	public List<QuizManage> listQuiz(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);	
	public void insertQuiz(QuizManage dto) throws Exception;
	public QuizManage findByQuiz(long quizId);
	
	
	public void updateQuiz(QuizManage dto) throws Exception;
	public void deleteQUiz(long quizId) throws Exception;
	
	
}
