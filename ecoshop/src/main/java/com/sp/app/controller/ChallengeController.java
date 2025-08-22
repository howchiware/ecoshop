package com.sp.app.controller;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	private final MyUtil myUtil;
	
	
	// 메인(사용자 목록) : 데일리 + 스페셜(첫 로드) 
    @GetMapping("list")
    public String list(
    		@RequestParam(name = "weekday", required = false) Integer weekday,
            @RequestParam(name = "size", required = false) Integer size,
            @RequestParam(name = "sort", defaultValue = "CLOSE_DATE") String sort,
            Model model
    ) {
        try {
            List<Challenge> weekly = service.listDailyAll();
            
            int javaDow = java.time.LocalDate.now().getDayOfWeek().getValue();
            int todayDow0to6 = javaDow % 7;
            int targetWeekday = (weekday != null ? weekday : todayDow0to6);
            
            Challenge today = service.getDailyByWeekday(targetWeekday);

            List<Challenge> special = service.listSpecialMore(null, size, sort, null);

            model.addAttribute("weekly", weekly);
            model.addAttribute("today", today);
            model.addAttribute("list", special);
            
            model.addAttribute("targetWeekday", targetWeekday);
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
			@RequestParam(name = "sort", defaultValue = "RECENT") String sort,
			@RequestParam(name = "lastEndDate", required = false) String lastEndDate
			) {
			try {
				return service.listSpecialMore(lastId, size, sort, lastEndDate);
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
	
	// 데일리 챌린지 참여 페이지 (GET)
	@GetMapping("join/daily/{challengeId}")
    public String dailyJoinForm(
    		@PathVariable("challengeId") long challengeId,
    		Model model,
    		HttpSession session) {
        SessionInfo info = (SessionInfo) session.getAttribute("member");
        if (info == null) {
            return "redirect:/member/login";
        }
        
        try {
        	Challenge dto = service.findDailyDetail(challengeId);
        	if (dto == null) {
        		return "redirect:/challenge/list";
        	}
        	
        	model.addAttribute("dto", dto);
        } catch (Exception e) {
        	log.info("dailyJoinForm :", e);
        }
        
        return "challenge/join";
    }

	// 데일리 챌린지 참여 폼 제출 (POST)
	@PostMapping("dailySubmit")
    public String dailySubmit(
            Challenge dto,
            @RequestParam("photoFile") MultipartFile photoFile,
            HttpSession session,
            RedirectAttributes reAttr
    ) {
        SessionInfo info = (SessionInfo) session.getAttribute("member");
        if (info == null) {
            return "redirect:/member/login";
        }

        try {
            dto.setMemberId(info.getMemberId());
            // 데일리 챌린지 타입 설정
            dto.setChallengeType("DAILY"); 
            service.submitDailyChallenge(dto, photoFile);
            reAttr.addFlashAttribute("message", "챌린지 참여가 완료되었습니다. 포인트가 지급됩니다.");
        } catch (Exception e) {
            log.info("dailySubmit : ", e);
            reAttr.addFlashAttribute("message", "챌린지 참여에 실패했습니다. 다시 시도해주세요.");
        } // addFlashAttribute : 사용자에게 일회성 알림 메시지 보이는 기능 - 리다이렉트와 함께 사용 

        // 성공 후 메인 페이지로 리다이렉트
        return "redirect:/challenge/list";
    }
    
    // 스페셜 진행률 (AJAX, 1~3일) 
    @ResponseBody
    @GetMapping("progress/{participationId}")
    public List<Map<String, Object>> specialProgress(@PathVariable("participationId") long participationId) {
        try {
            return service.selectSpecialProgress(participationId);
        } catch (Exception e) {
            log.info("specialProgress :", e);
        }
        return List.of();
    }
}