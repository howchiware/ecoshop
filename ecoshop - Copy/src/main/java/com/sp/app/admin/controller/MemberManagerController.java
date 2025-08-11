package com.sp.app.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/admin/member/*")
public class MemberManagerController {
	
	@GetMapping("list")
	public String handleHome() {
		
		try {
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return "admin/member/list";
	}

}
