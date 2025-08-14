package com.sp.app.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.app.admin.model.GongguManage;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/admin/product/*")
public class ProductManageController {
	
	@GetMapping("deliveryInfo")
	public String handleDeliveryInfo(
			@RequestParam(name = "page", defaultValue = "1") int current_page,
			@RequestParam(name = "schType", defaultValue = "orderNum") String schType,
			@RequestParam(name = "kwd",defaultValue = "") String kwd,
			Model model,
			HttpServletRequest req) throws Exception {

		return "admin/product/deliveryInfo";
	}
	
	@GetMapping("totalProductList")
	public String handleTotaLProductList(
			@RequestParam(name = "page", defaultValue = "1") int current_page,
			@RequestParam(name = "schType", defaultValue = "orderNum") String schType,
			@RequestParam(name = "kwd",defaultValue = "") String kwd,
			Model model,
			HttpServletRequest req) throws Exception {
		
		return "admin/product/totalProductList";
	}
	
	@GetMapping("productAddForm")
    public String productAddForm(@RequestParam(value = "productId", required = false) Long productId, Model model) {
		
		return "admin/product/productAdd";
	}
	
	@PostMapping("productAddForm")
	public String productAddSubmit(GongguManage dto) {
		
		return "redirect:/admin/product/totalProductList";
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
