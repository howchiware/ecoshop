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
	
	import com.sp.app.admin.model.AdvertisementManage;
	import com.sp.app.admin.model.PromotionManage;
	import com.sp.app.admin.service.PromotionManageService;
		import com.sp.app.common.MyUtil;
		import com.sp.app.common.PaginateUtil;
		import com.sp.app.common.StorageService;
		import com.sp.app.model.SessionInfo;
		
		import jakarta.annotation.PostConstruct;
		import jakarta.servlet.http.HttpServletRequest;
		import jakarta.servlet.http.HttpSession;
		import lombok.RequiredArgsConstructor;
		import lombok.extern.slf4j.Slf4j;
		
		@Controller
		@RequiredArgsConstructor
		@Slf4j
		@RequestMapping(value = "/admin/promotion/*")
		public class PromotionManageController {
			private final StorageService storageService;
			private final PaginateUtil paginateUtil;
		    private final MyUtil myUtil;
		    private final PromotionManageService service;
		    
		    private String uploadPath;
		
		    @PostConstruct
			public void init() {
				uploadPath = this.storageService.getRealPath("/uploads/promotion");		
			}
				
		    @GetMapping("list")
		    public String list(
		            @RequestParam(name = "pageAd", defaultValue = "1") int current_pageAd,
		            @RequestParam(name = "pagePr", defaultValue = "1") int current_pagePr,
		            @RequestParam(name = "schType", defaultValue = "all") String schType,
		            @RequestParam(name = "kwd", defaultValue = "") String kwd,
		            Model model,
		            HttpServletRequest req) throws Exception {

		        try {
		            int size = 9;
		            kwd = myUtil.decodeUrl(kwd);
		            String cp = req.getContextPath();

		            // 광고 map
		            Map<String, Object> mapAd = new HashMap<>();
		            mapAd.put("schType", schType);
		            mapAd.put("kwd", kwd);

		            int dataCountAd = service.dataCountAdvertisement(mapAd);
		            int total_pageAd = paginateUtil.pageCount(dataCountAd, size);

		            current_pageAd = Math.min(current_pageAd, total_pageAd);
		            int offsetAd = (current_pageAd - 1) * size;
		            if (offsetAd < 0) offsetAd = 0;

		            mapAd.put("offset", offsetAd);
		            mapAd.put("size", size);
		            List<AdvertisementManage> listAd = service.listAdvertisement(mapAd);

		            String listUrlAd = cp + "/admin/promotion/list";
		            String queryAd = "pageAd=" + current_pageAd;
		            String pagingAd = paginateUtil.paging(current_pageAd, total_pageAd, listUrlAd + "?" + queryAd);

		            // 프로모션 map
		            Map<String, Object> mapPr = new HashMap<>();
		            mapPr.put("schType", schType);
		            mapPr.put("kwd", kwd);

		            int dataCountPr = service.dataCount(mapPr);
		            int total_pagePr = paginateUtil.pageCount(dataCountPr, size);

		            current_pagePr = Math.min(current_pagePr, total_pagePr);
		            int offsetPr = (current_pagePr - 1) * size;
		            if (offsetPr < 0) offsetPr = 0;

		            mapPr.put("offset", offsetPr);
		            mapPr.put("size", size);
		            List<PromotionManage> listPr = service.listPromotionManage(mapPr);

		            String listUrlPr = cp + "/admin/promotion/list";
		            String queryPr = "pagePr=" + current_pagePr;
		            String pagingPr = paginateUtil.paging(current_pagePr, total_pagePr, listUrlPr + "?" + queryPr);

		            model.addAttribute("listAd", listAd);
		            model.addAttribute("listPr", listPr);
		            model.addAttribute("pagingAd", pagingAd);
		            model.addAttribute("pagingPr", pagingPr);
		            model.addAttribute("dataCountAd", dataCountAd);
		            model.addAttribute("dataCountPr", dataCountPr);

		        } catch (Exception e) {
		            log.info("list : ", e);
		        }

		        return "admin/promotion/list";
		    }
			
			@GetMapping("write")
			public String writeForm(Model model) throws Exception{
				
				model.addAttribute("mode", "write");
				
				return "admin/promotion/write";
			}
			
			@PostMapping("write")
			public String writeSubmit(PromotionManage dto, HttpSession session) throws Exception {
				try {
					SessionInfo info = (SessionInfo) session.getAttribute("member");
					
					dto.setMemberId(info.getMemberId());
					
					service.insertPromotionManage(dto, uploadPath);
					
					
					
				} catch (Exception e) {
					log.info("writeSubmit : ", e);
				}
		
				return "redirect:/admin/promotion/list";
			}
			
			@GetMapping("update")
			public String updateForm(@RequestParam(name = "promotionId") long promotionId,
					@RequestParam(name = "page") String page,
					Model model,
					HttpSession session) throws Exception {
		
				try {
					SessionInfo info = (SessionInfo) session.getAttribute("member");
		
					PromotionManage dto = Objects.requireNonNull(service.findById(promotionId));
					if (dto.getMemberId() != info.getMemberId()) {
						return "redirect:/admin/promotion/list?page=" + page;
					}
		
					model.addAttribute("dto", dto);
					model.addAttribute("page", page);
					model.addAttribute("mode", "update");
					
					return "admin/promotion/write";
					
				} catch (NullPointerException e) {
					log.info("updateForm : ", e);
				} catch (Exception e) {
					log.info("updateForm : ", e);
				}
				
				return "redirect:/admin/promotion/list?page=" + page;
			}
			
			@PostMapping("update")
			public String updateSubmit(PromotionManage dto,
					@RequestParam(name = "page") String page) throws Exception {
				
				try {
					service.updatePromotionManage(dto, uploadPath);
				} catch (Exception e) {
					log.info("updateSubmit : ", e);
				}
		
				return "redirect:/admin/promotion/list?page=" + page;
			}
			
			@GetMapping("delete")
			public String delete(@RequestParam(name = "promotionId") long promotionId,
					@RequestParam(name = "page") String page,
					@RequestParam(name = "imageFilename") String imageFilename,
					@RequestParam(name = "kwd", defaultValue = "") String kwd) throws Exception {
		
				String query = "page=" + page;
				try {
					kwd = myUtil.decodeUrl(kwd);
					if (! kwd.isBlank()) {
						query += "&kwd=" + myUtil.encodeUrl(kwd);
					}
		
					service.deletePromotionManage(promotionId, uploadPath, imageFilename);
					
				} catch (Exception e) {
					log.info("delete : ", e);
				}
		
				return "redirect:/admin/promotion/list?" + query;
			}
			
			
		}
		
		
			
			
		
