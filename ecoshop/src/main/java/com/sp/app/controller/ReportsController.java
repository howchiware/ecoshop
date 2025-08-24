package com.sp.app.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.dao.DuplicateKeyException;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sp.app.model.Reports;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.ReportsService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class ReportsController {
	private final ReportsService service;
	
	@PostMapping("/reports/saved")
	public Map<String, ?> handleSaved(
			Reports dto,
			HttpServletRequest req,
			HttpSession session) {
		Map<String, Object> model = new HashMap<>();
		
		String state = "true";
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			dto.setReporterId(info.getMemberId());
			dto.setReportIp(req.getRemoteAddr());
			
			service.insertReports(dto);
			
		} catch (DuplicateKeyException e) {
			state = "liked";
		} catch (Exception e) {
			state = "false";
		}
		
		model.put("state", state);
		
		return model;
	}
}
