package com.sp.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/free/*")
public class FreeController {
	
	// private final FreeService service;
	
	@GetMapping("freeHome")
	public String freeHome() {
		return "free/dairyList";
	}
	
	@GetMapping("dairyList")
	public String dailyList() {
		return "free/dairyList";
	}
	
	@GetMapping("dairyWrite")
	public String dailyWrite() {
		return "free/dairyWrite";
	}
	
	
	
}
