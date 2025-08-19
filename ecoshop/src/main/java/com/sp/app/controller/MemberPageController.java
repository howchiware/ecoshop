package com.sp.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sp.app.service.MemberService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/member/*")
public class MemberPageController {
	
	private final MemberService service;
	
	@GetMapping("myPage")
	public String myPageHome() {
		
		try {
			
		} catch (Exception e) {
			
		}
		
		return "member/myPage";
	}
	
	@GetMapping("myProfile")
	public String myProfile(HttpSession session) {
		
		try {
			
			
		} catch (Exception e) {
			
		}
		
		return "member/myProfile";
	}
	
	
	
}
