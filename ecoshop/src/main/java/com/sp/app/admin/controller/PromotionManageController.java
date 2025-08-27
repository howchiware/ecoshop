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
		public String list(@RequestParam(name = "page", defaultValue = "1") int current_page,
				@RequestParam(name = "schType", defaultValue = "all") String schType,
				@RequestParam(name = "kwd", defaultValue = "") String kwd,
				Model model,
				HttpServletRequest req) throws Exception {
			
			try {
				int size = 9;
				int total_page = 0;
				int dataCount = 0;
	
				kwd = myUtil.decodeUrl(kwd);
				
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("schType", schType);
				map.put("kwd", kwd);
				
				dataCount = service.dataCount(map);
				total_page = paginateUtil.pageCount(dataCount, size);
				
				current_page = Math.min(current_page, total_page);
				
				int offset = (current_page - 1) * size;
				if(offset < 0) offset = 0;
				
				map.put("offset", offset);
				map.put("size", size);
	
				List<PromotionManage> list = service.listPromotionManage(map);
	
				String cp = req.getContextPath();
				String query = "page=" + current_page;
				String params = "";
				String listUrl = cp + "/admin/promotion/list";
				if (! kwd.isBlank()) {
					params = "kwd=" + myUtil.encodeUrl(kwd);
					listUrl += "?" + params;
					query += "&" + params;
				}
				
				String paging = paginateUtil.paging(current_page, total_page, listUrl);
	
				model.addAttribute("list", list);
				model.addAttribute("dataCount", dataCount);
				model.addAttribute("size", size);
				model.addAttribute("total_page", total_page);
				model.addAttribute("page", current_page);
				model.addAttribute("paging", paging);
	
				model.addAttribute("kwd", kwd);
				model.addAttribute("query", query);
				
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
	
	
		
		
	
