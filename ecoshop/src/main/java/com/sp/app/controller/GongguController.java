package com.sp.app.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.admin.model.CategoryManage;
import com.sp.app.admin.service.CategoryManageService;
import com.sp.app.common.PaginateUtil;
import com.sp.app.model.GongguOrder;
import com.sp.app.model.GongguProduct;
import com.sp.app.model.GongguProductDeliveryRefundInfo;
import com.sp.app.model.GongguReview;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.GongguProductReviewService;
import com.sp.app.service.GongguService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/gonggu/*")
public class GongguController {
	private final PaginateUtil paginateUtil;
	private final CategoryManageService categoryManageService;
	private final GongguService gongguService;
	private final GongguProductReviewService gongguReviewService;
	
	@GetMapping("list")
	public String gongguList(
			@RequestParam(name = "categoryId", defaultValue = "0") long categoryId,
			@RequestParam(name = "sortBy", defaultValue = "0") int sortBy, 
			@RequestParam(name = "page", defaultValue = "1") int current_page,
			Model model,
			HttpServletRequest req,
			HttpSession session) throws Exception {

		try {
			
			List<CategoryManage> listCategory = categoryManageService.listCategory();
			model.addAttribute("listCategory", listCategory);
			
			int size = 12; 
			int total_page;
			int dataCount;
			
			Map<String, Object> map = new HashMap<>();
			map.put("categoryId", categoryId);
			map.put("sortBy", sortBy);
			
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			if(info != null) {
				map.put("memberId", info.getMemberId());
			}

			dataCount = gongguService.dataCount(map);
			total_page = paginateUtil.pageCount(dataCount, size);
			current_page = Math.min(current_page, total_page);

			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);

			List<GongguProduct> listGongguProduct = gongguService.listGongguProducts(map);
			
			if (listGongguProduct != null) {
                for (GongguProduct dto : listGongguProduct) {
                    int participantCount = gongguService.getParticipantCount(dto.getGongguProductId());
                    dto.setParticipantCount(participantCount);
                }
            }
			
			String cp = req.getContextPath();
			String listUrl = cp + "/gonggu/list?categoryId=" + categoryId;
			if (sortBy > 0) { 
			    listUrl += "&sortBy=" + sortBy;
			}
			String paging = paginateUtil.paging(current_page, total_page, listUrl);

			model.addAttribute("listGongguProduct", listGongguProduct);
			model.addAttribute("categoryId", categoryId);
			model.addAttribute("sortBy", sortBy);
			model.addAttribute("page", current_page);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("size", size);
			model.addAttribute("total_page", total_page);
			model.addAttribute("paging", paging);
			
			if (! listCategory.isEmpty()) {
		        List<GongguProduct> listProduct = gongguService.listAllProducts();
		        List<GongguProduct> listFiveProduct = gongguService.listFiveProducts();
		        
		        model.addAttribute("listProduct", listProduct);
		        model.addAttribute("listFiveProduct", listFiveProduct);
		    }
		} catch (Exception e) {
			log.error("gongguList: ", e);
			throw e;
		}

		if ("XMLHttpRequest".equals(req.getHeader("X-Requested-With"))) {
			return "gonggu/listDetail"; 
		} else {
			return "gonggu/list"; 
		}
	}

	@GetMapping("{gongguProductId}")
	public String detailRequest(
			@PathVariable("gongguProductId") long gongguProductId,
			HttpSession session,
			Model model) throws Exception {

		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");

			Map<String, Object> productMap = new HashMap<>();
			productMap.put("gongguProductId", gongguProductId);
			if(info != null) {
				productMap.put("memberId", info.getMemberId());
			}
			GongguProduct dto = Objects.requireNonNull(gongguService.findById(productMap));
			List<GongguProduct> listPhoto = gongguService.listGongguProductPhoto(gongguProductId);
			String detailInfo = gongguService.findDetailInfoById(gongguProductId);
			dto.setDetailInfo(detailInfo);
			
			GongguProduct mainThumbnail = new GongguProduct();
			mainThumbnail.setDetailPhoto(dto.getGongguThumbnail());
			listPhoto.add(0, mainThumbnail);

			GongguProductDeliveryRefundInfo deliveryRefundInfo = gongguService.listDeliveryRefundInfo();
			List<GongguProductDeliveryRefundInfo> deliveryFee = gongguService.listDeliveryFee();

			int participantCount = gongguService.getParticipantCount(gongguProductId);
			int limitCount = dto.getLimitCount();
			int remainCount = limitCount - participantCount;
			
			Map<String, Object> orderMap = new HashMap<String, Object>();
			List<GongguOrder> didIBuyProduct = null;

			if (info != null) {
				orderMap.put("memberId", info.getMemberId());
				orderMap.put("gongguProductId", gongguProductId);
				didIBuyProduct = gongguService.didIBuyProduct(orderMap);
			}
			boolean leaveReview = false;
			if(didIBuyProduct != null && didIBuyProduct.size() > 0) {
				leaveReview = true;
			}
			
			List<GongguReview> imgList = gongguReviewService.imgList(gongguProductId);
				
			model.addAttribute("dto", dto);
			model.addAttribute("imgList", imgList);
			model.addAttribute("listPhoto", listPhoto);
			model.addAttribute("deliveryRefundInfo", deliveryRefundInfo);
			model.addAttribute("deliveryFee", deliveryFee);
			model.addAttribute("participantCount", participantCount);
			model.addAttribute("limitCount", limitCount);
			model.addAttribute("remainCount", remainCount);
			model.addAttribute("didIBuyProduct", didIBuyProduct);
			model.addAttribute("leaveReview", leaveReview);

			return "gonggu/gongguProductInfo"; 

		} catch (NullPointerException e) {
			log.info("detailRequest: ", e);
		} catch (Exception e) {
			log.error("detailRequest: ", e);
		}

		return "redirect:/gonggu/list"; 
	}
	
	@ResponseBody
	@GetMapping("viewGongguProductDetail")
	public Map<String, ?> viewGongguProductDetail(
	        @RequestParam("gongguProductId") long gongguProductId,
	        HttpSession session) throws Exception {
	    
	    Map<String, Object> model = new HashMap<>();
	    try {
	        SessionInfo info = (SessionInfo) session.getAttribute("member");

	        Map<String, Object> productMap = new HashMap<>();
			productMap.put("gongguProductId", gongguProductId);
			if(info != null) {
				productMap.put("memberId", info.getMemberId());
			}
	        GongguProduct dto = Objects.requireNonNull(gongguService.findById(productMap));
	        List<GongguProduct> listPhoto = gongguService.listGongguProductPhoto(gongguProductId);
	        
	        GongguProduct mainThumbnail = new GongguProduct();
	        mainThumbnail.setGongguThumbnail(dto.getGongguThumbnail());
	        listPhoto.add(0, mainThumbnail);

	        int participantCount = gongguService.getParticipantCount(gongguProductId);
            
	        model.put("dto", dto);
	        model.put("listPhoto", listPhoto);
	        model.put("participantCount", participantCount);
	        model.put("limitCount", dto.getLimitCount());
	        model.put("remainCount", dto.getLimitCount() - participantCount);

	    } catch (NullPointerException e) {
	        log.info("viewGongguProductDetail : " , e);
	    } catch (Exception e) {
	        log.error("viewGongguProductDetail: ", e);
	    }
	    return model;
	}
}
