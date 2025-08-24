package com.sp.app.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sp.app.admin.model.InquiryManage;
import com.sp.app.service.InquiryService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/admin/blockAndInquiry/*")
public class BlockAndInquiryManageController {
	
	private final InquiryService service;
	
	@GetMapping("main")
	public String blockList(Model model) {
		
		try {
			InquiryManage stats = service.getInquiryStats();
			
			model.addAttribute("waitInquiry", stats.getWaitInquiry());
			model.addAttribute("allInquiry", stats.getAllInquiry());
			
			int rate = 0;
			if(stats.getAllInquiry() > 0) {
				rate = (int)(((double)stats.getCompInquiry() / stats.getAllInquiry()) * 100);
			}
			model.addAttribute("rate", rate);
			
		} catch (Exception e) {
			log.info("blockList: ", e);
		}
		
		return "admin/blockAndInquiry/main";
	}

}
