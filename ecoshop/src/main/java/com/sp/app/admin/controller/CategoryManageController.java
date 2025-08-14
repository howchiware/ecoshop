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
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.admin.model.CategoryManage;
import com.sp.app.admin.service.CategoryManageService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/admin/category/*")
public class CategoryManageController {

	private final CategoryManageService service;
	
	@GetMapping("categoryManage")
	public String handleCategoryManage() throws Exception {
		
		return "admin/category/categoryManage";
	}
	
	@GetMapping("listAllCategory")
	public String listAllCategory(Model model,
			HttpServletRequest req) throws Exception {

		try {
			List<CategoryManage> listCategory = service.listCategory();
			
			model.addAttribute("listCategory", listCategory);
			
		} catch (Exception e) {
			log.info("listAllCategory : ", e);
		}
		
		return "admin/category/listCategory";
	}
	
	@ResponseBody
	@PostMapping("insertCategory")
	public Map<String, Object> insertCategory(CategoryManage dto,
			HttpSession session) {
		Map<String, Object> model = new HashMap<>();
		
		String state = "false";
		try {
			service.insertCategory(dto);
			
			state = "true";
		} catch (Exception e) {
		}
		
		model.put("state", state);
		return model;
	}
	
	@ResponseBody
	@PostMapping("updateCategory")
	public Map<String, Object> updateCategory(CategoryManage dto, HttpSession session) {
		Map<String, Object> model = new HashMap<>();
		
		String state = "false";
		try {
			service.updateCategory(dto);
			
			state = "true";
		} catch (Exception e) {
		}
		
		model.put("state", state);
		return model;
	}
	
	@ResponseBody
	@PostMapping("deleteCategory")
	public Map<String, Object> deleteCategory(
			@RequestParam(name = "categoryId") long categoryId) {
		Map<String, Object> model = new HashMap<>();
		
		String state = "false";
		try {
			service.deleteCategory(categoryId);
			
			state = "true";
		} catch (Exception e) {
		}
		
		model.put("state", state);
		return model;
	}
}