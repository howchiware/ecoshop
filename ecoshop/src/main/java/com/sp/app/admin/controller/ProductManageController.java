package com.sp.app.admin.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.app.admin.model.GongguManage;
import com.sp.app.admin.model.ProductManage;
import com.sp.app.admin.service.ProductManageService;
import com.sp.app.common.PaginateUtil;
import com.sp.app.common.StorageService;

import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/admin/products/*")
public class ProductManageController {
	private final ProductManageService service;
	private final PaginateUtil paginateUtil;
	private final StorageService storageService;
	
	private String uploadPath;
	
	@PostConstruct
	public void init() {
		uploadPath = this.storageService.getRealPath("/uploads/products");		
	}	
	
	@GetMapping("totalProductList")
	public String handleTotaLProductList(
			@RequestParam(name = "page", defaultValue = "1") int current_page,
			@RequestParam(name = "schType", defaultValue = "orderNum") String schType,
			@RequestParam(name = "kwd",defaultValue = "") String kwd,
			Model model,
			HttpServletRequest req) throws Exception {
		
		return "admin/products/totalProductList";
	}
	
	@GetMapping("deliveryInfo")
	public String handleDeliveryInfo(
			@RequestParam(name = "page", defaultValue = "1") int current_page,
			@RequestParam(name = "schType", defaultValue = "orderNum") String schType,
			@RequestParam(name = "kwd",defaultValue = "") String kwd,
			Model model,
			HttpServletRequest req) throws Exception {

		return "admin/products/deliveryInfo";
	}
	
	@GetMapping("write")
    public String productAddForm(Model model) {
		try {
			List<ProductManage> listCategory = service.listCategory();
			
			model.addAttribute("mode", "write");
			model.addAttribute("listCategory", listCategory);
			
		} catch (Exception e) {
			log.info("productAddForm : ", e);
		}
		
		return "admin/products/productAdd";
	}
	
	@PostMapping("write")
	public String productAddSubmit(ProductManage dto,
			Model model) {
		
		try {
			service.insertProduct(dto, uploadPath);
		} catch (Exception e) {
			log.info("productAddSubmit : ", e);
		}
		
		return "redirect:/admin/products/totalProductList";
	}
	
	
	@GetMapping("productReview")
    public String reviewList(@RequestParam(value="memberId", required = false) Long memberId, Model model) {
    	
    	
    	return "admin/product/productReview";
    }
	
	@GetMapping("productInquiry")
	public String inquiryList(@RequestParam(value="memberId", required = false) Long memberId, Model model) {
		
		
		return "admin/product/productInquiry";
	}

}
