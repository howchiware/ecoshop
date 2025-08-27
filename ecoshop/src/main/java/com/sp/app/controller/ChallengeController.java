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
import com.sp.app.common.PaginateUtil;
import com.sp.app.model.Challenge;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.ChallengeService;

import jakarta.servlet.http.HttpServletRequest;
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
	private final PaginateUtil paginateUtil;

	// 메인 : 데일리 + 스페셜(첫 로드)
	@GetMapping("list")
	public String list(@RequestParam(name = "weekday", required = false) Integer weekday,
			@RequestParam(name = "size", required = false) Integer size,
			@RequestParam(name = "sort", defaultValue = "CLOSE_DATE") String sort, Model model) {
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
	public List<Challenge> specialMore(@RequestParam(name = "lastId", required = false) Long lastId,
			@RequestParam(name = "size", required = false) Integer size,
			@RequestParam(name = "sort", defaultValue = "RECENT") String sort,
			@RequestParam(name = "lastEndDate", required = false) String lastEndDate) {
		try {
			return service.listSpecialMore(lastId, size, sort, lastEndDate);
		} catch (Exception e) {
			log.info("specialMore :", e);
		}
		return List.of();
	}

	// 상세 (페이지 이동)
	@GetMapping("detail/{challengeId}")
	public String detail(@PathVariable("challengeId") long challengeId, Model model, HttpSession session) {
		try {
			Challenge dto = service.findSpecialDetail(challengeId);
			if (dto == null)
				dto = service.findDailyDetail(challengeId);
			if (dto == null)
				return "redirect:/challenge/list";

			model.addAttribute("dto", dto);

			// 스페셜이면 다음 일차 계산해서 JSP로 전달
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			if (info != null && "SPECIAL".equals(dto.getChallengeType())) {
				Integer nextDay = service.getNextSpecialDay(challengeId, info.getMemberId());
				model.addAttribute("nextDay", nextDay); // null = 모두 완료
			}
			return "challenge/article";
		} catch (Exception e) {
			log.info("detail : ", e);
			return "redirect:/challenge/list";
		}
	}

	// 데일리 챌린지 참여 페이지 (GET)
	@GetMapping("join/daily/{challengeId}")
	public String dailyJoinForm(@PathVariable("challengeId") long challengeId, Model model, HttpSession session) {
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
			model.addAttribute("submitAction", "/challenge/dailySubmit");
		} catch (Exception e) {
			log.info("dailyJoinForm :", e);
		}

		return "challenge/join";
	}

	// 데일리 챌린지 참여 폼 제출 (POST)
	@PostMapping("dailySubmit")
	public String dailySubmit(Challenge dto, @RequestParam("photoFile") MultipartFile photoFile, HttpSession session,
			RedirectAttributes reAttr) {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if (info == null) {
			return "redirect:/member/login";
		}

		try {
			dto.setMemberId(info.getMemberId());
			dto.setChallengeType("DAILY");
			service.submitDailyChallenge(dto, photoFile);
			reAttr.addFlashAttribute("message", "챌린지 참여가 완료되었습니다. 포인트가 지급됩니다.");
		} catch (Exception e) {
			log.info("dailySubmit : ", e);
			reAttr.addFlashAttribute("message", "챌린지 참여에 실패했습니다. 다시 시도해주세요.");
		}
		return "redirect:/challenge/list";
	}

	// 스페셜 챌린지 참가 페이지 (GET) — 1일차 기본
	@GetMapping("join/special/{challengeId}")
	public String specialJoinForm(@PathVariable("challengeId") long challengeId,
			@RequestParam(name = "day", required = false, defaultValue = "1") Integer day, Model model,
			HttpSession session) {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if (info == null) {
			return "redirect:/member/login";
		}

		try {
			Challenge dto = service.findSpecialDetail(challengeId);
			if (dto == null) {
				return "redirect:/challenge/list";
			}
			model.addAttribute("dto", dto);
			model.addAttribute("submitAction", "/challenge/specialSubmit");
			model.addAttribute("dayNumber", (day == null || day < 1) ? 1 : Math.min(day, 3));
			return "challenge/join";
		} catch (Exception e) {
			log.info("specialJoinForm :", e);
			return "redirect:/challenge/list";
		}
	}

	// 스페셜 챌린지 1~3일차 제출 (POST)
	@PostMapping("specialSubmit")
	public String specialSubmit(Challenge dto, @RequestParam("photoFile") MultipartFile photoFile,
			@RequestParam(name = "dayNumber") Integer dayNumber, HttpSession session, RedirectAttributes reAttr) {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if (info == null) {
			return "redirect:/member/login";
		}

		try {
			dto.setMemberId(info.getMemberId());
			dto.setChallengeType("SPECIAL");
			dto.setDayNumber(dayNumber);
			dto.setApprovalStatus(0); // 대기
			dto.setIsPublic("Y");

			service.submitSpecialDay(dto, photoFile);

			reAttr.addFlashAttribute("message", dayNumber + "일차 인증이 등록되었습니다. 관리자 승인을 기다려주세요.");
		} catch (Exception e) {
			log.info("specialSubmit :", e);
			reAttr.addFlashAttribute("message", "스페셜 챌린지 제출에 실패했습니다. 다시 시도해주세요.");
		}
		return "redirect:/challenge/detail/" + dto.getChallengeId();
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

	@PostMapping("special/submitFinal")
	@ResponseBody
	public Map<String, Object> specialSubmitFinal(@RequestParam("participationId") long participationId,
			HttpSession session) {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if (info == null)
			return Map.of("ok", false, "msg", "로그인이 필요합니다.");
		try {

			service.requestSpecialFinalApproval(participationId, info.getMemberId());
			return Map.of("ok", true);
		} catch (Exception e) {
			return Map.of("ok", false, "msg", e.getMessage());
		}
	}

	@ResponseBody
	@GetMapping("mypage/challengelist")
	public List<Challenge> listMyChallenges(@RequestParam("memberId") long memberId) {

		return service.listMyChallenges(memberId);
	}

	@GetMapping("mypage/list")
	public String mypageChallengeList(
	        HttpSession session,
	        Model model,
	        HttpServletRequest req,
	        @RequestParam(name="page", defaultValue="1") int page,
	        @RequestParam(name="size", defaultValue="10") int size) {

	    SessionInfo info = (SessionInfo) session.getAttribute("member");
	    if (info == null) return "redirect:/member/login";

	    int dataCount = service.countMyChallenges(info.getMemberId());
	    int total_page = paginateUtil.pageCount(dataCount, size);
	    if (total_page == 0) total_page = 1;
	    if (page > total_page) page = total_page;
	    if (page < 1) page = 1;

	    int offset = (page - 1) * size;

	    List<Challenge> list = service.listMyChallengesPaged(info.getMemberId(), offset, size);

	    String listUrl = req.getContextPath() + "/challenge/mypage/list";
	    String paging  = paginateUtil.pagingUrl(page, total_page, listUrl);

	    model.addAttribute("list", list);
	    model.addAttribute("page", page);
	    model.addAttribute("size", size);
	    model.addAttribute("dataCount", dataCount);
	    model.addAttribute("paging", paging);
	    
	    model.addAttribute("tab", "list"); // 탭 활성화

	    return "myPage/challengeList";
	}
	
	// 마이페이지 공개전환
	@PostMapping("post/visibility")
	@ResponseBody
	public Map<String,Object> toggleVisibility(
									@RequestParam("postId") long postId,
                                    @RequestParam("isPublic") String isPublic,
                                    HttpSession session) {
	    SessionInfo info = (SessionInfo) session.getAttribute("member");
	    if (info == null) return Map.of("ok", false, "msg", "로그인이 필요합니다.");
	    if(!"Y".equals(isPublic) && !"N".equals(isPublic)) {
	    	return Map.of("ok", false, "msg", "잘못된 요청입니다.");
	    }
	    try {
	        int n = service.updatePostVisibility(postId, info.getMemberId(), isPublic);
	        return Map.of("ok", n==1);
	    } catch (Exception e) {
	        return Map.of("ok", false, "msg", e.getMessage());
	    }
	}
	
	@GetMapping("mypage/specialPosts")
	public String mySpecialPosts(
							HttpSession session,
							Model model,
							HttpServletRequest req,
							@RequestParam(name = "page", defaultValue = "1") int page,
							@RequestParam(name = "size", defaultValue = "12") int size,
							@RequestParam(name = "challengeId", required = false) Long challengeId,
							@RequestParam(name = "kwd", required = false) String kwd) {
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if(info == null) return "redirect:/member/login";
		
		int dataCount = service.countMySpecialPosts(info.getMemberId(), challengeId, kwd);
		int total_page = paginateUtil.pageCount(dataCount, size);
		if(total_page == 0) total_page = 1;
		if(page > total_page) page = total_page;
		if(page < 1) page = 1;
		
		int offset = (page - 1) * size;
		
		List<Challenge> list = service.listMySpecialPostsPaged(info.getMemberId(), challengeId, offset, size, kwd);
		
		// 페이징 URL
		
		StringBuilder base = new StringBuilder(req.getContextPath())
				.append("/challenge/mypage/specialPosts?size=").append(size);
		if(challengeId != null) base.append("&challengeId=").append(challengeId);
		if(kwd != null && !kwd.isBlank())
			base.append("&kwd=").append(myUtil.encodeUrl(kwd)); 
		String paging = paginateUtil.pagingUrl(page, total_page, base.toString());
		
		model.addAttribute("list",list);
		model.addAttribute("page",page);
		model.addAttribute("size",size);
		model.addAttribute("dataCount",dataCount);
		model.addAttribute("paging",paging);
		model.addAttribute("kwd",kwd);
		model.addAttribute("challengeId",challengeId);
		
		model.addAttribute("tab", "posts"); // 탭 활성화
		
		return "myPage/specialPosts";
				
	}
	
	

}
