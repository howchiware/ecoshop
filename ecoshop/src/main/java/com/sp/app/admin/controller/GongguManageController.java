package com.sp.app.admin.controller;

import java.io.File;
import java.net.URLDecoder;
import java.net.URLEncoder;
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

import com.sp.app.admin.model.GongguDeliveryRefundInfo;
import com.sp.app.admin.model.GongguInquiryManage;
import com.sp.app.admin.model.GongguManage;
import com.sp.app.admin.model.GongguReviewManage;
import com.sp.app.admin.service.GongguManageService;
import com.sp.app.admin.service.GongguReviewInquiryManageService;
import com.sp.app.common.PaginateUtil;
import com.sp.app.common.StorageService;
import com.sp.app.model.SessionInfo;

import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/admin/gonggu/*")
public class GongguManageController {
    private final GongguManageService gongguManageService;
    private final StorageService storageService;

    private final PaginateUtil paginateUtil;
    private final GongguReviewInquiryManageService gongguReviewInquiryManageService;
    private String uploadPath;

    @PostConstruct
	public void init() {
		uploadPath = this.storageService.getRealPath("/uploads/gonggu");		
	}	
    
    @GetMapping("write")
 	public String gongguProductAddForm(Model model) {
    	try {
    	List<GongguManage> listCategory = gongguManageService.listCategory();

		model.addAttribute("mode", "write");
		model.addAttribute("listCategory", listCategory);
		
    	} catch (Exception e) {
			log.info("writeForm : ", e);
		}
		
 		return "admin/gonggu/write";
 	}
    
    @PostMapping("write")
    public String writeSubmit(GongguManage dto,
    		@RequestParam(name = "categoryId") long categoryId,
    		@RequestParam(name = "limitCount") int limitCount, 
    		Model model) throws Exception {
    	try {
    		dto.setCategoryId(categoryId);
    		dto.setLimitCount(limitCount);
			gongguManageService.insertGongguProduct(dto, uploadPath);
		} catch (Exception e) {
			log.info("productWriteSubmit : ",e);
			return "admin/gonggu/write";
		}
    	
    	return "redirect:/admin/gonggu/listProduct";
    }
 	
    @GetMapping("listProduct")
 	public String listProduct(
 			@RequestParam(name = "categoryId", defaultValue = "0") long categoryId,
 			@RequestParam(name = "productShow", defaultValue = "1") int productShow,
 			@RequestParam(name = "state", defaultValue = "1") int state,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,		
			@RequestParam(name = "page", defaultValue = "1") int current_page,
			Model model,
			HttpServletRequest req) throws Exception {
		
		try {
			int size = 10;
			int total_page;
			int dataCount;
			
			kwd = URLDecoder.decode(kwd, "UTF-8");
			
			GongguManage listCategory = gongguManageService.findByCategory(categoryId); 
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("state", state);
			map.put("schType", schType);
			map.put("kwd", kwd);
			map.put("categoryId", categoryId);
			map.put("productShow", productShow);
			
			dataCount = gongguManageService.dataCountGongguProduct(map);
			total_page = paginateUtil.pageCount(dataCount, size);
			current_page = Math.min(current_page, total_page);
			
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			
			List<GongguManage> listProduct = gongguManageService.listProduct(map);
			
			String cp = req.getContextPath();
			
			String listUrl = cp + "/admin/gonggu/listProduct";
			String articleUrl = cp + "/admin/gonggu/article?page=" + current_page;
			String query = "";
			
			if(state != 1) {
				query = "state=" + state;
			}
			if (! kwd.isBlank()) {
				query += query.isEmpty() ? "" : "&";
				query += "schType=" + schType + "&kwd=" + URLEncoder.encode(kwd, "UTF-8");
			}
			
			if(! query.isBlank()) {
				listUrl += "?" + query;
				articleUrl += "&" + query;
			}
			
			String paging = paginateUtil.paging(current_page, total_page, listUrl);

			model.addAttribute("listCategory", listCategory);
			model.addAttribute("listProduct", listProduct);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("state", state);
			model.addAttribute("schType", schType);
			model.addAttribute("kwd", kwd);
			model.addAttribute("productShow", productShow);
			model.addAttribute("categoryId", categoryId);
			model.addAttribute("articleUrl", articleUrl);
			model.addAttribute("page", current_page);
			model.addAttribute("size", size);
			model.addAttribute("total_page", total_page);
			model.addAttribute("paging", paging);
			
		} catch (Exception e) {
			log.info("listProduct : ", e);
		}
		
		return "admin/gonggu/list";
	}
    
    
    
    
    
    
    @GetMapping("article")
	public String article(
			@RequestParam(name = "gongguProductId") long gongguProductId,
			@RequestParam(name = "state", defaultValue = "1") int state,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			@RequestParam(name = "page") String page,
			Model model) throws Exception {
		
		String query = "page=" + page;
		try {
			kwd = URLDecoder.decode(kwd, "utf-8");

			if(state != 1) {
				query += "&state=" + state;
			}
			if (! kwd.isBlank()) {
				query += "&schType=" + schType + "&kwd=" + URLEncoder.encode(kwd, "UTF-8");
			}
			
			GongguManage dto = Objects.requireNonNull(gongguManageService.findById(gongguProductId));
			
			model.addAttribute("dto", dto);
			model.addAttribute("query", query);
			model.addAttribute("page", page);
			
			return "admin/gonggu/article";
			
		} catch (NullPointerException e) {
			log.info("article : ", e);
		} catch (Exception e) {
			log.info("article : ", e);
		}
		
		return "redirect:/admin/gonggu/listProduct?" + query;
	}
	
	@GetMapping("update")
	public String updateForm(
			@RequestParam(name = "gongguProductId") long gongguProductId,
			@RequestParam(name = "categoryId", defaultValue = "0") long categoryId,
			@RequestParam(name = "page") String page,
			Model model) throws Exception {
		
		try {
			List<GongguManage> listCategory = gongguManageService.listCategory();

			GongguManage dto = Objects.requireNonNull(gongguManageService.findById(gongguProductId));
			
			model.addAttribute("dto", dto);
			model.addAttribute("page", page);	
			model.addAttribute("categoryId", categoryId);
			model.addAttribute("mode", "update");
			model.addAttribute("listCategory", listCategory);
			
			return "admin/gonggu/write";
			
		} catch (NullPointerException e) {
			log.error("updateForm : ", e);
		} catch (Exception e) {
			log.error("updateForm : ", e);
		}
		
		return "redirect:/admin/gonggu/listProduct?page=" + page;
	}

	@PostMapping("update")
	public String updateSubmit(
			GongguManage dto,
			@RequestParam(name = "page") String page,
			Model model) throws Exception {
		
		try {
			gongguManageService.updateGongguProduct(dto, uploadPath);
		} catch (Exception e) {
		}
		
		return "redirect:/admin/gonggu/listProduct?page=" + page;
	}
	
	@GetMapping("delete")
	public String delete(
			@RequestParam(name = "state", defaultValue = "1") int state,
			@RequestParam(name = "gongguProductId") long gongguProductId,
			@RequestParam(name = "page") String page,
			@RequestParam(name = "gongguThumbnail") String gongguThumbnail,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd) throws Exception {

		String query = "page=" + page;
		try {
			kwd = URLDecoder.decode(kwd, "utf-8");
			if(state != 1) {
				query += "&state=" + state;
			}
			if (! kwd.isBlank()) {
				query += "&schType=" + schType + "&kwd=" + URLEncoder.encode(kwd, "UTF-8");
			}
			
			String pathString = uploadPath + File.separator + gongguThumbnail;
			gongguManageService.deleteGongguProduct(gongguProductId, pathString);
			
		} catch (Exception e) {
			log.error("delete : ", e);
		}

		return "redirect:/admin/gonggu/listProduct?" + query;
	}	
    
	
    @GetMapping("productReview")
    public String getProductReview(@RequestParam(value="memberId", required = false) Long memberId, Model model) {
    	
    	return "admin/gonggu/gongguReview";
    }
    
    @GetMapping(value = "reviewList")
    public String getProductReviewList(
    		@RequestParam(value = "gongguProductName", required = false) String gongguProductName, 
    		@RequestParam(value = "kwd", required = false) String kwd, 
    		Model model, HttpServletRequest req) {
    	
    	HttpSession session = req.getSession();
    	SessionInfo info = (SessionInfo)session.getAttribute("member");
    	
    	long managerId = info.getMemberId();
    	String managerName = info.getName();
    	
    	Map<String, Object> map = new HashMap<>();
        map.put("gongguProductName", gongguProductName);
        map.put("kwd", kwd);
    	
        List<GongguReviewManage> reviewList = gongguReviewInquiryManageService.searchReviews(map);
        
        if(reviewList != null) {
	        for(GongguReviewManage dto : reviewList) {
	        	if(dto.getAnswer() != null) {
	        		String answerName = gongguReviewInquiryManageService.answerNameFindById(dto.getAnswerId());
	        		dto.setAnswerName(answerName);        		
	        	}
	        }
        }
        
        model.addAttribute("reviewList", reviewList);
        model.addAttribute("gongguProductName", gongguProductName);
        model.addAttribute("kwd", kwd);
        model.addAttribute("managerId", managerId);
        model.addAttribute("managerName", managerName);
        
        return "admin/gonggu/reviewList";
    }
    
    @GetMapping(value = "inquiryList")
    public String getInquiryList(
    		@RequestParam(value = "gongguProductName", required = false) String gongguProductName, 
    		@RequestParam(value = "kwd", required = false) String kwd, 
    		Model model) {
    	
    	Map<String, Object> map = new HashMap<>();
        map.put("gongguProductName", gongguProductName);
        map.put("kwd", kwd);
        
        List<GongguInquiryManage> inquiryList = gongguReviewInquiryManageService.searchInquirys(map);
        
        model.addAttribute("inquiryList", inquiryList);
        model.addAttribute("gongguProductName", gongguProductName);
        model.addAttribute("kwd", kwd);
        
        return "admin/gonggu/inquiryList";
    }
    
	@GetMapping("gongguReview")
	public String getGongguReviewPage(@RequestParam(value="memberId", required = false) Long memberId, Model model) {
		
		return "admin/gonggu/gongguReview";
	}
	
    @PostMapping("writeAnswer")
    public String writeAnswer(GongguReviewManage dto,
    		Model model) {
    	try {
    		gongguReviewInquiryManageService.updateAnswer(dto);
		} catch (Exception e) {
			log.info("writeAnswer : ", e);
		}
    	
    	return "redirect:/admin/gonggu/gongguReview";
    }

    @GetMapping("deleteAnswer")
    public String deleteAnswer(@RequestParam(name="gongguReviewId") long gongguReviewId,
    		Model model,
    		HttpServletRequest req) {
    	try {
        	
    		gongguReviewInquiryManageService.deleteAnswer(gongguReviewId);        		
        	
    	} catch (Exception e) {
    		log.info("deleteAnswer : ", e);
    	}
    	
    	return "redirect:/admin/gonggu/gongguReview";
    }
    
    @GetMapping("deleteReview")
    public String deleteReview(@RequestParam(name="gongguReviewId") long gongguReviewId,
    		Model model,
    		HttpServletRequest req) {
    	try {
    		
    		gongguReviewInquiryManageService.deleteReview(gongguReviewId);        		
    		
    	} catch (Exception e) {
    		log.info("deleteReview : ", e);
    	}
    	
    	return "redirect:/admin/gonggu/gongguReview";
    }

    
    // 배송 정책 및 배송비
 	@GetMapping("deliveryWrite")
 	public String deliveryWriteForm(Model model,
 			HttpServletRequest req) throws Exception {
 		
 		try {
 			GongguDeliveryRefundInfo listDeliveryRefundInfo = gongguManageService.listDeliveryRefundInfo();
 			List<GongguDeliveryRefundInfo> listDeliveryFee = gongguManageService.listDeliveryFee();
 			
 			if(listDeliveryRefundInfo == null || listDeliveryFee.size() == 0) {
 				model.addAttribute("mode", "write");
 			} else {

 				model.addAttribute("mode", "update");
 				model.addAttribute("listDeliveryRefundInfo", listDeliveryRefundInfo);
 				model.addAttribute("listDeliveryFee", listDeliveryFee);
 			}
 			
 			return "admin/gonggu/gongguDeliveryInfo";

 		} catch (Exception e) {
 			log.info("deliveryWriteForm : ", e);
 		}
 		
 		return "admin";
 	}
 	
 	@PostMapping("deliveryWrite")
 	public String deliveryWriteSubmit(GongguDeliveryRefundInfo dto, 
 			@RequestParam(name = "deliveryLocation") List<String> deliveryLocation,
 			@RequestParam(name = "fee") List<Integer> fee,
 			Model model) {
 		
 		try {
 			Map<String, Object> map = new HashMap<>();

 			for(int i=0; i<deliveryLocation.size(); i++) {
 				map.put("deliveryLocation", deliveryLocation.get(i));
 				map.put("fee", fee.get(i));

 				gongguManageService.insertProductDeliveryFee(map);
 			}
 			
 			gongguManageService.insertProductDeliveryRefundInfo(dto);
 		} catch (Exception e) {
 			log.info("deliveryWriteSubmit : ", e);
 		}
 		
 		return "redirect:/admin";
 	}

 	@PostMapping("deliveryUpdate")
 	public String deliveryUpdateForm(GongguDeliveryRefundInfo dto, 
 			@RequestParam(name = "deliveryLocation") List<String> deliveryLocation,
 			@RequestParam(name = "fee") List<Integer> fee,
 			Model model) {
 		
 		try {
 			Map<String, Object> map = new HashMap<>();
 			
 			gongguManageService.deleteProductDeliveryFee();
 			
 			for(int i=0; i<deliveryLocation.size(); i++) {
 				map.put("deliveryLocation", deliveryLocation.get(i));
 				map.put("fee", fee.get(i));
 				
 				gongguManageService.insertProductDeliveryFee(map);
 			}
 			
 			gongguManageService.updateProductDeliveryRefundInfo(dto);
 		} catch (Exception e) {
 			log.info("deliveryUpdateForm : ", e);
 		}

 		return "redirect:/admin";
 	}
 	
 	


}