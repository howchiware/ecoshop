package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

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
	public Attendance findByMyAttendance(long memberId);
	public List<Attendance> listWeeklyReportMembers(Map<String, Object> map);
	public List<Attendance> findAttendanceByUsers(Map<String, Object> map);

	/* 퀴즈 */
	public void playQuiz(Quiz dto) throws SQLException;
	public List<Quiz> listQuiz(Map<String, Object> map) throws SQLException;
	public int countQuiz(Map<String, Object> map) throws SQLException;
	public Quiz findTodayQuiz() throws SQLException;
	public int isQuizSolved(Map<String, Object> map);
	public Quiz findUserAnswer(@Param("memberId") long memberId, @Param("quizId") Long quizId);
	
	/* 포인트 */
	public void insertPoint(Point dto) throws SQLException;

}
