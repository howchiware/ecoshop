package com.sp.app.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.app.common.MyUtil;
import com.sp.app.common.PaginateUtil;
import com.sp.app.model.Reports;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.ReportsService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/admin/reportsManage")
public class ReportsManageController {
	
	private final ReportsService service;
	private final PaginateUtil paginateUtil;
	private final MyUtil myUtil;
	
	@GetMapping("main")
	public String main(@RequestParam(name = "status", defaultValue = "0") int status,
			@RequestParam(name = "page", defaultValue = "1") int current_page,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,			
			Model model) {

		model.addAttribute("reportsStatus", status);
		model.addAttribute("page", current_page);
		model.addAttribute("schType", schType);
		model.addAttribute("kwd", kwd);
		
		return "admin/reportsManage/main";
	}
	
	// AJAX - Text
	@GetMapping("list/{menuItem}")
	public String list(@PathVariable(name = "menuItem") String menuItem,
			@RequestParam(name = "status", defaultValue = "0") int status,
			@RequestParam(name = "pageNo", defaultValue = "1") int current_page,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,			
			Model model) {
		
		String viewPage = "listAll";
		try {
			viewPage = menuItem.equals("group") ? "listGroup" : viewPage;
			
			int size = 10; // 한 화면에 보여주는 게시물 수
			int total_page = 0;
			int dataCount = 0;

			kwd = myUtil.decodeUrl(kwd);

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("status", status);
			map.put("schType", schType);
			map.put("kwd", kwd);

			if(menuItem.equals("all")) {
				dataCount = service.dataCount(map);
			} else {
				dataCount = service.dataGroupCount(map);
			}
			if (dataCount != 0) {
				total_page = paginateUtil.pageCount(dataCount, size);
			}

			current_page = Math.min(current_page, total_page);
			
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;

			map.put("offset", offset);
			map.put("size", size);			
			
			List<Reports> list = null;
			if(menuItem.equals("all")) {
				list = service.listReports(map);
			} else {
				list = service.listGroupReports(map);
			}

			String paging = paginateUtil.pagingMethod(current_page, total_page, "listPage");
			
			model.addAttribute("list", list);
			model.addAttribute("reportsStatus", status);
			model.addAttribute("pageNo", current_page);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("size", size);
			model.addAttribute("total_page", total_page);
			model.addAttribute("paging", paging);

		} catch (Exception e) {
			log.info("list : ", e);
		}
		
		return "admin/reportsManage/" + viewPage;
	}

	// AJAX - Text
	@GetMapping("listRelated")
	public String listRelated(
			@RequestParam(name = "reportId") long reportId,
			@RequestParam(name = "targetNum") long targetNum,
			@RequestParam(name = "target") String target,
			@RequestParam(name = "pageNo", defaultValue = "1") int current_page,
			Model model) {
		
		try {
			int size = 5;
			int total_page = 0;
			int dataCount = 0;

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("reportId", reportId);
			map.put("targetNum", targetNum);
			map.put("target", target);

			dataCount = service.dataRelatedCount(map);

			if (dataCount != 0) {
				total_page = paginateUtil.pageCount(dataCount, size);
			}

			current_page = Math.min(current_page, total_page);
			
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;

			map.put("offset", offset);
			map.put("size", size);			
			
			List<Reports> list = service.listRelatedReports(map);

			String paging = paginateUtil.pagingMethod(current_page, total_page, "listPage");
			
			model.addAttribute("list", list);
			model.addAttribute("pageNo", current_page);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("size", size);
			model.addAttribute("total_page", total_page);
			model.addAttribute("paging", paging);

		} catch (Exception e) {
			log.info("listRelated : ", e);
		}
		
		return "admin/reportsManage/listAll";
	}
	
