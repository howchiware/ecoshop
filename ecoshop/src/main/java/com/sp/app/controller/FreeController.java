package com.sp.app.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.common.MyUtil;
import com.sp.app.common.PaginateUtil;
import com.sp.app.model.Free;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.FreeService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/free")
public class FreeController {
	
	private final FreeService service;
	private final PaginateUtil paginateUtil;
	private final MyUtil myUtil;
	
	@GetMapping("freeHome")
	public String freeHome() {
		return "free/dairyList";
	}
	
	@GetMapping("dairyList")
	public String dailyList(@RequestParam(name = "page", defaultValue = "1") int current_page,
							@RequestParam(name = "schType", defaultValue = "nickname") String schType,
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
			
			List<Free> dairyList = service.dairyList(map);
			
			String cp = req.getContextPath();
			String query = "";
			String listUrl = cp + "/free/dairyList";
			if(! kwd.isBlank()) {
				query = "schType=" + schType + "&kwd=" + myUtil.encodeUrl(kwd);
				listUrl += "?" + query;
			}
			
			String paging = paginateUtil.pagingUrl(current_page, total_page, listUrl);
			
			model.addAttribute("dairyList", dairyList);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("size", size);
			model.addAttribute("total_page", total_page);
			model.addAttribute("page", current_page);
			model.addAttribute("paging", paging);
			model.addAttribute("schType", schType);
			model.addAttribute("kwd", kwd);
			
		} catch (Exception e) {
			log.info("dailyList: ", e);
		}
		
