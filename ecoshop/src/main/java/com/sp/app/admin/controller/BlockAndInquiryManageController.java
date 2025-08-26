package com.sp.app.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sp.app.admin.model.InquiryManage;
import com.sp.app.admin.service.InquiryManageService;
import com.sp.app.model.Reports;
import com.sp.app.service.ReportsService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/admin/blockAndInquiry/*")
public class BlockAndInquiryManageController {
	
	private final InquiryManageService service;
	private final ReportsService reService;
	
	@GetMapping("main")
	public String blockList(Model model) {
		
		try {
			/* 문의 */
			InquiryManage stats = service.getInquiryStats();
			model.addAttribute("waitInquiry", stats.getWaitInquiry());
			model.addAttribute("allInquiry", stats.getAllInquiry());

			int rateInquiry = 0;
			if(stats.getAllInquiry() > 0) {
				rateInquiry = (int)(((double)stats.getCompInquiry() / stats.getAllInquiry()) * 100);
			}
			
			model.addAttribute("rateInquiry", rateInquiry);
			
			/* 신고 */
			Reports reStats = reService.getReportStats();
			model.addAttribute("waitReport", reStats.getWaitReport());
			
			int todayReportCount = reService.todayReportCount(); 
			model.addAttribute("todayReportCount", todayReportCount);
			
		} catch (Exception e) {
			log.info("blockList: ", e);
		}
		
		return "admin/blockAndInquiry/main";
	}

}
