package com.sp.app.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.model.Destination;
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
}
