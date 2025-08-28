package com.sp.app.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.sp.app.common.PaginateUtil;
import com.sp.app.common.StorageService;
import com.sp.app.model.GongguOrder;
import com.sp.app.model.GongguReview;
import com.sp.app.model.GongguReviewHelpful;
import com.sp.app.model.GongguSummary;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.GongguOrderService;
import com.sp.app.service.GongguProductReviewService;
import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/gongguReview/*")
public class GongguReviewController {

	private final GongguOrderService gongguOrderService;
	private final GongguProductReviewService gongguProductReviewService;
	private final StorageService storageService;
	private final PaginateUtil paginateUtil;
	
	private String uploadPath;

	@PostConstruct
	public void init() {
		uploadPath = this.storageService.getRealPath("/uploads/review");
	}		
	
	// AJAX - JSON
	@PostMapping("write")
	public Map<String, ?> writeSubmit(GongguReview dto,
			HttpSession session) throws Exception {
		
		Map<String, Object> model = new HashMap<String, Object>();
		
		String state = "false";
		try {
			
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			dto.setMemberId(info.getMemberId());
			
			gongguProductReviewService.insertGongguReview(dto, uploadPath);
			
			state = "true";
		} catch (Exception e) {
		}
		
		model.put("state", state);
		return model;
	}
	
	// AJAX - JSON
	@GetMapping("listMyOrder")
	public Map<String, ?> listMyOrder(@RequestParam(name = "gongguProductId") long gongguProductId,
			HttpSession session){
		Map<String, Object> model = new HashMap<String, Object>();
		
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			// 상품을 구매하였는데 리뷰를 안 남긴 경우
			Map<String, Object> gongguOrderMap = new HashMap<String, Object>();
			List<GongguOrder> didIBuyGonggu = null;

			if(info != null) {
				gongguOrderMap.put("memberId", info.getMemberId());
				gongguOrderMap.put("gongguProductId", gongguProductId);				
				didIBuyGonggu = gongguOrderService.didIBuyGonggu(gongguOrderMap);
			}
			
			model.put("didIBuyGonggu", didIBuyGonggu);
			
		} catch (Exception e) {
			log.info("gongguList : ", e);
		}
		
		return model;
	}
	
	// AJAX - JSON
	@GetMapping("viewReviewDetail")
	public Map<String, ?> viewGongguReviewDetail(@RequestParam(name = "gongguOrderDetailId") long gongguOrderDetailId,
			HttpSession session){
		Map<String, Object> model = new HashMap<String, Object>();
		
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			GongguReview detailReview = gongguProductReviewService.viewGongguReviewDetail(gongguOrderDetailId);
			
			Map<String, Object> map = new HashMap<String, Object>();
			
			int reviewHelpfulCount = gongguProductReviewService.countGongguReviewHelpful(detailReview.getGongguOrderDetailId());
			detailReview.setReviewHelpfulCount(reviewHelpfulCount);
			
			if(info == null) {
				detailReview.setUserReviewHelpful(-1);
			} else {
				map.put("memberId", info.getMemberId());
				map.put("gongguOrderDetailId", gongguOrderDetailId);
				detailReview.setUserReviewHelpful(gongguProductReviewService.userReviewHelpful(map));					
			}
			
			model.put("detailReview", detailReview);
			
		} catch (Exception e) {
			log.info("list : ", e);
		}
		
		return model;
	}
	
	// AJAX - JSON
	@GetMapping("list")
	public Map<String, ?> list(
			@RequestParam(name = "gongguProductId") long gongguProductId,
			@RequestParam(name = "sortBy", defaultValue = "0") int sortBy,
			@RequestParam(name = "pageNo", defaultValue = "1") int current_page,
			@RequestParam(name = "onlyPhoto", defaultValue = "0") int onlyPhoto,
			HttpSession session) throws Exception {
		
		Map<String, Object> model = new HashMap<String, Object>();
		
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");		
			
			int size = 5;
			int dataCount = 0;
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("gongguProductId", gongguProductId);
			map.put("sortBy", sortBy);
			map.put("onlyPhoto", onlyPhoto);
			
			GongguSummary summary = Objects.requireNonNull(gongguProductReviewService.findByGongguReviewSummary(map));
			
			dataCount = gongguProductReviewService.dataCount(map);
			int total_page = paginateUtil.pageCount(dataCount, size);
			
			current_page = Math.min(current_page, total_page);

			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;

			map.put("offset", offset);
			map.put("size", size);

			List<GongguReview> list = null;
			if(onlyPhoto == 0) {
				list = gongguProductReviewService.listGongguReview(map);
			} else if(onlyPhoto == 1) {
				list = gongguProductReviewService.listGongguReviewOnlyPhoto(map);
			}
			if(info != null) {
				for(GongguReview dto : list) {
					if(info.getMemberId() == info.getMemberId()) {
						dto.setDeletePermit(true);
					}
				}
			}
			Map<String, Object> reviewMap = new HashMap<>();
			for(GongguReview dto : list) {
				int reviewHelpfulCount = gongguProductReviewService.countGongguReviewHelpful(dto.getGongguOrderDetailId());
				dto.setReviewHelpfulCount(reviewHelpfulCount);
				
				if(info == null) {
					dto.setUserReviewHelpful(-1);
				} else {					
					reviewMap.put("gongguOrderDetailId", dto.getGongguOrderDetailId());
					reviewMap.put("memberId", info.getMemberId());
					dto.setUserReviewHelpful(gongguProductReviewService.userReviewHelpful(reviewMap));					
				}
			}

			String paging = paginateUtil.pagingMethod(current_page, total_page, "listReview");
						
			model.put("list", list);
			model.put("summary", summary);
			model.put("dataCount", dataCount);
			model.put("size", size);
			model.put("pageNo", current_page);
			model.put("paging", paging);
			model.put("total_page", total_page);

			
		} catch (NullPointerException e) {
		} catch (Exception e) {
			log.info("list : ", e);
		}
		
		return model;
	}
	

	// 리뷰 도움돼요/안돼요 저장 - AJAX:JSON
	@PostMapping("insertReviewHelpful")
	public Map<String, Object> insertReviewHelpful(
			@RequestParam(name = "gongguOrderDetailId") long gongguOrderDetailId,
			@RequestParam(name = "reviewHelpful") int reviewHelpful,
			@RequestParam(name = "isReviewHelpful") String isReviewHelpful,
			@RequestParam(name = "isNotReviewHelpful") String isNotReviewHelpful,
			HttpSession session) throws Exception {
						
		Map<String, Object> model = new HashMap<String, Object>();
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String state = "false";
		int helpfulCount = 0;
		
		try {
			
			if(info == null) {
				state = "noLogin";
				model.put("state", state);
				return model;
			}

			GongguReviewHelpful dto = new GongguReviewHelpful();
			
			dto.setGongguOrderDetailId(gongguOrderDetailId);
			dto.setMemberId(info.getMemberId());
			dto.setUserReviewHelpful(reviewHelpful);
			
			if(isReviewHelpful.equals("true") || isNotReviewHelpful.equals("true")) {
				gongguProductReviewService.deleteGongguReviewHelpful(dto);
				dto.setUserReviewHelpful(-1);
			} else {
				gongguProductReviewService.insertGongguReviewHelpful(dto);
			}
			
			// 좋아요 싫어요 개수 가져오기
			helpfulCount = gongguProductReviewService.countGongguReviewHelpful(gongguOrderDetailId);
			
			state = "true";
			model.put("state", state);
			model.put("userReviewHelpful", dto.getUserReviewHelpful());
			model.put("helpfulCount", helpfulCount);

		} catch (Exception e) {
			log.info("insertReviewHelpful : ", e);
		}
		return model;
	}
	
	// AJAX - JSON : 마이페이지 - 내가 쓴 리뷰
	@GetMapping("myReviewlist")
	public Map<String, ?> myReviewlist (
			@RequestParam(name = "pageNo", defaultValue = "1") int current_page,
			HttpSession session) throws Exception {
		Map<String, Object> model = new HashMap<String, Object>();
		
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");		
			
			int size = 5;
			int dataCount = 0;
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("memberId", info.getMemberId());
			
			dataCount = gongguProductReviewService.myGongguDataCount(map);
			
			int total_page = paginateUtil.pageCount(dataCount, size);

			current_page = Math.min(current_page, total_page);

			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;

			map.put("offset", offset);
			map.put("size", size);

			List<GongguReview> list = gongguProductReviewService.listMyReview(map);
			
			String paging = paginateUtil.pagingMethod(current_page, total_page, "listReview");
			
			model.put("list", list);
			model.put("dataCount", dataCount);
			model.put("size", size);
			model.put("pageNo", current_page);
			model.put("paging", paging);
			model.put("total_page", total_page);
			
		} catch (Exception e) {
			log.info("myReviewlist : ", e);
		}
		
		return model;
	}
	
	// 마이페이지-리뷰/Q&A
	@GetMapping("gongguReview")
	public ModelAndView review(
			@RequestParam(name = "mode", defaultValue = "review") String mode,
			Model model) throws Exception {
		
		model.addAttribute("mode", mode);
		
		return new ModelAndView("myPage/review");
	}
	
	@GetMapping("delete")
	public Map<String, ?> deleteReview(
			@RequestParam(name = "gongguOrderDetailId", defaultValue = "1") int gongguOrderDetailId,
			HttpSession session) throws Exception {
		
		Map<String, Object> model = new HashMap<String, Object>();
		
		String state = "false";
		try {
			
			gongguProductReviewService.deleteGongguReview(gongguOrderDetailId, uploadPath);
			
			state = "true";
		} catch (Exception e) {
		}
		
		model.put("state", state);
		return model;
	}
}
