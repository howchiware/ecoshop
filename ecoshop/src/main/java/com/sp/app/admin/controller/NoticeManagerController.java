package com.sp.app.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/admin/notice/*")
public class NoticeManagerController {
	@GetMapping("list")
	public String handleHome() {
		
		try {
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return "admin/notice/list";
	}
	
	@GetMapping("write")
	public String writeForm(Model model, HttpSession session) throws Exception {
		model.addAttribute("mode", "write");

		return "admin/notice/write";
	}

}

