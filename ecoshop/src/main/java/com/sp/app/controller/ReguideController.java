	package com.sp.app.controller;
	
	import java.util.HashMap;
	import java.util.List;
	import java.util.Map;
	import java.util.Objects;
	
	import org.springframework.stereotype.Controller;
	import org.springframework.ui.Model;
	import org.springframework.web.bind.annotation.GetMapping;
	import org.springframework.web.bind.annotation.PostMapping;
	import org.springframework.web.bind.annotation.RequestMapping;
	import org.springframework.web.bind.annotation.RequestParam;
	import org.springframework.web.bind.annotation.ResponseBody;
	
	import com.sp.app.common.MyUtil;
	import com.sp.app.common.PaginateUtil;
	import com.sp.app.common.StorageService;
	import com.sp.app.model.Reguide;
	import com.sp.app.model.ReguideCategory;
	import com.sp.app.model.SessionInfo;
	import com.sp.app.service.ReguideService;
	
	import jakarta.annotation.PostConstruct;
	import jakarta.servlet.http.HttpServletRequest;
	import jakarta.servlet.http.HttpSession;
	import lombok.RequiredArgsConstructor;
	import lombok.extern.slf4j.Slf4j;
	
	@Controller
	@RequiredArgsConstructor
	@Slf4j
	@RequestMapping("/reguide/*")
	public class ReguideController {
		private final StorageService storageService;
		private final PaginateUtil paginateUtil;
		private final MyUtil myUtil;
		private final ReguideService service;
		
		private String uploadPath;
		
		 @PostConstruct
			public void init() {
				uploadPath = this.storageService.getRealPath("/uploads/reguide");		
			}
		
		 @GetMapping("list")
		 public String list(@RequestParam(name = "page", defaultValue = "1") int current_page,
		                    @RequestParam(name = "schType", defaultValue = "all") String schType,
		                    @RequestParam(name = "kwd", defaultValue = "") String kwd,
		                    @RequestParam(name = "size", defaultValue = "9") int size,
		                    Model model,
		                    HttpServletRequest req) throws Exception {
	
		     try {
		         kwd = myUtil.decodeUrl(kwd);
		         
		         int total_page = 0;
				 int dataCount = 0;

				 
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("schType", schType);
				map.put("kwd", kwd);
				
				 
				dataCount = service.dataCount(map);
				total_page = paginateUtil.pageCount(dataCount, size);
				current_page = Math.min(current_page, total_page);
		
		         int offset = (current_page - 1) * size;
		         if(offset < 0) offset = 0;
	
		         map.put("offset", offset);
		         map.put("size", size);
	
		         List<Reguide> list = service.listReguide(map);
	
		         String cp = req.getContextPath();

				 String listUrl = cp + "/reguide/list";
				 String articleUrl = cp + "/reguide/article?page=" + current_page;
	
		         // 쿼리 문자열 안전하게 생성
		         StringBuilder queryBuilder = new StringBuilder();
		         queryBuilder.append("page=").append(current_page);
		         queryBuilder.append("&size=").append(size);
		         if (!kwd.isBlank()) {
		             queryBuilder.append("&schType=").append(schType);
		             queryBuilder.append("&kwd=").append(myUtil.encodeUrl(kwd));
		         }

		         String paging = paginateUtil.paging(current_page, total_page, listUrl);
	
		         model.addAttribute("list", list);
		         model.addAttribute("dataCount", dataCount);
		         model.addAttribute("size", size);
		         model.addAttribute("page", current_page);
		         model.addAttribute("total_page", total_page);
		         model.addAttribute("articleUrl", articleUrl);
		         model.addAttribute("paging", paging);
		         model.addAttribute("schType", schType);
		         model.addAttribute("kwd", kwd);
	
		     } catch (Exception e) {
		         log.info("list : ", e);
		     }
	
		     return "reguide/list";
		 }
		
		@GetMapping("write")
		public String writeForm(Model model) throws Exception {
		    model.addAttribute("mode", "write");
	
		    List<ReguideCategory> categories = service.listCategory();
		    model.addAttribute("categories", categories);
	
		    model.addAttribute("dto", new Reguide());
	
		    return "reguide/write";
		}
		
		@PostMapping("write")
		public String writeSubmit(Reguide dto, HttpSession session) throws Exception {
			try {
				SessionInfo info = (SessionInfo) session.getAttribute("member");
				
				dto.setMemberId(info.getMemberId());
				
				service.insertReguide(dto, uploadPath, "write");
				
			} catch (Exception e) {
				log.info("writeSubmit : ", e);
			}
	
			return "redirect:/reguide/list";
		}
		
		@GetMapping("addCategory")
		public String addCategoryForm() {
		    return "reguide/category"; 
		}
		
		@PostMapping("addCategory")
		@ResponseBody
		public Map<String, Object> addCategory(@RequestParam("categoryName") String categoryName) {
		    Map<String, Object> result = new HashMap<>();
		    try {
		        ReguideCategory dto = new ReguideCategory();
		        dto.setCategoryName(categoryName);
		        service.insertCategory(dto); 
	
		        result.put("state", "success");
		        result.put("newCategoryCode", dto.getCategoryCode());
		        result.put("newCategoryName", categoryName);
		    } catch (Exception e) {
		        log.info("addCategory : ", e);
		        result.put("state", "fail");
		    }
		    return result;
		}
		
		@GetMapping("article")
		public String article(@RequestParam(name = "guidId") long guidId,
		                      @RequestParam(name = "page", defaultValue = "1") int page,
		                      @RequestParam(name = "schType", defaultValue = "all") String schType,
		                      @RequestParam(name = "kwd", defaultValue = "") String kwd,
		                      @RequestParam(name = "size", defaultValue = "9") int size,
		                      Model model,
		                      HttpSession session) throws Exception {
	
		    kwd = myUtil.decodeUrl(kwd);
	
		    StringBuilder queryBuilder = new StringBuilder();
		    queryBuilder.append("page=").append(page);
		    queryBuilder.append("&size=").append(size);
		    if (!kwd.isBlank()) {
		        queryBuilder.append("&schType=").append(schType);
		        queryBuilder.append("&kwd=").append(myUtil.encodeUrl(kwd));
		    }
		    String query = queryBuilder.toString();
	
		    service.updateHitCount(guidId);
	
		    Reguide dto = Objects.requireNonNull(service.findById(guidId));
	
		    Map<String, Object> map = new HashMap<>();
		    map.put("schType", schType);
		    map.put("kwd", kwd);
		    map.put("guidId", guidId);
	
		    Reguide prevDto = service.findByPrev(map);
		    Reguide nextDto = service.findByNext(map);
	
		    model.addAttribute("dto", dto);
		    model.addAttribute("prevDto", prevDto);
		    model.addAttribute("nextDto", nextDto);
		    model.addAttribute("query", query); // <-- 이걸 그대로 JSP에서 사용
		    model.addAttribute("page", page);
		    model.addAttribute("size", size);
	
		    return "reguide/article";
		}
	
		
		@GetMapping("update")
		public String updateForm(@RequestParam(name = "guidId") long guidId,
				@RequestParam(name = "page") String page,
				@RequestParam(name = "size") int size,
				Model model,
				HttpSession session) throws Exception {
			
			try {
				SessionInfo info = (SessionInfo) session.getAttribute("member");
	
				Reguide dto = Objects.requireNonNull(service.findById(guidId));
				if (dto.getMemberId() != info.getMemberId()) {
					return "redirect:/reguide/list?page=" + page + "&size=" + size;
				}
				
				List<ReguideCategory> categories = service.listCategory(); 
		        model.addAttribute("categories", categories);      
	
				model.addAttribute("dto", dto);
				model.addAttribute("page", page);
				model.addAttribute("size", size);
				model.addAttribute("mode", "update");
	
				return "reguide/write";
				
			} catch (NullPointerException e) {
				log.info("updateForm : ", e);
			} catch (Exception e) {
				log.info("updateForm : ", e);
			}
			
			return "redirect:/reguide/list?page=" + page + "&size=" + size;
		}
		
		@PostMapping("update")
		public String updateSubmit(Reguide dto,
				@RequestParam(name = "size") int size,
				@RequestParam(name = "page") String page,
				HttpSession session) throws Exception {
	
			SessionInfo info = (SessionInfo) session.getAttribute("member");
	
			try {
				dto.setMemberId(info.getMemberId());
				service.updateReguide(dto, uploadPath);
			} catch (Exception e) {
				log.info("updateSubmit : ", e);
			}
	
			return "redirect:/reguide/list?page=" + page + "&size=" + size;
		}
		
		@GetMapping("delete")
		public String delete(@RequestParam(name = "guidId") long guidId,
				@RequestParam(name = "page") String page,
				@RequestParam(name = "schType", defaultValue = "all") String schType,
				@RequestParam(name = "kwd", defaultValue = "") String kwd,
				HttpSession session) throws Exception {
	
			String query = "page=" + page ;
			try {
				kwd = myUtil.decodeUrl(kwd);
				if (! kwd.isBlank()) {
					query += "&schType=" + schType + "&kwd=" + myUtil.encodeUrl(kwd);
				}
				
				SessionInfo info = (SessionInfo) session.getAttribute("member");
				
				service.deleteReguide(guidId, info.getMemberId(), info.getUserLevel(), uploadPath, query);
				
			} catch (Exception e) {
				log.info("delete : ", e);
			}
	
			return "redirect:/reguide/list?" + query;
		}
		
		
		
	}
