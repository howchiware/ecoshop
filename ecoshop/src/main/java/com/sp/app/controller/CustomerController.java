package com.sp.app.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.admin.model.FaqManage;
import com.sp.app.admin.model.InquiryManage;
import com.sp.app.admin.service.InquiryManageService;
import com.sp.app.common.MyUtil;
import com.sp.app.common.PaginateUtil;
import com.sp.app.model.Inquiry;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.FaqService;
import com.sp.app.service.InquiryService;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/customer")
public class CustomerController {
	
	private final FaqService faqService;
	private final InquiryManageService InqService;
	private final InquiryService service;
	
	private final PaginateUtil paginateUtil;
	private final MyUtil myUtil;
	
	/* 고객센터 */
	@GetMapping("main")
	public String customerPage(Model model, HttpSession session) throws SQLException {
	    
	    try {
	    	Map<String, Object> map = new HashMap<>();
	    	
	    	List<FaqManage> faqListCategory = faqService.listCategory(map);
	    	
	    	model.addAttribute("faqListCategory", faqListCategory);
			
		} catch (Exception e) {
			log.error("customerPage: ", e);
		}

	    return "customer/main";
	}
	
	/* 자주 묻는 질문 */
	@GetMapping("faqList")
	public String faqPage(@RequestParam(name = "categoryId", defaultValue = "0") long categoryId,
						Model model, HttpServletResponse resp) throws Exception {
		
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("categoryId", categoryId);

			List<FaqManage> faqlist = faqService.listFaq(map);
			
			model.addAttribute("faqlist", faqlist);
		} catch (Exception e) {
			resp.sendError(401);
		}
		
		return "customer/faqList";
	}
	
	/* 1:1 문의 */
	@GetMapping("inquiry")
	public String inquiryPage(@RequestParam(name = "pageNo", defaultValue = "1") int current_page,
							@RequestParam(name = "schType", defaultValue = "all") String schType,
							@RequestParam(name = "kwd", defaultValue = "") String kwd,
							Model model, HttpServletResponse resp, HttpSession session) throws Exception {
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if (info == null) {
		    resp.sendError(HttpServletResponse.SC_UNAUTHORIZED); 
		    return null;
		}
		
		try {
			int size = 10;
			int total_page = 0;
			int dataCount = 0;
			
			kwd = myUtil.decodeUrl(kwd);			
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("memberId", info.getMemberId());
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
			
			List<Inquiry> myInquiries = service.listInqByMember(map); 
			
			List<InquiryManage> inquiryCategories = InqService.listCategory(map);
			
			model.addAttribute("myInquiries", myInquiries);
			model.addAttribute("inquiryCategories", inquiryCategories);
			
			model.addAttribute("mode", "write");
			model.addAttribute("pageNo", "1");


		} catch (Exception e) {
			resp.sendError(401);
		}
		return "customer/inquiry";
	}

	@ResponseBody
	@PostMapping("inquiry")
	public Map<String, ?> writeInqSubmit(Inquiry dto, HttpSession session) throws Exception {
		
		Map<String, Object> model = new HashMap<String, Object>();
		String state = "false";
		
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			if (info == null) {
				model.put("state", "loginRequired");
				return model;
			}
			
			dto.setMemberId(info.getMemberId());
			service.insertInq(dto);
			state = "true";
			
		} catch (Exception e) {
			log.info("writeInqSubmit: ", e);
		}
		
		model.put("state", state);
		return model;
	}

	@GetMapping("inquiry/detail")
	public String inquiryDetail(@RequestParam(name = "inquiryId") long inquiryId, 
	                            @RequestParam(name = "pageNo", defaultValue = "1") String pageNo,
	                            Model model, HttpSession session, HttpServletResponse resp) throws Exception {
	    
	    SessionInfo info = (SessionInfo) session.getAttribute("member");
	    if (info == null) {
	        resp.sendError(HttpServletResponse.SC_UNAUTHORIZED);
	        return null;
	    }

	    try {
	        Inquiry dto = service.findByInq(inquiryId);
	        
	        if (dto == null || dto.getMemberId() != info.getMemberId()) {
	            resp.sendError(HttpServletResponse.SC_FORBIDDEN); 
	            return null;
	        }

	        List<InquiryManage> inquiryCategories = InqService.listCategory(new HashMap<>());

	        model.addAttribute("dto", dto);
	        model.addAttribute("inquiryCategories", inquiryCategories);
	        model.addAttribute("pageNo", pageNo); 
	        
	    } catch (Exception e) {
	        log.error("inquiryDetail error", e);
	        resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	        return null;
	    }
	    
	    return "customer/detail";
	}

	
	@ResponseBody
	@PostMapping("inquiry/update")
	public Map<String, ?> updateSubmit(Inquiry dto, HttpSession session) throws Exception {
		
		Map<String, Object> model = new HashMap<>();
		String state = "false";
		
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			dto.setMemberId(info.getMemberId());
			service.updateInq(dto);
			state = "true";
			
		} catch (Exception e) {
			log.info("updateSubmit: ", e);
		}
		
		model.put("state", state);
		return model;
	}

	
	@GetMapping("inquiry/delete")
	public Map<String, Object> deleteForm(Inquiry dto, HttpSession session) throws Exception {
		
		Map<String, Object> model = new HashMap<>();
		String state = "false";
		
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			if(info == null) {
				model.put("state", "loginRequired");
				return model;
			}
			
			dto.setMemberId(info.getMemberId());
			
			service.deleteInq(dto);
			state = "true";
			
		} catch (Exception e) {
			log.info("deleteForm: ", e);
		}
		
		model.put("state", state);
	    return model;
	}
	
	@ResponseBody
	@PostMapping("inquiry/delete")
	public Map<String, ?> deleteSubmit(Inquiry dto, HttpSession session) throws Exception {
		
		Map<String, Object> model = new HashMap<>();
		String state = "false";
		
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			dto.setMemberId(info.getMemberId());
			service.deleteInq(dto);
			state = "true";
			
		} catch (Exception e) {
			log.info("deleteSubmit: ", e);
		}
		
		model.put("state", state);
		return model;
	}

}
