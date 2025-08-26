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
import com.sp.app.model.Magazine;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.MagazineService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
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
	public String magazineList(@RequestParam(name = "page", defaultValue = "1") int current_page,
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
	
	
	@GetMapping("write")
	public String writeForm(Model model, HttpSession session) throws Exception {
	
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if(info == null) {
			return "redirect:/magazine/login";
		}
		
		model.addAttribute("mode", "write");
		return "magazine/write";
	}
	
	@PostMapping("write")
	public String magazineWrite(Magazine dto, HttpSession session) throws Exception {
		
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");

			dto.setMemberId(info.getMemberId());
			dto.setName(info.getName());
			
			service.insertMagazine(dto, null);
		} catch (Exception e) {
			log.info("magazineWrite: ", e);
		}
		
		return "redirect:/magazine/list";
	}
	
	@GetMapping("article/{magazineId}")
	public String article(@PathVariable(name = "magazineId") long magazineId,
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
		    
			service.updateHitCount(magazineId);
			
			Magazine dto = Objects.requireNonNull(service.findByMagazine(magazineId));
			
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("schType", schType);
			map.put("kwd", kwd);
			map.put("magazineId", magazineId);
			
			Magazine prevDto = service.findByPrev(map);
			Magazine nextDto = service.findByNext(map);
			
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			map.put("memberId", info.getMemberId());
			boolean isUserLiked = service.isUserMagazineLiked(map);
			
			model.addAttribute("dto", dto);
			model.addAttribute("prevDto", prevDto);
			model.addAttribute("nextDto", nextDto);
			model.addAttribute("query", query);
			model.addAttribute("isUserLiked", isUserLiked);
			
			return "magazine/article";
			
		} catch (NullPointerException e) {
			log.info("article: ", e);
		} catch (Exception e) {
			log.info("article: ", e);
		}
		
		return "redirect:/magazine/list?" + query;		
	}
	
	@GetMapping("update")
	public String updateForm(@RequestParam(name = "magazineId") long magazineId, @RequestParam(name = "page") String page,
								Model model, HttpSession session) throws Exception {
		
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			Magazine dto = Objects.requireNonNull(service.findByMagazine(magazineId));
			
			if(dto.getMemberId() != info.getMemberId()) {
				return "redirect:/magazine/list?page=" + page;
			}
			
			model.addAttribute("dto", dto);
			model.addAttribute("mode", "update");
			model.addAttribute("page", page);
			
			return "magazine/write";
			
		} catch (NullPointerException e) {
		} catch (Exception e) {
			log.info("updateForm : ", e);
		}
		
		return "redirect:/magazine/list?page=" + page;
	}
	
	@PostMapping("update")
	public String updateSubmit(Magazine dto, @RequestParam(name = "page") String page, HttpSession session) throws Exception {
		
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			dto.setMemberId(info.getMemberId());
			service.updateMagazine(dto, page);
		} catch (Exception e) {
			log.info("updateMagazine: ", e);
		}
		
		return "redirect:/magazine/list?page=" + page;
	}
	
	@GetMapping("delete")
	public String deleteMagazine(@RequestParam(name = "magazineId") long magazineId,
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
			
			service.deleteMagazine(magazineId, info.getMemberId(), info.getUserLevel());
		} catch (Exception e) {
			log.info("deleteMagazine : ", e);
		}
		
		return "redirect:/magazine/list?" + query;		
	}
	
	@GetMapping("listReply")
	public String listReply(@RequestParam(name = "magazineId") long magazineId,
							@RequestParam(name = "pageNo", defaultValue = "1") int current_page,
							Model model, HttpServletResponse resp, HttpSession session) throws Exception {
		
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			int size = 5;
			int total_page = 0;
			int dataCount = 0;
			
			Map<String, Object> map = new HashMap<>();
			map.put("magazineId", magazineId);
			
			map.put("userLevel", info.getUserLevel());
			map.put("memberId", info.getMemberId());
			
			dataCount = service.replyCount(map);
			total_page = paginateUtil.pageCount(dataCount, size);
			current_page = Math.min(current_page, total_page);
			
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			
			List<Magazine> listReply = service.listReply(map);
			
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
		
		return "magazine/listReply";
	}
	
	@ResponseBody
	@PostMapping("insertReply")
	public Map<String, ?> insertReply(Magazine dto, HttpSession session) {
		
		Map<String, Object> model = new HashMap<>();
		
		String state = "true";
		
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			dto.setMemberId(info.getMemberId());
			dto.setName(info.getName());
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
			
			List<Magazine> listReplyAnswer = service.listReplyAnswer(paramMap);
			
			model.addAttribute("listReplyAnswer", listReplyAnswer);
			
		} catch (Exception e) {
			log.info("listReplyAnswer : ", e);
			throw e;
		}
		
		return "magazine/listReplyAnswer";
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
	@PostMapping("magazineLike/{magazineId}")
	public Map<String, ?> insertMagazineLike(@PathVariable(name = "magazineId") long magazineId, HttpSession session) {
		
		Map<String, Object> model = new HashMap<>();
		
		String state = "true";
		int magazineLikeCount = 0;
		
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			Map<String, Object> paramMap = new HashMap<>();
			paramMap.put("magazineId", magazineId);
			paramMap.put("memberId", info.getMemberId());
			
			service.insertMagazineLike(paramMap);
			
			magazineLikeCount = service.magazineLikeCount(magazineId);
			
		} catch (DuplicateKeyException e) {
			state = "liked";
		} catch (Exception e) {
			state = "false";
		}
		
		model.put("state", state);
		model.put("magazineLikeCount", magazineLikeCount);
		
		return model;
	}
	
	@ResponseBody
	@DeleteMapping("magazineLike/{magazineId}")
	public Map<String, ?> deleteMagazineLike(@PathVariable(name = "magazineId") long magazineId,
			HttpSession session) {
		Map<String, Object> model = new HashMap<>();
		
		String state = "true";
		int magazineLikeCount = 0;
		
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			Map<String, Object> paramMap = new HashMap<>();
			paramMap.put("magazineId", magazineId);
			paramMap.put("memberId", info.getMemberId());
			
			service.deleteMagazineLike(paramMap);
			
			magazineLikeCount = service.magazineLikeCount(magazineId);
			
		} catch (Exception e) {
			state = "false";
		}
		
		model.put("state", state);
		model.put("magazineLikeCount", magazineLikeCount);
		
		return model;
	}
	
}
