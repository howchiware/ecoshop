package com.sp.app.controller;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.common.PaginateUtil;
import com.sp.app.model.Challenge;
import com.sp.app.service.ChallengeService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/free")
public class ChallengeTalkController {

	private final ChallengeService service;
	private final PaginateUtil paginateUtil;

	@GetMapping("/challengeList")
	public String challengeTalk(@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "size", defaultValue = "12") int size,
			@RequestParam(name = "sort", defaultValue = "RECENT") String sort,
			@RequestParam(name = "kwd", required = false) String kwd, HttpServletRequest req, Model model) {

		// 1) 총건수/페이지 계산
		int dataCount = service.countPublicSpecialPosts(kwd);
		int totalPage = paginateUtil.pageCount(dataCount, size);
		if (totalPage == 0)
			totalPage = 1;
		if (page > totalPage)
			page = totalPage;
		if (page < 1)
			page = 1;

		// 2) 목록
		int offset = (page - 1) * size;
		List<Challenge> list = service.listPublicSpecialPostsPaged(offset, size, sort, kwd);

		// 3) 페이징 베이스 URL 생성 (page 제외 파라미터만 유지)
		StringBuilder base = new StringBuilder(req.getContextPath()).append("/free/challengeList").append("?size=")
				.append(size).append("&sort=").append(URLEncoder.encode(sort, StandardCharsets.UTF_8));
		if (kwd != null && !kwd.isBlank()) {
			base.append("&kwd=").append(URLEncoder.encode(kwd, StandardCharsets.UTF_8));
		}

		String paging = paginateUtil.pagingUrl(page, totalPage, base.toString());

		model.addAttribute("list", list);
		model.addAttribute("paging", paging);
		model.addAttribute("page", page);
		model.addAttribute("size", size);
		model.addAttribute("sort", sort);
		model.addAttribute("kwd", kwd);

		return "free/challengeList";
	}

	@GetMapping("/challengeList/{postId}")
	public String challengeTalkArticle(
			@PathVariable("postId") long postId, 
			@RequestParam(name="src", required=false) String src,
			Model model) {
		// 공개된 인증글만 조회 (승인 1, 공개Y, 스페셜)
		Challenge post = service.findPublicSpecialPost(postId);
		if (post == null)
			
			return "redirect:/free/challengeBundles"; // 없는 글이면 번들로
		
		List<String> photos = service.listPostPhotos(postId);
		
		// prev/next
	    Long prevPostId = service.getPrevPostId(post.getParticipationId(), post.getDayNumber());
	    Long nextPostId = service.getNextPostId(post.getParticipationId(), post.getDayNumber());

	    // 요약 불러오기
	    Challenge summary = service.getChallengeSummary(post.getChallengeId());
		
	    model.addAttribute("post", post);
	    model.addAttribute("photos", photos);
	    model.addAttribute("prevPostId", prevPostId);
	    model.addAttribute("nextPostId", nextPostId);
	    model.addAttribute("challengeSummary", summary); // ← 통일
	    model.addAttribute("src", src);

	    return "free/challengeArticle";
	}

	@GetMapping("/challengeBundles")
	public String challengeBundlesPage() {
		return "free/challengeBundles";
	}

	@GetMapping("/challengeBundles/feed")
	@ResponseBody
	public List<Challenge> challengeBundlesFeed(
			@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "size", defaultValue = "12") int size, 
			@RequestParam(name = "sort", defaultValue = "RECENT") String sort) {
		int offset = (Math.max(page, 1) - 1) * size;
		return service.listSpecialBundlesPaged(offset, size, sort);
	}

	@GetMapping("/challengeBundles/thread")
	@ResponseBody
	public List<Challenge> challengeBundlesThread(
			@RequestParam(name = "participationId") long participationId) {
		return service.listPublicThreadByParticipation(participationId);
	}

}
