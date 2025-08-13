package com.sp.app.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.sp.app.common.MyUtil;
import com.sp.app.common.StorageService;
import com.sp.app.model.Workshop;
import com.sp.app.service.WorkshopService;

import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/admin/workshop/*")
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
	@GetMapping("program/write")
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

		return "admin/workshop/program/write";
	}

	// 카테고리 등록
	@PostMapping("category")
	public String addCategory(Workshop dto, @RequestParam("categoryName") String categoryName) {
		try {
			service.insertCategory(dto, categoryName);
		} catch (Exception e) {
			log.info("program addCategory : ", e);
		}

		return "redirect:/admin/workshop/program/write";
	}

	// 프로그램 등록
	@PostMapping("program/write")
	public String writeSubmitProgram(Workshop dto, HttpSession session) throws Exception {
		try {
			service.insertProgram(dto, dto.getCategoryId(), dto.getProgramTitle(), dto.getProgramContent());
		} catch (Exception e) {
			log.info("program writeSubmit : ", e);
		}
		return "redirect:/admin/workshop/program/write";
	}

	// 프로그램 목록
	@GetMapping("program/list")
	public String programList(@RequestParam(name = "page", defaultValue = "1") int current_page,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			@RequestParam(name = "categoryId", required = false) Long categoryId, Model model, HttpServletRequest req)
			throws Exception {

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
			if (categoryId != null)
				map.put("categoryId", categoryId);

			List<Workshop> list = service.listProgram(map);

			// 카테고리 드롭다운
			Map<String, Object> m = new HashMap<String, Object>();
			m.put("offset", 0);
			m.put("size", 200);
			List<Workshop> category = service.listCategory(m);

			model.addAttribute("list", list);
			model.addAttribute("page", current_page);
			model.addAttribute("size", size);
			model.addAttribute("kwd", kwd);
			model.addAttribute("categoryId", categoryId);
			model.addAttribute("category", category);

		} catch (Exception e) {
			log.info("program list : ", e);
		}

		return "admin/workshop/program/list";
	}

	// 프로그램 내용 상세보기
	@GetMapping("program/detail")
	@ResponseBody
	public Map<String, Object> programDetail(@RequestParam("programId") Long programId) {
	    Workshop dto = service.findProgramById(programId);
	    Map<String, Object> map = new HashMap<>();
	    String content = (dto == null || dto.getProgramContent() == null) ? "" : dto.getProgramContent();
	    map.put("programContent", content);
	    return map;
	}


	// 프로그램 수정
	@GetMapping("program/update")
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

			return "admin/workshop/program/write";
		} catch (NullPointerException e) {
		} catch (Exception e) {
			log.info("update Program : ", e);
		}

		return "redirect:/admin/workshop/program/list?page=" + page;
	}

	@PostMapping("program/update")
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
	@PostMapping("program/delete")
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
	@PostMapping("manager/write")
	public String addManager(Workshop dto) {
		try {
			service.insertManager(dto);
		} catch (Exception e) {
			log.info("workshop addManager : ", e);
		}

		return "redirect:/admin/workshop/manager/list";
	}

	// 담당자 목록
	@GetMapping("manager/list")
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

		return "admin/workshop/manager/list";
	}

	// 담당자 수정
	@GetMapping("manager/update")
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

			return "admin/workshop/manager/list";
		} catch (Exception e) {
			log.info("update Manager : ", e);
		}

		return "redirect:/admin/workshop/manager/list?page=" + page;
	}

	@PostMapping("manager/update")
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
	@PostMapping("manager/delete")
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
	@GetMapping("list")
	public String workshopList(@RequestParam(name = "page", defaultValue = "1") int current_page,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
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

		} catch (Exception e) {
			log.info("workshop list : ", e);
		}

		return "admin/workshop/list";
	}

	// 워크샵 작성
	@GetMapping("write")
	public String workshopWriteForm(Model model) throws Exception {

		model.addAttribute("mode", "write");

		return "admin/workshop/write";
	}

	@PostMapping("write")
	public String workshopWriteSubmit(Workshop dto) throws Exception {
		try {
			service.insertWorkshop(dto);
		} catch (Exception e) {
			log.info("workshop writeSubmit : ", e);
		}
		return "redirect:/admin/workshop/write";
	}

	// 워크샵 상세
	@GetMapping("detail")
	public String workshopDetail(@RequestParam(name = "num") long num, @RequestParam(name = "page") String page,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd, Model model, HttpSession session)
			throws Exception {

		String query = "page=" + page;
		try {
			kwd = myUtil.decodeUrl(kwd);
			if (!kwd.isBlank()) {
				query += "&schType=" + schType + "&kwd=" + myUtil.encodeUrl(kwd);
			}

			Workshop dto = Objects.requireNonNull(service.findWorkshopById(num));

			model.addAttribute("dto", dto);
			model.addAttribute("page", page);
			model.addAttribute("query", query);

			return "admin/workshop/detail";
		} catch (Exception e) {
			log.info("workshop detail : ", e);
		}

		return "redirect:/admin/workshop/list?" + query;
	}

	// 워크샵 수정
	@GetMapping("workshop/update")
	public String updateFormWorkshop(@RequestParam(name = "num") long num, @RequestParam(name = "page") String page,
			Model model) throws Exception {

		try {
			Workshop dto = Objects.requireNonNull(service.findWorkshopById(num));

			model.addAttribute("dto", dto);
			model.addAttribute("mode", "update");
			model.addAttribute("page", page);

			return "admin/workshop/write";
		} catch (Exception e) {
			log.info("workshopUpdateForm : ", e);
		}

		return "redirect:/admin/workshop/list?page=" + page;
	}

	@PostMapping("workshop/update")
	public String updateSubmitWorkshop(Workshop dto, @RequestParam(name = "page", defaultValue = "1") String page)
			throws Exception {
		try {
			service.updateWorkshop(dto);
		} catch (Exception e) {
			log.info("update Workshop : ", e);
			throw e;
		}

		return "redirect:/admin/workshop/list?page=" + page;
	}

	// 워크샵 삭제
	@PostMapping("workshop/delete")
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

	// 사진 목록
	@GetMapping("photo/list")
	public String workshopPhotoList(@RequestParam long workshopId, Model model) {
		Map<String, Object> map = new HashMap<>();
		map.put("workshopId", workshopId);
		List<Workshop> photo = service.listWorkshopPhoto(map);
		model.addAttribute("photo", photo);

		return "admin/workshop/photo/list";
	}

	// 사진 업로드
	@PostMapping("photo/upload")
	public String workshopPhotoUpload(Workshop dto, @RequestParam long workshopId, MultipartFile file) {
		if (file == null || file.isEmpty()) {
	        return "redirect:/admin/workshop/photo/list?workshopId=" + workshopId;
	    }
		try {
			String workshopImagePath = storageService.uploadFileToServer(file, uploadPath);
			dto.setWorkshopId(workshopId);
			service.insertWorkshopPhoto(dto, workshopImagePath);
		} catch (Exception e) {
			log.info("workshopPhotoUpload : ", e);
		}

		return "redirect:/admin/workshop/photo/list?workshopId=" + workshopId;
	}

	// 사진 삭제
	@PostMapping("photo/delete")
	public String photoDelete(@RequestParam long photoId, @RequestParam long workshopId) {
		try {
			service.deleteWorkshopPhotoById(photoId, uploadPath);
		} catch (Exception e) {
			log.error("사진 삭제 실패", e);
		}
		return "redirect:/admin/workshop/photo/list?workshopId=" + workshopId;
	}

}
