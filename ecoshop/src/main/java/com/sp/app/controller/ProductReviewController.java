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
import com.sp.app.model.ProductReview;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.ProductReviewService;

import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/reivew/*")
public class ProductReviewController {
	private final ProductReviewService service;
	private final StorageService storageService;
	private final PaginateUtil paginateUtil;
	
	private String uploadPath;
	
	@PostConstruct
	public void init() {
		uploadPath = this.storageService.getRealPath("/uploads/review");
	}		
	
	/*
	// AJAX - JSON
	@PostMapping("write")
	public Map<String, ?> writeSubmit(ProductReview dto,
			HttpSession session) throws Exception {
		
		Map<String, Object> model = new HashMap<String, Object>();
		
		String state = "false";
		try {
			
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			dto.setMemberId(info.getMemberId());
			
			service.insertReview(dto, uploadPath);
			
			state = "true";
		} catch (Exception e) {
		}
		
		model.put("state", state);
		return model;
	}
	*/
	
	// AJAX - JSON
	@GetMapping("list")
	public Map<String, ?> list(
			@RequestParam(name = "productCode") long productCode,
			@RequestParam(name = "productId") long productId,
			@RequestParam(name = "sortBy", defaultValue = "0") int sortBy,
			@RequestParam(name = "pageNo", defaultValue = "1") int current_page,
			HttpSession session) throws Exception {
		
		Map<String, Object> model = new HashMap<String, Object>();
		
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");		
			
			int size = 5;
			int dataCount = 0;
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("productCode", productId);
			map.put("sortBy", sortBy);
			
			dataCount = service.dataCount(map);
			
			int total_page = paginateUtil.pageCount(dataCount, size);
			
			current_page = Math.min(current_page, total_page);

			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;

			map.put("offset", offset);
			map.put("size", size);

			List<ProductReview> list = service.listReview(map);
			if(info != null) {
				for(ProductReview dto : list) {
					if(info.getMemberId() == info.getMemberId()) {
						dto.setDeletePermit(true);
					}
				}
			}
			
			String paging = paginateUtil.pagingMethod(current_page, total_page, "listReview");
			
			model.put("list", list);
			model.put("dataCount", dataCount);
			model.put("size", size);
			model.put("pageNo", current_page);
			model.put("paging", paging);
			model.put("total_page", total_page);
			
		} catch (NullPointerException e) {
		} catch (Exception e) {
			log.info("list : ", e);
		}
		
		return model;
	}
	
	/*
	// AJAX - JSON : 마이페이지 - 내가 쓴 리뷰
	@GetMapping("list2")
	public Map<String, ?> list2(
			@RequestParam(name = "pageNo", defaultValue = "1") int current_page,
			HttpSession session) throws Exception {
		Map<String, Object> model = new HashMap<String, Object>();
		
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");		
			
			int size = 5;
			int dataCount = 0;
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("member_id", info.getMember_id());
			
			dataCount = service.dataCountManage(map);
			
			int total_page = paginateUtil.pageCount(dataCount, size);

			current_page = Math.min(current_page, total_page);

			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;

			map.put("offset", offset);
			map.put("size", size);

			List<Review> list = service.listReviewManage(map);
			
			String paging = paginateUtil.pagingMethod(current_page, total_page, "listReview");
			
			model.put("list", list);
			model.put("dataCount", dataCount);
			model.put("size", size);
			model.put("pageNo", current_page);
			model.put("paging", paging);
			model.put("total_page", total_page);
			
		} catch (Exception e) {
			log.info("list2 : ", e);
		}
		
		return model;
	}
	*/
	
}
