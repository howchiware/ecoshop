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
		
		String state = "false";
		try {
			
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			if(info == null) {
				state = "onlyMember";
				model.put("state", state);
				return model;
			}
			
			dto.setMemberId(info.getMemberId());			
			
			service.insertInquiry(dto, uploadPath);
			
			state = "true";
		} catch (Exception e) {
		}
		
		model.put("state", state);
		return model;
	}
	
	// AJAX - JSON
	@PostMapping("delete")
	public Map<String, ?> deletSubmit(@RequestParam(name = "inquiryId") long inquiryId,
			HttpSession session) throws Exception {
		
		Map<String, Object> model = new HashMap<String, Object>();
		
		String state = "false";
		try {	
			service.deleteInquiry(inquiryId);
			
			state = "true";
		} catch (Exception e) {
		}
		
		model.put("state", state);
		return model;
	}
	
	// AJAX - JSON
	@GetMapping("list")
	public Map<String, ?> list(
			@RequestParam(name = "productCode") long productCode,
			@RequestParam(name = "pageNo", defaultValue = "1") int current_page,
			HttpSession session) throws Exception {
		
		Map<String, Object> model = new HashMap<String, Object>();
		
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			int size = 5;
			int dataCount = 0;
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("productCode", productCode);
			
			dataCount = service.dataCount(map);
			int total_page = paginateUtil.pageCount(dataCount, size);
			
			current_page = Math.min(current_page, total_page);

			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;

			map.put("offset", offset);
			map.put("size", size);

			List<ProductInquiry> list = service.listInquiry(map);
			for(ProductInquiry dto : list) {
				if(dto.getSecret() == 1 && (info == null || (info.getUserLevel() < 50 && dto.getMemberId() != info.getMemberId()))) {
					dto.setTitle("비밀글 입니다. <i class='bi bi-lock'></i>");
					dto.setAnswer("");
				}
				
				if(info != null && (info.getUserLevel() > 50 || info.getMemberId() == dto.getMemberId())) {
					dto.setDeletePermit(1);
				} else {
					dto.setDeletePermit(0);
				}
			
			}
			
			String paging = paginateUtil.pagingMethod(current_page, total_page, "listInquiry");
			
			model.put("list", list);
			model.put("dataCount", dataCount);
			model.put("size", size);
			model.put("pageNo", current_page);
			model.put("paging", paging);
			model.put("total_page", total_page);
			
		} catch (Exception e) {
			log.info("list : ", e);
		}
		
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
