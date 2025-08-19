package com.sp.app.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.sp.app.common.MyUtil;
import com.sp.app.common.StorageService;
import com.sp.app.model.Participant;
import com.sp.app.model.Workshop;
import com.sp.app.model.WorkshopFaq;
import com.sp.app.service.WorkshopService;

import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/admin/workshop")
public class WorkshopManageController {
	private final WorkshopService service;
	private final MyUtil myUtil;
	private final StorageService storageService;

	private String uploadPath;

	@PostConstruct
	public void init() {
		uploadPath = this.storageService.getRealPath("/uploads/workshop");
	}

	// 프로그램 등록 폼
	@GetMapping("/program/write")
	public String programWriteForm(Model model) {
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("offset", 0);
			map.put("size", 200);

			List<Workshop> category = service.listCategory(map);

			model.addAttribute("category", category);
			model.addAttribute("mode", "write");
		} catch (Exception e) {
			log.info("program writeForm : ", e);
		}

		return "admin/workshop/programWrite";
	}

	// 카테고리 등록
	@PostMapping("/category")
	public String addCategory(Workshop dto, @RequestParam("categoryName") String categoryName) {
		try {
			service.insertCategory(dto, categoryName);
		} catch (Exception e) {
			log.info("program addCategory : ", e);
		}

		return "redirect:/admin/workshop/program/write";
	}

	// 프로그램 등록
	@PostMapping("/program/write")
	public String writeSubmitProgram(Workshop dto, HttpSession session) throws Exception {
		try {
			service.insertProgram(dto);
		} catch (Exception e) {
			log.info("program writeSubmit : ", e);
		}
		return "redirect:/admin/workshop/program/list";
	}

	// 프로그램 목록
	@GetMapping("/program/list")
	public String programList(@RequestParam(name = "page", defaultValue = "1") int current_page,
			@RequestParam(name = "kwd", defaultValue = "latest") String kwd,
			@RequestParam(name = "categoryId", required = false) Long categoryId, 
			Model model) {

		try {
			kwd = myUtil.decodeUrl(kwd);

			int size = 10;
			int offset = (current_page - 1) * size;
			if (offset < 0)
				offset = 0;

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("offset", offset);
			map.put("size", size);

			if (!kwd.isBlank())
				map.put("kwd", kwd);
			if (categoryId != null)
				map.put("categoryId", categoryId);

			List<Workshop> list = service.listProgram(map);

			// 카테고리 드롭다운
			Map<String, Object> cmap = new HashMap<String, Object>();
			cmap.put("offset", 0);
			cmap.put("size", 200);
			List<Workshop> category = service.listCategory(cmap);

			model.addAttribute("list", list);
			model.addAttribute("page", current_page);
			model.addAttribute("size", size);
			model.addAttribute("kwd", kwd);
			model.addAttribute("categoryId", categoryId);
			model.addAttribute("category", category);

		} catch (Exception e) {
			log.info("programList : ", e);
		}

		return "admin/workshop/programList";
	}

	// 프로그램 내용 상세보기
	@GetMapping("/program/detail")
	@ResponseBody
	public Map<String, Object> programDetail(@RequestParam("programId") Long programId) {
		Workshop dto = service.findProgramById(programId);
		Map<String, Object> map = new HashMap<>();
		String content = (dto == null || dto.getProgramContent() == null) ? "" : dto.getProgramContent();
		map.put("programContent", content);
		return map;
	}

	// 프로그램 수정
	@GetMapping("/program/update")
	public String updateFormProgram(@RequestParam(name = "num") long num, @RequestParam(name = "page") String page,
			Model model) throws Exception {
		try {
			Workshop dto = Objects.requireNonNull(service.findProgramById(num));

			Map<String, Object> map = new HashMap<>();
			map.put("offset", 0);
			map.put("size", 200);

			List<Workshop> categoryList = service.listCategory(map);

			model.addAttribute("category", categoryList);
			model.addAttribute("dto", dto);
			model.addAttribute("mode", "update");
			model.addAttribute("page", page);

			return "admin/workshop/programWrite";
		} catch (NullPointerException e) {
		} catch (Exception e) {
			log.info("update Program : ", e);
		}

		return "redirect:/admin/workshop/program/list?page=" + page;
	}

	@PostMapping("/program/update")
	public String updateSubmitProgram(Workshop dto, @RequestParam(name = "page", defaultValue = "1") String page)
			throws Exception {
		try {
			service.updateProgram(dto);
		} catch (Exception e) {
			log.info("update Program : ", e);
			throw e;
		}

		return "redirect:/admin/workshop/program/list?page=" + page;
	}

	// 프로그램 삭제
	@PostMapping("/program/delete")
	public String deleteProgram(@RequestParam(name = "num") long num,
			@RequestParam(name = "page", defaultValue = "1") String page,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd) throws Exception {
		String query = "page=" + page;
		try {
			kwd = myUtil.decodeUrl(kwd);
			if (!kwd.isBlank()) {
				query += "&schType=" + schType + "&kwd=" + myUtil.encodeUrl(kwd);
			}

			service.deleteProgram(num);
		} catch (Exception e) {
			log.info("delete Program : ", e);
			throw e;
		}

		return "redirect:/admin/workshop/program/list?" + query;
	}

	// 담당자 등록
	@PostMapping("/manager/write")
	public String addManager(Workshop dto) {
		try {
			service.insertManager(dto);
		} catch (Exception e) {
			log.info("workshop addManager : ", e);
		}

		return "redirect:/admin/workshop/manager/list";
	}

	// 담당자 목록
	@GetMapping("/manager/list")
	public String managerList(@RequestParam(name = "page", defaultValue = "1") int current_page,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			@RequestParam(name = "managerId", required = false) Long managerId, Model model) throws Exception {

		try {
			kwd = myUtil.decodeUrl(kwd);

			int size = 10;
			int offset = (current_page - 1) * size;
			if (offset < 0)
				offset = 0;

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("schType", schType);
			map.put("offset", offset);
			map.put("size", size);

			if (!kwd.isBlank())
				map.put("kwd", kwd);
			if (managerId != null)
				map.put("managerId", managerId);

			List<Workshop> list = service.listManager(map);

			model.addAttribute("list", list);
			model.addAttribute("page", current_page);
			model.addAttribute("size", size);
			model.addAttribute("kwd", kwd);
			model.addAttribute("managerId", managerId);

		} catch (Exception e) {
			log.info("manager List : ", e);
			throw e;
		}

		return "admin/workshop/managerList";
	}

	// 담당자 수정
	@GetMapping("/manager/update")
	public String updateManager(@RequestParam(name = "num") long num, @RequestParam(name = "page") String page,
			Model model) throws Exception {
		try {
			Workshop dto = Objects.requireNonNull(service.findManagerById(num));

			Map<String, Object> map = new HashMap<>();
			map.put("offset", 0);
			map.put("size", 200);

			model.addAttribute("dto", dto);
			model.addAttribute("mode", "update");
			model.addAttribute("page", page);

			return "admin/workshop/managerList";
		} catch (Exception e) {
			log.info("update Manager : ", e);
		}

		return "redirect:/admin/workshop/manager/list?page=" + page;
	}

	@PostMapping("/manager/update")
	public String updateSubmitManager(Workshop dto, @RequestParam(name = "page", defaultValue = "1") String page)
			throws Exception {
		try {
			service.updateManager(dto);
		} catch (Exception e) {
			log.info("update Manager : ", e);
			throw e;
		}

		return "redirect:/admin/workshop/manager/list?page=" + page;
	}

	// 담당자 삭제
	@PostMapping("/manager/delete")
	public String deleteManager(@RequestParam(name = "num") long num,
			@RequestParam(name = "page", defaultValue = "1") String page,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd) throws Exception {
		String query = "page=" + page;
		try {
			kwd = myUtil.decodeUrl(kwd);
			if (!kwd.isBlank()) {
				query += "&schType=" + schType + "&kwd=" + myUtil.encodeUrl(kwd);
			}

			service.deleteManager(num);
		} catch (Exception e) {
			log.info("delete Program : ", e);
			throw e;
		}

		return "redirect:/admin/workshop/manager/list?" + query;
	}

	// 워크샵 목록
	@GetMapping("/list")
	public String workshopList(@RequestParam(name = "page", defaultValue = "1") int current_page,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "workshopStatus", required = false) String workshopStatus,
			@RequestParam(name = "kwd", defaultValue = "") String kwd, Model model, HttpServletRequest req)
			throws Exception {
		try {
			int size = 10;
			int total_page = 0;
			int dataCount = 0;

			kwd = myUtil.decodeUrl(kwd);

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("schType", schType);
			map.put("kwd", kwd);
			
			if (workshopStatus != null && !workshopStatus.isBlank()) {
		        map.put("workshopStatus", workshopStatus);
		    }

			dataCount = service.workshopDataCount(map);
			if (dataCount > 0) {
				total_page = (dataCount + size - 1) / size;
				if (current_page > total_page)
					current_page = total_page;
			} else {
				current_page = 1;
			}

			int offset = (current_page - 1) * size;
			if (offset < 0)
				offset = 0;

			map.put("offset", offset);
			map.put("size", size);

			List<Workshop> list = service.listWorkshop(map);

			Map<String, Object> programMap = new HashMap<>();
			programMap.put("offset", 0);
			programMap.put("size", 100);
			List<Workshop> programList = service.listProgram(programMap);
			model.addAttribute("programList", programList);

			String cp = req.getContextPath();
			String query = "";
			String listUrl = cp + "/admin/workshop/list";
			String detailUrl = cp + "/admin/workshop/detail?page=" + current_page;

			if (!kwd.isBlank()) {
				query = "schType=" + schType + "&kwd=" + myUtil.encodeUrl(kwd);

				listUrl += "?" + query;
				detailUrl += "&" + query;
			}

			model.addAttribute("list", list);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("size", size);
			model.addAttribute("total_page", total_page);
			model.addAttribute("page", current_page);

			model.addAttribute("listUrl", listUrl);
			model.addAttribute("detailUrl", detailUrl);

			model.addAttribute("schType", schType);
			model.addAttribute("kwd", kwd);
			model.addAttribute("workshopStatus", workshopStatus);

		} catch (Exception e) {
			log.info("workshop list : ", e);
		}

		return "admin/workshop/workshopList";
	}
	
	@PostMapping("/updateStatus")
	@ResponseBody
	public Map<String, Object> updateStatus(@RequestBody Workshop dto) {
		Map<String, Object> map = new HashMap<>();
		try {
			service.updateWorkshopStatus(dto);
			map.put("success", true);
		} catch (Exception e) {
			map.put("success", false);
		}
		return map;
	}

	// 워크샵 작성
	@GetMapping("/write")
	public String workshopWriteForm(Model model) throws Exception {
		Map<String, Object> programMap = new HashMap<>();
		programMap.put("offset", 0);
		programMap.put("size", 100);
		List<Workshop> programList = service.listProgram(programMap);

		Map<String, Object> managerMap = new HashMap<>();
		managerMap.put("offset", 0);
		managerMap.put("size", 100);
		List<Workshop> managerList = service.listManager(managerMap);

		model.addAttribute("mode", "write");
		model.addAttribute("programList", programList);
		model.addAttribute("managerList", managerList);

		return "admin/workshop/workshopWrite";
	}

	@PostMapping("/write")
	public String workshopWriteSubmit(Workshop dto, @RequestParam("thumbnail") MultipartFile thumbnail,
			@RequestParam("photos") List<MultipartFile> photos) throws Exception {
		try {
			// 썸네일
			if (thumbnail != null && !thumbnail.isEmpty()) {
				String path = storageService.uploadFileToServer(thumbnail, uploadPath);
				dto.setThumbnailPath(path);
			}

			service.insertWorkshop(dto);

			// 상세 이미지
			for (MultipartFile photo : photos) {
				if (photo != null && !photo.isEmpty()) {
					String path = storageService.uploadFileToServer(photo, uploadPath);

					dto.setWorkshopId(dto.getWorkshopId());
					dto.setWorkshopImagePath(path);

					service.insertWorkshopPhoto(dto);
				}
			}

		} catch (Exception e) {
			log.info("workshop writeSubmit : ", e);
		}
		return "redirect:/admin/workshop/list";
	}

	// 워크샵 상세
	@GetMapping("/detail")
	public String workshopDetail(@RequestParam(name = "num") long num,
			@RequestParam(name = "page", defaultValue = "1") String page, Model model) throws Exception {

		String query = "page=" + page;
		try {
			// 기본 정보
			Workshop dto = service.findWorkshopById(num);
			if (dto == null) {
				return "redirect:/admin/workshop/list?" + query;
			}

			// 상세 이미지
			Map<String, Object> map = new HashMap<>();
			map.put("workshopId", num);
			List<Workshop> photoList = service.listWorkshopPhoto(map);

			model.addAttribute("dto", dto);
			model.addAttribute("photoList", photoList);
			model.addAttribute("page", page);
			model.addAttribute("query", query);

			return "admin/workshop/workshopDetail";
		} catch (Exception e) {
			log.info("workshop detail : ", e);
		}

		return "redirect:/admin/workshop/list?" + query;
	}

	// 워크샵 수정
	@GetMapping("/update")
	public String updateFormWorkshop(@RequestParam(name = "num") long num, @RequestParam(name = "page") String page,
			Model model) throws Exception {
		try {
			Workshop dto = Objects.requireNonNull(service.findWorkshopById(num));

			// 프로그램 목록
			Map<String, Object> programMap = new HashMap<>();
			programMap.put("offset", 0);
			programMap.put("size", 100);
			List<Workshop> programList = service.listProgram(programMap);

			// 담당자 목록
			Map<String, Object> managerMap = new HashMap<>();
			managerMap.put("offset", 0);
			managerMap.put("size", 100);
			List<Workshop> managerList = service.listManager(managerMap);

			model.addAttribute("programList", programList);
			model.addAttribute("managerList", managerList);
			model.addAttribute("dto", dto);
			model.addAttribute("mode", "update");
			model.addAttribute("page", page);

			return "admin/workshop/workshopWrite";
		} catch (Exception e) {
			log.info("workshopUpdateForm : ", e);
		}

		return "redirect:/admin/workshop/list?page=" + page;
	}

	@PostMapping("/update")
	public String updateSubmitWorkshop(Workshop dto, @RequestParam(name = "page", defaultValue = "1") String page,
			@RequestParam(name = "thumbnail", required = false) MultipartFile newThumbnail)
			throws Exception {
		try {
			Workshop workshop = service.findWorkshopById(dto.getWorkshopId());
			
			if(newThumbnail != null && !newThumbnail.isEmpty()) {
				String path = storageService.uploadFileToServer(newThumbnail, uploadPath);
				dto.setThumbnailPath(path);
			} else {
				dto.setThumbnailPath(workshop.getThumbnailPath());
			}
			
			service.updateWorkshop(dto);
		} catch (Exception e) {
			log.info("update Workshop : ", e);
			throw e;
		}
		return "redirect:/admin/workshop/list?page=" + page;
	}

	// 워크샵 삭제
	@PostMapping("/delete")
	public String deleteWorkshop(@RequestParam(name = "num") long num,
			@RequestParam(name = "page", defaultValue = "1") String page,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd) throws Exception {
		String query = "page=" + page;
		try {
			kwd = myUtil.decodeUrl(kwd);

			if (!kwd.isBlank()) {
				query += "&schType=" + schType + "&kwd=" + myUtil.encodeUrl(kwd);
			}

			service.deleteWorkshop(num);
		} catch (Exception e) {
			log.info("delete Workshop : ", e);
			throw e;
		}

		return "redirect:/admin/workshop/list?" + query;
	}

	// 사진 업로드
	@PostMapping("/photo/upload")
	public String workshopPhotoUpload(Workshop dto, @RequestParam long workshopId,
			@RequestParam("photo") List<MultipartFile> files) {
		try {
			for (MultipartFile file : files) {
				if (file != null && !file.isEmpty()) {
					String path = storageService.uploadFileToServer(file, uploadPath);
					
					dto.setWorkshopId(workshopId);
					dto.setWorkshopImagePath(path);
					
					service.insertWorkshopPhoto(dto);
				}
			}
		} catch (Exception e) {
			log.info("workshopPhotoUpload : ", e);
		}

		return "redirect:/admin/workshop/photo/list?workshopId=" + workshopId;
	}

	// 사진 삭제
	@PostMapping("/photo/delete")
	public String photoDelete(@RequestParam long photoId, @RequestParam long workshopId) {
		try {
			service.deleteWorkshopPhotoById(photoId, uploadPath);
		} catch (Exception e) {
			log.error("사진 삭제 실패", e);
		}
		return "redirect:/admin/workshop/photo/list?workshopId=" + workshopId;
	}

	// FAQ 작성 폼
	@GetMapping("/faq/write")
	public String faqWriteForm(@RequestParam(name = "programId", required = false) Long programId, Model model) {
		try {
			Map<String, Object> pmap = new HashMap<>();
			pmap.put("offset", 0);
			pmap.put("size", 200);

			List<Workshop> programList = service.listProgram(pmap);

			model.addAttribute("programList", programList);
			model.addAttribute("programId", programId);
			model.addAttribute("mode", "write");
		} catch (Exception e) {
			log.info("faqWriteForm : ", e);
		}

		return "admin/workshop/faqWrite";
	}

	// FAQ 등록
	@PostMapping("/faq/write")
	public String writeSubmitFaq(WorkshopFaq dto, HttpSession session,
			@RequestParam(name = "page", defaultValue = "1") String page) throws Exception {
		try {
			service.insertFaq(dto);
			session.setAttribute("msg", "FAQ가 등록되었습니다.");
			return "redirect:/admin/workshop/faq/list?programId=" + dto.getProgramId() + "&page=" + page;
		} catch (Exception e) {
			log.info("writeSubmitProgram : ", e);
		}
		session.setAttribute("msg", "FAQ가 등록에 실패했습니다.");
		return "redirect:/admin/workshop/faq/write";
	}

	// FAQ 목록
	@GetMapping("/faq/list")
	public String faqList(@RequestParam(name = "programId", required = false) Long programId, Model model) {

		try {
			Map<String, Object> pmap = new HashMap<String, Object>();
			pmap.put("offset", 0);
			pmap.put("size", 300);

			List<Workshop> programList = service.listProgram(pmap);
			model.addAttribute("programList", programList);

			if (programId == null && programList != null && !programList.isEmpty()) {
				programId = programList.get(0).getProgramId();
			}
			model.addAttribute("programId", programId);

			List<WorkshopFaq> faqList = List.of();
			if (programId != null) {
				Map<String, Object> map = new HashMap<>();
				map.put("programId", programId);
				faqList = service.listFaq(map);
			}
			model.addAttribute("faqList", faqList);

		} catch (Exception e) {
			log.info("faqList : ", e);
		}

		return "admin/workshop/faqList";
	}

	// FAQ 수정
	@GetMapping("/faq/update")
	public String updateFormFaq(@RequestParam(name = "faqId") long faqId,
			@RequestParam(name = "page", defaultValue = "1") String page, Model model) throws Exception {
		try {
			WorkshopFaq faq = service.findFaqById(faqId);

			Map<String, Object> map = new HashMap<>();
			map.put("offset", 0);
			map.put("size", 200);
			List<Workshop> programList = service.listProgram(map);

			model.addAttribute("dto", faq);
			model.addAttribute("programList", programList);
			model.addAttribute("programId", faq.getProgramId());
			model.addAttribute("mode", "update");
			model.addAttribute("page", page);

			return "admin/workshop/faqWrite";
		} catch (Exception e) {
			log.info("updateFormFaq : ", e);
		}

		return "redirect:/admin/workshop/faq/list?page=" + page;
	}

	@PostMapping("/faq/update")
	public String updateSubmitFaq(WorkshopFaq dto, @RequestParam(name = "page", defaultValue = "1") String page)
			throws Exception {

		service.updateFaq(dto);

		return "redirect:/admin/workshop/faq/list?programId=" + dto.getProgramId() + "&page=" + page;
	}

	// FAQ 삭제
	@PostMapping("/faq/delete")
	public String deleteFaq(@RequestParam(name = "faqId") long faqId, @RequestParam(name = "programId") long programId,
			@RequestParam(name = "page", defaultValue = "1") String page) throws Exception {
		try {
			service.deleteFaq(faqId);
		} catch (Exception e) {
			log.info("deleteFaq : ", e);
			throw e;
		}

		return "redirect:/admin/workshop/faq/list?programId=" + programId + "&page=" + page;
	}

	// 참여자 목록
	@GetMapping("/participant/list")
	public String participantList(@RequestParam(name = "workshopId", required = false) Long workshopId, Model model) {

		try {
			Map<String, Object> wmap = new HashMap<String, Object>();
			wmap.put("offset", 0);
			wmap.put("size", 300);

			List<Workshop> workshopList = service.listWorkshop(wmap);
			model.addAttribute("workshopList", workshopList);

			if (workshopId == null && workshopList != null && !workshopList.isEmpty()) {
				workshopId = workshopList.get(0).getWorkshopId();
			}
			model.addAttribute("workshopId", workshopId);

			List<Participant> participantList = List.of();
			if (workshopId != null) {
				Map<String, Object> map = new HashMap<>();
				map.put("workshopId", workshopId);
				participantList = service.listParticipant(map);
			}
			model.addAttribute("participantList", participantList);

		} catch (Exception e) {
			log.info("participantList : ", e);
		}

		return "admin/workshop/participantList";

	}

	// 출석체크
	@PostMapping("/participant/attendance")
	@ResponseBody
	public Map<String, Object> updateAttendance(@RequestParam(name = "participantId") long participantId,
			@RequestParam(name = "isAttended") String isAttended) {

		try {
			Map<String, Object> map = new HashMap<>();
			map.put("participantId", participantId);
			map.put("isAttended", isAttended);
			service.updateAttendance(map);
			return Map.of("success", true);
		} catch (Exception e) {
			return Map.of("success", false, "message", e.getMessage());
		}
	}

	// 신청 상태
	@PostMapping("/participant/status")
	@ResponseBody
	public Map<String, Object> updateParticipantStatus(@RequestParam(name = "participantId") long participantId,
			@RequestParam(name = "participantStatus") String participantStatus) {

		try {
			Map<String, Object> map = new HashMap<>();
			map.put("participantId", participantId);
			map.put("participantStatus", participantStatus);
			service.updateParticipantStatus(map);
			return Map.of("success", true);
		} catch (Exception e) {
			return Map.of("success", false, "message", e.getMessage());
		}
	}

}
