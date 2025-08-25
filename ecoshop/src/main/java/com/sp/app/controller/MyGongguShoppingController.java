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
import com.sp.app.model.GongguLike;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.MyGongguShoppingService; 

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/myGongguShopping/*") 
public class MyGongguShoppingController {

	private final MyGongguShoppingService service; 

	@PostMapping("/gongguLike/{gongguProductId}")
	@ResponseBody
	public Map<String, ?> gongguLikeSubmit(@PathVariable(name = "gongguProductId") long gongguProductId,
			HttpSession session) throws Exception {
		Map<String, Object> model = new HashMap<>();
		String state = "false";
		
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			if (info == null) {
				model.put("message", "로그인이 필요합니다.");
				return model;
			}
			
			Map<String, Object> map = new HashMap<>();
			map.put("memberId", info.getMemberId());
			map.put("gongguProductId", gongguProductId);
			
			service.insertGongguLike(map);
			
			state = "true";
		} catch (Exception e) {
			log.error("gongguLikeSubmit : ", e);
		}
		
		model.put("state", state);
		return model;
	}
	
	@DeleteMapping("/gongguLike/{gongguProductId}")
	@ResponseBody
	public Map<String, ?> gongguLikeDelete(@PathVariable(name = "gongguProductId") Long gongguProductId,
			HttpSession session) throws Exception {
		
		Map<String, Object> model = new HashMap<>();
		String state = "false";
		
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			if (info == null) {
				model.put("message", "로그인이 필요합니다.");
				return model;
			}
			
			Map<String, Object> map = new HashMap<>();
			map.put("memberId", info.getMemberId());
			map.put("gongguProductId", gongguProductId);
			
			service.deleteGongguLike(map);
			
			state = "true";
		} catch (Exception e) {
			log.error("gongguLikeDelete : ", e);
		}
		
		model.put("state", state);
		return model;
	}
	
	@DeleteMapping("/gongguLike")
	@ResponseBody
	public Map<String, ?> gongguLikeDeleteAll(HttpSession session) throws Exception {
		
		Map<String, Object> model = new HashMap<>();
		String state = "false";
		
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			if (info == null) {
				model.put("message", "로그인이 필요합니다.");
				return model;
			}
			
			Map<String, Object> map = new HashMap<>();
			map.put("memberId", info.getMemberId());
			map.put("gongguProductId", null); 
			
			service.deleteGongguLike(map);
			
			state = "true";
		} catch (Exception e) {
			log.error("gongguLikeDeleteAll : ", e);
		}
		
		model.put("state", state);
		return model;
	}

	@GetMapping("/gongguLike")
	public String gongguLikeList(Model model,
			HttpSession session) throws Exception {
		
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			if (info == null) {
				return "redirect:/member/login"; 
			}
			
			List<GongguLike> list = service.listGongguLike(info.getMemberId());
			
			model.addAttribute("list", list);
			
		} catch (Exception e) {
			log.error("gongguLikeList : ", e);
		}
		
		return "myGongguShopping/wishList"; 
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

}
