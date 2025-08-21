package com.sp.app.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.app.common.MyUtil;
import com.sp.app.common.PaginateUtil;
import com.sp.app.model.SessionInfo;
import com.sp.app.model.TipBoard;
import com.sp.app.service.TipBoardService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/tipBoard/*")
public class TipBoardController {
	private final TipBoardService service;
	private final PaginateUtil paginateUtil;
	private final MyUtil myUtil;
	
	@GetMapping("list")
	public String list(@RequestParam(name = "page", defaultValue = "1") int current_page,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			@RequestParam(name = "size", defaultValue = "10") int size,
			Model model,
			HttpServletRequest req) throws Exception {

		
		try {
			int total_page = 0;
			int dataCount = 0;
			
			kwd = myUtil.decodeUrl(kwd);
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("schType", schType);
			map.put("kwd", kwd);
			
			dataCount = service.dataCount(map);
			total_page = paginateUtil.pageCount(dataCount, size);
			
			current_page = Math.min(current_page, total_page);
			
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;

			map.put("offset", offset);
			map.put("size", size);
			
			List<TipBoard> list = service.listTipBoard(map);
			
			String cp = req.getContextPath();
			String query = "size=" + size;
			String listUrl = cp + "/tipBoard/list";
			String articleUrl = cp + "/tipBoard/article?page=" + current_page;
			
			if (! kwd.isBlank()) { 
				query += "&schType=" + schType + "&kwd=" + myUtil.encodeUrl(kwd);
			}
			
			listUrl += "?" + query;
			articleUrl += "&" + query;
			
			String paging = paginateUtil.paging(current_page, total_page, articleUrl);
			
			model.addAttribute("list", list);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("size", size);
			model.addAttribute("page", current_page);
			model.addAttribute("total_page", total_page);
			model.addAttribute("articleUrl", articleUrl);
			model.addAttribute("paging", paging);

			model.addAttribute("schType", schType);
			model.addAttribute("kwd", kwd);
			
		} catch (Exception e) {
			log.info("list : ", e);
		}
		
		return "tipBoard/list";
	}
	
	@GetMapping("write")
	public String writeForm(HttpSession session, Model model) throws Exception{
		model.addAttribute("mode", "write");
		
		return "tipBoard/write";
	}
	
	@PostMapping("write")
	public String writeSubmit(TipBoard dto, HttpSession session) throws Exception{
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			dto.setMemberId(info.getMemberId());
			service.insertTipBoard(dto, "write");
		} catch (Exception e) {
			log.info("writeSubmit : ", e);
		}
		
		return "redirect:/tipBoard/list";
	}
}
