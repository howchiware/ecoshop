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
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.admin.model.CategoryManage;
import com.sp.app.admin.model.GongguDeliveryRefundInfo;
import com.sp.app.admin.model.GongguInquiryManage;
import com.sp.app.admin.model.GongguManage;
import com.sp.app.admin.model.GongguReviewManage;
import com.sp.app.admin.model.ProductManage;
import com.sp.app.admin.service.CategoryManageService;
import com.sp.app.admin.service.GongguManageService;
import com.sp.app.admin.service.GongguReviewInquiryManageService;
import com.sp.app.admin.service.ProductManageService;
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
    private final CategoryManageService categoryManageService;
    private final PaginateUtil paginateUtil;
    private final GongguReviewInquiryManageService gongguReviewInquiryManageService;
    private final ProductManageService productManageService;
    private String uploadPath;

    @PostConstruct
	public void init() {
		uploadPath = this.storageService.getRealPath("/uploads/gonggu");		
	}	
    
    @GetMapping("write")
 	public String gongguProductAddForm(Model model, Map<String, Object> map) {
    	try {
 			
			List<CategoryManage> categoryList = gongguManageService.listCategory();
			List<ProductManage> productList = productManageService.listProduct(map);
			
			model.addAttribute("mode", "write");
			model.addAttribute("categoryList", categoryList);
			model.addAttribute("productList", productList);
			
		} catch (Exception e) {
			log.info("gongguProductAddForm : ", e);
		}
 		
 		return "admin/gonggu/gongguProductAdd";
 	}
 	
 	@PostMapping("write") 
 	public String gongguProductAddSubmit(GongguManage dto, Model model) {
 		try {
			gongguManageService.insertGongguProduct(dto, uploadPath);
		} catch (Exception e) {
			log.info("gongguProductAddSubmit : ", e);
		}
 		
 		return "redirect:/admin/gonggu/listProduct";
 	}
 	
 	@GetMapping("update")
 	public String updateForm(
 			@RequestParam(name = "categoryId", defaultValue = "0") long categoryId,
			@RequestParam(name = "gongguProductId") long gongguProductId,
			@RequestParam(name = "productId") long productId,
			@RequestParam(name = "productCode") String productCode,
			@RequestParam(name = "page") String page,
			Model model) {
 		
 		try {
			GongguManage dto = Objects.requireNonNull(gongguManageService.findById(gongguProductId));
			
			List<CategoryManage> listCategory = gongguManageService.listCategory();
			
			// 추가 이미지
			List<GongguManage> listPhoto = gongguManageService.listProductPhoto(gongguProductId);
			
			// 옵션1/옵션2 옵션명
			// List<ProductManage> listOption = productManageService.listProductOption(productId);
			
			model.addAttribute("mode", "update");
			
			model.addAttribute("dto", dto);
			model.addAttribute("listPhoto", listPhoto);
			
			model.addAttribute("listCategory", listCategory);
			model.addAttribute("page", page);
			
			return "admin/gonggu/gongguProductAdd";
			
 		} catch (NullPointerException e) {
			log.info("updateForm : ", e);
		} catch (Exception e) {
			log.info("updateForm : ", e);
		}
 		
 		String query = "categoryId=" + categoryId + "&page=" + page;
		return "redirect:/admin/gonggu/listProduct?" + query;
 	}
 	
 	@PostMapping("update")
	public String updateSubmit(GongguManage dto,
			@RequestParam(name = "page") String page,
			Model model) {
		
		try {
			gongguManageService.updateGongguProduct(dto, uploadPath);
		} catch (Exception e) {
			log.info("updateSubmit : ", e);
		}

		String query = "categoryId=" + dto.getCategoryId() + "&page=" + page;
		return "redirect:/admin/gonggu/listProduct?" + query;
	}
 	
 	@ResponseBody
	@PostMapping("deleteFile")
	public Map<String, ?> deleteFile(@RequestParam(name = "gongguProductDetailId") long gongguProductDetailId, 
			@RequestParam(name = "detailPhoto") String detailPhoto) throws Exception {
		Map<String, Object> model = new HashMap<>();

		String state = "false";
		try {
			String pathString = uploadPath + File.separator + detailPhoto;
			gongguManageService.deleteProductPhoto(gongguProductDetailId, pathString);
			
			state = "true";
		} catch (Exception e) {
		}
		
		model.put("state", state);
		return model;
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

    @GetMapping("category")
    public String category(@RequestParam(value="categoryId", required = false) Long categoryId, Model model) throws Exception {
    	List<CategoryManage> categoryList = categoryManageService.listCategory();
    	
    	model.addAttribute("categoryList", categoryList);
    	return "admin/category/category";
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
 	
 	@GetMapping("listProduct")
 	public String listProduct(
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,		
			@RequestParam(name = "categoryId", defaultValue = "0") long categoryId,
			@RequestParam(name = "period", defaultValue = "") String period,
			@RequestParam(name = "periodStart", defaultValue = "") String periodStart,
			@RequestParam(name = "periodEnd", defaultValue = "") String periodEnd,
			@RequestParam(name = "priceLowest", defaultValue = "") String priceLowest,
			@RequestParam(name = "priceHighest", defaultValue = "") String priceHighest,
			@RequestParam(name = "stockLowest", defaultValue = "") String stockLowest,
			@RequestParam(name = "stockHighest", defaultValue = "") String stockHighest,
			@RequestParam(name = "page", defaultValue = "1") int current_page,
			Model model,
			HttpServletRequest req) {
		
		try {
			int size = 5;
			int total_page;
			int dataCount;
			
			kwd = URLDecoder.decode(kwd, "UTF-8");
			
			List<CategoryManage> listCategory = categoryManageService.listCategory();
			
			Map<String, Object> map = new HashMap<>();
			map.put("categoryId", categoryId);
			map.put("schType", schType);
			map.put("kwd", kwd);
			map.put("period", period);
			map.put("periodStart", periodStart);
			map.put("periodEnd", periodEnd);
			map.put("priceLowest", priceLowest);
			map.put("priceHighest", priceHighest);
			map.put("stockLowest", stockLowest);
			map.put("stockHighest", stockHighest);
			
			dataCount = gongguManageService.dataCount(map);
			total_page = paginateUtil.pageCount(dataCount, size);
			current_page = Math.min(current_page, total_page);
			
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			
			List<GongguManage> listProduct = gongguManageService.listProduct(map);
			
			for(GongguManage dto : listProduct) {
				String categoryName = gongguManageService.findByCategory(dto.getCategoryId()).getCategoryName();
				dto.setCategoryName(categoryName);
			}
			
			String cp = req.getContextPath();
			
			String listUrl = cp + "/admin/gonggu/listProduct";
			
			String query = "categoryId=" + categoryId;
			if (! kwd.isBlank()) {
				query += "&schType=" + schType + "&kwd=" + URLEncoder.encode(kwd, "UTF-8");
			}
			if(! periodStart.isBlank() && ! periodEnd.isBlank()) {
				query += "&period=" + period + "&periodStart=" + periodStart + "&periodEnd=" + periodEnd;				
			}
			if(! priceLowest.isBlank() && ! priceHighest.isBlank()) {
				query += "&priceLowest=" + priceLowest + "&priceHighest=" + priceHighest;				
			}
			if(! stockLowest.isBlank() && ! stockHighest.isBlank()) {
				query += "&stockLowest=" + stockLowest + "&stockHighest=" + stockHighest;
			}
			
			listUrl += "?" + query;
			
			String paging = paginateUtil.paging(current_page, total_page, listUrl);
			
			model.addAttribute("listCategory", listCategory);
			model.addAttribute("listProduct", listProduct);
			model.addAttribute("dataCount", dataCount);
			
			model.addAttribute("categoryId", categoryId);
			model.addAttribute("schType", schType);
			model.addAttribute("kwd", kwd);
			model.addAttribute("period", period);
			model.addAttribute("periodStart", periodStart);
			model.addAttribute("periodEnd", periodEnd);
			model.addAttribute("priceLowest", priceLowest);
			model.addAttribute("priceHighest", priceHighest);
			model.addAttribute("stockLowest", stockLowest);
			model.addAttribute("stockHighest", stockHighest);
			
			model.addAttribute("page", current_page);
			model.addAttribute("size", size);
			model.addAttribute("total_page", total_page);
			model.addAttribute("paging", paging);
		} catch (Exception e) {
			log.info("listProduct : ", e);
		}
		
		return "admin/gonggu/totalGongguProductList";
	}


}