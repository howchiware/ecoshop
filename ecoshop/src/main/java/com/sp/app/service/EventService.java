package com.sp.app.service;

import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import com.sp.app.model.Attendance;
import com.sp.app.model.Quiz;

public interface EventService {
	
	public void insertAttendance(long memberId, int dayIndex) throws SQLException;
	public List<Attendance> listAttendance(Map<String, Object> map);
	public boolean isAlreadyChecked(long memberId, LocalDate today);
	public int getWeeklyCount(long memberId);
	public void addPoints(long memberId, int i);
	
	
	public void playQuiz(long memberId) throws SQLException;
	public boolean isAlreadyCheckedQuiz(long memberId, LocalDate today);
	public Quiz findTodayQuiz();
	// public int getWeeklyCount(long memberId);
	public void addPointByQuiz(long memberId, int i);
	public boolean isQuizSolved(long memberId, Long quizId);
	
}