		return "free/dairyList";
	}
	
	@GetMapping("write")
	public String writeForm(Model model, HttpSession session) throws Exception {
	
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if(info == null) {
			return "redirect:/member/login";
		}
		
		model.addAttribute("mode", "write");
		return "free/dairyWrite";
	}
	
	@PostMapping("write")
	public String dailyWrite(Free dto, HttpSession session) throws Exception {
		
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");

			dto.setMemberId(info.getMemberId());
			dto.setNickname(info.getNickname());
			
			service.insertDairy(dto);
		} catch (Exception e) {
			log.info("dailyWrite: ", e);
		}
		
		return "redirect:/free/dairyList";
	}
	
	@GetMapping("article/{freeId}")
	public String article(@PathVariable(name = "freeId") long freeId,
							@RequestParam(name = "page") String page,
							@RequestParam(name = "schType", defaultValue = "all") String schType,
							@RequestParam(name = "kwd", defaultValue = "") String kwd,
							Model model, HttpSession session, HttpServletRequest request) throws Exception {
		
		String query = "page=" + page;
		
		try {
			kwd = myUtil.decodeUrl(kwd);
			if(! kwd.isBlank()) {
				query += "&schType=" + schType + "&kwd=" + myUtil.encodeUrl(kwd);
			}
		    
			service.updateHitCount(freeId);
			
			Free dto = Objects.requireNonNull(service.findByDairy(freeId));
			
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("schType", schType);
			map.put("kwd", kwd);
			map.put("freeId", freeId);
			
			Free prevDto = service.findByPrev(map);
			Free nextDto = service.findByNext(map);
			
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			map.put("memberId", info.getMemberId());
			boolean isUserLiked = service.isUserFreeLiked(map);
			
			model.addAttribute("dto", dto);
			model.addAttribute("prevDto", prevDto);
			model.addAttribute("nextDto", nextDto);
			model.addAttribute("query", query);
			model.addAttribute("isUserLiked", isUserLiked);
			
			return "free/dairyArticle";
			
		} catch (NullPointerException e) {
			log.info("dairyArticle: ", e);
		} catch (Exception e) {
			log.info("dairyArticle: ", e);
		}
		
		return "redirect:/free/dairyList?" + query;		
	}
	
	@GetMapping("update")
	public String updateForm(@RequestParam(name = "freeId") long freeId, @RequestParam(name = "page") String page,
								Model model, HttpSession session) throws Exception {
		
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			Free dto = Objects.requireNonNull(service.findByDairy(freeId));
			
			if(dto.getMemberId() != info.getMemberId()) {
				return "redirect:/free/dairyList?page=" + page;
			}
			
			model.addAttribute("dto", dto);
			model.addAttribute("mode", "update");
			model.addAttribute("page", page);
			
			return "free/dairyWrite";
			
		} catch (NullPointerException e) {
		} catch (Exception e) {
			log.info("updateForm : ", e);
		}
		
		return "redirect:/free/dairyList?page=" + page;
	}
	
	@PostMapping("update")
	public String updateSubmit(Free dto, @RequestParam(name = "page") String page, HttpSession session) throws Exception {
		
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			dto.setMemberId(info.getMemberId());
			service.updateDairy(dto);
		} catch (Exception e) {
			log.info("dairyUpdate: ", e);
		}
		
		return "redirect:/free/dairyList?page=" + page;
	}
	
	@GetMapping("delete")
	public String dairyDelete(@RequestParam(name = "freeId") long freeId,
						@RequestParam(name = "page") String page,
						@RequestParam(name = "schType", defaultValue = "all") String schType,
						@RequestParam(name = "kwd", defaultValue = "") String kwd,
						HttpSession session) throws Exception {
		
		String query = "page=" + page;
		
		try {
			kwd = myUtil.decodeUrl(kwd);
			if(! kwd.isBlank()) {
				query += "&schType=" + schType + "&kwd=" + myUtil.encodeUrl(kwd);
			}
			
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			service.deleteDairy(freeId, info.getMemberId(), info.getUserLevel());
		} catch (Exception e) {
			log.info("dairyDelete : ", e);
		}
		
		return "redirect:/free/dairyList?" + query;		
	}
	
	@GetMapping("listReply")
	public String listReply(@RequestParam(name = "freeId") long freeId,
							@RequestParam(name = "pageNo", defaultValue = "1") int current_page,
							Model model, HttpServletResponse resp, HttpSession session) throws Exception {
		
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			int size = 5;
			int total_page = 0;
			int dataCount = 0;
			
			Map<String, Object> map = new HashMap<>();
			map.put("freeId", freeId);
			
			map.put("userLevel", info.getUserLevel());
			map.put("memberId", info.getMemberId());
			
			dataCount = service.replyCount(map);
			total_page = paginateUtil.pageCount(dataCount, size);
			current_page = Math.min(current_page, total_page);
			
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			
			List<Free> listReply = service.listReply(map);
			
			String paging = paginateUtil.pagingMethod(current_page, total_page, "listPage");
			
			model.addAttribute("listReply", listReply);
			model.addAttribute("pageNo", current_page);
			model.addAttribute("replyCount", dataCount);
			model.addAttribute("total_page", total_page);
			model.addAttribute("paging", paging);
			
		} catch (Exception e) {
			log.info("listReply: ", e);
			resp.sendError(406);
			throw e;
		}
		
		return "free/dairyListReply";
	}
	
	@ResponseBody
	@PostMapping("insertReply")
	public Map<String, ?> insertReply(Free dto, HttpSession session) {
		
		Map<String, Object> model = new HashMap<>();
		
		String state = "true";
		
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			dto.setMemberId(info.getMemberId());
			dto.setNickname(info.getNickname());
			service.insertReply(dto);
			
		} catch (Exception e) {
			state = "false";
		}
		
		model.put("state", state);
		return model;
	}
	
	@ResponseBody
	@PostMapping("deleteReply")
	public Map<String, ?> deleteReply(@RequestParam Map<String, Object> paramMap) {
		Map<String, Object> model = new HashMap<>();
		
		String state = "true";
		
		try {
			service.deleteReply(paramMap);
		} catch (Exception e) {
			state = "false";
		}
		
		model.put("state", state);
		return model;
	}
	
	@GetMapping("listReplyAnswer")
	public String listReplyAnswer(@RequestParam Map<String, Object> paramMap,
			Model model,
			HttpServletResponse resp,
			HttpSession session) throws Exception {
		
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			paramMap.put("userLevel", info.getUserLevel());
			paramMap.put("memberId", info.getMemberId());
			
			List<Free> listReplyAnswer = service.listReplyAnswer(paramMap);
			
			model.addAttribute("listReplyAnswer", listReplyAnswer);
			
		} catch (Exception e) {
			log.info("listReplyAnswer : ", e);
			throw e;
		}
		
		return "free/listReplyAnswer";
	}
	
	@ResponseBody
	@PostMapping(value = "countReplyAnswer")
	public Map<String, ?> countReplyAnswer(@RequestParam Map<String, Object> paramMap,
			HttpSession session) {
		
		Map<String, Object> model = new HashMap<>();
		
		int count = 0;
		
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			paramMap.put("userLevel", info.getUserLevel());
			paramMap.put("memberId", info.getMemberId());
			
			count = service.replyAnswerCount(paramMap);
		} catch (Exception e) {
			log.info("countReplyAnswer : ", e);
		}
		
		model.put("count", count);
		return model;
	}
	
	@ResponseBody
	@PostMapping("freeLike/{freeId}")
	public Map<String, ?> insertFreeLike(@PathVariable(name = "freeId") long freeId, HttpSession session) {
		
		Map<String, Object> model = new HashMap<>();
		
		String state = "true";
		int freeLikeCount = 0;
		
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			Map<String, Object> paramMap = new HashMap<>();
			paramMap.put("freeId", freeId);
			paramMap.put("memberId", info.getMemberId());
			
			service.insertFreeLike(paramMap);
			
			freeLikeCount = service.freeLikeCount(freeId);
			
		} catch (DuplicateKeyException e) {
			state = "liked";
		} catch (Exception e) {
			state = "false";
		}
		
		model.put("state", state);
		model.put("freeLikeCount", freeLikeCount);
		
		return model;
	}
	
	@ResponseBody
	@DeleteMapping("freeLike/{freeId}")
	public Map<String, ?> deleteFreeLike(@PathVariable(name = "freeId") long freeId,
			HttpSession session) {
		Map<String, Object> model = new HashMap<>();
		
		String state = "true";
		int freeLikeCount = 0;
		
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			Map<String, Object> paramMap = new HashMap<>();
			paramMap.put("freeId", freeId);
			paramMap.put("memberId", info.getMemberId());
			
			service.deleteFreeLike(paramMap);
			
			freeLikeCount = service.freeLikeCount(freeId);
			
		} catch (Exception e) {
			state = "false";
		}
		
		model.put("state", state);
		model.put("freeLikeCount", freeLikeCount);
		
		return model;
	}
	
	
}
