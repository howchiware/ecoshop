package com.sp.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sp.app.model.Advertisement;
import com.sp.app.service.AdvertisementService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/advertisement/*")
public class AdvertisementController {
	private final AdvertisementService service;
	private String uploadPath;
	
	
	@GetMapping("list")
	public String list(Model model, HttpServletRequest req) throws Exception{
		try {
			
		} catch (Exception e) {
			log.info("list : ", e);
		}
		return "advertisement/list";
	}
	
	@GetMapping("write")
	public String writeForm(Model model, HttpSession session) throws Exception {
		model.addAttribute("model", "write");
		
		return "advertisement/write";
	}
	
	@PostMapping("write")
	public String writeSubmit(Advertisement dto, HttpSession session) throws Exception{
		
		try {
			service.insertAdvertisement(dto, uploadPath);	
			
		} catch (Exception e) {
			log.info("writeSubmit : ", e);
		}
		return "redirect:/advertisement/list";
	}
}
