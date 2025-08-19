package com.sp.app.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/admin/promotion/*")
public class PromotionManageController {
	
	
	@GetMapping("list")
	public String list(@RequestParam(name = "page", defaultValue = "1") int current_page,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			Model model,
			HttpServletRequest req) throws Exception {
		
		try {
			
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

	
	
}
