package com.sp.app.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.app.common.MyUtil;
import com.sp.app.common.PaginateUtil;
import com.sp.app.model.Magazine;
import com.sp.app.service.MagazineService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/magazine/*")
public class MagazineController {
	private final MagazineService service;
	private final PaginateUtil paginateUtil;
	private final MyUtil myUtil;
	
	@GetMapping("magazineHome")
	public String magazineHome() {
		return "magazine/list";
	}
	
	@GetMapping("list")
	public String dailyList(@RequestParam(name = "page", defaultValue = "1") int current_page,
							@RequestParam(name = "schType", defaultValue = "all") String schType,
							@RequestParam(name = "kwd", defaultValue = "") String kwd,
							Model model,
							HttpServletRequest req) throws Exception {
		
		try {
			int size = 10;
			int total_page = 0;
			int dataCount = 0;
			
			kwd = myUtil.decodeUrl(kwd);
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("schType", schType);
			map.put("kwd", kwd);
			
			dataCount = service.dataCount(map);
			if(dataCount != 0) {
				total_page = dataCount / size + (dataCount % size > 0 ? 1 : 0);
			}
			
			current_page = Math.min(current_page, total_page);
			
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			
			List<Magazine> magazineList = service.magazineList(map);
			
			String cp = req.getContextPath();
			String query = "";
			String listUrl = cp + "/magazine/list";
			if(! kwd.isBlank()) {
				query = "schType=" + schType + "&kwd=" + myUtil.encodeUrl(kwd);
				listUrl += "?" + query;
			}
			
			String paging = paginateUtil.paging(current_page, total_page, listUrl);
			
			model.addAttribute("magazineList", magazineList);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("size", size);
			model.addAttribute("total_page", total_page);
			model.addAttribute("page", current_page);
			model.addAttribute("paging", paging);
			model.addAttribute("schType", schType);
			model.addAttribute("kwd", kwd);
			
		} catch (Exception e) {
			log.info("magazineList: ", e);
		}
		
		return "magazine/list";
	}
	
	
}
