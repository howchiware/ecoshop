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
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.model.Destination;
import com.sp.app.model.ProductLike;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.MyShoppingService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/myShopping/*")
public class MyShoppingController {
	private final MyShoppingService service;
	
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
	
	// 찜 리스트
	@GetMapping("productLike")
	public String productLikeList(Model model,
			HttpSession session) throws Exception {
		
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");

			List<ProductLike> list = service.listProductLike(info.getMemberId());
			
			model.addAttribute("list", list);
			
		} catch (Exception e) {
			log.info("productLikeList : ", e);
		}
		
		return "myShopping/wishList";
	}
	
}
