package com.sp.app.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sp.app.admin.service.ChallengeManageService;
import com.sp.app.common.MyUtil;
import com.sp.app.common.PaginateUtil;
import com.sp.app.common.StorageService;
import com.sp.app.model.Challenge;

import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/admin/challengeManage/*")
public class ChallengeManagerController {

	private final ChallengeManageService service;
	private final PaginateUtil paginateUtil;
	private final MyUtil myUtil;
	private final StorageService storageService;

	// 실제 저장 경로: /uploads/challenge 
	private String uploadPath;

	@PostConstruct
	public void init() {
		this.uploadPath = storageService.getRealPath("/uploads/challenge");
	}

	// 목록 + 검색/페이징
	@GetMapping("list")
	public String list(@RequestParam(name = "page", defaultValue = "1") int current_page,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			@RequestParam(name = "challengeType", required = false) String challengeType,
			@RequestParam(name = "weekday", required = false) Integer weekday, 
			Model model, HttpServletRequest req) {
		try {
			kwd = myUtil.decodeUrl(kwd);

			int size = 10;
			Map<String, Object> map = new HashMap<>();
			map.put("kwd", kwd);
			map.put("challengeType", challengeType);
			map.put("weekday", weekday);

			int dataCount = service.dataCount(map);
			int total_page = paginateUtil.pageCount(dataCount, size);
			if (total_page == 0)
				total_page = 1;

			current_page = Math.min(Math.max(current_page, 1), total_page);
			int offset = Math.max((current_page - 1) * size, 0);

			map.put("offset", offset);
			map.put("size", size);

			List<Challenge> list = service.listChallenge(map);

			String cp = req.getContextPath();
			StringBuilder query = new StringBuilder();
			if (!kwd.isBlank()) {
				query.append(query.length() == 0 ? "" : "&").append("kwd=").append(myUtil.encodeUrl(kwd));
			}
			if (challengeType != null && !challengeType.isBlank()) {
				query.append(query.length() == 0 ? "" : "&").append("challengeType=").append(challengeType);
			}
			if (weekday != null) {
				query.append(query.length() == 0 ? "" : "&").append("weekday=").append(weekday);
			}

			String listUrl = cp + "/admin/challengeManage/list" + (query.length() > 0 ? "?" + query : "");
			String paging = paginateUtil.pagingUrl(current_page, Math.max(total_page, 1), listUrl);

			model.addAttribute("list", list);
			model.addAttribute("page", current_page);
			model.addAttribute("size", size);
			model.addAttribute("total_page", Math.max(total_page, 1));
			model.addAttribute("paging", paging);

			model.addAttribute("kwd", kwd);
			model.addAttribute("challengeType", challengeType);
			model.addAttribute("weekday", weekday);

		} catch (Exception e) {
			log.error("admin challenge list :", e);
		}
		return "admin/challengeManage/list";
	}

	// 작성 폼
	@GetMapping("write")
	public String writeForm(Model model) {
		model.addAttribute("mode", "write");
		return "admin/challengeManage/write";
	}

	// 작성 처리 
	@PostMapping("write")
	public String writeSubmit(Challenge dto, RedirectAttributes ra) {
		try {
			normalizeType(dto); 

			
			if ("DAILY".equals(dto.getChallengeType()) && dto.getWeekday() == null) {
				ra.addFlashAttribute("message", "DAILY는 요일(weekday)이 필요합니다.");
				return "redirect:/admin/challengeManage/write";
			}
			if ("SPECIAL".equals(dto.getChallengeType())
					&& (isBlank(dto.getStartDate()) || isBlank(dto.getEndDate()))) {
				ra.addFlashAttribute("message", "SPECIAL은 시작일/종료일이 필요합니다.");
				return "redirect:/admin/challengeManage/write";
			}

			service.insertChallenge(dto, uploadPath);
			ra.addFlashAttribute("message", "등록이 완료되었습니다.");
		} catch (Exception e) {
			log.error("admin challenge writeSubmit :", e);
			ra.addFlashAttribute("message", "등록에 실패했습니다. 다시 시도해 주세요.");
			return "redirect:/admin/challengeManage/write";
		}
		return "redirect:/admin/challengeManage/list";
	}

	// 상세 페이지
	@GetMapping("article")
	public String article(@RequestParam("challengeId") long challengeId,
			@RequestParam(name = "page", defaultValue = "1") String page,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			@RequestParam(name = "challengeType", required = false) String challengeType, Model model) {
		String query = buildQuery(page, kwd, challengeType);
		try {
			Challenge dto = service.findById(challengeId);
			if (dto == null)
				throw new IllegalArgumentException("데이터가 존재하지 않습니다.");

			if ("DAILY".equalsIgnoreCase(dto.getChallengeType())) {
				Challenge d = service.findDailyById(challengeId);
				if (d != null)
					dto.setWeekday(d.getWeekday());
			} else if ("SPECIAL".equalsIgnoreCase(dto.getChallengeType())) {
				Challenge s = service.findSpecialById(challengeId);
				if (s != null) {
					dto.setStartDate(s.getStartDate());
					dto.setEndDate(s.getEndDate());
					dto.setRequireDays(s.getRequireDays());
					dto.setSpecialStatus(s.getSpecialStatus());
				}
			}

			model.addAttribute("dto", dto);
			model.addAttribute("page", page);
			model.addAttribute("query", query);
			return "admin/challengeManage/article";
			
		} catch (Exception e) {
			log.error("admin challenge article :", e);
			return "redirect:/admin/challengeManage/list?" + query;
		}
	}

	// 수정 폼
	@GetMapping("update")
	public String updateForm(@RequestParam("challengeId") long challengeId,
			@RequestParam(name = "page", defaultValue = "1") String page, Model model) {
		try {
			Challenge dto = service.findById(challengeId);
			if (dto == null)
				throw new IllegalArgumentException("데이터가 존재하지 않습니다.");

			if ("DAILY".equalsIgnoreCase(dto.getChallengeType())) {
				Challenge d = service.findDailyById(challengeId);
				if (d != null)
					dto.setWeekday(d.getWeekday());
			} else if ("SPECIAL".equalsIgnoreCase(dto.getChallengeType())) {
				Challenge s = service.findSpecialById(challengeId);
				if (s != null) {
					dto.setStartDate(s.getStartDate());
					dto.setEndDate(s.getEndDate());
					dto.setRequireDays(s.getRequireDays());
					dto.setSpecialStatus(s.getSpecialStatus());
				}
			}

			model.addAttribute("mode", "update");
			model.addAttribute("page", page);
			model.addAttribute("dto", dto);
			return "admin/challengeManage/write";
		} catch (Exception e) {
			log.error("admin challenge updateForm :", e);
			return "redirect:/admin/challengeManage/list?page=" + page;
		}
	}

	// 수정 처리
	@PostMapping("update")
	public String updateSubmit(Challenge dto, @RequestParam(name = "page", defaultValue = "1") String page,
			RedirectAttributes ra) {
		try {
			normalizeType(dto);

			// 타입별 최소 검증
			if ("DAILY".equals(dto.getChallengeType()) && dto.getWeekday() == null) {
				ra.addFlashAttribute("message", "DAILY는 요일(weekday)이 필요합니다.");
				return "redirect:/admin/challengeManage/update?challengeId=" + dto.getChallengeId() + "&page=" + page;
			}
			if ("SPECIAL".equals(dto.getChallengeType())
					&& (isBlank(dto.getStartDate()) || isBlank(dto.getEndDate()))) {
				ra.addFlashAttribute("message", "SPECIAL은 시작일/종료일이 필요합니다.");
				return "redirect:/admin/challengeManage/update?challengeId=" + dto.getChallengeId() + "&page=" + page;
			}

			
			service.updateChallenge(dto, uploadPath);
			ra.addFlashAttribute("message", "수정이 완료되었습니다.");
		} catch (Exception e) {
			log.error("admin challenge updateSubmit :", e);
			ra.addFlashAttribute("message", "수정에 실패했습니다. 다시 시도해 주세요.");
			return "redirect:/admin/challengeManage/update?challengeId=" + dto.getChallengeId() + "&page=" + page;
		}
		return "redirect:/admin/challengeManage/list?page=" + page;
	}

	// 삭제
	@GetMapping("delete")
	public String delete(@RequestParam("challengeId") long challengeId,
			@RequestParam(name = "page", defaultValue = "1") String page, RedirectAttributes ra) {
		try {
			service.deleteChallenge(challengeId, uploadPath);
			ra.addFlashAttribute("message", "삭제되었습니다.");
		} catch (Exception e) {
			log.error("admin challenge delete :", e);
			ra.addFlashAttribute("message", "삭제에 실패했습니다.");
		}
		return "redirect:/admin/challengeManage/list?page=" + page;
	}

	// 유틸
	private static boolean isBlank(String s) {
		return s == null || s.isBlank();
	}

	private static void normalizeType(Challenge dto) {
		if (dto.getChallengeType() != null) {
			dto.setChallengeType(dto.getChallengeType().trim().toUpperCase());
		}
	}

	private String buildQuery(String page, String kwd, String challengeType) {
		StringBuilder q = new StringBuilder("page=").append(page == null ? "1" : page);
		try {
			kwd = myUtil.decodeUrl(kwd);
			if (!isBlank(kwd))
				q.append("&kwd=").append(myUtil.encodeUrl(kwd));
		} catch (Exception e) {
		
		}
		if (!isBlank(challengeType))
			q.append("&challengeType=").append(challengeType);
		return q.toString();
	}

	
	// 인증 목록
	@GetMapping("certList")
	public String certList(
	        @RequestParam(value="page", defaultValue="1") int currentPage,
	        @RequestParam(value="keyword", required=false) String keyword,
	        @RequestParam(value="type", defaultValue="ALL") String type,
	        @RequestParam(value="approvalStatus", required=false) Integer approvalStatus,
	        Model model, HttpServletRequest req) {

	    final int size = 10;

	    // DAILY는 승인 개념 없음 → 상태 필터 무시
	    boolean isDaily = "DAILY".equalsIgnoreCase(type);
	    if (isDaily) approvalStatus = null;

	    // 목록/페이징 파라미터
	    Map<String,Object> param = new HashMap<>();
	    param.put("keyword", keyword);
	    param.put("type", type);
	    param.put("approvalStatus", approvalStatus);

	    int total = service.countAdminCerts(param);
	    int totalPage = paginateUtil.pageCount(total, size);
	    currentPage = Math.min(Math.max(currentPage, 1), Math.max(totalPage, 1));
	    int offset = (currentPage - 1) * size;

	    param.put("offset", offset);
	    param.put("size", size);

	    List<Challenge> list = service.listAdminCerts(param);

	    // 요약칩: SPECIAL일 때만 사용 (JSP도 type=='SPECIAL'일 때만 출력)
	    Map<String,Object> base = new HashMap<>();
	    base.put("keyword", keyword);
	    base.put("type", "SPECIAL");

	    Map<String,Object> p0 = new HashMap<>(base); p0.put("approvalStatus", 0); // 대기
	    Map<String,Object> p1 = new HashMap<>(base); p1.put("approvalStatus", 1); // 승인
	    Map<String,Object> p2 = new HashMap<>(base); p2.put("approvalStatus", 2); // 반려

	    model.addAttribute("countPending",  service.countAdminCerts(p0));
	    model.addAttribute("countApproved", service.countAdminCerts(p1));
	    model.addAttribute("countRejected", service.countAdminCerts(p2));

	    // 페이징 URL
	    String baseUrl = req.getContextPath() + "/admin/challengeManage/certList";
	    StringBuilder qs = new StringBuilder();
	    try {
	        if (keyword != null && !keyword.isBlank()) {
	            qs.append(qs.length()==0 ? "?" : "&")
	              .append("keyword=").append(myUtil.encodeUrl(keyword));
	        }
	    } catch (Exception ignore) {}
	    if (type != null && !"ALL".equalsIgnoreCase(type)) {
	        qs.append(qs.length()==0 ? "?" : "&").append("type=").append(type);
	    }
	    if (approvalStatus != null && !isDaily) {
	        qs.append(qs.length()==0 ? "?" : "&").append("approvalStatus=").append(approvalStatus);
	    }

	    String listUrl = baseUrl + (qs.length() > 0 ? qs.toString() : "");
	    String paging = paginateUtil.pagingUrl(currentPage, Math.max(totalPage, 1), listUrl);

	    model.addAttribute("list", list);
	    model.addAttribute("paging", paging);
	    model.addAttribute("keyword", keyword);
	    model.addAttribute("page", currentPage);
	    model.addAttribute("type", type);
	    model.addAttribute("approvalStatus", approvalStatus);

	    return "admin/challengeManage/certList";
	}


	// 승인
	@PostMapping("cert/approve")
	public String approve(
			@RequestParam("postId") long postId,
			@RequestParam(value="page", defaultValue="1") int page,
            @RequestParam(value="keyword", required=false) String keyword,
            @RequestParam(value="type", defaultValue="ALL") String type,
            @RequestParam(value="approvalStatus", required=false) Integer approvalStatus,
			RedirectAttributes ra) {
		try {
			service.approveCert(postId);
			ra.addFlashAttribute("message", "승인되었습니다.");
		} catch (Exception e) {
			log.error("approve error postId={}", postId, e);
			ra.addFlashAttribute("message", "승인 처리에 실패했습니다: " + e.getMessage());
		}
		StringBuilder redir = new StringBuilder("redirect:/admin/challengeManage/certList?page=").append(page);
	    if (keyword != null && !keyword.isBlank()) redir.append("&keyword=").append(myUtil.encodeUrl(keyword));
	    if (type != null) redir.append("&type=").append(type);
	    if (approvalStatus != null) redir.append("&approvalStatus=").append(approvalStatus);
	    return redir.toString();
	}

	// 반려
	@PostMapping("cert/reject")
	public String reject(
			@RequestParam("postId") long postId,
			@RequestParam(value="page", defaultValue="1") int page,
            @RequestParam(value="keyword", required=false) String keyword,
            @RequestParam(value="type", defaultValue="ALL") String type,
            @RequestParam(value="approvalStatus", required=false) Integer approvalStatus,
			RedirectAttributes ra) {
		try {
			service.rejectCert(postId);
			ra.addFlashAttribute("message", "반려되었습니다.");
		} catch (Exception e) {
			log.error("reject error postId={}", postId, e);
			ra.addFlashAttribute("message", "반려 처리에 실패했습니다: " + e.getMessage());
		}
		StringBuilder redir = new StringBuilder("redirect:/admin/challengeManage/certList?page=").append(page);
	    if (keyword != null && !keyword.isBlank()) redir.append("&keyword=").append(myUtil.encodeUrl(keyword));
	    if (type != null) redir.append("&type=").append(type);
	    if (approvalStatus != null) redir.append("&approvalStatus=").append(approvalStatus);
	    return redir.toString();
	}
	
	// 상세보기 (인증글)
	@GetMapping("cert/detail")
	public String certDetail(
	        @RequestParam("postId") long postId,
	        @RequestParam(value="page", defaultValue="1") int page,
	        @RequestParam(value="keyword", required=false) String keyword,
	        @RequestParam(value="type", defaultValue="ALL") String type,
	        @RequestParam(value="approvalStatus", required=false) Integer approvalStatus,
	        Model model, RedirectAttributes ra) {

	    try {
	        // 인증글/챌린지/회원 정보
	        com.sp.app.model.Challenge dto = service.findCertDetail(postId);
	        if (dto == null) {
	            ra.addFlashAttribute("message", "데이터가 없습니다.");
	            return buildCertListRedirect(page, keyword, type, approvalStatus);
	        }

	        // 사진 목록
	        java.util.List<String> photos = service.listCertPhotos(postId);

	        model.addAttribute("dto", dto);
	        model.addAttribute("photos", photos);

	        model.addAttribute("page", page);
	        model.addAttribute("keyword", keyword);
	        model.addAttribute("type", type);
	        model.addAttribute("approvalStatus", approvalStatus);

	        return "admin/challengeManage/certDetail";
	    } catch (Exception e) {
	        log.error("certDetail error postId={}", postId, e);
	        ra.addFlashAttribute("message", "상세 조회에 실패했습니다.");
	        return buildCertListRedirect(page, keyword, type, approvalStatus);
	    }
	}

	private String buildCertListRedirect(int page, String keyword, String type, Integer approvalStatus) {
	    StringBuilder redir = new StringBuilder("redirect:/admin/challengeManage/certList?page=").append(page);
	    try {
	        if (keyword != null && !keyword.isBlank()) {
	            redir.append("&keyword=").append(myUtil.encodeUrl(keyword));
	        }
	    } catch (Exception ignore) {}
	    if (type != null) redir.append("&type=").append(type);
	    if (approvalStatus != null) redir.append("&approvalStatus=").append(approvalStatus);
	    return redir.toString();
	}


}
