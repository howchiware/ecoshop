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
import com.sp.app.model.Product;
import com.sp.app.model.ProductDeliveryRefundInfo;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.ProductService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/products/*")
public class ProductController {

	private final CategoryManageService categoryManageService;
	private final ProductService productService;
	
	@GetMapping("main")
	public String productsList(Model model) throws Exception {
		try {
			List<CategoryManage> listCategory = categoryManageService.listCategory();
			model.addAttribute("listCategory", listCategory);

			if (! listCategory.isEmpty()) {
		        List<Product> listProduct = productService.listProductByCategoryId(listCategory.get(0).getCategoryId());
		        model.addAttribute("listProduct", listProduct);
		    }
		} catch (Exception e) {
			log.error("productsList: ", e);
			throw e;
		}
		return "products/main";
	} 
	
	@GetMapping("products")
	public String productsByCategory(@RequestParam(value = "categoryId") long categoryId, Model model) throws Exception {
		try {
			List<Product> listProduct = productService.listProductByCategoryId(categoryId);
			model.addAttribute("listProduct", listProduct);
		} catch (Exception e) {
			log.error("productsByCategory : ", e);
			throw e;
		}
		
		return "products/listDetail";
	}

/*
	// AJAX - JSON
	@GetMapping("list")
	public Map<String, ?> list(
			@RequestParam(name = "categoryNum") long categoryNum,
			@RequestParam(name = "sortBy", defaultValue = "0") int sortBy,
			HttpSession session) throws Exception {
		
		Map<String, Object> model = new HashMap<String, Object>();
		
		
		return model;
	}
 */
	
	@GetMapping("{productId}")
	public String detailRequest(@PathVariable("productId") long productId,
			HttpSession session, Model model) throws Exception{
		
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			// 상품
			Product dto = Objects.requireNonNull(productService.findById(productId));
			
			if(info != null) {
				// 찜 여부
				Map<String, Object> map = new HashMap<>();
				map.put("memberId", info.getMemberId());
				map.put("productId", dto.getProductId());
				map.put("productCode", dto.getProductCode());
				
				// dto.setUserWish(myShoppingService.findByWishId(map)== null ? 0 : 1);
			}
			
			// 추가 이미지
			List<Product> listPhoto = productService.listProductPhoto(productId);
			
			// 옵션명
			List<Product> listOption = productService.listProductOption(productId);
			
			// 옵션1 옵션값
			List<Product> listOptionDetail = null;
			if(listOption.size() > 0) {
				listOptionDetail = productService.listOptionDetail(listOption.get(0).getOptionNum());
			}
			
			for(Product od : listOptionDetail) {
				System.out.println(od.getOptionDetailNum());
			}
			
			Map<String, Object> map = new HashMap<String, Object>();
			List<Product> listStock = null;
			
			if(dto.getOptionCount() < 2) {
				map.put("productId", dto.getProductId());
				map.put("productCode", dto.getProductCode());
				map.put("optionDetailNum", listOptionDetail.get(0).getOptionDetailNum());
				listStock = productService.listOptionDetailStock(map);
				
				if(dto.getOptionCount() == 0 && listStock.size() > 0) {
					// 옵션이 없는 경우 재고 수량
					dto.setStockNum(listStock.get(0).getStockNum());
					dto.setTotalStock(listStock.get(0).getTotalStock());
				} else if(dto.getOptionCount() > 0) {
					// 옵션이 하나인 경우 재고 수량
					for(Product vo : listOptionDetail) {
						for(Product ps : listStock) {
							if(vo.getOptionDetailNum() == ps.getOptionDetailNum()) {
								vo.setStockNum(ps.getStockNum());
								vo.setTotalStock(ps.getTotalStock());
								break;
							}
						}
					}
				}
			}
			
			// 추가 이미지
			dto.setPhotoName(dto.getThumbnail());
			listPhoto.add(0, dto);
			
			// 배송정책
			ProductDeliveryRefundInfo deliveryRefundInfo = productService.listDeliveryRefundInfo();
			List<ProductDeliveryRefundInfo> deliveryFee = productService.listDeliveryFee();
			
			
			model.addAttribute("dto", dto);
			model.addAttribute("listOption", listOption);
			model.addAttribute("listOptionDetail", listOptionDetail);
			model.addAttribute("listPhoto", listPhoto);
			model.addAttribute("deliveryRefundInfo", deliveryRefundInfo);
			model.addAttribute("deliveryFee", deliveryFee);
			
			return "products/productInfo";
			
		} catch (NullPointerException e) {
		} catch (Exception e) {
			log.info("detailRequest : ", e);
		}
		
		return "redirect:/products/main";
	}
	
	@GetMapping("listOptionDetail2")
	@ResponseBody
	public List<Product> listOptionDetail2(
			@RequestParam(name = "optionNum") long optionNum,
			@RequestParam(name = "optionNum2") long optionNum2,
			@RequestParam(name = "optionDetailNum") long detailNum) {
		
		List<Product> list = productService.listOptionDetail(optionNum2);
		return list;
	}
	
	@GetMapping("listOptionDetailStock")
	@ResponseBody
	public List<Product> listOptionDetailStock(@RequestParam Map<String, Object> paramMap) {
		// 상세 옵션 및 재고량 -----
		List<Product> list = productService.listOptionDetailStock(paramMap);
		return list;
	}	
}
