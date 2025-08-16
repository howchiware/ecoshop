package com.sp.app.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.model.SessionInfo;
import com.sp.app.model.Workshop;
import com.sp.app.model.WorkshopReview;
import com.sp.app.service.WorkshopService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/workshop")
public class WorkshopController {

	private final WorkshopService service;

	// 워크샵 목록
	@GetMapping("/list")
	public String userWorkshopList(@RequestParam(name = "page", defaultValue = "1") int currentPage,
			@RequestParam(name = "categoryId", required = false) Long categoryId,
			@RequestParam(name = "sort", defaultValue = "latest") String sort,
			@RequestParam(name = "onlyRecruiting", defaultValue = "true") boolean onlyRecruiting, Model model)
			throws Exception {

		try {
			final int size = 9;

			// 페이징
			Map<String, Object> pmap = new HashMap<>();
			if (categoryId != null)
				pmap.put("categoryId", categoryId);
			pmap.put("onlyRecruiting", onlyRecruiting);

			int dataCount = service.userWorkshopDataCount(pmap);

			int totalPage = (dataCount + size - 1) / size;
			if (totalPage == 0)
				totalPage = 1;
			if (currentPage > totalPage)
				currentPage = totalPage;

			int offset = (currentPage - 1) * size;
			if (offset < 0)
				offset = 0;

			Map<String, Object> map = new HashMap<String, Object>();
			if (categoryId != null)
				map.put("categoryId", categoryId);
			map.put("onlyRecruiting", onlyRecruiting);
			map.put("sort", sort);
			map.put("offset", offset);
			map.put("size", size);

			List<Workshop> list = service.listUserWorkshop(map);

			// 카테고리 드롭다운
			Map<String, Object> cmap = new HashMap<String, Object>();
			cmap.put("offset", 0);
			cmap.put("size", 200);
			List<Workshop> category = service.listCategory(cmap);

			model.addAttribute("list", list);
			model.addAttribute("page", currentPage);
			model.addAttribute("size", size);
			model.addAttribute("totalPage", totalPage);
			model.addAttribute("dataCount", dataCount);

			model.addAttribute("categoryId", categoryId);
			model.addAttribute("category", category);
			model.addAttribute("sort", sort);
			model.addAttribute("onlyRecruiting", onlyRecruiting);

		} catch (Exception e) {
			log.info("userWorkshopList : ", e);

			throw e;
		}

		return "workshop/list";
	}

	// 상세
	@GetMapping("/detail")
	public String userWorkshopDetail(@RequestParam(name = "workshopId", required = false) Long workshopId,
			@RequestParam(name = "page", defaultValue = "1") String page, Model model) {

		if (workshopId == null)
			return "redirect:/workshop/list?page=" + page;

		try {
			Workshop dto = service.findWorkshopDetail(workshopId);
			
			String thumbPath;
			if (dto.getThumbnailPath() == null || dto.getThumbnailPath().isEmpty()) {
				thumbPath = "/dist/images/noimage.png";
			} else if (dto.getThumbnailPath().startsWith("http") || dto.getThumbnailPath().startsWith("/")) {
				thumbPath = dto.getThumbnailPath();
			} else {
				thumbPath = "/uploads/workshop/" + dto.getThumbnailPath();
			}
			
			Map<String, Object> map = new HashMap<>();
			map.put("workshopId", workshopId);
			List<Workshop> photoList = service.listWorkshopPhoto(map);

			model.addAttribute("dto", dto);
			model.addAttribute("thumbPath", thumbPath);
			model.addAttribute("photoList", photoList);
			model.addAttribute("page", page);
			model.addAttribute("query", "page=" + page);
			return "workshop/detail";
		} catch (Exception e) {
			log.info("userWorkshopDetail : ", e);
			return "redirect:/workshop/list?page=" + page;
		}
	}

	// 신청 페이지
	@GetMapping("/apply")
	public String applyWorkshop(
	        @RequestParam(name = "workshopId", required = false) Long workshopId,
	        HttpSession session, Model model) {

	    if (workshopId == null) return "redirect:/workshop/list";

	    try {
	        SessionInfo info = (SessionInfo) session.getAttribute("member");
	        if (info == null) {
	            session.setAttribute("msg", "로그인 후 이용해주세요.");
	            return "redirect:/member/login";
	        }

	        Workshop detail = service.findWorkshopDetail(workshopId);
	        model.addAttribute("detail", detail);
	        model.addAttribute("workshopId", workshopId);
	        return "workshop/apply";
	    } catch (Exception e) {
	        log.info("applyWorkshop : ", e);
	        return "redirect:/workshop/detail?workshopId=" + workshopId;
	    }
	}


