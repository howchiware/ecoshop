package com.sp.app.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.app.admin.model.MemberManage;
import com.sp.app.admin.service.MemberManageService;
import com.sp.app.common.MyUtil;
import com.sp.app.common.PaginateUtil;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/admin/member/*")
public class MemberManageController {
	private final MyUtil myUtil;
	private final MemberManageService service;
	private final PaginateUtil paginateUtil;
	
	@GetMapping("list")
	public String handleHome(@RequestParam(name = "page", defaultValue = "1") int current_page,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd, 
			@RequestParam(name = "role", defaultValue = "1") int  userLevel,
			@RequestParam(name = "non", defaultValue = "0") int  non,
			@RequestParam(name = "enabled", defaultValue = "") String enabled,
			Model model,
			HttpServletRequest resp) throws Exception {
	
		try {
			int size = 10;
			int total_page = 0;
			int dataCount = 0;
			
			kwd = myUtil.decodeUrl(kwd);
			
			// 전체 페이지 수
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("userLevel", userLevel);
			map.put("non", non);
			map.put("enabled", enabled);
			map.put("schType", schType);
			map.put("kwd", kwd);
			
			dataCount = service.dataCount(map);
			if(dataCount != 0) {
				total_page = paginateUtil.pageCount(dataCount, size);
			}

			current_page = Math.min(current_page, total_page);
			
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			
			List<MemberManage> list = service.listMember(map);
			
			String paging = paginateUtil.paging(current_page, total_page, "listMember");
			
			model.addAttribute("list", list);
			model.addAttribute("page", current_page);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("size", size);
			model.addAttribute("total_page", total_page);
			model.addAttribute("userLevel", userLevel);
			model.addAttribute("non", non);
			model.addAttribute("enabled", enabled);
			model.addAttribute("paging", paging);
			model.addAttribute("schType", schType);
			model.addAttribute("kwd", kwd);
			
		} catch (Exception e) {
			log.info("list", e);
			
			throw e;
		}
		
		return "admin/member/list";
	}
	
	
	

}
