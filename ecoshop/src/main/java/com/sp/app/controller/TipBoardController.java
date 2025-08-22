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
			
			if (!kwd.isBlank()) { 
			    query += "&schType=" + schType + "&kwd=" + myUtil.encodeUrl(kwd);
			}
			
			listUrl += "?" + query;
			articleUrl += "&" + query;
			
			String paging = paginateUtil.paging(current_page, total_page, listUrl);
			
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
	
	@GetMapping("article")
	public String article(@RequestParam(name = "tipId") long tipId,
			@RequestParam(name = "page") String page,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			@RequestParam(name = "size") int size,
			Model model,
			HttpSession session) throws Exception {

		String query = "page=" + page + "&size=" + size;
                                                                                                                                                                                                                                                                                                                                             		try {
			kwd = myUtil.decodeUrl(kwd);
			if (! kwd.isBlank()) {
				query += "&schType=" + schType + "&kwd=" + myUtil.encodeUrl(kwd);
			}

			service.updateHitCount(tipId);
			
			TipBoard dto = Objects.requireNonNull(service.findById(tipId));

			//dto.setContent(myUtil.htmlSymbols(dto.getContent()));
			//dto.setName(myUtil.nameMasking(dto.getName()));

			Map<String, Object> map = new HashMap<>();
			map.put("schType", schType);
			map.put("kwd", kwd);
			map.put("groupNum", dto.getGroupNum());
			map.put("orderNo", dto.getOrderNo());
			map.put("tipId", tipId);
			
			TipBoard prevDto = service.findByPrev(map);
			TipBoard nextDto = service.findByNext(map);
			
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			map.put("memberId", info.getMemberId());
			boolean isUserLiked = service.isUserTipBoardLiked(map);

			model.addAttribute("dto", dto);
			model.addAttribute("prevDto", prevDto);
			model.addAttribute("nextDto", nextDto);
			model.addAttribute("query", query);
			model.addAttribute("size", size);
			model.addAttribute("page", page);
			model.addAttribute("isUserLiked", isUserLiked);
			
			return "tipBoard/article";
			
		} catch (NullPointerException e) {
			log.info("article : ", e);
		} catch (Exception e) {
			log.info("article : ", e);
		}
		
		return "redirect:/tipBoard/list?" + query;
	}
	
	@GetMapping("update")
	public String updateForm(@RequestParam(name = "tipId") long tipId,
			@RequestParam(name = "page") String page,
			@RequestParam(name = "size") int size,
			Model model,
			HttpSession session) throws Exception {
		
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");

			TipBoard dto = Objects.requireNonNull(service.findById(tipId));
			if (dto.getMemberId() != info.getMemberId()) {
				return "redirect:/tipBoard/list?page=" + page + "&size=" + size;
			}

			model.addAttribute("dto", dto);
			model.addAttribute("page", page);
			model.addAttribute("size", size);
			model.addAttribute("mode", "update");

			return "tipBoard/write";
			
		} catch (NullPointerException e) {
			log.info("updateForm : ", e);
		} catch (Exception e) {
			log.info("updateForm : ", e);
		}
		
		return "redirect:/tipBoard/list?page=" + page + "&size=" + size;
	}

	@PostMapping("update")
	public String updateSubmit(TipBoard dto,
			@RequestParam(name = "size") int size,
			@RequestParam(name = "page") String page,
			HttpSession session) throws Exception {

		SessionInfo info = (SessionInfo) session.getAttribute("member");

		try {
			dto.setMemberId(info.getMemberId());
			service.updateTipBoard(dto);
		} catch (Exception e) {
			log.info("updateSubmit : ", e);
		}

		return "redirect:/tipBoard/list?page=" + page + "&size=" + size;
	}
	
	@GetMapping("reply")
	public String replyForm(@RequestParam(name = "tipId") long tipId,
			@RequestParam(name = "page") String page,
			@RequestParam(name = "size") int size,
			Model model) throws Exception {
		
		try {
			TipBoard dto = Objects.requireNonNull(service.findById(tipId));

			dto.setContent("[" + dto.getSubject() + "] 에 대한 답변입니다.\n");

			model.addAttribute("dto", dto);
			model.addAttribute("page", page);
			model.addAttribute("size", size);
			model.addAttribute("mode", "reply");

			return "tipBoard/write";
			
		} catch (NullPointerException e) {
			log.info("replyForm : ", e);
		} catch (Exception e) {
			log.info("replyForm : ", e);
		}

		return "redirect:/tipBoard/list?page=" + page + "&size=" + size;
	}

	@PostMapping("reply")
	public String replySubmit(TipBoard dto,
			@RequestParam(name = "size") int size,
			@RequestParam(name = "page") String page,
			HttpSession session) throws Exception {

		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			dto.setMemberId(info.getMemberId());
			
			service.insertTipBoard(dto, "reply");
		} catch (Exception e) {
			log.info("replySubmit : ", e);
		}

		return "redirect:/tipBoard/list?page=" + page + "&size=" + size;
	}

	@GetMapping("delete")
	public String delete(@RequestParam(name = "tipId") long tipId,
			@RequestParam(name = "page") String page,
			@RequestParam(name = "size") int size,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			HttpSession session) throws Exception {

		String query = "page=" + page + "&size=" + size;
		try {
			kwd = myUtil.decodeUrl(kwd);
			if (! kwd.isBlank()) {
				query += "&schType=" + schType + "&kwd=" + myUtil.encodeUrl(kwd);
			}
			
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			service.deleteTipBoard(tipId, info.getMemberId(), info.getUserLevel());
			
		} catch (Exception e) {
			log.info("delete : ", e);
		}

		return "redirect:/tipBoard/list?" + query;
	}
	
	@ResponseBody
	@PostMapping("tipBoardLike/{tipId}")
	public Map<String, ?> insertTipBoardLike(
			@PathVariable(name = "tipId") long tipId,
			HttpSession session) {
		Map<String, Object> model = new HashMap<>();
		
		String state = "true";
		int tipLikeCount = 0;
		
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			Map<String, Object> paramMap = new HashMap<>();
			paramMap.put("tipId", tipId);
			paramMap.put("memberId", info.getMemberId());
			
			service.insertTipBoardLike(paramMap);
			
			tipLikeCount = service.tipLikeCount(tipId);
			
		} catch (DuplicateKeyException e) {
			state = "liked";
		} catch (Exception e) {
			state = "false";
		}
		
		model.put("state", state);
		model.put("tipLikeCount", tipLikeCount);
		
		return model;
	}
	
	@ResponseBody
	@DeleteMapping("tipBoardLike/{tipId}")
	public Map<String, ?> deleteBoardLike(@PathVariable(name = "tipId") long tipId,
			HttpSession session) {
		Map<String, Object> model = new HashMap<>();
		
		String state = "true";
		int tipLikeCount = 0;
		
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			Map<String, Object> paramMap = new HashMap<>();
			paramMap.put("tipId", tipId);
			paramMap.put("memberId", info.getMemberId());
			
			service.deleteTipBoardLike(paramMap);
			
			tipLikeCount = service.tipLikeCount(tipId);
			
		} catch (Exception e) {
			state = "false";
		}
		
		model.put("state", state);
		model.put("tipLikeCount", tipLikeCount);
		
		return model;
	}
}
