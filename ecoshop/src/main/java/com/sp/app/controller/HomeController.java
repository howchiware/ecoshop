package com.sp.app.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.sp.app.admin.model.AdvertisementManage;
import com.sp.app.admin.model.PromotionManage;
import com.sp.app.admin.service.AdvertisementManageService;
import com.sp.app.admin.service.PromotionManageService;
import com.sp.app.model.GongguProduct;
import com.sp.app.model.Product;
import com.sp.app.model.Workshop;
import com.sp.app.model.Challenge;
import com.sp.app.service.ChallengeService;
import com.sp.app.service.GongguService;
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
	private final AdvertisementManageService advertisementManageService;
	private final ProductService productService;
	private final WorkshopService workshopService;
	private final GongguService gongguService;
	private final ChallengeService challengeService;
	
	@GetMapping("/")
	public String MainPage(Model model) {
		try {
			// 베너
			Map<String, Object> bannerMap = new HashMap<>();
			bannerMap.put("postingStatus", 0);
			bannerMap.put("status", 5);
			bannerMap.put("inquiryType", 1);

			List<AdvertisementManage> bannerList = advertisementManageService.listMainBanner(bannerMap);
			model.addAttribute("bannerList", bannerList);
			
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
		
			// 공동구매
			List<GongguProduct> gongguList = gongguService.listTwoProducts();
			long nowTime = System.currentTimeMillis();
	        for (GongguProduct product : gongguList) {
	            Date endDate = product.getEndDate();
	            if (endDate != null) {
	                long endTime = endDate.getTime();
	                long remainingTime = endTime - nowTime;
	                if (remainingTime > 0) {
	                    long remainingDays = TimeUnit.MILLISECONDS.toDays(remainingTime);
	                    product.setRemainingDays(remainingDays);
	                } else {
	                    product.setRemainingDays(-1); 
	                }
	            } else {
	                product.setRemainingDays(-1); 
	            }
	        }
			model.addAttribute("gongguList", gongguList);
			
			 // 데일리 챌린지
            int todayIdx0to6 = java.time.LocalDate.now().getDayOfWeek().getValue() % 7; // 0:일 ~ 6:토
            Challenge todayDaily = challengeService.getDailyByWeekday(todayIdx0to6);
            model.addAttribute("todayDaily", todayDaily);

        } catch (Exception e) {
            
        }
        return "main/home";
    }
}