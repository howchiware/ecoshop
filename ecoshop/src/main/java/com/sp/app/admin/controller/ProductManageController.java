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
import com.sp.app.admin.model.GongguInquiryManage;
import com.sp.app.admin.model.GongguReviewManage;
import com.sp.app.admin.model.ProductDeliveryRefundInfo;
import com.sp.app.admin.model.ProductManage;
import com.sp.app.admin.model.ProductStockManage;
import com.sp.app.admin.service.ProductManageService;
import com.sp.app.common.PaginateUtil;
import com.sp.app.common.StorageService;

import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/admin/products/*")
public class ProductManageController {

	private final ProductManageService service;
	private final PaginateUtil paginateUtil;
	private final StorageService storageService;
	
	private String uploadPath;
	
	@PostConstruct
	public void init() {
		uploadPath = this.storageService.getRealPath("/uploads/products");		
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
			
			List<CategoryManage> listCategory = service.listCategory();
			
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
			
			dataCount = service.dataCount(map);
			total_page = paginateUtil.pageCount(dataCount, size);
			current_page = Math.min(current_page, total_page);
			
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			
			List<ProductManage> listProduct = service.listProduct(map);
			
			for(ProductManage dto : listProduct) {
				String categoryName = service.findByCategory(dto.getCategoryId()).getCategoryName();
				dto.setCategoryName(categoryName);
			}
			
			String cp = req.getContextPath();
			
			String listUrl = cp + "/admin/products/listProduct";

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
		
		return "admin/products/totalProductList";
	}
    
	
	@GetMapping("write")
    public String productAddForm(Model model) {
		try {
			List<CategoryManage> listCategory = service.listCategory();
			
			model.addAttribute("mode", "write");
			model.addAttribute("listCategory", listCategory);
			
		} catch (Exception e) {
			log.info("productAddForm : ", e);
		}
		
		return "admin/products/productAdd";
	}
	
	@PostMapping("write")
	public String productAddSubmit(ProductManage dto,
			Model model) {
		
		try {
			service.insertProduct(dto, uploadPath);
		} catch (Exception e) {
			log.info("productAddSubmit : ", e);
		}
		
		return "redirect:/admin/products/listProduct";
	}
	
	@GetMapping("update")
	public String updateForm(
			@RequestParam(name = "categoryId", defaultValue = "0") long categoryId,
			@RequestParam(name = "productId") long productId,
			@RequestParam(name = "productCode") String productCode,
			@RequestParam(name = "page") String page,
			Model model) {
		
		try {
			ProductManage dto = Objects.requireNonNull(service.findById(productId));
			
			// 카테고리
			List<CategoryManage> listCategory = service.listCategory();
			
			// 추가 이미지
			List<ProductManage> listPhoto = service.listProductPhoto(productId);
			
			// 옵션1/옵션2 옵션명
			List<ProductManage> listOption = service.listProductOption(productId);
			
			// 옵션1/옵션2 상세 옵션
			List<ProductManage> listOptionDetail = null;
			List<ProductManage> listOptionDetail2 = null;
			if(listOption.size() > 0) {
				dto.setOptionNum(listOption.get(0).getOptionNum());
				dto.setOptionName(listOption.get(0).getOptionName());
				listOptionDetail = service.listOptionDetail(listOption.get(0).getOptionNum());
			}
			if(listOption.size() > 1) {
				dto.setOptionNum2(listOption.get(1).getOptionNum());
				dto.setOptionName2(listOption.get(1).getOptionName());
				listOptionDetail2 = service.listOptionDetail(listOption.get(1).getOptionNum());
			}
			
			model.addAttribute("mode", "update");
			
			model.addAttribute("dto", dto);
			model.addAttribute("listPhoto", listPhoto);
			model.addAttribute("listOptionDetail", listOptionDetail);
			model.addAttribute("listOptionDetail2", listOptionDetail2);
			
			model.addAttribute("listCategory", listCategory);
			
			model.addAttribute("page", page);
			
			return "admin/products/productAdd";
			
		} catch (NullPointerException e) {
			log.info("updateForm : ", e);
		} catch (Exception e) {
			log.info("updateForm : ", e);
		}
		
		String query = "categoryId=" + categoryId + "&page=" + page;
		return "redirect:/admin/products/listProduct?" + query;
	}
	
	@PostMapping("update")
	public String updateSubmit(ProductManage dto,
			@RequestParam(name = "page") String page,
			Model model) {
		
		try {
			service.updateProduct(dto, uploadPath);
		} catch (Exception e) {
			log.info("updateSubmit : ", e);
		}

		String query = "categoryId=" + dto.getCategoryId() + "&page=" + page;
		return "redirect:/admin/products/listProduct?" + query;
	}
	
	@ResponseBody
	@PostMapping("deleteFile")
	public Map<String, ?> deleteFile(@RequestParam(name = "ProductPhotoNum") long ProductPhotoNum, 
			@RequestParam(name = "PhotoName") String PhotoName) throws Exception {
		Map<String, Object> model = new HashMap<>();

		String state = "false";
		try {
			String pathString = uploadPath + File.separator + PhotoName;
			service.deleteProductPhoto(ProductPhotoNum, pathString);
			
			state = "true";
		} catch (Exception e) {
		}
		
		model.put("state", state);
		return model;
	}
	
	@ResponseBody
	@PostMapping("deleteOptionDetail")
	public Map<String, ?> deleteOptionDetail(@RequestParam(name = "optionDetailNum") long optionDetailNum) throws Exception {
		Map<String, Object> model = new HashMap<>();
		
		String state = "false";
		try {
			service.deleteOptionDetail(optionDetailNum);
			
			state = "true";
		} catch (Exception e) {
		}
		
		model.put("state", state);
		return model;
	}
	
	// AJAX-Text
	@GetMapping("listProductStock")
	public String listProductStock(@RequestParam Map<String, Object> paramMap,
			Model model) throws Exception {
		try {
			List<ProductStockManage> list = service.listProductStock(paramMap);
			
			if(list.size() >= 1) {
				String productName = list.get(0).getProductName();
				String title = list.get(0).getOptionName();
				String title2 = list.get(0).getOptionName2();
				
				model.addAttribute("productId", paramMap.get("productId"));
				model.addAttribute("productCode", paramMap.get("productCode"));
				model.addAttribute("productName", productName);
				model.addAttribute("optionCount", paramMap.get("optionCount"));
				model.addAttribute("title", title);
				model.addAttribute("title2", title2);
			}
			
			model.addAttribute("list", list);
		} catch (Exception e) {
			log.info("listProductStock", e);
		}

		return "admin/products/listProductStock";
	}
	
	@ResponseBody
	@PostMapping("updateProductStock")
	public Map<String, Object> updateProductStock(ProductStockManage dto) throws Exception {
		Map<String, Object> model = new HashMap<>();
		
		// 상세 옵션별 재고 추가 또는 변경
		String state = "false";
		try {
			service.updateProductStock(dto);
			
			state = "true";
		} catch (Exception e) {
			log.info("updateProductStock", e);
		}
		
		model.put("state", state);
		return model;
	}
	
	@PostMapping("deleteProductSelect")
	public String deleteProductSelect(
			@RequestParam(name = "nums") List<Long> nums,
			HttpSession session) {
		
		try {			
			service.deleteProduct(nums, uploadPath);
		} catch (Exception e) {
			log.info("deleteProductSelect : ", e);
		}
		
		return "redirect:/admin/products/listProduct";
	}
	
	// 배송 정책 및 배송비
	@GetMapping("deliveryWrite")
	public String deliveryWriteForm(Model model,
			HttpServletRequest req) throws Exception {
		
		try {
			ProductDeliveryRefundInfo listDeliveryRefundInfo = service.listDeliveryRefundInfo();
			List<ProductDeliveryRefundInfo> listDeliveryFee = service.listDeliveryFee();
			
			if(listDeliveryRefundInfo == null || listDeliveryFee.size() == 0) {
				model.addAttribute("mode", "write");
			} else {

				model.addAttribute("mode", "update");
				model.addAttribute("listDeliveryRefundInfo", listDeliveryRefundInfo);
				model.addAttribute("listDeliveryFee", listDeliveryFee);
			}
			
			return "admin/products/deliveryInfo";

		} catch (Exception e) {
			log.info("deliveryWriteForm : ", e);
		}
		
		return "admin";
	}
	
	@PostMapping("deliveryWrite")
	public String deliveryWriteSubmit(ProductDeliveryRefundInfo dto, 
			@RequestParam(name = "deliveryLocation") List<String> deliveryLocation,
			@RequestParam(name = "fee") List<Integer> fee,
			Model model) {
		
		try {
			Map<String, Object> map = new HashMap<>();

			for(int i=0; i<deliveryLocation.size(); i++) {
				map.put("deliveryLocation", deliveryLocation.get(i));
				map.put("fee", fee.get(i));

				service.insertProductDeliveryFee(map);
			}
			
			service.insertProductDeliveryRefundInfo(dto);
		} catch (Exception e) {
			log.info("deliveryWriteSubmit : ", e);
		}
		
		return "redirect:/admin";
	}

	@PostMapping("deliveryUpdate")
	public String deliveryUpdateForm(ProductDeliveryRefundInfo dto, 
			@RequestParam(name = "deliveryLocation") List<String> deliveryLocation,
			@RequestParam(name = "fee") List<Integer> fee,
			Model model) {
		
		try {
			Map<String, Object> map = new HashMap<>();
			
			service.deleteProductDeliveryFee();
			
			for(int i=0; i<deliveryLocation.size(); i++) {
				map.put("deliveryLocation", deliveryLocation.get(i));
				map.put("fee", fee.get(i));
				
				service.insertProductDeliveryFee(map);
			}
			
			service.updateProductDeliveryRefundInfo(dto);
		} catch (Exception e) {
			log.info("deliveryUpdateForm : ", e);
		}

		return "redirect:/admin";
	}
}
