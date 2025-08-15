package com.sp.app.admin.controller;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.app.admin.model.AttendanceManage;
import com.sp.app.admin.service.AttendanceManageService;
import com.sp.app.common.MyUtil;
import com.sp.app.common.PaginateUtil;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/admin/attendance/*")
public class AttendanceManagerController {
	
	private final AttendanceManageService service;
	private final PaginateUtil paginateUtil;
	private final MyUtil myUtil;
	
	@GetMapping("list")
	public String attendanceList(@RequestParam(name = "page", defaultValue = "1") int current_page,
								@RequestParam(name = "schType", defaultValue = "name") String schType,
								@RequestParam(name = "kwd", defaultValue = "") String kwd,
								@RequestParam(name = "role", defaultValue = "1") int userLevel,
								@RequestParam(name = "start", required = false) String start,
								@RequestParam(name = "end", required = false) String end,								
								Model model, HttpServletRequest req) {
		
		try {
			int size = 15;
			int total_page = 0;
			int dataCount = 0;
			
			kwd = myUtil.decodeUrl(kwd);
			
			LocalDate startDate;
			LocalDate endDate;
			
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			if (start != null && !start.isEmpty() && end != null && !end.isEmpty()) {
			    startDate = LocalDate.parse(start, formatter);
			    endDate = LocalDate.parse(end, formatter);
			} else {
			    LocalDate today = LocalDate.now();
			    startDate = today.with(DayOfWeek.MONDAY);
			    endDate = today.with(DayOfWeek.SUNDAY);
			}
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("schType", schType);
			map.put("kwd", kwd);
			map.put("start", startDate);
			map.put("end", endDate);
			/*
			dataCount = service.dataCount(map);
			if (dataCount != 0) {
				total_page = dataCount / size + (dataCount % size > 0 ? 1 : 0);
			}
			*/
			dataCount = service.memberCount(map);
			if(dataCount != 0) {
			    total_page = (dataCount + size - 1) / size;
			}
			
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			
			List<AttendanceManage> list = service.listAttendanceMember(map);
			
			int pointTargetCount = service.pointTargetCount(map);
	        int totalAttendanceCount = service.totalAttendanceCount(map);
			
			String cp = req.getContextPath();
			String listUrl = cp + "/admin/attendance/list";

			if (!kwd.isBlank()) {
			    listUrl += "?schType=" + schType + "&kwd=" + myUtil.encodeUrl(kwd);
			}

			String paging = paginateUtil.paging(current_page, total_page, listUrl);

			model.addAttribute("list", list);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("size", size);
			model.addAttribute("total_page", total_page);
			model.addAttribute("page", current_page);
			model.addAttribute("paging", paging);
			model.addAttribute("schType", schType);
			model.addAttribute("kwd", kwd);
			model.addAttribute("start", startDate.toString());
			model.addAttribute("end", endDate.toString());
			model.addAttribute("pointTargetCount", pointTargetCount);
	        model.addAttribute("totalAttendanceCount", totalAttendanceCount);
			
		} catch (Exception e) {
			log.info("attendanceList: ", e);
		}
		
		return "admin/attendance/list";
	}

}
