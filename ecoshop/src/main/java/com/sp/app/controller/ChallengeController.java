package com.sp.app.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.common.MyUtil;
import com.sp.app.model.Challenge;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.ChallengeService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/challenge/*")
public class ChallengeController {
	// 사용자 화면
	private final ChallengeService service;
	private final MyUtil myUtil; // 나중에 보고 제거 가능 
	
	
	// 메인(사용자 목록) : 데일리 + 스페셜(첫 로드) 
    @GetMapping("list")
    public String list(
    		@RequestParam(name = "weekday", required = false) Integer weekday,
            @RequestParam(name = "size", required = false) Integer size,
            @RequestParam(name = "sort", defaultValue = "RECENT") String sort,
            Model model
    ) {
        try {
            // 데일리, 요일버튼 목록(weekday, challengeUd 포함)
            List<Challenge> weekly = service.listDailyAll();
            
            
            // 파라미터 없으면 '오늘'로
            int javaDow = java.time.LocalDate.now().getDayOfWeek().getValue(); // // 1=Mon..7=Sun
            int todayDow0to6 = javaDow % 7; // 0=Sun..6=Sat
            int targetWeekday = (weekday != null ? weekday : todayDow0to6);
            
            
            // 해당 요일 카드 1건 
            Challenge today = service.getDailyByWeekday(targetWeekday);

            // 스페셜(더보기 첫 로드)
            List<Challenge> special = service.listSpecialMore(null, size, sort);

            model.addAttribute("weekly", weekly);
            model.addAttribute("today", today);
            model.addAttribute("list", special);
            
         // 뷰에서 버튼 활성화/스크롤용
            model.addAttribute("targetWeekday", targetWeekday); // 버튼 활성화용
            model.addAttribute("size", (size == null ? 6 : size));
            model.addAttribute("sort", sort);
        } catch (Exception e) {
            log.info("challenge list :", e);
        }
        return "challenge/list";
    }
    
  
	
	// 스페셜 더보기 (AJAX)
	@ResponseBody
	@GetMapping("special/more")
	public List<Challenge> specialMore(
			@RequestParam(name = "lastId", required = false) Long lastId,
			@RequestParam(name = "size", required = false) Integer size,
			@RequestParam(name = "sort", defaultValue = "RECENT") String sort
			) {
			try {
				return service.listSpecialMore(lastId, size, sort);
			} catch (Exception e) {
				 log.info("specialMore :", e);
			}
			return List.of();
	}
			
		// 상세 (페이지 이동)
			@GetMapping("detail/{challengeId}")
			public String detail(
					@PathVariable("challengeId") long challengeId,
					Model model
			) {
				try {
					// SPECIAL 우선 조회, 없으면 DAILY 조회
					Challenge dto = service.findSpecialDetail(challengeId);
					if(dto == null) dto = service.findDailyDetail(challengeId);
					if(dto == null) return "redirect:/challenge/list";
					
					model.addAttribute("dto", dto);
					return "challenge/article";
				} catch (Exception e) {
					log.info("detail : ", e);
				}
				
				return "redirect:/challenge/list";
			}
			
			//오늘 요일 챌린지 참가 (AJAX) 
		    @ResponseBody
		    @PostMapping("join/daily")
		    public Map<String, Object> joinDaily(
		            @RequestParam("challengeId") long challengeId,
		            HttpSession session
		    ) throws Exception {
		        Map<String, Object> res = new HashMap<>();
		        String state = "false";

		        try {
		            SessionInfo info = (SessionInfo) session.getAttribute("member");
		            if (info == null) {
		                res.put("state", "login");
		                return res;
		            }

		            // 오늘 중복 참가 방지
		            int count = service.countTodayDailyJoin(info.getMemberId(), challengeId);
		            if (count > 0) {
		                res.put("state", "joined");
		                return res;
		            }

		            // 참여 등록
		            Long pid = Objects.requireNonNull(service.nextParticipationId());
		            Challenge dto = new Challenge();
		            dto.setParticipationId(pid);
		            dto.setChallengeId(challengeId);
		            dto.setMemberId(info.getMemberId());
		            dto.setParticipationStatus(0); // 진행

		            service.insertParticipation(dto);
		            state = "true";
		        } catch (Exception e) {
		            log.info("joinDaily :", e);
		        }

		        res.put("state", state);
		        return res;
		    }
		    
		    // 스페셜 진행률 (AJAX, 1~3일) 
		    @ResponseBody
		    @GetMapping("progress/{participationId}")
		    public List<Map<String, Object>> specialProgress(@PathVariable long participationId) {
		        try {
		            return service.selectSpecialProgress(participationId);
		        } catch (Exception e) {
		            log.info("specialProgress :", e);
		        }
		        return List.of();
		    }
			
	
	
}
