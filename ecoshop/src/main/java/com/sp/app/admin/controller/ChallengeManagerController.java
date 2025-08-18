package com.sp.app.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.app.admin.service.ChallengeManageService;
import com.sp.app.common.MyUtil;
import com.sp.app.common.PaginateUtil;
import com.sp.app.common.StorageService;
import com.sp.app.model.Challenge;

import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/admin/challengeManage/*")
public class ChallengeManagerController {

    private final ChallengeManageService service;
    private final PaginateUtil paginateUtil;
    private final MyUtil myUtil;
    private final StorageService storageService; // 업로드 실제 경로 계산용

    /** A안 물리 경로: /uploads/challenge */
    private String uploadPath;

    @PostConstruct
    public void init() {
        // 외부 톰캣 + WAR 기준으로 getRealPath() 정상 동작
        // webapp 루트 기준: /uploads/challenge
        this.uploadPath = storageService.getRealPath("/uploads/challenge");
    }

    // 목록 + 검색/페이징
    @GetMapping("list")
    public String list(
            @RequestParam(name = "page", defaultValue = "1") int current_page,
            @RequestParam(name = "kwd", defaultValue = "") String kwd,
            @RequestParam(name = "challengeType", required = false) String challengeType, // DAILY | SPECIAL
            @RequestParam(name = "weekday", required = false) Integer weekday,            // 0~6 (DAILY일 때만)
            Model model,
            HttpServletRequest req
    ) {
        try {
            int size = 10;
            int total_page = 0;

            kwd = myUtil.decodeUrl(kwd);

            Map<String, Object> map = new HashMap<>();
            map.put("kwd", kwd);
            map.put("challengeType", challengeType);
            map.put("weekday", weekday);

            int dataCount = service.dataCount(map);
            if (dataCount != 0) {
                total_page = paginateUtil.pageCount(dataCount, size);
            }

            current_page = Math.min(current_page, Math.max(total_page, 1));

            int offset = (current_page - 1) * size;
            if (offset < 0) offset = 0;

            map.put("offset", offset);
            map.put("size", size);

            List<Challenge> list = service.listChallenge(map);

            String cp = req.getContextPath();
            String query = "";
            String listUrl = cp + "/admin/challengeManage/list";

            if (!kwd.isBlank()) query += (query.isBlank() ? "" : "&") + "kwd=" + myUtil.encodeUrl(kwd);
            if (challengeType != null && !challengeType.isBlank())
                query += (query.isBlank() ? "" : "&") + "challengeType=" + challengeType;
            if (weekday != null)
                query += (query.isBlank() ? "" : "&") + "weekday=" + weekday;

            if (!query.isBlank()) listUrl += "?" + query;

            String paging = paginateUtil.paging(current_page, total_page, listUrl);

            model.addAttribute("list", list);
            model.addAttribute("page", current_page);
            model.addAttribute("size", size);
            model.addAttribute("total_page", total_page);
            model.addAttribute("paging", paging);

            model.addAttribute("kwd", kwd);
            model.addAttribute("challengeType", challengeType);
            model.addAttribute("weekday", weekday);

        } catch (Exception e) {
            log.info("list :", e);
        }
        return "admin/challengeManage/list";
    }

    // 작성 폼
    @GetMapping("write")
    public String writeForm(Model model) {
        model.addAttribute("mode", "write");
        return "admin/challengeManage/write";
    }

    /** 작성 처리 (challenge + daily/special 분기) */
    @PostMapping("write")
    public String writeSubmit(
            Challenge dto) {
        try {
            // 파일 저장/DB 저장은 서비스에 위임 (Notice 스타일)
            service.insertChallenge(dto, uploadPath);
        } catch (Exception e) {
            log.error("writeSubmit :", e);
        }
        return "redirect:/admin/challengeManage/list";
    }

    // 상세
    @GetMapping("article")
    public String article(
    		@RequestParam("challengeId") long challengeId,
            @RequestParam(name = "page", defaultValue = "1") String page,
            @RequestParam(name = "kwd", defaultValue = "") String kwd,
            @RequestParam(name = "challengeType", required = false) String challengeType,
            Model model
    ) {
        String query = "page=" + page;
        try {
            kwd = myUtil.decodeUrl(kwd);
            if (!kwd.isBlank()) query += "&kwd=" + myUtil.encodeUrl(kwd);
            if (challengeType != null && !challengeType.isBlank()) query += "&challengeType=" + challengeType;

            Challenge dto = Objects.requireNonNull(service.findById(challengeId));

            if ("DAILY".equalsIgnoreCase(dto.getChallengeType())) {
                Challenge d = service.findDailyById(challengeId);
                if (d != null) dto.setWeekday(d.getWeekday());
            } else if ("SPECIAL".equalsIgnoreCase(dto.getChallengeType())) {
                Challenge s = service.findSpecialById(challengeId);
                if (s != null) {
                    dto.setStartDate(s.getStartDate());
                    dto.setEndDate(s.getEndDate());
                    dto.setRequireDays(s.getRequireDays());
                    dto.setSpecialStatus(s.getSpecialStatus());
                }
            }

            model.addAttribute("dto", dto);
            model.addAttribute("page", page);
            model.addAttribute("query", query);

            return "admin/challengeManage/article";
        } catch (NullPointerException e) {
            log.info("article :", e);
        } catch (Exception e) {
            log.info("article :", e);
        }
        return "redirect:/admin/challengeManage/list?" + query;
    }

    // 수정 폼
    @GetMapping("update")
    public String updateForm(
            @RequestParam("challengeId") long challengeId,
            @RequestParam(name = "page", defaultValue = "1") String page,
            Model model
    ) {
        try {
            Challenge dto = Objects.requireNonNull(service.findById(challengeId));

            if ("DAILY".equalsIgnoreCase(dto.getChallengeType())) {
                Challenge d = service.findDailyById(challengeId);
                if (d != null) dto.setWeekday(d.getWeekday());
            } else if ("SPECIAL".equalsIgnoreCase(dto.getChallengeType())) {
                Challenge s = service.findSpecialById(challengeId);
                if (s != null) {
                    dto.setStartDate(s.getStartDate());
                    dto.setEndDate(s.getEndDate());
                    dto.setRequireDays(s.getRequireDays());
                    dto.setSpecialStatus(s.getSpecialStatus());
                }
            }

            model.addAttribute("mode", "update");
            model.addAttribute("page", page);
            model.addAttribute("dto", dto);

            return "admin/challengeManage/write";
        } catch (NullPointerException e) {
            log.info("updateForm :", e);
        } catch (Exception e) {
            log.info("updateForm :", e);
        }
        return "redirect:/admin/challengeManage/list?page=" + page;
    }

    // 수정 처리
    @PostMapping("update")
    public String updateSubmit(
            Challenge dto,
            @RequestParam(name = "page", defaultValue = "1") String page) {
        try {
            // 파일 교체/기존파일 삭제 포함해서 서비스에서 처리
            service.updateChallenge(dto, uploadPath);
        } catch (Exception e) {
            log.error("updateSubmit :", e);
        }
        return "redirect:/admin/challengeManage/list?page=" + page;
    }

    // 삭제
    @GetMapping("delete")
    public String delete(
            @RequestParam("challengeId") long challengeId,
            @RequestParam(name="page", defaultValue="1") String page) {
        try {
            service.deleteChallenge(challengeId, uploadPath);
        } catch (Exception e) {
            log.error("delete : ", e);
        }
        return "redirect:/admin/challengeManage/list?page=" + page;
    }
}
