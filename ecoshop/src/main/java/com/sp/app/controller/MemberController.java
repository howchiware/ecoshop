package com.sp.app.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sp.app.model.Member;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.MemberService;

import jakarta.servlet.http.HttpServletRequest;
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
	public String loginSubmit(@RequestParam(name = "userId") String userId,
			@RequestParam(name = "password") String password, Model model, HttpSession session) {

		Map<String, Object> map = new HashMap<>();
		map.put("userId", userId);
		map.put("password", password);

		Member dto = service.loginMember(map);
		if (dto == null) {
			model.addAttribute("message", "아이디 또는 패스워드가 일치하지 않습니다.");
			return "member/login";
		}

		SessionInfo info = SessionInfo.builder().memberId(dto.getMemberId()).userId(dto.getUserId()).name(dto.getName())
				.nickname(dto.getNickname()).email(dto.getEmail()).userLevel(dto.getUserLevel()).build();

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

	@GetMapping("account")
	public String memberForm(Model model) {
		model.addAttribute("mode", "account");

		return "member/member";
	}

	@PostMapping("account")
	public String memberSubmit(Member dto, final RedirectAttributes reAttr, Model model, HttpServletRequest req) {

		try {
			service.insertMember(dto);

			StringBuilder sb = new StringBuilder();
			sb.append(dto.getName() + "님 회원가입이 완료되었습니다. 환영합니다!<br>");

			reAttr.addFlashAttribute("message", sb.toString());
			reAttr.addFlashAttribute("title", "회원가입");

			return "redirect:/member/complete";

		} catch (DuplicateKeyException e) {
			model.addAttribute("mode", "account");
			model.addAttribute("message", "아이디 중복으로 회원가입이 실패했습니다.");
		} catch (DataIntegrityViolationException e) {
			model.addAttribute("mode", "account");
			model.addAttribute("message", "제약 조건 위반으로 회원가입이 실패했습니다.");
		} catch (Exception e) {
			model.addAttribute("mode", "account");
			model.addAttribute("message", "회원가입이 실패했습니다.");
		}

		return "member/member";
	}

	@GetMapping("complete")
	public String complete(@ModelAttribute("message") String message) throws Exception {

		if (message == null || message.isBlank()) {
			return "redirect:/";
		}

		return "member/complete";
	}

	@ResponseBody
	@PostMapping("userIdCheck")
	public Map<String, ?> idCheck(@RequestParam(name = "userId") String userId) throws Exception {

		Map<String, Object> model = new HashMap<>();

		String p = "false";
		try {
			Member dto = service.findById(userId);
			if (dto == null) {
				p = "true";
			}
		} catch (Exception e) {
		}

		model.put("passed", p);

		return model;
	}

	@ResponseBody
	@PostMapping("nicknameCheck")
	public Map<String, ?> nicknameCheck(@RequestParam(name = "nickname") String nickname) throws Exception {

		Map<String, Object> model = new HashMap<>();

		String p = "false";
		try {
			Member dto = service.findByNickname(nickname);
			if (dto == null) {
				p = "true";
			}
		} catch (Exception e) {
		}

		model.put("passed", p);

		return model;
	}

	@GetMapping("pwd")
	public String pwdForm(@RequestParam(name = "dropout", required = false) String dropout, Model model) {

		if (dropout == null) {
			model.addAttribute("mode", "update");
		} else {
			model.addAttribute("mode", "dropout");
		}

		return "member/pwd";
	}
	
	@PostMapping("pwd")
	public String pwdSubmit(@RequestParam(name = "password") String password, @RequestParam(name = "mode") String mode,  final RedirectAttributes reAttr,
			Model model, HttpSession session) {

		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			if(info == null) {
				return "redirect:/";
			}
			
			Member dto = Objects.requireNonNull(service.findByMemberId(info.getMemberId()));

			if (! dto.getPassword().equals(password)) {
				model.addAttribute("mode", mode);
				model.addAttribute("message", "패스워드가 일치하지 않습니다.");
				
				return "member/pwd";
			}
			
			if (mode.equals("dropout")) {
				
				service.deleteMember(info.getMemberId());
				
				session.removeAttribute("member");
				session.invalidate();

				StringBuilder sb = new StringBuilder();
				sb.append(dto.getName() + "님의 회원 탈퇴 처리가 정상적으로 처리되었습니다.<br>");
				sb.append("메인화면으로 이동 하시기 바랍니다.<br>");

				reAttr.addFlashAttribute("title", "회원 탈퇴");
				reAttr.addFlashAttribute("message", sb.toString());

				return "redirect:/member/complete";
			}

			model.addAttribute("dto", dto);
			model.addAttribute("mode", "update");
			
			return "member/editMember";
			
		} catch (NullPointerException e) {
			session.invalidate();
		} catch (Exception e) {
			log.info("pwdSubmit: ", e);
		}
		
		return "redirect:/";
	}
	
	@GetMapping("update")
	public String updateForm(Model model, HttpSession session) {
		
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			if(info == null) {
				return "redirect:/";
			}
			
			model.addAttribute("mode", "update");
			return "member/member";
		} catch (Exception e) {
			log.info("updateForm: ", e);
		}
		
		return "member/editMember";
	}
	
	@PostMapping("update")
	public String updateSubmit(Member dto, final RedirectAttributes reAttr, Model model, HttpSession session) {
		
		StringBuilder sb = new StringBuilder();
		
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			dto.setMemberId(info.getMemberId());
			
			service.updateMember(dto);
			
			sb.append(dto.getName() + "님의 회원정보가 정상적으로 변경되었습니다.");
			
		} catch (Exception e) {
			sb.append(dto.getName() + "님의 회원정보 변경이 실패했습니다.<br>");
			sb.append("잠시후 다시 변경 하시기 바랍니다.<br>");
		}
		
		reAttr.addFlashAttribute("title", "회원 정보 수정");
		reAttr.addFlashAttribute("message", sb.toString());
		
		return "redirect:/member/complete";
	}
	
	@GetMapping("pwdFind")
	public String pwdFindForm(HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		if(info != null) {
			return "redirect:/";
		}
		
		return "member/pwdFind";
	}
	
	@PostMapping("pwdFind")
	public String pwdFindSubmit(@RequestParam(name = "userId") String userId, @RequestParam(name = "name") String name, RedirectAttributes reAttr, Model model) throws Exception {
		
		Member dto = service.findById(userId);
		if(dto == null || dto.getEmail() == null || dto.getUserLevel() == 0 || dto.getEnabled() == 0) {
		    model.addAttribute("message", "등록된 아이디가 아닙니다.");
		    return "member/pwdFind";
		}

		if (!dto.getName().equals(name)) {
		    model.addAttribute("message", "아이디 또는 이름이 일치하지 않습니다.");
		    return "member/pwdFind";
		}
		
		try {
			
			service.generatePwd(dto);
			
			StringBuilder sb = new StringBuilder();
			sb.append("회원님의 이메일로 임시 패스워드를 전송했습니다.<br>");
			sb.append("로그인 후 패스워드를 꼭 변경해주시길 바랍니다.<br>");
			
			reAttr.addFlashAttribute("title", "패스워드 찾기");
			reAttr.addFlashAttribute("message", sb.toString());
			
			return "redirect:/member/complete";
		} catch (Exception e) {
			model.addAttribute("message", "이메일 전송 실패했습니다.<br>");
			model.addAttribute("message", "잠시 후 이용부탁드립니다.<br>");
		}
		
		return "member/pwdFind";
	}
	
}
