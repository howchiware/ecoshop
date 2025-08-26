package com.sp.app.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.sp.app.admin.model.PromotionManage;
import com.sp.app.admin.service.PromotionManageService;
import com.sp.app.model.Product;
import com.sp.app.model.Workshop;
import com.sp.app.service.ProductService;
import com.sp.app.service.WorkshopService;

import org.springframework.ui.Model;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class HomeController {
	private final PromotionManageService PromotionManageService;
	private final ProductService productService;
	private final WorkshopService workshopService;
	
	@GetMapping("/")
	public String MainPage(Model model) {
		try {
			// 베스트 상품
			Map<String, Object> map = new HashMap<>();
			map.put("offset", 0);
			map.put("size", 5);
			List<PromotionManage> listPromotionManage = PromotionManageService.listPromotionManage(map);
			
			List<Product> bestProductList = productService.listThreeProducts();
			
			model.addAttribute("listPromotionManage", listPromotionManage);	
			model.addAttribute("bestProductList", bestProductList);	
			
			// 워크샵
			Map<String, Object> wMap = new HashMap<>();
			
			wMap.put("onlyRecruiting", true);
			wMap.put("sort", "deadline");
			wMap.put("offset", 0);
			wMap.put("size", 6);

			List<Workshop> recruitingWorkshop = workshopService.listWorkshopMain(wMap);
			
			Workshop mainWorkshop = (recruitingWorkshop == null || recruitingWorkshop.isEmpty())
	                ? null : recruitingWorkshop.get(0);
			
			model.addAttribute("recruitingWorkshop", recruitingWorkshop);
			model.addAttribute("mainWorkshop", mainWorkshop);
		
		} catch (Exception e) {
			
		}
		return "main/home";
	}

}
