package com.sp.app.admin.controller;
	
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
	
import com.sp.app.admin.model.AdvertisementManage;

import com.sp.app.admin.service.AdvertisementManageService;
import com.sp.app.common.MyUtil;
import com.sp.app.common.PaginateUtil;
import com.sp.app.common.StorageService;
import com.sp.app.exception.StorageException;

import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
	
	@Controller
	@RequiredArgsConstructor
	@Slf4j
	@RequestMapping(value = "/admin/advertisement/*")
	public class AdvertisementManageController {
	    private final MyUtil myUtil;
		private final AdvertisementManageService service;
		private final PaginateUtil paginateUtil;
		private final StorageService storageService;
		
		private String uploadPath;
		
		@PostConstruct
		public void init() {
			uploadPath = this.storageService.getRealPath("/uploads/advertisement");
		}	
	
		@GetMapping("list")
		public String advertisementManage(
				@RequestParam(name = "pageNo", defaultValue = "1") int current_page,
				Model model) throws Exception{
			try {
				int size = 10;
				int offset = (current_page - 1) * size;
	            if (offset < 0) offset = 0;
	
	            Map<String, Object> map = new HashMap<>();
	            map.put("offset", offset); 
	            map.put("size", size);  
	            
	            List<AdvertisementManage> listAdvertisement = service.listAdvertisement(map);
	            
	            model.addAttribute("listAdvertisement",listAdvertisement);
	            model.addAttribute("pageNo", current_page);
			} catch (Exception e) {
				log.info("advertisementManage : ", e);
			}
			return "admin/advertisement/list";
		}
		
		// 신청
		@GetMapping("result")
	    public String handleHome(
	    		 @RequestParam(name = "pageNo", defaultValue = "1") int current_page, 
	    	        @RequestParam(name = "schType", defaultValue = "") String schType,
	    	        @RequestParam(name = "kwd", defaultValue = "") String kwd,
	    	        @RequestParam(name = "role", defaultValue = "1") int role, 
	            Model model,
	            HttpServletRequest req) throws Exception {
	
	        try {
	            int size = 10;      
	            int total_page = 1; 
	            int dataCount = 0;
	
	            kwd = myUtil.decodeUrl(kwd);
	
	            Map<String, Object> map = new HashMap<>();
	            map.put("role", role);
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
	
	            List<AdvertisementManage> list = service.listAdvertisement(map);
	
	            String paging = paginateUtil.pagingMethod(current_page, total_page, "listPage");
	
	            model.addAttribute("list", list);
	            model.addAttribute("pageNo", current_page);
	            model.addAttribute("dataCount", dataCount);
	            model.addAttribute("size", size);
	            model.addAttribute("total_page", total_page);
	            model.addAttribute("role", role);
	            model.addAttribute("paging", paging);
	            model.addAttribute("schType", schType);
	            model.addAttribute("kwd", kwd);
	
	        } catch (Exception e) {
	            log.info("list", e);
	            throw e;
	        }
	
	        return "admin/advertisement/result";
	    }
		
		// 신청 목록
		@GetMapping("application")
	    public String application(
	    		 @RequestParam(name = "page", defaultValue = "1") int current_page, 
	    	        @RequestParam(name = "schType", defaultValue = "") String schType,
	    	        @RequestParam(name = "kwd", defaultValue = "") String kwd,
	    	        @RequestParam(name = "role", defaultValue = "3") int role, 
	            Model model,
	            HttpServletRequest req) throws Exception {
	
	        try {
	            int size = 10;      
	            int total_page = 1; 
	            int dataCount = 0;
	
	            kwd = myUtil.decodeUrl(kwd);
	
	            Map<String, Object> map = new HashMap<>();
	            map.put("role", role);
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
	
	            List<AdvertisementManage> list = service.listAdvertisement(map);
	
	            String paging = paginateUtil.pagingMethod(current_page, total_page, "listPage");
	
	            model.addAttribute("list", list);
	            model.addAttribute("pageNo", current_page);
	            model.addAttribute("dataCount", dataCount);
	            model.addAttribute("size", size);
	            model.addAttribute("total_page", total_page);
	            model.addAttribute("role", role);
	            model.addAttribute("paging", paging);
	            model.addAttribute("schType", schType);
	            model.addAttribute("kwd", kwd);
	
	        } catch (Exception e) {
	            log.info("list", e);
	            throw e;
	        }
	
	        return "admin/advertisement/application";
	    }
		
		@PostMapping("updateStatus")
		@ResponseBody
		public Map<String, Object> updateStatus(
		        @RequestParam("advertisingId") long advertisingId,
		        @RequestParam("status") int status) {
	
		    Map<String, Object> result = new HashMap<>();
		    try {
		        Map<String, Object> map = new HashMap<>();
		        map.put("advertisingId", advertisingId);
		        map.put("status", status);
	
		        service.updateStatus(map);
	
		        result.put("success", true);
		    } catch (Exception e) {
		        result.put("success", false);
		        result.put("message", e.getMessage());
		    }
	
		    return result;
		}
		
		 @GetMapping("profile")
		    public String detaileAdvertisement(@RequestParam(name = "advertisingId") Long advertisingId,
		                                 @RequestParam(name = "page") String page,
		                                 @RequestParam(name = "schType", defaultValue = "all") String schType,
		                     			 @RequestParam(name = "kwd", defaultValue = "") String kwd,
		                                 Model model, HttpServletResponse resp) throws Exception {
		        try {
		        	AdvertisementManage dto = Objects.requireNonNull(service.findById(advertisingId));
		        	 List<AdvertisementManage> listFile = service.listAdvertisementFile(advertisingId);
		        	 
		            model.addAttribute("dto", dto);
		            model.addAttribute("page", page);
		            model.addAttribute("listFile", listFile);
		           
		            
	
		        } catch (NullPointerException e) {
		            resp.sendError(410);
		            throw e;
		        } catch (Exception e) {
		            resp.sendError(406);
		            throw e;
		        }
		        return "admin/advertisement/profile";
		    }
		 
		 @ResponseBody
		 @PostMapping("updateAdvertisement")
		 public Map<String, ?> updateAdvertisement(@RequestParam Map<String, Object> paramMap) throws Exception {
		     Map<String, Object> model = new HashMap<>();
		     String state = "true";
		     try {
		         service.updateAdvertisement(paramMap);
		     } catch (Exception e) {
		         state = "false";
		     }
		     model.put("state", state);
		     return model;
		 }
		 
		 @GetMapping("download/{advertisingFileNum}")
			public ResponseEntity<?> download(
					@PathVariable(name = "advertisingFileNum") long advertisingFileNum) throws Exception {
				
				try {
					AdvertisementManage dto = Objects.requireNonNull(service.findByFileId(advertisingFileNum));

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
		 
	
	}