	// 신청 제출
	@PostMapping("/submit")
	public String writeSubmitWorkshop(@RequestParam(name = "workshopId") long workshopId,
			@RequestParam(name = "name") String name, @RequestParam(name = "tel") String tel,
			@RequestParam(name = "email") String email, @RequestParam(name = "agreeTerms") boolean agreeTerms,
			@RequestParam(name = "agreeMarketing", defaultValue = "false") boolean agreeMarketing, HttpSession session)
			throws Exception {
		
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			if (info == null) { // 로그인 체크
				session.setAttribute("msg", "로그인 후 이용해주세요.");
				return "redirect:/member/login";
			}

			// 필수 동의
			if (!agreeTerms) {
				session.setAttribute("msg", "필수 동의를 체크해주세요.");
				return "redirect:/workshop/apply?workshopId=" + workshopId;
			}

			// 신청 여부
			Map<String, Object> map = new HashMap<>();
			map.put("workshopId", workshopId);
			map.put("memberId", info.getMemberId());

			if (service.hasApplied(map) > 0) {
				session.setAttribute("msg", "이미 신청하셨습니다.");
				return "redirect:/workshop/apply?workshopId=" + workshopId;
			}

			// 모집 상태
			Workshop status = service.findWorkshopStatusAndCapacity(workshopId);
			if (status.getWorkshopStatus() != 1) {
				session.setAttribute("msg", "모집이 마감되었습니다.");
				return "redirect:/workshop/apply?workshopId=" + workshopId;
			}

			Map<String, Object> p = new HashMap<>();
			p.put("workshopId", workshopId);
			p.put("memberId", info.getMemberId());
			p.put("agreeTerms", agreeTerms);
			p.put("agreeMarketing", agreeMarketing);

			service.applyWorkshop(p);

			session.setAttribute("msg", "신청이 완료되었습니다.");
			return "redirect:/workshop/detail?workshopId=" + workshopId;

		} catch (Exception e) {
			log.error("workshop writeSubmit : ", e);
			session.setAttribute("msg", "신청 처리 중 오류가 발생했습니다.");

			return "redirect:/workshop/apply?workshopId=" + workshopId;
		}
	}

	// 신청 취소
	@PostMapping("apply/cancel")
	public String applyCancelWorkshop(@RequestParam(name = "workshopId") long workshopId, HttpSession session)
			throws Exception {
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			if (info == null) {
				session.setAttribute("msg", "로그인 후 이용해주세요.");
				return "redirect:/member/login";
			}

			Map<String, Object> map = new HashMap<>();
			map.put("memberId", info.getMemberId());
			map.put("workshopId", workshopId);

			service.cancelApplication(map);

			session.setAttribute("msg", "신청이 취소되었습니다.");
			return "redirect:/workshop/detail?workshopId=" + workshopId;

		} catch (Exception e) {
			log.error("workshop writeSubmit : ", e);
			session.setAttribute("msg", "취소 처리 중 오류가 발생했습니다.");

			return "redirect:/workshop/detail?workshopId=" + workshopId;
		}
	}

	// FAQ 목록
	@GetMapping("/faq/list")
	@ResponseBody
	public Map<String, Object> userFaqList(@RequestParam(name = "page", defaultValue = "1") int currentPage,
			@RequestParam(name = "workshopId", required = false) Long workshopId, Model model) throws Exception {

		final int size = 9;

		// 총 개수
		Map<String, Object> pmap = new HashMap<>();
		pmap.put("workshopId", workshopId);
		int dataCount = service.faqDataCount(pmap);

		// 페이징 계산
		int totalPage = (dataCount + size - 1) / size;
		if (totalPage == 0)
			totalPage = 1;
		if (currentPage > totalPage)
			currentPage = totalPage;

		int offset = (currentPage - 1) * size;
		if (offset < 0)
			offset = 0;

		// 목록 조회
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("workshopId", workshopId);
		map.put("offset", offset);
		map.put("size", size);

		List<Workshop> list = service.listUserFaq(map);

		Map<String, Object> result = new HashMap<>();

		result.put("list", list);
		result.put("page", currentPage);
		result.put("size", size);
		result.put("totalPage", totalPage);
		result.put("dataCount", dataCount);

		return result;
	}

	// 후기 목록
	@GetMapping("/review/list")
	@ResponseBody
	public Map<String, Object> userReviewList(@RequestParam(name = "page", defaultValue = "1") int currentPage,
			@RequestParam(name = "workshopId", required = false) Long workshopId, Model model) throws Exception {

		final int size = 9;

		// 총 개수
		Map<String, Object> pmap = new HashMap<>();
		pmap.put("workshopId", workshopId);
		int dataCount = service.reviewDataCount(pmap);

		// 페이징 계산
		int totalPage = (dataCount + size - 1) / size;
		if (totalPage == 0)
			totalPage = 1;
		if (currentPage > totalPage)
			currentPage = totalPage;

		int offset = (currentPage - 1) * size;
		if (offset < 0)
			offset = 0;

		// 목록 조회
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("workshopId", workshopId);
		map.put("offset", offset);
		map.put("size", size);

		List<WorkshopReview> list = service.listUserReview(map);

		Map<String, Object> result = new HashMap<>();

		result.put("list", list);
		result.put("page", currentPage);
		result.put("size", size);
		result.put("totalPage", totalPage);
		result.put("dataCount", dataCount);

		return result;
	}

	// 후기 등록
	@PostMapping("/review/submit")
	@ResponseBody
	public Map<String, Object> submitReview(@RequestParam(name = "workshopId") long workshopId,
			@RequestParam(name = "participantId") long participantId, @RequestParam String reviewContent,
			HttpSession session) throws Exception {

		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if (info == null) {
			return Map.of("success", false, "error", "login_required");
		}

		if (!service.isParticipantOfMember(participantId, info.getMemberId())) {
			return Map.of("success", false, "error", "not_allowed");
		}

		Map<String, Object> map = new HashMap<>();
		map.put("participantId", participantId);
		map.put("workshopId", workshopId);

		if (service.reviewDataCount(map) > 0) {
			return Map.of("success", false, "error", "duplicate");
		}

		WorkshopReview dto = new WorkshopReview();
		dto.setWorkshopId(workshopId);
		dto.setParticipantId(participantId);
		dto.setReviewContent(reviewContent);

		service.insertReview(dto);

		return Map.of("success", true);
	}

	// 후기 수정

	// 후기 삭제

}
