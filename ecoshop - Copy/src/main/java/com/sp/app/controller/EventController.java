package com.sp.app.controller;

import org.springframework.stereotype.Controller;import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sp.app.service.EventService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/event/*")
public class EventController {
	
	private final EventService service;
	
	@GetMapping("attendance")
	public String list(Model model, HttpServletRequest req) throws Exception {
		
		try {
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return "event/attendance";
	}

}
