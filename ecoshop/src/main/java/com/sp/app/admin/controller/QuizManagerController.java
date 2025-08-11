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

import com.sp.app.admin.model.QuizManage;
import com.sp.app.admin.service.QuizManageService;
import com.sp.app.common.MyUtil;
import com.sp.app.common.PaginateUtil;
import com.sp.app.model.SessionInfo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import oracle.jdbc.proxy.annotation.Post;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/admin/quiz/*")
public class QuizManagerController {
	
	private final QuizManageService service;
	private final PaginateUtil paginateUtil;
	private final MyUtil myUtil;
	
	@GetMapping("list")
	public String quizList(@RequestParam(name = "page", defaultValue = "1") int current_page,
								@RequestParam(name = "schType", defaultValue = "name") String schType,
								@RequestParam(name = "kwd", defaultValue = "") String kwd,						
								Model model, HttpServletRequest req) {
		
		try {
			int size = 15;
			int total_page = 0;
			int dataCount = 0;
			
			kwd = myUtil.decodeUrl(kwd);
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("schType", schType);
			map.put("kwd", kwd);
			
			dataCount = service.dataCount(map);
			if (dataCount != 0) {
				total_page = paginateUtil.pageCount(dataCount, size);
			}
			
			current_page = Math.min(current_page, total_page);
			
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			
			List<QuizManage> list = service.listQuiz(map);
			
			String cp = req.getContextPath();
			String query = "";
			String listUrl = cp + "/admin/quiz/list";
			String articleUrl = cp + "/admin/quiz/article?page=" + current_page;
			if (!kwd.isBlank()) {
				query = "schType=" + schType + "&kwd=" + myUtil.encodeUrl(kwd);
				
				listUrl += "?" + query;
				articleUrl += "&" + query;
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
			model.addAttribute("articleUrl", articleUrl);
			
		} catch (Exception e) {
			log.info("quizList: ", e);
		}
		
		return "admin/quiz/list";
	}
	
	@GetMapping("write")
	public String quizWriteForm(Model model) throws Exception {
		
		model.addAttribute("mode", "write");
		
		return "admin/quiz/write";
	}
	
	@PostMapping("write")
	public String quizWriteSubmit(QuizManage dto, HttpSession session) throws Exception {
		
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			dto.setInsertId(info.getMemberId());
			
			service.insertQuiz(dto);
			
		} catch (Exception e) {
			log.info("quizSubmit: ", e);
		}
		
		return "redirect:/admin/quiz/list";
	}
	
	@GetMapping("article")
	public String quizArticle(@RequestParam(name = "quizId") long quizId,
						@RequestParam(name = "page") String page,
						@RequestParam(name = "schType", defaultValue = "name") String schType,
						@RequestParam(name = "kwd", defaultValue = "") String kwd, Model model, HttpSession session) throws Exception {
		
		String query = "page=" + page;
		
		try {
			
			kwd = myUtil.decodeUrl(kwd);
			if(! kwd.isBlank()) {
				query += "&schType=" + schType + "&kwd=" + myUtil.encodeUrl(kwd);
			}
			
			QuizManage dto = Objects.requireNonNull(service.findByQuiz(quizId));
			dto.setContent(myUtil.htmlSymbols(dto.getContent()));
			dto.setCommentary(myUtil.htmlSymbols(dto.getCommentary()));
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("schType", schType);
			map.put("kwd", kwd);
			map.put("quizId", quizId);
			
			model.addAttribute("dto", dto);
			model.addAttribute("page", page);
			model.addAttribute("query", query);
			
			return "admin/quiz/article";			
			
		} catch (NullPointerException e) {
			log.info("article: ", e);
		} catch (Exception e) {
			log.info("article: ", e);
		}
		
		return "redirect:/admin/quiz/list?" + query;
	}
	
	@GetMapping("update")
	public String quizUpdateForm(@RequestParam(name = "quizId") long quizId, @RequestParam(name = "page") String page,
			Model model, HttpSession session) throws Exception {
		
		try {			
			QuizManage dto = Objects.requireNonNull(service.findByQuiz(quizId));
			
			model.addAttribute("dto", dto);
			model.addAttribute("mode", "update");
			model.addAttribute("page", page);
			
			return "admin/quiz/write";
			
		} catch (NullPointerException e) {
		} catch (Exception e) {
			log.info("updateForm: ", e);
		}
		
		return "redirect:/admin/quiz/list?page" + page;
	}
	
	@PostMapping("update")
	public String quizUpdateSubmit(QuizManage dto, @RequestParam(name = "page") String page) throws Exception {
		
		try {
			service.updateQuiz(dto);
		} catch (Exception e) {
			log.info("updateSubmit: ", e);
		}
		
		return "redirect:/admin/quiz/list?page" + page;
	}
	
	@GetMapping("delete")
	public String deleteQuiz(@RequestParam(name = "quizId") long quizId, @RequestParam(name = "page") String page,
					@RequestParam(name = "schType", defaultValue = "name") String schType, @RequestParam(name = "kwd", defaultValue = "") String kwd,
					HttpSession session) throws Exception {
		
		String query = "page=" + page;
		
		try {
			kwd = myUtil.decodeUrl(kwd);
			if(! kwd.isBlank()) {
				query += "&schType=" + schType + "&kwd" + myUtil.encodeUrl(kwd);
			}
			
			service.deleteQUiz(quizId);
			
		} catch (Exception e) {
			log.info("deleteQuiz: ", e);
		}
		
		return "redirect:/admin/quiz/list?" + query;
	}
	
	

}