	@GetMapping("article/{reportId}")
	public String article(@PathVariable(name = "reportId") long reportId,
			@RequestParam(name = "status", defaultValue = "0") int status,			
			@RequestParam(name = "page") String page,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			Model model) throws Exception {

		String query = "page=" + page;
		try {
			kwd = myUtil.decodeUrl(kwd);

			if(status != 0) {
				query += "&status=" + status;
			}
			if (! kwd.isBlank()) {
				query += "&schType=" + schType + "&kwd=" + myUtil.encodeUrl(kwd);
			}

			Reports report = Objects.requireNonNull(service.findById(reportId));
			if(report.getReasonDetail() != null) {
				report.setReasonDetail(report.getReasonDetail().replaceAll("\n", "<br>"));
			}
			
			// 대상 게시글 신고건수
			Map<String, Object> countMap = new HashMap<>();
			countMap.put("target", report.getTarget());
			countMap.put("targetNum", report.getTargetNum());
			int reportsCount = service.dataRelatedCount(countMap);
			
			// 대상 게시글 내용
			Map<String, Object> map = new HashMap<>();
			String target = report.getTarget(); // 타겟 테이블
			map.put("target", report.getTarget());
			if(report.getContentType().contains("reply")) {
				map.put("fieldName", "replyNum");
			} else { // 실제 테이블의 PK
				if("freeBoard".equals(target)) {
					map.put("fieldName", "freeId"); 
					map.put("pkColumnName", "freeId"); 
				}
				
			}
			map.put("contentType", report.getContentType());
			map.put("reportId", report.getTargetNum());
			
			Reports posts = service.findByPostsId(map);
			if(posts != null) {
				posts.setContent(posts.getContent().replaceAll("\n", "<br>"));
				
				if(report.getTarget().equals("photo") && posts.getImageFilename() != null) {
					posts.setImageFilename("/uploads/photo/" + posts.getImageFilename());
				}
			}
			
			model.addAttribute("report", report);
			model.addAttribute("posts", posts);
			model.addAttribute("reportsCount", reportsCount);
			
			model.addAttribute("reportsStatus", status);
			model.addAttribute("page", page);
			model.addAttribute("schType", schType);
			model.addAttribute("kwd", kwd);

			model.addAttribute("query", query);

			return "admin/reportsManage/article";
			
		} catch (NullPointerException e) {
			log.info("article : ", e);
		} catch (Exception e) {
			log.info("article : ", e);
		}
		
		return "redirect:/admin/reportsManage/main";
	}
	
	@PostMapping("update")
	public String updateReports(
			Reports dto,
			@RequestParam(name = "reportAction") String reportAction,
			@RequestParam(name = "status", defaultValue = "0") int status,			
			@RequestParam(name = "page") String page,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			HttpSession session,
			Model model) throws Exception {

		String query = "page=" + page;
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			kwd = myUtil.decodeUrl(kwd);

			if(status != 0) {
				query += "&status=" + status;
			}
			if (! kwd.isBlank()) {
				query += "&schType=" + schType + "&kwd=" + myUtil.encodeUrl(kwd);
			}

			// 신고 처리
			dto.setProcessorId(info.getMemberId());
			service.updateReports(dto);
			
			// 게시글 블록 또는 삭제
			Map<String, Object> map = new HashMap<>();
			String target = dto.getTarget();
			map.put("target", dto.getTarget());
			
			if(dto.getContentType().contains("reply")) {
				// map.put("fieldName", dto.getContentType().contains("reply") ? "replyNum" : "reportId");				
				map.put("fieldName", "replyNum");
			} else {
				if("freeBoard".equals(target)) {
					map.put("fieldName", "freeId");
				} else if("exBoard".equals(target)) {
					map.put("fieldName", "primaryKey");
				}
			}
			
			map.put("reportId", dto.getTargetNum());
			map.put("content_type", dto.getContentType());
			
			if(reportAction.equals("blind")) {
				map.put("block", 1);
				service.updateBlockPosts(map);
			} else if(reportAction.equals("unlock")) {
				map.put("block", 0);
				service.updateBlockPosts(map);
			} else if(reportAction.equals("delete")) {
				service.deletePosts(map);
			}

			return "redirect:/admin/reportsManage/article/" + dto.getReportId() + "?" +query;
			
		} catch (NullPointerException e) {
			log.info("article : ", e);
		} catch (Exception e) {
			log.info("article : ", e);
		}
		
		return "redirect:/admin/reportsManage/main";
	}	
}
