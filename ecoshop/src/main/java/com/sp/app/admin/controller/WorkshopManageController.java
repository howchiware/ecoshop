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

import com.sp.app.common.MyUtil;
import com.sp.app.model.Workshop;
import com.sp.app.service.WorkshopService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/admin/workshop/program/*")
public class WorkshopManageController {
	private final WorkshopService service;
	private final MyUtil myUtil;

	// 프로그램 등록 폼
	@GetMapping("write")
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
	@PostMapping("write")
	public String writeSubmitProgram(Workshop dto, HttpSession session) throws Exception {
		try {
			service.insertProgram(dto, dto.getCategoryId(), dto.getProgramTitle(), dto.getProgramContent());
		} catch (Exception e) {
			log.info("program writeSubmit : ", e);
		}
		return "redirect:/admin/workshop/program/write";
	}

	// 프로그램 목록
	@GetMapping("list")
	public String programlist(@RequestParam(name = "page", defaultValue = "1") int current_page,
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
	@GetMapping("detail")
	@ResponseBody
	public Map<String, Object> programDetail(@RequestParam("programId") Long programId) {
		Workshop dto = service.findProgramById(programId);
		Map<String, Object> map = new HashMap<>();
		map.put("programContent", dto.getProgramContent());
		return map;
	}

	// 프로그램 수정
	@GetMapping("update")
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

	@PostMapping("update")
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
	@PostMapping("delete")
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
}
