package com.sp.app.controller;

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
import org.springframework.web.bind.annotation.RequestMapping;

import com.sp.app.model.Attendance;
import com.sp.app.model.Quiz;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.EventService;
import com.sp.app.service.MemberService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/member/*")
public class MemberPageController {
	
	private final MemberService service;
	private final EventService eventService;
	
	@GetMapping("myPage")
	public String myPageHome(HttpSession session) {
		
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			if (info == null) {
                return "redirect:/member/login";
            }
			
		} catch (Exception e) {
			
		}
		
		return "member/myPage";
	}
	
	@GetMapping("myProfile")
	public String myProfile(HttpSession session) {
		
		try {
			
			
		} catch (Exception e) {
			
		}
		
		return "member/myProfile";
	}
	
	/* 이벤트 참여 현황 */
	@GetMapping("myEvent")
	public String myEvent(Model model, HttpSession session) {
		
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			if (info == null) {
                return "redirect:/member/login";
            }
			
			Map<String, Object> map = new HashMap<>();
			map.put("memberId", info.getMemberId());
			
			/* 출석 */
			List<Attendance> list = eventService.listAttendance(map);
			if(list == null) list = new ArrayList<>();
			
			Set<Integer> attendanceDays = list.stream()
	                .map(dto -> {
	                    LocalDateTime dateTime = LocalDateTime.parse(dto.getRegDate(), DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
	                    return dateTime.getDayOfWeek().getValue();
	                })
	                .collect(Collectors.toSet());

			LocalDate now = LocalDate.now();
			LocalDate monday = now.with(DayOfWeek.MONDAY);
			List<String> weekDate = new ArrayList<>();
			for (int i = 0; i < 7; i++) {
				LocalDate date = monday.plusDays(i);
				String mw = date.getMonthValue() + "월 " + date.getDayOfMonth() + "일";
				weekDate.add(mw);
			}

			model.addAttribute("attendanceDays", new ArrayList<>(attendanceDays));
			model.addAttribute("weekDate", weekDate);
			
			/* 퀴즈 */
			Quiz todayQuiz = eventService.findTodayQuiz();
			model.addAttribute("todayQuiz", todayQuiz);
			
			if(todayQuiz != null) {
				model.addAttribute("todayQuizSubject", todayQuiz.getSubject());
				
				boolean isSolved = eventService.isQuizSolved(info.getMemberId(), todayQuiz.getQuizId());
				model.addAttribute("isSolved", isSolved);
				
				if(isSolved) {
					Quiz userAnswer = eventService.findUserAnswer(info.getMemberId(), todayQuiz.getQuizId());
					
					 if (userAnswer != null) {
				        boolean isCorrect = userAnswer.getQuizAnswer() == todayQuiz.getAnswer();
				        model.addAttribute("isCorrect", isCorrect);
				    } else {
				        model.addAttribute("isCorrect", false);
				    }
				}
			}
			
		} catch (Exception e) {
			log.info("myEvent: ", e);
			throw e;
		}
		
		return "member/myEvent";
	}
	
	/* 이벤트 참여 현황 - 상세 */
	@GetMapping("myEventAttendance")
	public String myEventAttendance(Model model, HttpSession session) {
		
		
		
		return "member/myEventAttendance";
	}
	
}
