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

import com.sp.app.admin.model.InquiryManage;
import com.sp.app.admin.service.InquiryManageService;
import com.sp.app.common.MyUtil;
import com.sp.app.common.PaginateUtil;
import com.sp.app.model.SessionInfo;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/admin/inquiry/*")
public class InquiryManageController {
	

	private final InquiryManageService service;
	private final PaginateUtil paginateUtil;
	private final MyUtil myUtil;
	
	@GetMapping("main")
	public String inquiryMain(@RequestParam(name = "pageNo", defaultValue = "1") int current_page, Model model) {
		
		try {
			Map<String, Object> map = new HashMap<>();
			
			List<InquiryManage> listCategory = service.listCategory(map);
			
			model.addAttribute("listCategory", listCategory);
			model.addAttribute("categoryId", "0");
			model.addAttribute("pageNo", current_page);
			
		} catch (Exception e) {
			log.info("inquiryMain: ", e);
		}
		
		return "admin/inquiry/main";
	}
	
	@GetMapping("list")
	public String inquiryList(@RequestParam(name= "pageNo", defaultValue = "1") int current_page,
						@RequestParam(name = "schType", defaultValue = "all") String schType,
						@RequestParam(name = "kwd", defaultValue = "") String kwd,
						@RequestParam(name = "categoryId", defaultValue = "0") long categoryId,
						@RequestParam(name = "status", defaultValue = "-1") int status,
						Model model, HttpServletResponse resp) throws Exception {
		
		try {
			
			int size = 10;
			int total_page = 0;
			int dataCount = 0;
			
			kwd = myUtil.decodeUrl(kwd);
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("schType", schType);
			map.put("kwd", kwd);
			map.put("categoryId", categoryId);
			map.put("status", status);
			
			dataCount = service.dataCount(map);
			if(dataCount != 0) {
				total_page = paginateUtil.pageCount(dataCount, size);
			}
			
			current_page = Math.min(current_page, total_page);
			
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			
			List<InquiryManage> list = service.listInquiry(map);
			
			String paging = paginateUtil.pagingMethod(current_page, total_page, "listPage");
			
			model.addAttribute("list", list);
			model.addAttribute("pageNo", current_page);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("size", size);
			model.addAttribute("total_page", total_page);
			model.addAttribute("paging", paging);
			
		} catch (Exception e) {
			resp.sendError(406);
			throw e;
		}
		
		return "admin/inquiry/list";
	}
	
	@GetMapping("listAllCategory")
	public String listAllCategoryByInquiry(Model model, HttpServletResponse resp) throws Exception {
		
		try {
			Map<String, Object> map = new HashMap<>();
			
			map.put("mode", "all");
			List<InquiryManage> listCategory = service.listCategory(map);
			
			model.addAttribute("listCategory", listCategory);
			
			return "admin/inquiry/listCategory";
			
		} catch (Exception e) {
			resp.sendError(406);
			throw e;
		}
	}

	@GetMapping("update")
	public String updateInquiryForm(@RequestParam(name = "inquiryId") long inquiryId, @RequestParam(name = "pageNo") String pageNo,
						Model model, HttpServletResponse resp, HttpSession session) throws Exception {
		
		try {
			
			InquiryManage dto = Objects.requireNonNull(service.findByInquiry(inquiryId));
			
			Map<String, Object> map = new HashMap<>();
			
			List<InquiryManage> listCategory = service.listCategory(map);
			
			model.addAttribute("mode", "update");
			model.addAttribute("pageNo", pageNo);
			model.addAttribute("dto", dto);
			model.addAttribute("listCategory", listCategory);
			
			return "admin/inquiry/update";
			
		} catch (NullPointerException e) {
			log.info("updateInquiryForm : ", e);
			resp.sendError(406);
			throw e;
		} catch (Exception e) {
			log.info("updateInquiryForm : ", e);
			resp.sendError(406);
			throw e;
		}
	}
	
	@ResponseBody
	@PostMapping("update")
	public Map<String, ?> updateInquirySubmit(InquiryManage dto, HttpSession session) throws Exception {
		
		Map<String, Object> model = new HashMap<String, Object>();
		
		String state = "false";
		
		try {
			
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			dto.setAnswerId(info.getMemberId());
			service.updateInquiry(dto);
			
			state = "true";
			
		} catch (Exception e) {
			log.info("updateInquirySubmit : ", e);
		}
		
		model.put("state", state);
		
		return model;
	}
	
	
	@ResponseBody
	@PostMapping("insertCategory")
	public Map<String, ?> insertCategory(InquiryManage dto) throws Exception {
		
		Map<String, Object> model = new HashMap<>();
		
		String state = "false";
		
		try {
			service.insertCategory(dto);
			state = "true";
		} catch (Exception e) {
			log.info("insertCategory: ", e);
		}
		
		model.put("state", state);
		return model;
	}
	
	@ResponseBody
	@PostMapping("updateCategory")
	public Map<String, ?> updateCategory(InquiryManage dto) throws Exception {
		
		Map<String, Object> model = new HashMap<>();
		
		String state = "false";
		
		try {
			service.updateCategory(dto);
			state = "true";
		} catch (Exception e) {
			log.info("updateCategory: ", e);
		}
		
		model.put("state", state);
		return model;
	}
	
	@ResponseBody
	@PostMapping("deleteCategory")
	public Map<String, ?> deleteCategory(@RequestParam(name = "categoryId") long categoryId) throws Exception {
		
		Map<String, Object> model = new HashMap<>();
		
		String state = "false";
		
		try {
			service.deleteCategory(categoryId);
			state = "true";
		} catch (Exception e) {
			log.info("deleteCategory: ", e);
		}
		
		model.put("state", state);
		return model;
	}

}
