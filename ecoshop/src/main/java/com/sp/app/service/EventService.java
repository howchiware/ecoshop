package com.sp.app.service;

import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import com.sp.app.model.Attendance;
import com.sp.app.model.Point;
import com.sp.app.model.Quiz;

public interface EventService {
	
	public void insertAttendance(long memberId, int dayIndex) throws SQLException;
	public List<Attendance> listAttendance(Map<String, Object> map);
	public boolean isAlreadyChecked(long memberId, LocalDate today);
	public int getWeeklyCount(long memberId);
	
	public void playQuiz(Quiz dto) throws SQLException;
	public boolean isAlreadyCheckedQuiz(long memberId, LocalDate today);
	public Quiz findTodayQuiz();
	public boolean isQuizSolved(long memberId, Long quizId);
	
	public void insertPoint(Point dto) throws SQLException;
}
