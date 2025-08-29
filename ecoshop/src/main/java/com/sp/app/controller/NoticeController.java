package com.sp.app.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.controller.NoticeController;
import com.sp.app.model.Notice;
import com.sp.app.service.NoticeService;
import com.sp.app.common.MyUtil;
import com.sp.app.common.PaginateUtil;
import com.sp.app.common.StorageService;
import com.sp.app.exception.StorageException;

import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/notice/*")
public class NoticeController {
	private final NoticeService service;
	private final PaginateUtil paginateUtil;
	private final StorageService storageService;
	private final MyUtil myUtil;
	
	private String uploadPath;
	
	@PostConstruct
	public void init() {
		uploadPath = this.storageService.getRealPath("/uploads/notice");
	}	
	
	@GetMapping("list")
	public String list(@RequestParam(name = "page", defaultValue = "1") int current_page,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			Model model,
			HttpServletRequest req) throws Exception {
		
		try {
			int size = 10; // 한 화면에 보여주는 게시물 수
			int total_page = 0;
			int dataCount = 0;

			kwd = myUtil.decodeUrl(kwd);

			// 전체 페이지 수
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("schType", schType);
			map.put("kwd", kwd);

			dataCount = service.dataCount(map);
			if (dataCount != 0) {
				total_page = paginateUtil.pageCount(dataCount, size);
			}
			
			// 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
			current_page = Math.min(current_page, total_page);

			// 1페이지인 경우 공지리스트 가져오기
			List<Notice> noticeList = null;
			if (current_page == 1) {
				noticeList = service.listNoticeTop();
			}

			// 리스트에 출력할 데이터를 가져오기
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;

			map.put("offset", offset);
			map.put("size", size);

			// 글 리스트
			List<Notice> list = service.listNotice(map);

			String cp = req.getContextPath();
			String query = "";
			String listUrl = cp + "/notice/list";
			if (! kwd.isBlank()) { // if(kwd.length() != 0) {
				query = "schType=" + schType + "&kwd=" + myUtil.encodeUrl(kwd);
				
				listUrl += "?" + query;
			}

			String paging = paginateUtil.paging(current_page, total_page, listUrl);

			model.addAttribute("noticeList", noticeList);
			model.addAttribute("list", list);
			model.addAttribute("page", current_page);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("size", size);
			model.addAttribute("total_page", total_page);
			model.addAttribute("paging", paging);

			model.addAttribute("schType", schType);
			model.addAttribute("kwd", kwd);
			
		} catch (Exception e) {
			log.info("list : ", e);
		}
		
		return "notice/list";
	}

	@GetMapping("article/{noticeId}")
	public String article(@PathVariable(name = "noticeId") long noticeId,
			@RequestParam(name = "page") String page,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			Model model) throws Exception {

		String query = "page=" + page;
		try {
			kwd = myUtil.decodeUrl(kwd);

			if (! kwd.isBlank()) {
				query += "&schType=" + schType + "&kwd=" + myUtil.encodeUrl(kwd);
			}

			service.updateHitCount(noticeId);

			Notice dto = Objects.requireNonNull(service.findById(noticeId));

			// 이전 글, 다음 글
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("schType", schType);
			map.put("kwd", kwd);
			map.put("updateDate", dto.getUpdateDate());

			Notice prevDto = service.findByPrev(map);
			Notice nextDto = service.findByNext(map);

			// 파일
			List<Notice> listFile = service.listNoticeFile(noticeId);
			
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));

			model.addAttribute("dto", dto);
			model.addAttribute("prevDto", prevDto);
			model.addAttribute("nextDto", nextDto);
			model.addAttribute("listFile", listFile);
			model.addAttribute("page", page);
			model.addAttribute("query", query);

			return "notice/article";
			
		} catch (NullPointerException e) {
			log.info("article : ", e);
		} catch (Exception e) {
			log.info("article : ", e);
		}
		
		return "redirect:/notice/list?" + query;
	}

	
	@GetMapping("download/{noticefileId}")
	public ResponseEntity<?> download(
			@PathVariable(name = "noticefileId") long noticefileId) throws Exception {
		
		try {
			Notice dto = Objects.requireNonNull(service.findByFileId(noticefileId));

			return storageService.downloadFile(uploadPath, dto.getSaveFilename(), dto.getOriginalFilename());
			
		} catch (NullPointerException | StorageException e) {
			log.info("download : ", e);
		} catch (Exception e) {
			log.info("download : ", e);
		}
		
		String errorMessage = "<script>alert('파일 다운로드가 불가능 합니다 !!!');history.back();</script>";

		return ResponseEntity.status(HttpStatus.NOT_FOUND) // 404 상태 코드 반환
				.contentType(MediaType.valueOf("text/html;charset=UTF-8"))
				.body(errorMessage); // 에러 메시지 반환
	}

	@GetMapping("zipdownload/{noticeId}")
	public ResponseEntity<?> zipdownload(@PathVariable(name = "noticeId") long noticeId) throws Exception {
		try {
			List<Notice> listFile = service.listNoticeFile(noticeId);
			if (listFile.size() > 0) {
				String[] sources = new String[listFile.size()];
				String[] originals = new String[listFile.size()];
				String fileName = listFile.get(0).getOriginalFilename();
				String zipFilename = fileName.substring(0, fileName.lastIndexOf(".")) + "_외.zip";

				for (int idx = 0; idx < listFile.size(); idx++) {
					sources[idx] = uploadPath + File.separator + listFile.get(idx).getSaveFilename();
					originals[idx] = File.separator + listFile.get(idx).getOriginalFilename();
				}

				return storageService.downloadZipFile(sources, originals, zipFilename);
			}
			
		} catch (Exception e) {
			log.info("zipdownload : ", e);
		}
		
		String errorMessage = "<script>alert('파일 다운로드가 불가능 합니다 !!!');history.back();</script>";
		 
		return ResponseEntity.status(HttpStatus.NOT_FOUND) // 404 상태 코드 반환
				.contentType(MediaType.valueOf("text/html;charset=UTF-8")) // HTML 콘텐츠 타입 설정
				.body(errorMessage); // 에러 메시지 반환
	}

	@ResponseBody
	@PostMapping("deleteFile")
	public Map<String, ?> deleteFile(@RequestParam(name = "noticefileId") long noticefileId, 
			HttpSession session) throws Exception {
		Map<String, Object> model = new HashMap<>();

		String state = "false";
		try {
			Notice dto = Objects.requireNonNull(service.findByFileId(noticefileId));
			
			service.deleteUploadFile(uploadPath, dto.getSaveFilename());

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("field", "noticefileId");
			map.put("noticeId", noticefileId);
			
			service.deleteNoticeFile(map);
			
			state = "true";
			
		} catch (NullPointerException e) {
			log.info("deleteFile : ", e);
		} catch (Exception e) {
			log.info("deleteFile : ", e);
		}

		// 작업 결과를 json으로 전송
		model.put("state", state);
		return model;
	}


}

