package com.sp.app.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.admin.model.FaqManage;
import com.sp.app.admin.service.FaqManageService;
import com.sp.app.common.MyUtil;
import com.sp.app.common.PaginateUtil;
import com.sp.app.model.SessionInfo;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/admin/faq/*")
public class FaqManageController {
	
	private final FaqManageService service;
	private final PaginateUtil paginateUtil;
	private final MyUtil myUtil;

	@GetMapping("main")
	public String faqMain(@RequestParam(name = "pageNo", defaultValue = "1") int current_page, Model model) throws Exception {
		
		try {
			Map<String, Object> map = new HashMap<>();

			List<FaqManage> listCategory = service.listCategory(map);
			
			model.addAttribute("listCategory", listCategory);
			model.addAttribute("categoryId", "0");
			model.addAttribute("pageNo", current_page);
			
		} catch (Exception e) {
			log.info("faqMain: ", e);
		}
		
		return "admin/faq/main";
	}
	
	@GetMapping("list")
	public String faqList(@RequestParam(name= "pageNo", defaultValue = "1") int current_page,
						@RequestParam(name = "schType", defaultValue = "all") String schType,
						@RequestParam(name = "kwd", defaultValue = "") String kwd,
						@RequestParam(name = "categoryId", defaultValue = "0") long categoryId,
						Model model, HttpServletResponse resp) throws Exception {
		
		try {
			
			int size = 10;
			int total_page = 0;
			int dataCount = 0;
			
			kwd = myUtil.decodeUrl(kwd);
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("schType", schType);
			map.put("kwd", kwd);
			map.put("categoryId", categoryId);
			
			dataCount = service.dataCount(map);
			if(dataCount != 0) {
				total_page = paginateUtil.pageCount(dataCount, size);
			}
			
			current_page = Math.min(current_page, total_page);
			
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			
			List<FaqManage> list = service.listFaq(map);
			
			String paging = paginateUtil.pagingFunc(current_page, total_page, "listPage");
			
			model.addAttribute("list", list);
			model.addAttribute("pageNo", current_page);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("size", size);
			model.addAttribute("total_page", total_page);
			model.addAttribute("paging", paging);
			
		} catch (Exception e) {
			resp.sendError(406);
			throw e;
		}
		
		return "admin/faq/list";
	}
	

	@GetMapping("listAllCategory")
	public String listAllCategory(Model model, HttpServletResponse resp) throws Exception {
		
		try {
			Map<String, Object> map = new HashMap<>();
			
			map.put("mode", "all");
			List<FaqManage> listCategory = service.listCategory(map);
			
			model.addAttribute("listCategory", listCategory);
			
			return "admin/faq/listCategory";
			
		} catch (Exception e) {
			resp.sendError(406);
			throw e;
		}
	}
	
	@GetMapping("write")
	public String writeFaqForm(Model model, HttpServletResponse resp) throws Exception {
		
		try {
			Map<String, Object> map = new HashMap<>();
			
			List<FaqManage> listCategory = service.listCategory(map);
			
			model.addAttribute("pageNo", "1");
			model.addAttribute("mode", "write");
			model.addAttribute("listCategory", listCategory);
			
			return "admin/faq/write";
			
		} catch (Exception e) {
			resp.sendError(406);
			throw e;
		}
	}
	
	@ResponseBody
	@PostMapping("write")
	public Map<String, ?> writeFaqSubmit(FaqManage dto, HttpSession session) throws Exception {
		
		Map<String, Object> model = new HashMap<String, Object>();
		
		String state = "false";
		
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			dto.setMemberId(info.getMemberId());
			service.insertFaq(dto);
			
			state = "true";
			
		} catch (Exception e) {
			log.info("writeFaqSubmit: ", e);
		}
		
		model.put("state", state);
		
		return model;
	}
	
	@GetMapping("update")
	public String updateFaqForm(@RequestParam(name = "faqId") long faqId, @RequestParam(name = "pageNo") String pageNo,
						Model model, HttpServletResponse resp, HttpSession session) throws Exception {
		
		try {
			
			FaqManage dto = Objects.requireNonNull(service.findByFaq(faqId));
			
			Map<String, Object> map = new HashMap<>();
			
			List<FaqManage> listCategory = service.listCategory(map);
			
			model.addAttribute("mode", "update");
			model.addAttribute("pageNo", pageNo);
			model.addAttribute("dto", dto);
			model.addAttribute("listCategory", listCategory);
			
			return "admin/faq/write";
			
		} catch (NullPointerException e) {
			log.info("updateFaqForm : ", e);
			resp.sendError(406);
			throw e;
		} catch (Exception e) {
			log.info("updateFaqForm : ", e);
			resp.sendError(406);
			throw e;
		}
	}
	
	@ResponseBody
	@PostMapping("update")
	public Map<String, ?> updateFaqSubmit(FaqManage dto, HttpSession session) throws Exception {
		
		Map<String, Object> model = new HashMap<String, Object>();
		
		String state = "false";
		
		try {
			
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			dto.setUpdateId(info.getMemberId());
			service.updateFaq(dto);
			
			state = "true";
			
		} catch (Exception e) {
			log.info("updateFaqSubmit : ", e);
		}
		
		model.put("state", state);
		
		return model;
	}
	
	@ResponseBody
	@PostMapping("delete")
	public Map<String, ?> deleteFaq(@RequestParam(name = "faqId") long faqId, HttpSession sesison) throws Exception {
		
		Map<String, Object> model = new HashMap<>();
		
		String state = "false";
		
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("faqId", faqId);
			
			service.deleteFaq(map);
			
			state = "true";
		} catch (Exception e) {
			log.info("deleteFaq: ", e);
		}
		
		model.put("state", state);
		
		return model;
	}
	
	@ResponseBody
	@PostMapping("insertCategory")
	public Map<String, ?> insertCategory(FaqManage dto) throws Exception {
		
		Map<String, Object> model = new HashMap<>();
		
		String state = "false";
		
		try {
			service.insertCategory(dto);
			state = "true";
		} catch (Exception e) {
			log.info("insertCategory: ", e);
		}
		
		model.put("state", state);
		return model;
	}
	
	@ResponseBody
	@PostMapping("updateCategory")
	public Map<String, ?> updateCategory(FaqManage dto) throws Exception {
		
		Map<String, Object> model = new HashMap<>();
		
		String state = "false";
		
		try {
			service.updateCategory(dto);
			state = "true";
		} catch (Exception e) {
			log.info("updateCategory: ", e);
		}
		
		model.put("state", state);
		return model;
	}
	
	@ResponseBody
	@PostMapping("deleteCategory")
	public Map<String, ?> deleteCategory(@RequestParam(name = "categoryId") long categoryId) throws Exception {
		
		Map<String, Object> model = new HashMap<>();
		
		String state = "false";
		
		try {
			service.deleteCategory(categoryId);
			state = "true";
		} catch (Exception e) {
			log.info("deleteCategory: ", e);
		}
		
		model.put("state", state);
		return model;
	}
	

}
