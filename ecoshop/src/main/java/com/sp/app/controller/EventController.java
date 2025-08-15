package com.sp.app.controller;

import java.sql.SQLException;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.model.Attendance;
import com.sp.app.model.Member;
import com.sp.app.model.Quiz;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.EventService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/event")
public class EventController {
	
	private final EventService service;
	
	@GetMapping("attendance")
	public String attendancePage(Model model, HttpSession session) throws SQLException {
	    
		try {
	    SessionInfo info = (SessionInfo) session.getAttribute("member");
	    List<Attendance> list = new ArrayList<>();
	    
	    if (info != null) {
	        Map<String, Object> map = new HashMap<>();
	        map.put("memberId", info.getMemberId());
	        list = service.listAttendance(map);
	        if (list == null) list = new ArrayList<>();

	        for (Attendance dto : list) {
	            String regDateStr = dto.getRegDate();
	            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
	            LocalDateTime dateTime = LocalDateTime.parse(regDateStr, formatter);
	            dto.setDayIndex(dateTime.getDayOfWeek().getValue());
	        }
	    }

	    Set<Integer> attendanceDays = list.stream()
	            .map(Attendance::getDayIndex)
	            .distinct()
	            .collect(Collectors.toSet());

	    LocalDate now = LocalDate.now();
	    LocalDate monday = now.with(DayOfWeek.MONDAY);
	    List<String> weekDate = new ArrayList<>();
	    for (int i = 0; i < 7; i++) {
	        LocalDate date = monday.plusDays(i);
	        String mw = date.getMonthValue() + "월 " + date.getDayOfMonth() + "일";
	        weekDate.add(mw);
	    }

	    List<Integer> attendanceDaysList = new ArrayList<>(attendanceDays);
	    model.addAttribute("attendanceDays", attendanceDaysList);
	    model.addAttribute("weekDate", weekDate);
	    
		} catch (Exception e) {
			log.info("attendancePage", e);
			throw e;
		}

	    return "event/attendance";
	}


	
	@PostMapping("/attendance/check")
	@ResponseBody
	public Map<String, Object> checkAttendance(HttpSession session) {
	   
		Map<String, Object> map = new HashMap<String, Object>();
		
	    try {
	    	 SessionInfo info = (SessionInfo) session.getAttribute("member");
	         if (info == null) {
	             map.put("success", false);
	             map.put("message", "로그인이 필요합니다.");
	             return map;
	         }
	        
	        LocalDate now = LocalDate.now();
	        int dayIndex = now.getDayOfWeek().getValue();

	        boolean alreadyChecked = service.isAlreadyChecked(info.getMemberId(), now);
	        if (alreadyChecked) {
	        		map.put("success", false);
	        		map.put("message", "이미 오늘 출석체크를 하셨습니다.");
	            return map;
	        }

	        service.insertAttendance(info.getMemberId(), dayIndex);

	        int totalCount = service.getWeeklyCount(info.getMemberId());
	        if (totalCount == 5) {
	            service.addPoints(info.getMemberId(), 500);
	            map.put("point", true);
	        }

	        map.put("success", true);
	    } catch (Exception e) {
	    		log.error("checkAttendance: ", e);
	    		map.put("success", false);
	    		map.put("message", "출석체크 처리 중 오류가 발생했습니다.");
	    }
	    return map;
	}
	
	
	
	
	
	@GetMapping("quiz")
	public String quizPage(Model model, HttpSession session) throws SQLException {
	    
		
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			if (info == null) {
	            return "redirect:/member/login";
	         }
			
		    Quiz todayQuiz = service.findTodayQuiz();
		    model.addAttribute("todayQuiz", todayQuiz);
		    
		    boolean isSolved = false;
	        if(todayQuiz != null) {
	            isSolved = service.isQuizSolved(info.getMemberId(), todayQuiz.getQuizId());
	        }
	        model.addAttribute("isSolved", isSolved);
		    
		} catch (Exception e) {
			log.info("quizPage : ", e);
		}
		
		return "event/quiz";
	}
	
	@PostMapping("/quiz/play")
	@ResponseBody
	public String quizPlay(Member dto, HttpSession session) {
	   
	    try {
	    	SessionInfo info = (SessionInfo) session.getAttribute("member");
	    	dto.setMemberId(info.getMemberId());
	    	
	    	service.playQuiz(dto.getMemberId());
	    	 
	    } catch (Exception e) {
	    	log.info("quizPlay");
	    }
	    
	    return "redirect:/event/quiz";
	}



}
