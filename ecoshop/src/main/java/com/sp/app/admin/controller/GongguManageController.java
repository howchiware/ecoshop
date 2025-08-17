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

import com.sp.app.admin.model.CategoryManage;
import com.sp.app.admin.model.GongguInquiryManage;
import com.sp.app.admin.model.GongguManage;
import com.sp.app.admin.model.GongguReviewManage;
import com.sp.app.admin.service.CategoryManageService;
import com.sp.app.admin.service.GongguManageService;
import com.sp.app.admin.service.GongguReviewInquiryManageService;
import com.sp.app.common.StorageService;

import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/admin/gonggu/*")
public class GongguManageController {
    private final GongguManageService gongguManageService;
    private final StorageService storageService;
    private final CategoryManageService categoryManageService;
    private final GongguReviewInquiryManageService gongguReviewInquiryManageService;
    
    private String uploadPath;

    @PostConstruct
	public void init() {
		uploadPath = this.storageService.getRealPath("/uploads/gonggu");		
	}	
    
    @GetMapping("productForm")
    public String productForm(@RequestParam(value = "gongguProductId", required = false) Long gongguProductId, Model model) {
        GongguManage gongguManage;

        if (gongguProductId != null) {
            try {
                gongguManage = gongguManageService.findById(gongguProductId);
            } catch (Exception e) {
                log.error("productInfo : ", e);
                gongguManage = new GongguManage();
            }
        } else {
            gongguManage = new GongguManage();
        }
        
        model.addAttribute("gongguProduct", gongguManage);
        
        return "admin/gonggu/gongguProduct";
    }
    
    @PostMapping("productForm")
    public String submitProduct(GongguManage dto) {
        try {
            gongguManageService.insertGongguProduct(dto, uploadPath);
        } catch (Exception e) {
            log.error("productForm : ", e);
            return "redirect:/admin/gonggu/productForm";
        }
        
        return "redirect:/admin/gonggu/productList";
    }
    
    @GetMapping("productReview")
    public String getProductReview(@RequestParam(value="memberId", required = false) Long memberId, Model model) {
    	
    	return "admin/gonggu/gongguReview";
    }
    
    @GetMapping(value = "reviewList")
    public String getProductReviewList(
    		@RequestParam(value = "gongguProductName", required = false) String gongguProductName, 
    		@RequestParam(value = "kwd", required = false) String kwd, 
    		Model model) {
    	Map<String, Object> map = new HashMap<>();
        map.put("gongguProductName", gongguProductName);
        map.put("kwd", kwd);
    	
        List<GongguReviewManage> reviewList = gongguReviewInquiryManageService.searchReviews(map);
      
        model.addAttribute("reviewList", reviewList);
        model.addAttribute("gongguProductName", gongguProductName);
        model.addAttribute("kwd", kwd);
        
        return "admin/gonggu/reviewList";
    }
    
    @GetMapping(value = "inquiryList")
    public String getInquiryList(
    		@RequestParam(value = "gongguProductName", required = false) String gongguProductName, 
    		@RequestParam(value = "kwd", required = false) String kwd, 
    		Model model) {
    	
    	Map<String, Object> map = new HashMap<>();
        map.put("gongguProductName", gongguProductName);
        map.put("kwd", kwd);
        
        List<GongguInquiryManage> inquiryList = gongguReviewInquiryManageService.searchInquirys(map);
        
        model.addAttribute("inquiryList", inquiryList);
        model.addAttribute("gongguProductName", gongguProductName);
        model.addAttribute("kwd", kwd);
        
        return "admin/gonggu/inquiryList";
    }

    @GetMapping("category")
    public String category(@RequestParam(value="categoryId", required = false) Long categoryId, Model model) throws Exception {
    	List<CategoryManage> categoryList = categoryManageService.listCategory();
    	
    	model.addAttribute("categoryList", categoryList);
    	return "admin/category/category";
    }


}