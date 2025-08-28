package com.sp.app.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.common.MyUtil;
import com.sp.app.common.PaginateUtil;
import com.sp.app.model.Destination;
import com.sp.app.model.Point;
import com.sp.app.model.ProductLike;
import com.sp.app.model.ProductOrder;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.MyShoppingService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/myShopping/*")
public class MyShoppingController {
	private final MyShoppingService service;
	private final PaginateUtil paginateUtil;
	private final MyUtil myUtil;
	
	// 장바구니
	@GetMapping("cart")
	public String listCart(HttpSession session,
			Model model) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		List<ProductOrder> list = service.listCart(info.getMemberId());
		
		model.addAttribute("list", list);
		
		return "myShopping/cart";
	}
	
	// 장바구니 저장
	@PostMapping("saveCart")
	public String saveCart(ProductOrder dto, HttpSession session) throws Exception {
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			dto.setMemberId(info.getMemberId());
			
			service.insertCart(dto);
			
		} catch (Exception e) {
			log.info("saveCart : ", e);
		}
		
		return "redirect:/myShopping/cart";
	}
	
	// 장바구니에서 하나 상품 비우기
	@GetMapping("deleteCart")
	public String deleteCart(@RequestParam(name = "stockNum") long stockNum,
			HttpSession session) throws Exception {
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			Map<String, Object> map = new HashMap<>();
			map.put("gubun", "item");
			map.put("memberId", info.getMemberId());
			map.put("stockNum", stockNum);
			
			service.deleteCart(map);
			
		} catch (Exception e) {
			log.info("deleteCart : ", e);
		}
		
		return "redirect:/myShopping/cart";
	}
	
	// 장바구니에서 선택 상품 비우기
	@GetMapping("deleteListCart")
	public String deleteListCart(@RequestParam(name = "nums") List<Long> nums,
			HttpSession session) throws Exception {
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			Map<String, Object> map = new HashMap<>();
			map.put("gubun", "list");
			map.put("memberId", info.getMemberId());
			map.put("list", nums);
			
			service.deleteCart(map);
			
		} catch (Exception e) {
			log.info("deleteListCart : ", e);
		}
		
		return "redirect:/myShopping/cart";
	}
	
	// 장바구니 모두 비우기
	@GetMapping("deleteCartAll")
	public String deleteCartAll(HttpSession session) throws Exception {
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			Map<String, Object> map = new HashMap<>();
			map.put("gubun", "all");
			map.put("memberId", info.getMemberId());
			
			service.deleteCart(map);
			
		} catch (Exception e) {
			log.info("deleteCartAll : ", e);
		}
		
		return "redirect:/myShopping/cart";
	}
	
	// 배송지
	@PostMapping("deliveryAddress/write")
	public String deliveryAddressCreated(Destination dto, HttpSession session) {
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			dto.setMemberId(info.getMemberId());
			
			service.insertDestination(dto);
			
		} catch (Exception e) {
			log.info("deliveryAddressCreated : ", e);
		}
		
		return "redirect:/myShopping/deliveryAddress";
	}
	
	@ResponseBody
	@PostMapping("deliveryAddress/save")
	public Map<String, Object> deliveryAddressSave(Destination dto, HttpSession session) {
		Map<String, Object> model = new HashMap<>();
		String state = "true";
		
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");

			dto.setMemberId(info.getMemberId());
			
			service.insertDestination(dto);
		} catch (Exception e) {
			state = "false";
			
			log.info("deliveryAddressSave : ", e);
		}
		
		model.put("state", state);
		
		return model;
	}

	
	@PostMapping("productLike/{productCode}")
	@ResponseBody
	public Map<String, ?> productLikeSubmit(@PathVariable(name = "productCode") long productCode,
			HttpSession session) throws Exception {
		Map<String, Object> model = new HashMap<>();
		
		String state = "false";
		try {
			Map<String, Object> map = new HashMap<>();
			
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			map.put("memberId", info.getMemberId());
			map.put("productCode", productCode);
			
			service.insertProductLike(map);
			
			state = "true";
		} catch (Exception e) {
			log.info("productLikeSubmit : ", e);
		}
		
		model.put("state", state);
		return model;
	}
	
	// 찜 삭제 : AJAX - JSON
	@DeleteMapping("productLike/{productCode}")
	@ResponseBody
	public Map<String, ?> productLikeDelete(@PathVariable(name = "productCode") Long productCode,
			HttpSession session) throws Exception {
		
		Map<String, Object> model = new HashMap<String, Object>();
		
		String state = "false";
		try {
			Map<String, Object> map = new HashMap<>();
			
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			map.put("memberId", info.getMemberId());
			map.put("productCode", productCode);
			
			service.deleteProductLike(map);
			
			state = "true";
		} catch (Exception e) {
			log.info("productLikeDelete : ", e);
		}
		
		model.put("state", state);
		return model;
	}
	
	// 찜 전체 삭제 : AJAX - JSON
	@DeleteMapping("productLike")
	@ResponseBody
	public Map<String, ?> productLikeDeleteAll(HttpSession session) throws Exception {
		
		Map<String, Object> model = new HashMap<String, Object>();
		
		String state = "false";
		try {
			Map<String, Object> map = new HashMap<>();
			
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			map.put("memberId", info.getMemberId());
			
			service.deleteProductLike(map);
			
			state = "true";
		} catch (Exception e) {
			log.info("productLikeDeleteAll : ", e);
		}
		
		model.put("state", state);
		return model;
	}
	
	// AJAX
	// 찜 리스트
	@GetMapping("list2")
	@ResponseBody
	public Map<String, ?> productLikeList2(
			@RequestParam(name = "pageNo", defaultValue = "1") int current_page,
			HttpSession session) throws Exception {
		Map<String, Object> model = new HashMap<String, Object>();

		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			int size = 10;
			int dataCount = 0;
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("memberId", info.getMemberId());
			
			dataCount = service.productLikeDataCount(map);
			
			int total_page = paginateUtil.pageCount(dataCount, size);

			current_page = Math.min(current_page, total_page);

			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;

			map.put("offset", offset);
			map.put("size", size);
			
			System.out.println(offset);
			System.out.println(size);
			List<ProductLike> list = service.listProductLike(map);
			
			String paging = paginateUtil.pagingMethod(current_page, total_page, "listProductLike");
			
			model.put("list", list);
			model.put("dataCount", dataCount);
			model.put("size", size);
			model.put("pageNo", current_page);
			model.put("paging", paging);
			model.put("total_page", total_page);
			
		} catch (Exception e) {
			log.info("productLikeList2 : ", e);
		}
		
		return model;
	}	
	
	// 찜 리스트
	@GetMapping("productLike")
	public String productLikeList(Model model,
			HttpSession session) throws Exception {
		
		model.addAttribute("mode", "productLike");
		
		return "myShopping/wishList";
	}	
	
	@GetMapping("myPoint")
	public String myPoint(@RequestParam(name = "page", defaultValue = "1") int current_page,
			@RequestParam(name = "schType", defaultValue = "classifyStr") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			Model model,
			HttpServletRequest req,
			HttpSession session) {
		
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");			
			
			int size = 10;
			int total_page = 0;
			int dataCount = 0;

			/*
			if (req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
				kwd = myUtil.decodeUrl(kwd);
			}
			*/
			kwd = myUtil.decodeUrl(kwd);

			// 전체 페이지 수
			// - 1:적립, 2:사용, 3:소멸, 4:주문취소
			Map<String, Object> map = new HashMap<String, Object>();
			if(schType.equals("classifyStr") && ! kwd.isEmpty()) {
				schType = "classify";
				if("적립".contains(kwd)) {
					kwd = "1";
				} else if("사용".contains(kwd)) {
					kwd = "2";
				} else if("소멸".contains(kwd)) {
					kwd = "3";
				} else if("주문취소".contains(kwd)) {
					kwd = "4";
				}
			}

			map.put("memberId", info.getMemberId());
			map.put("schType", schType);
			map.put("kwd", kwd);
			
			dataCount = service.pointDataCount(map);
			if (dataCount != 0) {
				total_page = dataCount / size + (dataCount % size > 0 ? 1 : 0);
			}
			
			// 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
			current_page = Math.min(current_page, total_page);

			// 리스트에 출력할 데이터를 가져오기
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;

			map.put("offset", offset);
			map.put("size", size);

			// 글 리스트
			List<Point> pointList = service.listPointHistory(map);
			
			int balance = pointList.get(0).getBalance();

			String cp = req.getContextPath();
			String query = "";
			String listUrl = cp + "myShopping/myPoint";
			if (! kwd.isBlank()) {
				query = "schType=" + schType + "&kwd=" + myUtil.encodeUrl(kwd);
				
				listUrl += "?" + query;
			}
			String paging = paginateUtil.paging(current_page, total_page, listUrl);	
			
			// - 1:적립, 2:사용, 3:소멸, 4:주문취소
			if(kwd == "1") {
				kwd = "적립";
			} else if(kwd == "2") {
				kwd = "사용";
			} else if(kwd == "3") {
				kwd = "소멸";
			} else if(kwd == "4") {
				kwd = "주문취소";
			} 
			
			model.addAttribute("pointList", pointList);			
			model.addAttribute("balance", balance);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("size", size);
			model.addAttribute("total_page", total_page);
			model.addAttribute("page", current_page);
			
			model.addAttribute("paging", paging);
			
			model.addAttribute("schType", schType);
			model.addAttribute("kwd", kwd);
		} catch (Exception e) {
			log.info("myPageHome : ", e);
		}
		
		return "myShopping/myPoint";
	}
	
	// 최근상품목혹
	@GetMapping("recentProduct")
	public String handlerecentProduct() {
		return "myShopping/recentProduct";
	}
	
}
