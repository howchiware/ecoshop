package com.sp.app.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.app.model.Member;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.MemberService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/member/*")
public class MemberController {
	
	private final MemberService service;
	
	@GetMapping("login")
	public String loginForm() {
		return "member/login";
	}
	
	@PostMapping("login")
	public String loginSubmit(@RequestParam(name = "userId") String userId, @RequestParam(name = "password") String password,
							Model model, HttpSession session) {
		
		Map<String, Object> map = new HashMap<>();
		map.put("userId", userId);
		map.put("password", password);
		
		Member dto = service.loginMember(map);
		if(dto == null) {
			model.addAttribute("message", "아이디 또는 패스워드가 일치하지 않습니다.");
			return "member/login";
		}
		
		SessionInfo info = SessionInfo.builder()
				.memberId(dto.getMemberId())
				.userId(dto.getUserId())
				.name(dto.getName())
				.nickname(dto.getNickname())
				.email(dto.getEmail())
				.userLevel(dto.getUserLevel())
				.build();
		
		session.setMaxInactiveInterval(30 * 60);
		
		session.setAttribute("member", info);
		
		String uri = (String) session.getAttribute("preLoginURI");
		session.removeAttribute("preLoginURI");
		if (uri == null) {
			uri = "redirect:/";
		} else {
			uri = "redirect:" + uri;
		}

		return uri;
	}
	
	@GetMapping("logout")
	public String logout(HttpSession session) {
		session.removeAttribute("member");
		
		session.invalidate();
		
		return "redirect:/";
	}

}
