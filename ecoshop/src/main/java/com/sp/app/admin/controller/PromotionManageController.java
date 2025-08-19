package com.sp.app.admin.controller;

import java.util.HashMap;
import java.util.Map;

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
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			Model model,
			HttpServletRequest req) throws Exception {
		
		try {
			int size = 8;
			int total_page;
			int dataCount;

			kwd = myUtil.decodeUrl(kwd);
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("kwd", kwd);
			
		} catch (Exception e) {
			// TODO: handle exception
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

	
	
}
