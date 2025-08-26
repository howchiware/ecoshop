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

import com.sp.app.model.Destination;
import com.sp.app.model.GongguOrder;
import com.sp.app.model.GongguProductDeliveryRefundInfo;
import com.sp.app.model.Member;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.GongguOrderService;
import com.sp.app.service.GongguService;
import com.sp.app.service.MemberService;
import com.sp.app.service.MyGongguShoppingService;

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
	
	@RequestMapping(name = "payment", method = {RequestMethod.GET, RequestMethod.POST})
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
	        
	        if (gongguOrderService.didIBuyGonggu(map)) {
	            model.addAttribute("message", "이미 구매가 완료되었습니다.");
	            model.addAttribute("gongguProductId", gongguProductId);
	            return "gonggu/gongguProductInfo"; 
	        }
	        
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
                deliveryCharge = totalAmount >= 30000 ? 0 : listDeliveryFee.get(0).getDeliveryFee();
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
}
