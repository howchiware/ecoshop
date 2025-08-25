package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Attendance;
import com.sp.app.model.Point;
import com.sp.app.model.Quiz;

@Mapper
public interface EventMapper {
	
	/* 출석 체크*/
	public void insertAttendance(Attendance dto) throws SQLException;
	public List<Attendance> listAttendance(Map<String, Object> map) throws SQLException;
	public int countAttendance(Map<String, Object> map) throws SQLException;
	public int countWeeklyAttendance(long memberId) throws SQLException;

	/* 퀴즈 */
	public void playQuiz(Quiz dto) throws SQLException;
	public List<Quiz> listQuiz(Map<String, Object> map) throws SQLException;
	public int countQuiz(Map<String, Object> map) throws SQLException;
	public Quiz findTodayQuiz() throws SQLException;
	public int isQuizSolved(Map<String, Object> map);
	
	/* 포인트 */
	public void insertPoint(Point dto) throws SQLException;
}
