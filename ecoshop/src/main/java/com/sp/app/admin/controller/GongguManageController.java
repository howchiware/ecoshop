package com.sp.app.admin.controller;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.ResponseBody;
import com.sp.app.admin.model.GongguInquiryManage;
import com.sp.app.admin.model.GongguManage;
import com.sp.app.admin.model.GongguPackageManage;
import com.sp.app.admin.model.GongguProductDeliveryRefundInfoManage;
import com.sp.app.admin.model.GongguReviewManage;
import com.sp.app.admin.model.ProductManage;
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
    private final ProductManageService productManageService;

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

			for (GongguManage dto : listProduct) {
				long originalPrice = dto.getOriginalPrice(); 	  
				long sale = dto.getSale();
			    
				long gongguPrice = originalPrice;
			    if (sale > 0) {
			        gongguPrice = originalPrice - (long)(originalPrice * sale / 100.0);
			    }
			    dto.setGongguPrice(gongguPrice);
			}
		    
			GongguManage listCategory = gongguManageService.findByCategory(categoryId); 
			
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
			@RequestParam(name = "categoryId") long categoryId,
			@RequestParam(name = "page") String page,
			Model model) throws Exception {
		
		try {
			List<GongguManage> listCategory = gongguManageService.listCategory();
			 
			GongguManage dto = Objects.requireNonNull(gongguManageService.findById(gongguProductId));
			List<GongguManage> listFile = gongguManageService.listGongguProductPhoto(gongguProductId);
			
			model.addAttribute("dto", dto);
			model.addAttribute("page", page);	
			model.addAttribute("mode", "update");
			model.addAttribute("listCategory", listCategory);
			model.addAttribute("listFile", listFile);
			
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
	    @RequestParam(name = "page") String page) throws Exception {

	    try {
	        gongguManageService.updateGongguProduct(dto, uploadPath);
	    } catch (Exception e) {
	        log.error("updateSubmit error: ", e);
	        return "redirect:/admin/gonggu/update?gongguProductId=" + dto.getGongguProductId() + "&categoryId=" + dto.getCategoryId() + "&page=" + page;
	    }

	    return "redirect:/admin/gonggu/listProduct?categoryId=" + dto.getCategoryId() + "&page=" + page;
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
			
			List<Long> gongguProductIds = new ArrayList<>();
			gongguProductIds.add(gongguProductId);
			
			gongguManageService.deleteGongguProduct(gongguProductIds, uploadPath);
			
		} catch (Exception e) {
			log.error("delete : ", e);
		}
		
		return "redirect:/admin/gonggu/listProduct?" + query;
	}	
    
	@PostMapping("deleteFile")
	@ResponseBody
	public Map<String, Object> deleteFile(@RequestParam("fileNum") long fileNum) {
	    Map<String, Object> model = new HashMap<>();
	    String state = "true";

	    try {
	        gongguManageService.deleteSingleGongguProductPhoto(fileNum, uploadPath);
	    } catch (Exception e) {
	        state = "false";
	        log.error("deleteFile : ", e);
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
    public String writeReviewAnswer(
    		@RequestParam(value="answerId", required = false) Long answerId,
    		GongguReviewManage dto,
    		Model model) {
    	try {
    		gongguReviewInquiryManageService.updateAnswer(dto);
		} catch (Exception e) {
			log.info("writeAnswer : ", e);
		}
    	
    	return "redirect:/admin/gonggu/gongguReview";
    }

    @GetMapping("deleteAnswer")
    public String deleteAnswer(@RequestParam(name="gongguOrderDetailId") long gongguOrderDetailId,
    		Model model,
    		HttpServletRequest req) {
    	try {
        	
    		gongguReviewInquiryManageService.deleteAnswer(gongguOrderDetailId);        		
        	
    	} catch (Exception e) {
    		log.info("deleteAnswer : ", e);
    	}
    	
    	return "redirect:/admin/gonggu/gongguReview";
    }
    
    @GetMapping("deleteReview")
    public String deleteReview(@RequestParam(name="gongguOrderDetailId") long gongguOrderDetailId,
    		Model model,
    		HttpServletRequest req) {
    	try {
    		
    		gongguReviewInquiryManageService.deleteReview(gongguOrderDetailId);        		
    		
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
 			GongguProductDeliveryRefundInfoManage listDeliveryRefundInfo = gongguManageService.listGongguDeliveryRefundInfo();
 			List<GongguProductDeliveryRefundInfoManage> listDeliveryFee = gongguManageService.listGongguDeliveryFee();
 			
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
 	public String deliveryWriteSubmit(GongguProductDeliveryRefundInfoManage dto,
 	        @RequestParam(name = "deliveryLocation") List<String> deliveryLocation,
 	        @RequestParam(name = "fee") List<Integer> fee,
 	        Model model) {
 	    try {
 	        Map<String, Object> map = new HashMap<>();
 	        for(int i=0; i<deliveryLocation.size(); i++) {
 	            map.put("deliveryLocation", deliveryLocation.get(i));
 	            map.put("fee", fee.get(i));
 	            gongguManageService.insertGongguDeliveryFee(map); 
 	        }
 	        gongguManageService.insertGongguDeliveryRefundInfo(dto);
 	    } catch (Exception e) {
 	        log.info("deliveryWriteSubmit : ", e);
 	    }
 	    return "redirect:/admin";
 	}

 	// deliveryUpdateForm 메서드 (수정 후)
 	@PostMapping("deliveryUpdate")
 	public String deliveryUpdateForm(GongguProductDeliveryRefundInfoManage dto,
 	        @RequestParam(name = "deliveryLocation") List<String> deliveryLocation,
 	        @RequestParam(name = "fee") List<Integer> fee,
 	        Model model) {
 	    try {
 	        Map<String, Object> map = new HashMap<>();
 	        gongguManageService.deleteGongguDeliveryFee();
 	        
 	        for(int i=0; i<deliveryLocation.size(); i++) {
 	            map.put("deliveryLocation", deliveryLocation.get(i));
 	            map.put("fee", fee.get(i));
 	            gongguManageService.insertGongguDeliveryFee(map);
 	        }
 	        gongguManageService.updateGongguDeliveryRefundInfo(dto);
 	    } catch (Exception e) {
 	        log.info("deliveryUpdateForm : ", e);
 	    }
 	    return "redirect:/admin";
 	}
 	
 	@GetMapping("listProduct/{gongguProductId}")
 	public String packageList(@PathVariable("gongguProductId") long gongguProductId,
 			@RequestParam(name = "state", defaultValue = "1") int state,
			@RequestParam(name = "page") String page,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			Model model, HttpServletRequest req) throws Exception {
 		String query = "page=" + page;
		try {
			if(state != 1) {
				query += "&state=" + state;
			}
		
			kwd = URLDecoder.decode(kwd, "utf-8");

			if (! kwd.isBlank()) {
				query += "&schType=" + schType + "&kwd=" + URLEncoder.encode(kwd, "UTF-8");
			}
			
			GongguManage dto = Objects.requireNonNull(gongguManageService.findById(gongguProductId)); 

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("gongguProductId", gongguProductId);
			
			List<GongguPackageManage> productList = gongguManageService.listPackage(map);
			
			model.addAttribute("gongguProductId", gongguProductId);
			model.addAttribute("dto", dto);
			model.addAttribute("productList", productList);
			model.addAttribute("state", state);
			model.addAttribute("page", page);
			model.addAttribute("query", query);
			
			return "admin/gonggu/gongguProductList";
			
		} catch (Exception e) {
			log.info("handleGongguProductList : ", e);
		}
		
		return "redirect:/admin/gonggu/list?" + query;
	}
 	
 	// 패키지 상품 등록
 	@ResponseBody
 	@PostMapping("insertPackage")
 	public Map<String, ?> insertGongguPackage(
 	    @RequestParam("productCode") long productCode,
 	    @RequestParam("gongguProductId") long gongguProductId) throws Exception {

 	    Map<String, Object> model = new HashMap<>();
 	    String state = "true";

 	    try {
 	        GongguManage gongguInfo = gongguManageService.findById(gongguProductId);
 	        if (gongguInfo == null) {
 	            state = "false";
 	            model.put("state", state);
 	            return model;
 	        }

 	        ProductManage productInfo = productManageService.findById(productCode);
 	        if (productInfo == null) {
 	            state = "false";
 	            model.put("state", state);
 	            return model;
 	        }
 	        
 	        GongguPackageManage dto = new GongguPackageManage();
 	        dto.setProductCode(productCode);
 	        dto.setGongguProductId(gongguProductId);
 	        dto.setStock(gongguInfo.getLimitCount());
 	        dto.setProductName(productInfo.getProductName());
 	        dto.setPrice(productInfo.getPrice());
 	        dto.setThumbnail(productInfo.getThumbnail());
 	        
 	        gongguManageService.insertGongguPackage(dto);
 	        gongguManageService.updateOriginalPrice(gongguProductId);
 	        GongguManage updatedGongguInfo = gongguManageService.findById(gongguProductId);
 	        
 	        model.put("originalPrice", updatedGongguInfo.getOriginalPrice());
 	        model.put("gongguPrice", updatedGongguInfo.getGongguPrice());
 	        model.put("state", state);
 	        model.put("item", dto); 
 	        
 	    } catch (Exception e) {
 	        log.error("insertPackage : " ,e);
 	        state = "false";
 	    }
 	    model.put("state", state);
 	    return model;
 	}
 	
 	
 	// 패키지 상품 삭제
 	@ResponseBody
 	@PostMapping("deletePackage")
 	public Map<String, ?> deleteGongguPackage(
 	        @RequestParam("packageNum") long packageNum) throws Exception {
 	    Map<String, Object> model = new HashMap<String, Object>();
 	    String state = "true";
 	    try {
 	        GongguPackageManage packageDto = gongguManageService.findPacById(packageNum);
 	        long gongguProductId = packageDto.getGongguProductId();

 	        gongguManageService.deleteGongguPackage(packageNum);

 	        GongguManage updatedGongguInfo = gongguManageService.findById(gongguProductId);

 	        model.put("state", "true");
 	        model.put("originalPrice", updatedGongguInfo.getOriginalPrice());
 	        model.put("gongguPrice", updatedGongguInfo.getGongguPrice());

 	    } catch (Exception e) {
 	        state = "false";
 	        log.error("deleteGongguPackage error: ", e);
 	    }
 	    model.put("state", state);
 	    return model;
 	}
 	
 	// 상품 검색
 	@ResponseBody
 	@GetMapping("listProduct/search")
 	public Map<String, ?> productContainSearch(@RequestParam Map<String, Object> map) throws Exception {
 		Map<String, Object> model = new HashMap<String, Object>();
 		
 		String state = "true";
 		try {
 			List<ProductManage> list = gongguManageService.productSearch(map);
 		
 			model.put("list", list);
 		} catch (Exception e) {
 			state = "false";
 		}
 		
 		model.put("state", state);
 		return model;
 	}
 	
 	// 패키지 상품 목록 조회
 	@ResponseBody
 	@GetMapping("listPackage")
 	public Map<String, ?> listPackage(
 	    @RequestParam("gongguProductId") long gongguProductId) throws Exception {

 	    Map<String, Object> map = new HashMap<>();
 	    map.put("gongguProductId", gongguProductId);
 	    try {
 	        List<GongguPackageManage> list = gongguManageService.listPackage(map);
 	        map.put("state", "true");
 	       	map.put("list", list);
 	    } catch (Exception e) {
 	    	map.put("state", "false");
 	        log.error("listPackage : ", e);
 	    }
 	    return map;
 	}
 

}