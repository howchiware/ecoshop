package com.sp.app.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/admin/block/*")
public class BlockManageController {
	
	@GetMapping("list")
	public String blockList() {
		
		try {
			
		} catch (Exception e) {
			log.info("blockList: ", e);
		}
		
		return "admin/block/list";
	}

}
