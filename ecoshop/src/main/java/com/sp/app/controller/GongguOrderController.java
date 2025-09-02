package com.sp.app.controller;

import java.util.Collections;
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

import com.sp.app.common.PaginateUtil;
import com.sp.app.model.Destination;
import com.sp.app.model.GongguOrder;
import com.sp.app.model.GongguPayment;
import com.sp.app.model.GongguProductDeliveryRefundInfo;
import com.sp.app.model.GongguReview;
import com.sp.app.model.Member;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.GongguOrderService;
import com.sp.app.service.GongguProductReviewService;
import com.sp.app.service.GongguService;
import com.sp.app.service.MemberService;
import com.sp.app.service.MyGongguShoppingService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/gongguOrder/*")
public class GongguOrderController {
	private final GongguOrderService gongguOrderService;
	private final GongguService gongguService;
	private final MemberService memberService;
	private final MyGongguShoppingService myGongguShoppingService;
	private final PaginateUtil paginateUtil;
	private final GongguProductReviewService gongguProductReviewService;
	private String uploadPath;
	
	@RequestMapping(value="payment", method={RequestMethod.GET, RequestMethod.POST})
	public String paymentForm(
			@RequestParam(name = "gongguProductId") long gongguProductId, 
			Model model,
			HttpSession session) throws Exception {
		try {
	        SessionInfo info = (SessionInfo)session.getAttribute("member");
	        if (info == null) {
	            return "redirect:/member/login";
	        }
	        
	        Map<String, Object> map = new HashMap<>();
	        map.put("memberId", info.getMemberId());
	        map.put("gongguProductId", gongguProductId);
	        
			Member orderUser = memberService.findById(info.getUserId());
			
			String gongguOrderNumber = null; // 주문 상품 번호
			String gongguOrderName = ""; // 주문 상품 이름
			int totalAmount = 0; // 패키지 가격
			int deliveryCharge = 0; // 배송비
			int totalPayment = 0; // 결제할 금액(상품비 + 배송비);
			
			gongguOrderNumber = gongguOrderService.gongguproductOrderNumber();
	        
	        GongguOrder productParam = new GongguOrder();
	        productParam.setGongguProductId(gongguProductId);

	        GongguOrder gongguProduct = gongguOrderService.findByGongguProduct(gongguProductId);

	        if (gongguProduct == null) {
	            return "redirect:/"; 
	        }

	        gongguProduct.setCnt(1);
	        gongguProduct.setPrice(gongguProduct.getSalePrice());

	        totalAmount = gongguProduct.getSalePrice();
	        gongguOrderName = gongguProduct.getGongguProductName();
	        List<GongguOrder> listGongguProduct = Collections.singletonList(gongguProduct);
			
			// 배송비
			List<GongguProductDeliveryRefundInfo> listDeliveryFee = gongguService.listDeliveryFee();	
			if(!listDeliveryFee.isEmpty()) {
                deliveryCharge = listDeliveryFee.get(0).getDeliveryFee();
           }

			// 결제할 금액(상품 총금액 + 배송비)
			totalPayment = totalAmount + deliveryCharge;
			
			// 배송지
			List<Destination> listDestination = myGongguShoppingService.listDestination(info.getMemberId());
			Destination destination = myGongguShoppingService.defaultDelivery(info.getMemberId());
			
			model.addAttribute("gongguOrderNumber", gongguOrderNumber); // 주문 번호
			model.addAttribute("orderUser", orderUser); // 주문 유저
			model.addAttribute("gongguOrderName", gongguOrderName); // 주문 상품명
			
			model.addAttribute("listGongguProduct", listGongguProduct);
			model.addAttribute("totalAmount", totalAmount); // 총금액 (수량*할인가격 의 합)
			model.addAttribute("totalPayment", totalPayment); // 결제할 금액
			model.addAttribute("deliveryCharge", deliveryCharge); // 배송비

			model.addAttribute("listDestination", listDestination);
			model.addAttribute("destination", destination);
			
			return "gongguOrder/payment";
			
			
		} catch (Exception e) {
			log.info("paymentForm : ", e);
		}
		
		return "redirect:/";
	}

	
	@PostMapping("paymentOk")
	public String paymentSubmit(GongguOrder dto,
	        @RequestParam(name = "gongguProductId") long gongguProductId, 
	        final RedirectAttributes reAttr,
	        HttpSession session) throws Exception {

	    try {
	        SessionInfo info = (SessionInfo)session.getAttribute("member");
	        if(info == null) {
	            return "redirect:/member/login";
	        }

	        dto.setMemberId(info.getMemberId());
	        dto.setUsedPoint(0);
	        dto.setClassify(2);

	        gongguOrderService.insertGongguOrder(dto, gongguProductId);

	        String p = String.format("%,d", dto.getPayment());

	        StringBuilder sb = new StringBuilder();
	        sb.append(info.getName() + "님 상품을 구매해 주셔서 감사 합니다.<br>");
	        sb.append("구매 하신 상품의 결제가 정상적으로 처리되었습니다.<br>");
	        sb.append("결제 금액 : <label class='fs-5 fw-bold text-primary'>" + p + "</label>원");

	        reAttr.addFlashAttribute("title", "상품 결제 완료");
	        reAttr.addFlashAttribute("message", sb.toString());

	        return "redirect:/gongguOrder/complete";

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
		
		return "gongguOrder/complete";
	}

	
	// 마이페이지  
	@GetMapping("gongguPayment")
	public String gongguPaymentList(
			@RequestParam(name = "page", defaultValue = "1") int current_page,
			Model model,
			HttpServletRequest req,
			HttpSession session) throws Exception {
		
		try {
			int size = 10;
			int total_page;
			int dataCount;
			
			SessionInfo info = (SessionInfo)session.getAttribute("member");

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("memberId", info.getMemberId());
			
			dataCount = gongguOrderService.countGongguPayment(map);
			total_page = paginateUtil.pageCount(dataCount, size);
			current_page = Math.min(current_page, total_page);
			
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			
			List<GongguPayment> list = gongguOrderService.listGongguPayment(map);
			
			String cp = req.getContextPath();
			String listUrl = cp + "/myPage/gongguPaymentList";
			
			String paging = paginateUtil.paging(current_page, total_page, listUrl);
			
			model.addAttribute("list", list);
			model.addAttribute("page", current_page);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("size", size);
			model.addAttribute("total_page", total_page);
			model.addAttribute("paging", paging);		
			
		} catch (Exception e) {
			log.info("gongguPaymentList : ", e);
		}
		
		return "myPage/gongguPaymentList";
	}
	
	@GetMapping("updateGongguOrderHistory")
	public String updateGongguOrderHistory(
			@RequestParam(name = "gongguOrderDetailId") long gongguOrderDetailId,
			@RequestParam(name = "page") String page,
			HttpSession session) throws Exception {
		
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			if(info == null) {
				return "redirect:/member/login";
			}
			gongguOrderService.updateGongguOrderHistory(gongguOrderDetailId);
		} catch (Exception e) {
			log.error("updateGongguOrderHistory : ", e);
		}
		
		return "redirect:/gongguOrder/gongguPaymentList?page=" + page;
	}
	
	@GetMapping("confirmation")
	public String confirmation(
			@RequestParam(name = "gongguOrderDetailId") long gongguOrderDetailId,
			@RequestParam(name = "page") String page,
			HttpSession session) throws Exception {
		
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			if(info == null) {
				return "redirect:/member/login";
			}
			
			Map<String, Object> map = new HashMap<>();
			map.put("gongguOrderDetailId", gongguOrderDetailId);
			map.put("detailState", 8);
			map.put("stateMemo", "구매확정완료");
			map.put("memberId", info.getMemberId());
			gongguOrderService.updateGongguOrderDetailState(map);
			
		} catch (Exception e) {
			log.error("confirmation : ", e);
		}
		
		return "redirect:/gongguOrder/gongguPaymentList?page=" + page;
	}
	
	@GetMapping("gongguOrderDetailView")
	@ResponseBody
	public Map<String, Object> gongguOrderDetailView(
			@RequestParam(name = "orderId") long orderId,
			@RequestParam(name = "gongguOrderDetailId") long gongguOrderDetailId,
			HttpServletResponse resp,
			HttpSession session) throws Exception {
		
		Map<String, Object> model = new HashMap<>();
		
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			if(info == null) {
				model.put("state", "noLogin");
				return model;
			}
			
			Map<String, Object> paramMap = new HashMap<>();
			paramMap.put("orderId", orderId);
			paramMap.put("gongguOrderDetailId", gongguOrderDetailId);
			paramMap.put("memberId", info.getMemberId());
			
			GongguPayment dto = gongguOrderService.findByGongguOrderDetail(paramMap);
			
			List<GongguPayment> listBuy = gongguOrderService.listGongguPurchase(paramMap); 
			
			GongguOrder orderDelivery = gongguOrderService.findByGongguOrderDelivery(paramMap);
			
			model.put("dto", dto);
			model.put("listBuy", listBuy);
			model.put("orderDelivery", orderDelivery);
			model.put("state", "true");
			
		} catch (NullPointerException e) {
			model.put("state", "notFound");
		} catch (Exception e) {
			log.error("gongguOrderDetailView : ", e);
			model.put("state", "false");
		}
		
		return model;
	}
	
	@PostMapping("orderDetailUpdate")
	public String orderDetailUpdate(
			@ModelAttribute GongguOrder dto,
			@RequestParam(name = "page") String page,
			@ModelAttribute GongguPayment pDto,
			HttpSession session) throws Exception {
		
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			if(info == null) {
				return "redirect:/member/login";
			}
			
			Map<String, Object> map = new HashMap<>();
			map.put("gongguOrderDetailId", dto.getGongguOrderDetailId());
			map.put("detailState", dto.getDetailState());
			map.put("stateMemo", pDto.getStateMemo());
			map.put("memberId", info.getMemberId());
			
			gongguOrderService.updateGongguOrderDetailState(map);
			
		} catch (Exception e) {
			log.error("orderDetailUpdate : ", e);
		}
		
		return "redirect:/gongguOrder/gongguPaymentList?page=" + page;
	}

	@PostMapping("reviewWrite")
	@ResponseBody
	public Map<String, ?> reviewWriteSubmit(
			GongguReview dto,
			HttpSession session) throws Exception {
		
		Map<String, Object> model = new HashMap<>();
		String state = "false";
		
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			if (info == null) {
				model.put("message", "로그인이 필요합니다.");
				return model;
			}
			
			dto.setMemberId(info.getMemberId());
			gongguProductReviewService.insertGongguReview(dto, uploadPath);
			
			state = "true";
		} catch (Exception e) {
			log.error("reviewWriteSubmit : ", e);
		}
		
		model.put("state", state);
		return model;
	}

	@PostMapping("/gonggu/updateDetailState")
	@ResponseBody
	public Map<String, Object> updateDetailState(@RequestParam long gongguOrderDetailId) {
	    Map<String, Object> model = new HashMap<>();
	    try {
	        gongguOrderService.updateDetailState(gongguOrderDetailId, 1); // 1 : 구매확정상태임
	        model.put("state", "true");
	    } catch (Exception e) {
	        model.put("state", "false");
	    }
	    return model;
	}
}
