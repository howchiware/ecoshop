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
import com.sp.app.model.Product;
import com.sp.app.model.ProductDeliveryRefundInfo;
import com.sp.app.model.ProductOrder;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.MyShoppingService;
import com.sp.app.service.ProductOrderService;
import com.sp.app.service.ProductReviewService;
import com.sp.app.service.ProductService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/products/*")
public class ProductController {

	private final ProductReviewService reviewService;
	private final ProductOrderService orderService;
	private final CategoryManageService categoryManageService;
	private final ProductService productService;
	private final MyShoppingService myShoppingService;
	private final PaginateUtil paginateUtil;
	
	@GetMapping("main")
	public String productsList(@RequestParam(name = "categoryId", defaultValue = "1") long categoryId,
			@RequestParam(name = "page", defaultValue = "1") int current_page,
			Model model,
			HttpServletRequest req, HttpSession session) throws Exception {
		
		try {
			List<CategoryManage> listCategory = categoryManageService.listCategory();
			model.addAttribute("listCategory", listCategory);
			
			if (! listCategory.isEmpty()) {
				
		        List<Product> listProduct = productService.listAllProducts();
		        List<Product> listFiveProduct = productService.listFiveProducts();
		        /*
		        for(Product dto : listProduct) {
		        	Map<String, Object> reviewMap = new HashMap<String, Object>();
		        	
		        	reviewMap.put("productCode", dto.getProductCode());
		        	
		        	int reviewCount = reviewService.dataCount(reviewMap);
		        	dto.setReviewCount(reviewCount);
		        }
		        */
		        
		        model.addAttribute("listProduct", listProduct);
		        model.addAttribute("listFiveProduct", listFiveProduct);
		    }
		} catch (Exception e) {
			log.error("productsList: ", e);
			throw e;
		}
		return "products/main";
	} 
	
	@GetMapping("products")
	public String productsByCategory(
			@RequestParam(name = "categoryId", defaultValue = "1") long categoryId,
			@RequestParam(name = "sortBy", defaultValue = "0") int sortBy,
			@RequestParam(name = "page", defaultValue = "1") int current_page,
			Model model,
			HttpServletRequest req, HttpSession session) throws Exception {
		
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			int size = 12;
			int total_page;
			int dataCount;
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("categoryId", categoryId);
			map.put("sortBy", sortBy);
			
			// Product categoryDto = Objects.requireNonNull(productService.findByCategoryId(categoryId));
			
			dataCount = productService.dataCount(map);
			System.out.println(dataCount);
			total_page = paginateUtil.pageCount(dataCount, size);
			
			current_page = Math.min(current_page, total_page);

			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			if(info != null) {
				map.put("memberId", info.getMemberId());
			}
			
			List<Product> listProduct = productService.listProductByCategoryId(map);
	        
	        for(Product dto : listProduct) {
	        	Map<String, Object> reviewMap = new HashMap<String, Object>();
	        	
	        	reviewMap.put("productCode", dto.getProductCode());
	        	
	        	int reviewCount = reviewService.dataCount(reviewMap);
	        	dto.setReviewCount(reviewCount);
	        	
	        	if(info != null) {
					// 찜 여부
					Map<String, Object> productLikemap = new HashMap<>();
					productLikemap.put("memberId", info.getMemberId());
					productLikemap.put("productId", dto.getProductId());
					productLikemap.put("productCode", dto.getProductCode());
					
					dto.setUserProductLike(myShoppingService.findByProductLikeId(productLikemap)== null ? 0 : 1);
				}
	        }
	        String cp = req.getContextPath();
			String listUrl = cp + "/products/main?categoryId=" + categoryId;
			
			String paging = paginateUtil.paging(current_page, total_page, listUrl);
			
			model.addAttribute("listProduct", listProduct);
			model.addAttribute("categoryId", categoryId);
			//model.addAttribute("categoryName", categoryDto.getCategoryName());
			model.addAttribute("page", current_page);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("size", size);
			model.addAttribute("total_page", total_page);
			model.addAttribute("paging", paging);
	        
			
		} catch (Exception e) {
			log.error("productsByCategory : ", e);
			throw e;
		}
		
		return "products/listDetail";
	}
	
	
	
	/*
	@GetMapping("main")
	public String productsList(@RequestParam(name = "categoryId", defaultValue = "1") long categoryId,
			@RequestParam(name = "page", defaultValue = "1") int current_page,
			Model model,
			HttpServletRequest req, HttpSession session) throws Exception {
		
		try {
			List<CategoryManage> listCategory = categoryManageService.listCategory();
			model.addAttribute("listCategory", listCategory);
			
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			int size = 12;
			int total_page;
			int dataCount;

			if (! listCategory.isEmpty()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("categoryId", categoryId);
				
				dataCount = productService.dataCount(map);
				total_page = paginateUtil.pageCount(dataCount, size);
				
				current_page = Math.min(current_page, total_page);

				int offset = (current_page - 1) * size;
				if(offset < 0) offset = 0;
				
				map.put("offset", offset);
				map.put("size", size);
				if(info != null) {
					map.put("memberId", info.getMemberId());
				}
				
		        List<Product> listProduct = productService.listProductByCategoryId(map);
		        
		        for(Product dto : listProduct) {
		        	Map<String, Object> reviewMap = new HashMap<String, Object>();
		        	
		        	reviewMap.put("productCode", dto.getProductCode());
		        	
		        	int reviewCount = reviewService.dataCount(reviewMap);
		        	dto.setReviewCount(reviewCount);
		        }
		        String cp = req.getContextPath();
				String listUrl = cp + "/products/products?categoryId=" + categoryId;
				
				String paging = paginateUtil.paging(current_page, total_page, listUrl);
		        
		        for(Product dto : listProduct) {
		        	System.out.println(dto.getReviewCount());
		        }
		        model.addAttribute("listProduct", listProduct);
		        model.addAttribute("page", current_page);
				model.addAttribute("dataCount", dataCount);
				model.addAttribute("size", size);
				model.addAttribute("total_page", total_page);
				model.addAttribute("paging", paging);
		    }
		} catch (Exception e) {
			log.error("productsList: ", e);
			throw e;
		}
		return "products/main";
	} 
	
	@GetMapping("products")
	public String productsByCategory(@RequestParam(name = "categoryId", defaultValue = "1") long categoryId,
			@RequestParam(name = "page", defaultValue = "1") int current_page,
			Model model,
			HttpServletRequest req, HttpSession session) throws Exception {
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			int size = 12;
			int total_page;
			int dataCount;
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("categoryId", categoryId);
			
			dataCount = productService.dataCount(map);
			total_page = paginateUtil.pageCount(dataCount, size);
			
			current_page = Math.min(current_page, total_page);

			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			if(info != null) {
				map.put("memberId", info.getMemberId());
			}

			
			List<Product> listProduct = productService.listProductByCategoryId(map);
	        
	        for(Product dto : listProduct) {
	        	Map<String, Object> reviewMap = new HashMap<String, Object>();
	        	
	        	reviewMap.put("productCode", dto.getProductCode());
	        	
	        	int reviewCount = reviewService.dataCount(reviewMap);
	        	dto.setReviewCount(reviewCount);
	        }
	        
	        String cp = req.getContextPath();
			String listUrl = cp + "/products/products?categoryId=" + categoryId;
			
			String paging = paginateUtil.paging(current_page, total_page, listUrl);
	        
			model.addAttribute("listProduct", listProduct);
	        model.addAttribute("page", current_page);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("size", size);
			model.addAttribute("total_page", total_page);
			model.addAttribute("paging", paging);
			
		} catch (Exception e) {
			log.error("productsByCategory : ", e);
			throw e;
		}
		
		return "products/listDetail";
	}
	*/

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
				
				dto.setUserProductLike(myShoppingService.findByProductLikeId(map)== null ? 0 : 1);
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
			
			Map<String, Object> map = new HashMap<String, Object>();
			List<Product> listStock = null;
			if(dto.getOptionCount() < 2) {
				map.put("productId", dto.getProductId());
				map.put("productCode", dto.getProductCode());
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
			
			// 상품을 구매하였는데 리뷰를 안 남긴 경우
			Map<String, Object> orderMap = new HashMap<String, Object>();
			List<ProductOrder> didIBuyThis = null;

			if(info != null) {
				orderMap.put("memberId", info.getMemberId());
				orderMap.put("productCode", productId);				
				didIBuyThis = orderService.didIBuyThis(orderMap);
			}
			
			/*
			List<ProductReview> myReviewOfThis = new ArrayList<>();
			for(ProductOrder order : didIBuyThis) {
				ProductReview review = orderService.myReviewOfThis(order.getOrderDetailId());
				if(review != null) {
					myReviewOfThis.add(review);					
				}
			}
			System.out.println(didIBuyThis.size());
			System.out.println(myReviewOfThis.size());
			
			boolean leaveReview = false;
			if(didIBuyThis.size() > myReviewOfThis.size()) {
				leaveReview = true;
			}
			System.out.println(leaveReview);
			*/
			boolean leaveReview = false;
			if(didIBuyThis != null && didIBuyThis.size() > 0) {
				leaveReview = true;
			}
			
			model.addAttribute("dto", dto);
			model.addAttribute("listOption", listOption);
			model.addAttribute("listOptionDetail", listOptionDetail);
			model.addAttribute("listPhoto", listPhoto);
			model.addAttribute("deliveryRefundInfo", deliveryRefundInfo);
			model.addAttribute("deliveryFee", deliveryFee);
			model.addAttribute("didIBuyThis", didIBuyThis);
			model.addAttribute("leaveReview", leaveReview);
			
			return "products/productInfo";
			
		} catch (NullPointerException e) {
		} catch (Exception e) {
			log.info("detailRequest : ", e);
		}
		
		return "redirect:/products/main";
	}
	
	@ResponseBody
	@GetMapping("viewProductDetail")
	public Map<String, ?> viewProductDetail(@RequestParam("productCode") long productCode,
			HttpSession session) throws Exception{

		Map<String, Object> model = new HashMap<String, Object>();
		
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			// 상품
			Product dto = Objects.requireNonNull(productService.findById(productCode));
			
			if(info != null) {
				// 찜 여부
				Map<String, Object> map = new HashMap<>();
				map.put("memberId", info.getMemberId());
				map.put("productId", dto.getProductId());
				map.put("productCode", dto.getProductCode());
				
				dto.setUserProductLike(myShoppingService.findByProductLikeId(map)== null ? 0 : 1);
			}
			
			// 추가 이미지
			List<Product> listPhoto = productService.listProductPhoto(productCode);
			
			// 옵션명
			List<Product> listOption = productService.listProductOption(productCode);
			
			// 옵션1 옵션값
			List<Product> listOptionDetail = null;
			if(listOption.size() > 0) {
				listOptionDetail = productService.listOptionDetail(listOption.get(0).getOptionNum());
			}
			
			Map<String, Object> map = new HashMap<String, Object>();
			List<Product> listStock = null;
			if(dto.getOptionCount() < 2) {
				map.put("productId", dto.getProductId());
				map.put("productCode", dto.getProductCode());
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
			
			model.put("dto", dto);
			model.put("listOption", listOption);
			model.put("listOptionDetail", listOptionDetail);
			model.put("listPhoto", listPhoto);
			
			
		} catch (NullPointerException e) {
		} catch (Exception e) {
			log.info("viewProductDetail : ", e);
		}
		
		return model;
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
