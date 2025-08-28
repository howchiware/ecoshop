package com.sp.app.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sp.app.admin.model.ProductDeliveryRefundInfoManage;
import com.sp.app.admin.service.ProductManageService;
import com.sp.app.common.PaginateUtil;
import com.sp.app.model.Destination;
import com.sp.app.model.Member;
import com.sp.app.model.Payment;
import com.sp.app.model.Point;
import com.sp.app.model.ProductLike;
import com.sp.app.model.ProductOrder;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.MemberService;
import com.sp.app.service.MyShoppingService;
import com.sp.app.service.ProductOrderService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/productsOrder/*")
public class ProductOrderController {
	private final ProductOrderService orderService;
	private final ProductManageService productManageService;
	private final MemberService memberService;
	private final MyShoppingService myShoppingService;
	private final PaginateUtil paginateUtil;
	
	@RequestMapping(name = "payment", method = {RequestMethod.GET, RequestMethod.POST})
	public String paymentForm(
			@RequestParam(name = "productCodes") List<Long> productCodes, 
			@RequestParam(name = "stockNums") List<Long> stockNums,
			@RequestParam(name = "buyQtys") List<Integer> buyQtys,
			@RequestParam(name = "mode", defaultValue = "buy") String mode,
			Model model,
			HttpSession session) throws Exception {
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			/*
			if(info == null) {
				return "redirect:/member/login";
			}
			*/
			Member orderUser = memberService.findById(info.getUserId());
			
			String productOrderNumber = null; // 주문 상품 번호
			String productOrderName = ""; // 주문 상품 이름
			int totalAmount = 0; // 상품 가격 합
			int deliveryCharge = 0; // 배송비
			int totalPayment = 0; // 결제할 금액(상품합 + 배송비);
			int totalSavedPoint = 0; // 적립금 총합
			
			productOrderNumber = orderService.productOrderNumber();
			
			List<Map<String, Long>> list = new ArrayList<>();
			for(int i=0; i < stockNums.size(); i++) {
				Map<String, Long> map = new HashMap<>();
				map.put("stockNum", stockNums.get(i));
				map.put("productId", productCodes.get(i));
				list.add(map);
			}
			
			List<ProductOrder> listProduct = orderService.listOrderProduct(list);
			
			for(int i = 0; i < listProduct.size(); i++) {
				ProductOrder dto = listProduct.get(i);
				
				dto.setQty(buyQtys.get(i));
				dto.setProductMoney(buyQtys.get(i) * dto.getPrice());
				
				totalSavedPoint += (buyQtys.get(i) * dto.getPoint());
				dto.setPoint(buyQtys.get(i) * dto.getPoint());
				
				totalAmount += buyQtys.get(i) * dto.getPrice();
			}
			
			productOrderName = listProduct.get(0).getProductName();
			if(listProduct.size() > 1) {
				productOrderName += " 외 " + (listProduct.size() - 1) + "건";
			}
			
			// 배송비
			List<ProductDeliveryRefundInfoManage> listDeliveryFee = productManageService.listDeliveryFee();
			
			deliveryCharge = totalAmount >= 30000 ? 0 : listDeliveryFee.get(0).getFee();
			
			// 결제할 금액(상품 총금액 + 배송비)
			totalPayment = totalAmount + deliveryCharge;
			
			// 포인트
			Point userPoint = orderService.findByUserPoint(info.getMemberId());
			
			// 배송지
			List<Destination> listDestination = myShoppingService.listDestination(info.getMemberId());
			Destination destination = myShoppingService.defaultDelivery(info.getMemberId());
			
			model.addAttribute("productOrderNumber", productOrderNumber); // 주문 번호
			model.addAttribute("orderUser", orderUser); // 주문 유저
			model.addAttribute("productOrderName", productOrderName); // 주문 상품명
			
			model.addAttribute("listProduct", listProduct);
			model.addAttribute("totalAmount", totalAmount); // 총금액 (수량*할인가격 의 합)
			model.addAttribute("totalPayment", totalPayment); // 결제할 금액
			model.addAttribute("totalSavedPoint", totalSavedPoint); // 총 적림예정액
			model.addAttribute("userPoint", userPoint); // 포인트
			model.addAttribute("deliveryCharge", deliveryCharge); // 배송비

			model.addAttribute("listDestination", listDestination);
			model.addAttribute("destination", destination);
			
			model.addAttribute("mode", mode); // 바로 구매인지 장바구니 구매인지를 가지고 있음
			
			return "productsOrder/payment";
			
			
		} catch (Exception e) {
			log.info("paymentForm : ", e);
		}
		
		return "redirect:/";
	}
	
	@PostMapping("paymentOk")
	public String paymentSubmit(ProductOrder dto, 
			@RequestParam(name = "mode", defaultValue = "buy") String mode,
			final RedirectAttributes reAttr,
			HttpSession session) throws Exception {
		
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			dto.setMemberId(info.getMemberId());
			
			orderService.insertOrder(dto);
			
			if(mode.equals("cart")) {
				// 구매 상품에 대한 장바구니 비우기
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("gubun", "list");
				map.put("memberId", info.getMemberId());
				map.put("list", dto.getStockNums());
				
				myShoppingService.deleteCart(map);
			}
			
			String p = String.format("%,d", dto.getPayment());
			
			StringBuilder sb = new StringBuilder();
			sb.append(info.getName() + "님 상품을 구매해 주셔서 감사 합니다.<br>");
			sb.append("구매 하신 상품의 결제가 정상적으로 처리되었습니다.<br>");
			sb.append("결제 금액 : <label class='fs-5 fw-bold text-primary'>" +  p + "</label>원");

			reAttr.addFlashAttribute("title", "상품 결제 완료");
			reAttr.addFlashAttribute("message", sb.toString());
			
			return "redirect:/productsOrder/complete";
			
		} catch (Exception e) {
			log.info("paymentSubmit : ", e);
		}
		
		return "redirect:/";
	}
	
	@GetMapping("complete")
	public String complete(@ModelAttribute("title") String title, 
			@ModelAttribute("message") String message) throws Exception {
		// F5를 누른 경우
		if (message == null || message.isBlank()) { 
			return "redirect:/";
		}
		
		return "productsOrder/complete";
	}
	
	// 마이페이지 주문 내역
	// 결제내역
	@GetMapping("paymentList")
	public String paymentList(@RequestParam(name = "page", defaultValue = "1") int current_page,
			Model model,
			HttpServletRequest req,
			HttpSession session) throws Exception {
		
		try {
			int size = 5;
			int total_page;
			int dataCount;
			
			SessionInfo info = (SessionInfo)session.getAttribute("member");

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("memberId", info.getMemberId());
			
			dataCount = orderService.countPayment(map);
			total_page = paginateUtil.pageCount(dataCount, size);
			current_page = Math.min(current_page, total_page);
			
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			
			List<Payment> list = orderService.listPayment(map);
			
			String cp = req.getContextPath();
			String listUrl = cp + "/productsOrder/paymentList";
			
			String paging = paginateUtil.paging(current_page, total_page, listUrl);
			
			model.addAttribute("list", list);
			model.addAttribute("page", current_page);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("size", size);
			model.addAttribute("total_page", total_page);
			model.addAttribute("paging", paging);		
			
		} catch (Exception e) {
			log.info("paymentList : ", e);
		}
		
		return "myPage/paymentList";
	}
	
	
	// 구매 상세 보기 : AJAX - Text
	@GetMapping("detailView")
	public String detailView(@RequestParam Map<String, Object> paramMap,
			Model model,
			HttpServletResponse resp,
			HttpSession session) throws Exception {
		
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			paramMap.put("memberId", info.getMemberId());
			
			// 구매 상세 정보
			Payment dto = orderService.findPaymentByOrderDetail(paramMap);
			
			// 퍼처스 리스트(함께 구매한 상품 리스트)
			List<Payment> listBuy = orderService.listPurchase(paramMap);
			
			// 배송지 정보
			ProductOrder orderDelivery = orderService.findByOrderDelivery(paramMap);
			
			model.addAttribute("dto", dto);
			model.addAttribute("listBuy", listBuy);
			model.addAttribute("orderDelivery", orderDelivery);
			
		} catch (Exception e) {
			resp.sendError(406);
			
			throw e;
		}
		
		return "myPage/orderDetailView"; 
	}
	
	// 구매 확정
	@GetMapping("confirmation")
	public String confirmation(@RequestParam Map<String, Object> paramMap,
			@RequestParam(name = "page") String page,
			HttpSession session) throws Exception {
		
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			paramMap.put("detailState", "1"); // 구매확정
			paramMap.put("stateMemo", "구매확정완료");
			paramMap.put("memberId", info.getMemberId());
			
			orderService.updateOrderDetailState(paramMap);
			
		} catch (Exception e) {
			log.info("confirmation : ", e);
		}
		
		return "redirect:/productsOrder/paymentList?page="+page; 
	}
	
	// 주문취소/반품/교환요청
	@PostMapping("orderDetailUpdate")
	public String orderDetailUpdate(@RequestParam Map<String, Object> paramMap,
			@RequestParam(name = "page") String page,
			HttpSession session) throws Exception {
		
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			paramMap.put("memberId", info.getMemberId());
			
			orderService.updateOrderDetailState(paramMap);
			
		} catch (Exception e) {
			log.info("orderDetailUpdate : ", e);
		}
		
		return "redirect:/productsOrder/paymentList?page="+page;
	}
	
	@GetMapping("updateOrderHistory")
	public String updateOrderHistory(@RequestParam(name = "orderDetailId") long orderDetailId,
			@RequestParam(name = "page") String page,
			HttpSession session) throws Exception {
		
		try {
			orderService.updateOrderHistory(orderDetailId);
		} catch (Exception e) {
		}
		
		return "redirect:/productsOrder/paymentList?page="+page;
	}
	
	// AJAX
	@GetMapping("stateView")
	@ResponseBody
	public Map<String, ?> stateView(
			@RequestParam(name = "orderDetailId") long orderDetailId,
			HttpSession session) throws Exception {
		Map<String, Object> model = new HashMap<String, Object>();
		
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("memberId", info.getMemberId());
			map.put("orderDetailId", orderDetailId);
			
			Payment payment = orderService.stateView(map);
			
			model.put("payment", payment);
			
		} catch (Exception e) {
			log.info("stateView : ", e);
		}
			
		return model;	
	}
}
