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
import com.sp.app.model.ProductOrder;
import com.sp.app.model.ProductReview;
import com.sp.app.model.ReviewHelpful;
import com.sp.app.model.SessionInfo;
import com.sp.app.model.Summary;
import com.sp.app.service.ProductOrderService;
import com.sp.app.service.ProductReviewService;

import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/review/*")
public class ProductReviewController {
	private final ProductOrderService orderService;
	private final ProductReviewService service;
	private final StorageService storageService;
	private final PaginateUtil paginateUtil;
	
	private String uploadPath;
	
	@PostConstruct
	public void init() {
		uploadPath = this.storageService.getRealPath("/uploads/review");
	}		
	
	// AJAX - JSON
	@PostMapping("write")
	public Map<String, ?> writeSubmit(ProductReview dto,
			HttpSession session) throws Exception {
		
		Map<String, Object> model = new HashMap<String, Object>();
		
		String state = "false";
		try {
			
			System.out.println("ggg");
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			dto.setMemberId(info.getMemberId());
			
			service.insertReview(dto, uploadPath);
			
			state = "true";
		} catch (Exception e) {
		}
		
		model.put("state", state);
		return model;
	}
	
	// AJAX - JSON
	@GetMapping("listMyOrder")
	public Map<String, ?> listMyOrder(@RequestParam(name = "productCode") long productCode,
			HttpSession session){
		Map<String, Object> model = new HashMap<String, Object>();
		
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			// 상품을 구매하였는데 리뷰를 안 남긴 경우
			Map<String, Object> orderMap = new HashMap<String, Object>();
			List<ProductOrder> didIBuyThis = null;

			System.out.println(productCode);
			if(info != null) {
				orderMap.put("memberId", info.getMemberId());
				orderMap.put("productCode", productCode);				
				didIBuyThis = orderService.didIBuyThis(orderMap);
			}
			
			model.put("didIBuyThis", didIBuyThis);
			
		} catch (Exception e) {
			log.info("list : ", e);
		}
		
		return model;
	}
	
	// AJAX - JSON
	@GetMapping("viewReviewDetail")
	public Map<String, ?> viewReviewDetail(@RequestParam(name = "reviewId") long reviewId,
			HttpSession session){
		Map<String, Object> model = new HashMap<String, Object>();
		
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			ProductReview detailReview = service.viewReviewDetail(reviewId);
			
			Map<String, Object> map = new HashMap<String, Object>();
			
			int reviewHelpfulCount = service.countReviewHelpful(detailReview.getReviewId());
			detailReview.setReviewHelpfulCount(reviewHelpfulCount);
			
			if(info == null) {
				detailReview.setUserReviewHelpful(-1);
			} else {
				map.put("memberId", info.getMemberId());
				map.put("orderDetailId", reviewId);
				detailReview.setUserReviewHelpful(service.userReviewHelpful(map));					
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
			@RequestParam(name = "productCode") long productCode,
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
			map.put("productCode", productCode);
			map.put("sortBy", sortBy);
			map.put("onlyPhoto", onlyPhoto);
			
			Summary summary = Objects.requireNonNull(service.findByReviewSummary(map));
			
			dataCount = service.dataCount(map);
			int total_page = paginateUtil.pageCount(dataCount, size);
			
			current_page = Math.min(current_page, total_page);

			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;

			map.put("offset", offset);
			map.put("size", size);

			List<ProductReview> list = null;
			System.out.println(onlyPhoto);
			if(onlyPhoto == 0) {
				list = service.listReview(map);
			} else if(onlyPhoto == 1) {
				list = service.listReviewOnlyPhoto(map);
			}
			if(info != null) {
				for(ProductReview dto : list) {
					if(info.getMemberId() == info.getMemberId()) {
						dto.setDeletePermit(true);
					}
				}
			}
			Map<String, Object> reviewMap = new HashMap<>();
			for(ProductReview dto : list) {
				int reviewHelpfulCount = service.countReviewHelpful(dto.getReviewId());
				dto.setReviewHelpfulCount(reviewHelpfulCount);
				
				if(info == null) {
					dto.setUserReviewHelpful(-1);
				} else {
					System.out.println(dto.getReviewId());
					reviewMap.put("orderDetailId", dto.getReviewId());
					reviewMap.put("memberId", info.getMemberId());
					dto.setUserReviewHelpful(service.userReviewHelpful(reviewMap));					
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
			@RequestParam(name = "reviewId") long reviewId,
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

			ReviewHelpful dto = new ReviewHelpful();
			
			dto.setOrderDetailId(reviewId);
			dto.setMemberId(info.getMemberId());
			dto.setUserReviewHelpful(reviewHelpful);
			
			if(isReviewHelpful.equals("true") || isNotReviewHelpful.equals("true")) {
				service.deleteReviewHelpful(dto);
				dto.setUserReviewHelpful(-1);
			} else {
				service.insertReviewHelpful(dto);
			}
			
			// 좋아요 싫어요 개수 가져오기
			helpfulCount = service.countReviewHelpful(reviewId);
			
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
	@GetMapping("list2")
	public Map<String, ?> list2(
			@RequestParam(name = "pageNo", defaultValue = "1") int current_page,
			HttpSession session) throws Exception {
		Map<String, Object> model = new HashMap<String, Object>();
		
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");		
			
			int size = 5;
			int dataCount = 0;
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("memberId", info.getMemberId());
			
			dataCount = service.myDataCount(map);
			
			int total_page = paginateUtil.pageCount(dataCount, size);

			current_page = Math.min(current_page, total_page);

			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;

			map.put("offset", offset);
			map.put("size", size);

			List<ProductReview> list = service.listMyReview(map);
			
			String paging = paginateUtil.pagingMethod(current_page, total_page, "listReview");
			
			model.put("list", list);
			model.put("dataCount", dataCount);
			model.put("size", size);
			model.put("pageNo", current_page);
			model.put("paging", paging);
			model.put("total_page", total_page);
			
		} catch (Exception e) {
			log.info("list2 : ", e);
		}
		
		return model;
	}
	
	// 마이페이지-리뷰/Q&A
	@GetMapping("review")
	public ModelAndView review(
			@RequestParam(name = "mode", defaultValue = "review") String mode,
			Model model) throws Exception {
		
		model.addAttribute("mode", mode);
		
		return new ModelAndView("myPage/review");
	}
	
	@GetMapping("delete")
	public Map<String, ?> deleteReview(
			@RequestParam(name = "reviewId", defaultValue = "1") int reviewId,
			HttpSession session) throws Exception {
		
		Map<String, Object> model = new HashMap<String, Object>();
		
		String state = "false";
		try {
			
			service.deleteReview(reviewId, uploadPath);
			
			state = "true";
		} catch (Exception e) {
		}
		
		model.put("state", state);
		return model;
	}
	
	@GetMapping("updateReview")
	public Map<String, ?> updateReview(
			@RequestParam(name = "reviewId", defaultValue = "1") int reviewId,
			HttpSession session) throws Exception {
		
		Map<String, Object> model = new HashMap<String, Object>();

		try {
			
			ProductReview dto = service.findReviewById(reviewId);			
			
			model.put("dto", dto);
		} catch (Exception e) {
		}
		
		return model;
	}
}
