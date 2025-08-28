package com.sp.app.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sp.app.admin.model.MemberManage;
import com.sp.app.admin.service.MemberManageService;
import com.sp.app.common.MyUtil;
import com.sp.app.common.PaginateUtil;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/admin/member/*")
public class MemberManageController {
    private final MyUtil myUtil;
    private final MemberManageService service;
    private final PaginateUtil paginateUtil;

    @GetMapping("main")
    public String memberManage(@RequestParam(name = "pageNo", defaultValue = "1") int current_page,
                                Model model) throws Exception {
        try {
            int size = 10;
            int offset = (current_page - 1) * size;
            if (offset < 0) offset = 0;

            Map<String, Object> map = new HashMap<>();
            map.put("mode", "enabled");
            map.put("offset", offset); 
            map.put("size", size);     
            
            List<MemberManage> listMember = service.listMember(map);

            model.addAttribute("listMember", listMember);
            model.addAttribute("pageNo", current_page);
        } catch (Exception e) {
            log.info("memberManage : ", e);
        }
        return "admin/member/main";
    }

    @GetMapping("list")
    public String handleHome(
            @RequestParam(name = "pageNo", defaultValue = "1") int current_page,
            @RequestParam(name = "schType", defaultValue = "") String schType,
            @RequestParam(name = "kwd", defaultValue = "") String kwd,
            @RequestParam(name = "role", defaultValue = "1") int role,
            @RequestParam(name = "enabled", defaultValue = "") String enabled,
            Model model,
            HttpServletRequest req) throws Exception {

        try {
            int size = 10;      
            int total_page = 1; 
            int dataCount = 0;

            kwd = myUtil.decodeUrl(kwd);

            Map<String, Object> map = new HashMap<>();
            map.put("role", role);
            map.put("enabled", enabled);
            map.put("schType", schType);
            map.put("kwd", kwd);

            dataCount = service.dataCount(map);

            if (dataCount > 0) {
                total_page = paginateUtil.pageCount(dataCount, size);
            }

            current_page = Math.min(current_page, total_page);
            if (current_page < 1) current_page = 1;

            int offset = (current_page - 1) * size;
            map.put("offset", offset);
            map.put("size", size);

            List<MemberManage> list = service.listMember(map);

            String paging = paginateUtil.pagingFunc(current_page, total_page, "listPage");

            model.addAttribute("list", list);
            model.addAttribute("pageNo", current_page);
            model.addAttribute("dataCount", dataCount);
            model.addAttribute("size", size);
            model.addAttribute("total_page", total_page);
            model.addAttribute("role", role);
            model.addAttribute("enabled", enabled);
            model.addAttribute("paging", paging);
            model.addAttribute("schType", schType);
            model.addAttribute("kwd", kwd);

        } catch (Exception e) {
            log.info("list", e);
            throw e;
        }

        return "admin/member/list";
    }

    @GetMapping("profile")
    public String detaileMember(@RequestParam(name = "memberId") Long memberId,
                                 @RequestParam(name = "page") String page, Model model,
                                 HttpServletResponse resp) throws Exception {

        try {
            MemberManage dto = Objects.requireNonNull(service.findById(memberId));

            model.addAttribute("dto", dto);
            model.addAttribute("page", page);

        } catch (NullPointerException e) {
            resp.sendError(410);
            throw e;
        } catch (Exception e) {
            resp.sendError(406);
            throw e;
        }
        return "admin/member/profile";
    }

    @ResponseBody
    @PostMapping("updateMember")
    public Map<String, ?> updateMember(@RequestParam Map<String, Object> paramMap) throws Exception {
        Map<String, Object> model = new HashMap<>();

        String state = "true";

        try {
            service.updateMember(paramMap);
        } catch (Exception e) {
            state = "false";
        }

        model.put("state", state);
        return model;
    }

    @GetMapping("write")
    public String writeMember(MemberManage dto, final RedirectAttributes reAttr, Model model,
                               HttpServletRequest req) throws Exception {
        try {
            Map<String, Object> map = new HashMap<>();
            map.put("mode", "enabled");

            model.addAttribute("pageNo", "1");
            model.addAttribute("mode", "write");

            return "admin/member/write";

        } catch (DuplicateKeyException e) {
            model.addAttribute("mode", "account");
            model.addAttribute("message", "아이디 중복으로 회원가입이 실패했습니다.");
        } catch (DataIntegrityViolationException e) {
            model.addAttribute("mode", "account");
            model.addAttribute("message", "제약 조건 위반으로 회원가입이 실패했습니다.");
        } catch (Exception e) {
            log.info("writeForm : ", e);
            throw e;
        }

        return "admin/member/write";
    }

    @ResponseBody
    @PostMapping("write")
    public Map<String, ?> writeSubmit(MemberManage dto, HttpSession session) throws Exception {
        Map<String, Object> model = new HashMap<>();

        String state = "false";
        try {
            service.insertMember(dto);
            state = "true";
        } catch (Exception e) {
            log.info("writeSubmit : ", e);
        }

        model.put("state", state);
        return model;
    }

    @ResponseBody
    @PostMapping("userIdCheck")
    public Map<String, ?> idCheck(@RequestParam(name = "userId") String userId) throws Exception {
        Map<String, Object> model = new HashMap<>();
        String p = "false";
        try {
            MemberManage dto = service.findById1(userId);
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
            MemberManage dto = service.findByNickname(nickname);
            if (dto == null) {
                p = "true";
            }
        } catch (Exception e) {
        }
        model.put("passed", p);
        return model;
    }
    
    @PostMapping("deleteMember")
    public String deleteMember(@RequestParam(name = "memberId") Long memberId,
                               @RequestParam(name = "name") String name,
                               RedirectAttributes redirectAttributes) {

        try {
            service.deleteMember(memberId);
            service.updateMemberEnabled(memberId);
            redirectAttributes.addFlashAttribute("message", "사용자 " + name + "(" + memberId + ") 가 정상적으로 탈퇴 처리되었습니다.");

        } catch (Exception e) {
        	log.error("deleteMember", e);
            redirectAttributes.addFlashAttribute("errorMessage", "처리 중 오류가 발생했습니다.");
        }
        
        return "redirect:/admin/member/main";
    }
}