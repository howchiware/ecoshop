package com.sp.app.admin.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.app.admin.model.NoticeManage;
import com.sp.app.admin.service.NoticeManageService;
import com.sp.app.common.MyUtil;
import com.sp.app.common.PaginateUtil;
import com.sp.app.common.StorageService;
import com.sp.app.model.SessionInfo;

import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/admin/notice/*")
public class NoticeManageController {
	private final NoticeManageService service;
	private final PaginateUtil paginateUtil;
	private final StorageService storageService;
	private final MyUtil myUtil;
	
	private String uploadPath;
	
	@PostConstruct
	public void init() {
		uploadPath = this.storageService.getRealPath("/uploads/notice");
	}	
	
	@GetMapping("list")
	public String list(@RequestParam(name = "page", defaultValue = "1") int current_page,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			Model model,
			HttpServletRequest req) throws Exception {
		
		try {
			int size = 10; // 한 화면에 보여주는 게시물 수
			int total_page = 0;
			int dataCount = 0;

			kwd = myUtil.decodeUrl(kwd);

			// 전체 페이지 수
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("schType", schType);
			map.put("kwd", kwd);

			dataCount = service.dataCount(map);
			if (dataCount != 0) {
				total_page = paginateUtil.pageCount(dataCount, size);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return "admin/notice/list";
	}
	
	@GetMapping("write")
	public String writeForm(Model model, HttpSession session) throws Exception {
		model.addAttribute("mode", "write");

		return "admin/notice/write";
	}
	
	@PostMapping("write")
	public String writeSubmit(NoticeManage dto, HttpSession session) throws Exception {

		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			dto.setMemberId(info.getMemberId());
			service.insertNotice(dto, uploadPath);
			
		} catch (Exception e) {
			log.info("writeSubmit : ", e);
		}

		return "redirect:/admin/notice/list";
	}

}

