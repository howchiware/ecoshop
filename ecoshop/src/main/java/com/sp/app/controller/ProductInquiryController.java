package com.sp.app.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sp.app.common.PaginateUtil;
import com.sp.app.common.StorageService;
import com.sp.app.model.ProductInquiry;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.ProductInquiryService;

import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/inquiry/*")
public class ProductInquiryController {
	private final ProductInquiryService service;
	private final StorageService storageService;
	private final PaginateUtil paginateUtil;
	
	private String uploadPath;
	
	@PostConstruct
	public void init() {
		uploadPath = this.storageService.getRealPath("/uploads/qna");
	}		
	
	
	// AJAX - JSON
	@PostMapping("write")
	public Map<String, ?> writeSubmit(ProductInquiry dto,
			HttpSession session) throws Exception {
		
		Map<String, Object> model = new HashMap<String, Object>();
		
		
		return model;
	}
	
	// AJAX - JSON
	@GetMapping("list")
	public Map<String, ?> list(
			@RequestParam(name = "productCode") long productCode,
			@RequestParam(name = "pageNo", defaultValue = "1") int current_page,
			HttpSession session) throws Exception {
		
		Map<String, Object> model = new HashMap<String, Object>();
		
		
		return model;
	}

	// AJAX - JSON : 마이페이지 - 내 Q&A
	@GetMapping("list2")
	public Map<String, ?> list2(
			@RequestParam(name = "pageNo", defaultValue = "1") int current_page,
			HttpSession session) throws Exception {
		
		Map<String, Object> model = new HashMap<String, Object>();
		
		return model;
	}

}
