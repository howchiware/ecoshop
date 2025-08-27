package com.sp.app.admin.controller;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.admin.service.TotalManageService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class HomeManageController {
	private final TotalManageService service;
	
	@GetMapping("/admin")
	public String handleHome(Model model) {
		try {
			Map<String, Object> today = service.todayProduct();
			Map<String, Object> thisMonth = service.thisMonthProduct();
			Map<String, Object> previousMonth = service.previousMonthProduct();
			Map<String, Object> member = service.memberCount();
			Map<String, Object> staff = service.staffCount();
			
			model.addAttribute("today", today);
			model.addAttribute("thisMonth", thisMonth);
			model.addAttribute("previousMonth", previousMonth);
			model.addAttribute("member", member);
			model.addAttribute("staff", staff);
			
		} catch (Exception e) {
			log.info("handleHome : ", e);
		}
		return "admin/main/home";
	}
	@ResponseBody
	@GetMapping("/admin/charts")
	public Map<String, Object> handleCharts() {
		
		Map<String, Object> model = new HashMap<String, Object>();
		try {
			Calendar cal = Calendar.getInstance();
			int y = cal.get(Calendar.YEAR);
			int m = cal.get(Calendar.MONTH) + 1;
			int d = cal.get(Calendar.DATE);
			
			String date = String.format("%04d-%02d-%02d", y, m, d);
			String month = String.format("%04d%02d", y, m);
			
			List<Map<String, Object>> days = service.dayTotalAmount(date);
			List<Map<String, Object>> months = service.monthTotalAmount(month);
			
			if(d < 20) {
				cal.add(Calendar.MONTH, -1);
				y = cal.get(Calendar.YEAR);
				m = cal.get(Calendar.MONTH) + 1;
				month = String.format("%04d%02d", y, m);
			}
			
			Map<String, Object> dayOfWeek = service.dayOfWeekTotalCount(month);
			dayOfWeek.put("month", month);
			
			model.put("days", days);
			model.put("months", months);
			model.put("dayOfWeek", dayOfWeek);
			
			model.put("state", "true");
		} catch (Exception e) {
			model.put("state", "false");
		}
		
		return model;
	}
}
