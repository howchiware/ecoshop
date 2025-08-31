package com.sp.app.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.sp.app.common.MyUtil;
import com.sp.app.common.PaginateUtil;
import com.sp.app.common.StorageService;
import com.sp.app.mapper.PointMapper;
import com.sp.app.mapper.WorkshopMapper;
import com.sp.app.model.Participant;
import com.sp.app.model.Point;
import com.sp.app.model.Workshop;
import com.sp.app.model.WorkshopFaq;
import com.sp.app.service.WorkshopService;

import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/admin/workshop")
public class WorkshopManageController {
	private final WorkshopService service;
	private final MyUtil myUtil;
	private final StorageService storageService;
	private final WorkshopMapper workshopMapper;
	private final PointMapper pointMapper;
	private final PaginateUtil paginateUtil;

	private String uploadPath;

	@PostConstruct
	public void init() {
		uploadPath = this.storageService.getRealPath("/uploads/workshop");
	}

	@GetMapping("/category/manage")
	public String categoryManage(
	        @RequestParam(name = "page", defaultValue = "1") int current_page,
	        Model model,
	        HttpServletRequest req) {

	    try {
	        int size = 10;
	        int total_page = 0;
	        int offset = (Math.max(current_page, 1) - 1) * size;

	        Map<String, Object> pmap = new HashMap<>();
	        pmap.put("offset", offset);
	        pmap.put("size", size);

	        // 전체 데이터 개수
	        int dataCount = service.categoryDataCount(pmap);
	        if (dataCount > 0) {
	            total_page = paginateUtil.pageCount(dataCount, size);
	        }

	        if (current_page > total_page) {
	            current_page = total_page > 0 ? total_page : 1; // 최소 1페이지 보정
	        }
	        
	        offset = (current_page - 1) * size;
	        if (offset < 0) offset = 0;
	        pmap.put("offset", offset);

	        // 목록
	        List<Workshop> categoryList = service.listCategory(pmap);

	        // 페이징 처리
	        String cp = req.getContextPath();
	        String listUrl = cp + "/admin/workshop/category/manage";
	        String paging = paginateUtil.pagingUrl(current_page, total_page, listUrl);

	        model.addAttribute("page", current_page);
	        model.addAttribute("size", size);
	        model.addAttribute("categoryList", categoryList);
	        model.addAttribute("dataCount", dataCount);
	        model.addAttribute("paging", paging);

	    } catch (Exception e) {
	        log.info("categoryManage : ", e);
	        model.addAttribute("page", 1);
	        model.addAttribute("categoryList", List.of());
	        model.addAttribute("dataCount", 0);
	        model.addAttribute("paging", "");
	    }

	    return "admin/workshop/categoryManage";
	}

	// 카테고리 등록
	@PostMapping("/category/write")
	public String addCategory(Workshop dto, 
			@RequestParam("categoryName") String categoryName, 
			@RequestParam(value = "isActive", required = false) Integer isActive,
			HttpSession session) {
		try {
			String name = categoryName == null ? "" : categoryName.trim();
			if(name.isEmpty()) throw new IllegalAccessException();
			
			dto.setCategoryName(name);
			dto.setIsActive(isActive == null ? 1 : (isActive == 1 ? 1 : 0));
			
			service.insertCategory(dto);
			session.setAttribute("msg", "카테고리가 등록되었습니다.");
		} catch (Exception e) {
			log.info("addCategory : ", e);
			session.setAttribute("msg", "카테고리 등록에 실패했습니다.");
		}
		return "redirect:/admin/workshop/category/manage";
	}
	
	// 카테고리 토글
	@PostMapping("/category/toggle")
	@ResponseBody
	public Map<String, Object> toggleCategory(@RequestParam (name = "categoryId") Long categoryId,
	                                          @RequestParam (name = "isActive") Integer isActive) {
	    try {
	        int status = (isActive != null && isActive == 1) ? 1 : 0;
	        service.categoryActive(categoryId, status);
	        return Map.of("success", true, "message", "상태가 변경되었습니다.");
	    } catch (Exception e) {
	        log.error("toggleCategory :", e);
	        return Map.of("success", false, "message", "상태 변경에 실패했습니다.");
	    }
	}


	// 카테고리 수정
	@PostMapping("/category/update")
	public String updateCategory(Workshop dto, 
			@RequestParam(name = "categoryId") Long categoryId,
			@RequestParam(name = "categoryName") String categoryName,
			@RequestParam(value = "isActive", required = false) Integer isActive,
			HttpSession session) {
		try {
			String name = categoryName == null ? "" : categoryName.trim();
			if(name.isEmpty()) throw new IllegalAccessException();
			
			dto.setCategoryId(categoryId);
	        dto.setCategoryName(name);
	        dto.setIsActive(isActive == null ? 1 : (isActive == 1 ? 1 : 0));
			
			service.updateCategory(dto);
			session.setAttribute("msg", "카테고리가 수정되었습니다.");
		} catch (Exception e) {
			log.info("writeSubmitProgram : ", e);
			session.setAttribute("msg", "카테고리 등록에 실패했습니다.");
		}

		return "redirect:/admin/workshop/category/manage";
	}

	// 카테고리 삭제
	@PostMapping("/category/delete")
	public String deleteCategory(@RequestParam(name = "categoryId") Long categoryId, HttpSession session)
			throws Exception {
		try {
			service.deleteCategory(categoryId);
			session.setAttribute("msg", "카테고리가 삭제되었습니다.");
		} catch (Exception e) {
			log.info("deleteCategory : ", e);
			session.setAttribute("msg", "카테고리 삭제에 실패했습니다.");
		}

		return "redirect:/admin/workshop/category/manage";
	}

	// 프로그램 등록 폼
	@GetMapping("/program/write")
	public String programWriteForm(Model model) {
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("offset", 0);
			map.put("size", 200);

			List<Workshop> category = service.listCategory(map);

			model.addAttribute("category", category);
			model.addAttribute("mode", "write");
		} catch (Exception e) {
			log.info("program writeForm : ", e);
		}

		return "admin/workshop/programWrite";
	}

	// 프로그램 등록
	@PostMapping("/program/write")
	public String writeSubmitProgram(Workshop dto, HttpSession session) throws Exception {
		try {
			service.insertProgram(dto);
		} catch (Exception e) {
			log.info("program writeSubmit : ", e);
		}
		return "redirect:/admin/workshop/program/list";
	}

	// 프로그램 목록
	@GetMapping("/program/list")
	public String programList(@RequestParam(name = "page", defaultValue = "1") int current_page,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			@RequestParam(name = "categoryId", required = false) Long categoryId, Model model,
			HttpServletRequest req) {

		try {
			kwd = myUtil.decodeUrl(kwd);

			int size = 10;
			int total_page = 0;
			int offset = (current_page - 1) * size;
			if (offset < 0)
				offset = 0;

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("offset", offset);
			map.put("size", size);

	        int dataCount = service.programDataCount(map);
	        if (dataCount > 0) {
	            total_page = paginateUtil.pageCount(dataCount, size);
	        }
	        
	        if (current_page > total_page) {
	            current_page = total_page > 0 ? total_page : 1;
	        }

			if (!kwd.isBlank())
				map.put("kwd", kwd);
			if (categoryId != null)
				map.put("categoryId", categoryId);

			List<Workshop> list = service.listProgram(map);

			// 카테고리 드롭다운
			Map<String, Object> cmap = new HashMap<String, Object>();
			cmap.put("offset", 0);
			cmap.put("size", 200);
			List<Workshop> category = service.listCategory(cmap);
			
			 String cp = req.getContextPath();
		        String listUrl = cp + "/admin/workshop/program/list";
		        String paging = paginateUtil.pagingUrl(current_page, total_page, listUrl);
		        
		    model.addAttribute("paging", paging);
		    model.addAttribute("dataCount", dataCount);
			model.addAttribute("list", list);
			model.addAttribute("page", current_page);
			model.addAttribute("size", size);
			model.addAttribute("kwd", kwd);
			model.addAttribute("categoryId", categoryId);
			model.addAttribute("category", category);

		} catch (Exception e) {
			log.info("programList : ", e);
		}

		return "admin/workshop/programList";
	}

	@GetMapping("/program/detail")
	public String programDetail(@RequestParam(name = "num") long num,
			@RequestParam(name = "page", defaultValue = "1") String current_page,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			@RequestParam(name = "categoryId", required = false) Long categoryId, Model model) {

		Workshop dto = service.findProgramById(num);

		model.addAttribute("dto", dto);
		model.addAttribute("page", current_page);
		model.addAttribute("schType", schType);
		model.addAttribute("kwd", kwd);
		model.addAttribute("categoryId", categoryId);

		return "admin/workshop/programDetail";
	}

	// 프로그램 수정
	@GetMapping("/program/update")
	public String updateFormProgram(@RequestParam(name = "num") long num, @RequestParam(name = "page") String page,
			Model model) throws Exception {
		try {
			Workshop dto = Objects.requireNonNull(service.findProgramById(num));

			Map<String, Object> map = new HashMap<>();
			map.put("offset", 0);
			map.put("size", 200);

			List<Workshop> categoryList = service.listCategory(map);

			model.addAttribute("category", categoryList);
			model.addAttribute("dto", dto);
			model.addAttribute("mode", "update");
			model.addAttribute("page", page);

			return "admin/workshop/programWrite";
		} catch (NullPointerException e) {
		} catch (Exception e) {
			log.info("update Program : ", e);
		}

		return "redirect:/admin/workshop/program/list?page=" + page;
	}

	@PostMapping("/program/update")
	public String updateSubmitProgram(Workshop dto, @RequestParam(name = "page", defaultValue = "1") String page)
			throws Exception {
		try {
			service.updateProgram(dto);
		} catch (Exception e) {
			log.info("update Program : ", e);
			throw e;
		}

		return "redirect:/admin/workshop/program/list?page=" + page;
	}

	// 프로그램 삭제
	@PostMapping("/program/delete")
	public String deleteProgram(@RequestParam(name = "num") long num,
			@RequestParam(name = "page", defaultValue = "1") String page,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd) throws Exception {
		String query = "page=" + page;
		try {
			kwd = myUtil.decodeUrl(kwd);
			if (!kwd.isBlank()) {
				query += "&schType=" + schType + "&kwd=" + myUtil.encodeUrl(kwd);
			}

			service.deleteProgram(num);
		} catch (Exception e) {
			log.info("delete Program : ", e);
			throw e;
		}

		return "redirect:/admin/workshop/program/list?" + query;
	}

	// 담당자 등록
	@PostMapping("/manager/write")
	public String addManager(Workshop dto) {
		try {
			service.insertManager(dto);
		} catch (Exception e) {
			log.info("workshop addManager : ", e);
		}

		return "redirect:/admin/workshop/manager/list";
	}

	// 담당자 목록
	@GetMapping("/manager/list")
	public String managerList(@RequestParam(name = "page", defaultValue = "1") int current_page,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			@RequestParam(name = "managerId", required = false) Long managerId, 
			HttpServletRequest req, Model model) throws Exception {

		try {
			kwd = myUtil.decodeUrl(kwd);

			int size = 10;
			int total_page = 0;
			int offset = (current_page - 1) * size;
			if (offset < 0)
				offset = 0;

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("schType", schType);
			map.put("offset", offset);
			map.put("size", size);

			if (!kwd.isBlank())
				map.put("kwd", kwd);
			if (managerId != null)
				map.put("managerId", managerId);
			
	        int dataCount = service.managerDataCount(map);
	        if (dataCount > 0) {
	            total_page = paginateUtil.pageCount(dataCount, size);
	        }

	        if (current_page > total_page) {
	            current_page = total_page > 0 ? total_page : 1; 
	        }

			List<Workshop> list = service.listManager(map);
			
			 String cp = req.getContextPath();
		     String listUrl = cp + "/admin/workshop/manager/list";
		     String paging = paginateUtil.pagingUrl(current_page, total_page, listUrl);

			model.addAttribute("list", list);
			model.addAttribute("page", current_page);
			model.addAttribute("size", size);
			model.addAttribute("kwd", kwd);
			model.addAttribute("managerId", managerId);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("paging", paging);

		} catch (Exception e) {
			log.info("manager List : ", e);
			throw e;
		}

		return "admin/workshop/managerList";
	}

	@PostMapping("/manager/update")
	public String updateSubmitManager(Workshop dto, @RequestParam(name = "page", defaultValue = "1") String page)
			throws Exception {
		try {
			service.updateManager(dto);
		} catch (Exception e) {
			log.info("update Manager : ", e);
			throw e;
		}

		return "redirect:/admin/workshop/manager/list?page=" + page;
	}

	// 담당자 삭제
	@PostMapping("/manager/delete")
	public String deleteManager(@RequestParam(name = "num") long num,
			@RequestParam(name = "page", defaultValue = "1") String page,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd) throws Exception {

		String query = "page=" + page;

		try {
			kwd = myUtil.decodeUrl(kwd);
			if (!kwd.isBlank()) {
				query += "&schType=" + schType + "&kwd=" + myUtil.encodeUrl(kwd);
			}

			service.deleteManager(num);
		} catch (Exception e) {
			log.info("delete Program : ", e);
			throw e;
		}

		return "redirect:/admin/workshop/manager/list?" + query;
	}

	// 워크샵 목록
	@GetMapping("/list")
	public String workshopList(@RequestParam(name = "page", defaultValue = "1") int current_page,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "workshopStatus", required = false) String workshopStatus,
			@RequestParam(name = "kwd", defaultValue = "") String kwd, Model model, HttpServletRequest req)
			throws Exception {
		try {
			int size = 10;
			int total_page = 0;
			int dataCount = 0;

			kwd = myUtil.decodeUrl(kwd);

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("schType", schType);
			map.put("kwd", kwd);

			if (workshopStatus != null && !workshopStatus.isBlank()) {
				map.put("workshopStatus", workshopStatus);
			}

			dataCount = service.workshopDataCount(map);
			if (dataCount > 0) {
				total_page = (dataCount + size - 1) / size;
				if (current_page > total_page)
					current_page = total_page;
			} else {
				current_page = 1;
			}

			int offset = (current_page - 1) * size;
			if (offset < 0)
				offset = 0;

			map.put("offset", offset);
			map.put("size", size);

			List<Workshop> list = service.listWorkshop(map);

			Map<String, Object> programMap = new HashMap<>();
			
			programMap.put("offset", 0);
			programMap.put("size", 100);
			List<Workshop> programList = service.listProgram(programMap);
			model.addAttribute("programList", programList);

			String cp = req.getContextPath();
			String listUrl = cp + "/admin/workshop/list";
			// String detailUrl = cp + "/admin/workshop/detail?page=" + current_page;
			String paging = paginateUtil.pagingUrl(current_page, total_page, listUrl);

			model.addAttribute("list", list);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("size", size);
			model.addAttribute("total_page", total_page);
			model.addAttribute("page", current_page);
			model.addAttribute("paging", paging);

			model.addAttribute("schType", schType);
			model.addAttribute("kwd", kwd);
			model.addAttribute("workshopStatus", workshopStatus);

		} catch (Exception e) {
			log.info("workshop list : ", e);
		}

		return "admin/workshop/workshopList";
	}

	@PostMapping("/updateStatus")
	@ResponseBody
	public Map<String, Object> updateStatus(@RequestBody Workshop dto) {
		Map<String, Object> map = new HashMap<>();
		try {
			service.updateWorkshopStatus(dto);
			map.put("success", true);
		} catch (Exception e) {
			map.put("success", false);
		}
		return map;
	}

	// 워크샵 작성
	@GetMapping("/write")
	public String workshopWriteForm(Model model) throws Exception {
		Map<String, Object> programMap = new HashMap<>();
		programMap.put("offset", 0);
		programMap.put("size", 100);
		List<Workshop> programList = service.listProgram(programMap);

		Map<String, Object> managerMap = new HashMap<>();
		managerMap.put("offset", 0);
		managerMap.put("size", 100);
		List<Workshop> managerList = service.listManager(managerMap);

		model.addAttribute("mode", "write");
		model.addAttribute("programList", programList);
		model.addAttribute("managerList", managerList);

		return "admin/workshop/workshopWrite";
	}

	@PostMapping("/write")
	public String workshopWriteSubmit(Workshop dto, @RequestParam("thumbnail") MultipartFile thumbnail,
			@RequestParam("photos") List<MultipartFile> photos) throws Exception {
		try {
			// 썸네일
			if (thumbnail != null && !thumbnail.isEmpty()) {
				String path = storageService.uploadFileToServer(thumbnail, uploadPath);
				dto.setThumbnailPath(path);
			}

			service.insertWorkshop(dto);

			// 상세 이미지
			for (MultipartFile photo : photos) {
				if (photo != null && !photo.isEmpty()) {
					String path = storageService.uploadFileToServer(photo, uploadPath);

					dto.setWorkshopId(dto.getWorkshopId());
					dto.setWorkshopImagePath(path);

					service.insertWorkshopPhoto(dto);
				}
			}

		} catch (Exception e) {
			log.info("workshop writeSubmit : ", e);
		}
		return "redirect:/admin/workshop/list";
	}

	// 워크샵 상세
	@GetMapping("/detail")
	public String workshopDetail(@RequestParam(name = "num") long num,
			@RequestParam(name = "page", defaultValue = "1") String page, Model model) throws Exception {

		String query = "page=" + page;
		try {
			// 기본 정보
			Workshop dto = service.findWorkshopById(num);
			if (dto == null) {
				return "redirect:/admin/workshop/list?" + query;
			}

			// 상세 이미지
			Map<String, Object> map = new HashMap<>();
			map.put("workshopId", num);
			List<Workshop> photoList = service.listWorkshopPhoto(map);

			model.addAttribute("dto", dto);
			model.addAttribute("photoList", photoList);
			model.addAttribute("page", page);
			model.addAttribute("query", query);

			return "admin/workshop/workshopDetail";
		} catch (Exception e) {
			log.info("workshop detail : ", e);
		}

		return "redirect:/admin/workshop/list?" + query;
	}

	// 워크샵 수정
	@GetMapping("/update")
	public String updateFormWorkshop(@RequestParam(name = "num") long num, @RequestParam(name = "page") String page,
			Model model) throws Exception {
		try {
			Workshop dto = Objects.requireNonNull(service.findWorkshopById(num));

			// 프로그램 목록
			Map<String, Object> programMap = new HashMap<>();
			programMap.put("offset", 0);
			programMap.put("size", 100);
			List<Workshop> programList = service.listProgram(programMap);

			// 담당자 목록
			Map<String, Object> managerMap = new HashMap<>();
			managerMap.put("offset", 0);
			managerMap.put("size", 100);
			List<Workshop> managerList = service.listManager(managerMap);

			Map<String, Object> photoMap = new HashMap<>();
	        photoMap.put("workshopId", num);
	        List<Workshop> photoList = service.listWorkshopPhoto(photoMap);
	        model.addAttribute("photoList", photoList);
			
			model.addAttribute("programList", programList);
			model.addAttribute("managerList", managerList);
			model.addAttribute("dto", dto);
			model.addAttribute("mode", "update");
			model.addAttribute("page", page);

			return "admin/workshop/workshopWrite";
		} catch (Exception e) {
			log.info("workshopUpdateForm : ", e);
		}

		return "redirect:/admin/workshop/list?page=" + page;
	}

	@PostMapping("/update")
	public String updateSubmitWorkshop(Workshop dto, @RequestParam(name = "page", defaultValue = "1") String page,
			@RequestParam(name = "thumbnail", required = false) MultipartFile newThumbnail,
			@RequestParam(name = "photos", required = false) List<MultipartFile> newPhotos,
			@RequestParam(name="deletePhotoIds", required=false) List<Long> deletePhotoIds) throws Exception {
		try {
			Workshop workshop = service.findWorkshopById(dto.getWorkshopId());

			// 썸네일
			if (newThumbnail != null && !newThumbnail.isEmpty()) {
				String path = storageService.uploadFileToServer(newThumbnail, uploadPath);
				dto.setThumbnailPath(path);
			} else {
				dto.setThumbnailPath(workshop.getThumbnailPath());
			}
			
			service.updateWorkshop(dto);
			
			if (deletePhotoIds != null) {
				for (Long photoId : deletePhotoIds) {
					service.deleteWorkshopPhotoById(photoId, uploadPath);
				}
			}
			
			// 상세 사진
			if (newPhotos != null) {
	            for (MultipartFile photo : newPhotos) {
	                if (photo != null && !photo.isEmpty()) {
	                    String path = storageService.uploadFileToServer(photo, uploadPath);

	                    Workshop p = new Workshop();
	                    p.setWorkshopId(dto.getWorkshopId());
	                    p.setWorkshopImagePath(path);
	                    service.insertWorkshopPhoto(p);
	                }
	            }
	        }
			

		} catch (Exception e) {
			log.info("update Workshop : ", e);
			throw e;
		}
		return "redirect:/admin/workshop/list?page=" + page;
	}

	// 워크샵 삭제
	@PostMapping("/delete")
	public String deleteWorkshop(@RequestParam(name = "num") long num,
			@RequestParam(name = "page", defaultValue = "1") String page,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd) throws Exception {
		String query = "page=" + page;
		try {
			kwd = myUtil.decodeUrl(kwd);

			if (!kwd.isBlank()) {
				query += "&schType=" + schType + "&kwd=" + myUtil.encodeUrl(kwd);
			}

			service.deleteWorkshop(num);
		} catch (Exception e) {
			log.info("delete Workshop : ", e);
			throw e;
		}

		return "redirect:/admin/workshop/list?" + query;
	}

	// 사진 업로드
	@PostMapping("/photo/upload")
	public String workshopPhotoUpload(Workshop dto, @RequestParam long workshopId,
			@RequestParam("photo") List<MultipartFile> files) {
		try {
			for (MultipartFile file : files) {
				if (file != null && !file.isEmpty()) {
					String path = storageService.uploadFileToServer(file, uploadPath);

					dto.setWorkshopId(workshopId);
					dto.setWorkshopImagePath(path);

					service.insertWorkshopPhoto(dto);
				}
			}
		} catch (Exception e) {
			log.info("workshopPhotoUpload : ", e);
		}

		return "redirect:/admin/workshop/photo/list?workshopId=" + workshopId;
	}

	// 사진 삭제
	@PostMapping("/photo/delete")
	public String photoDelete(@RequestParam long photoId, @RequestParam long workshopId) {
		try {
			service.deleteWorkshopPhotoById(photoId, uploadPath);
		} catch (Exception e) {
			log.error("사진 삭제 실패", e);
		}
		return "redirect:/admin/workshop/photo/list?workshopId=" + workshopId;
	}

	// FAQ 관리
	@GetMapping("/faq/manage")
	public String faqManage(@RequestParam(name = "page", defaultValue = "1") int current_page,
			@RequestParam(name = "programId", required = false) Long programId, 
			HttpServletRequest req, Model model) {
		try {
			int size = 10;
			int total_page = 0;
			int offset = (Math.max(current_page, 1) - 1) * size;

			// 프로그램 드롭다운
			Map<String, Object> pmap = new HashMap<>();
			pmap.put("offset", 0);
			pmap.put("size", 1000);
			List<Workshop> programList = service.listProgram(pmap);
			
			if (programId == null && programList != null && !programList.isEmpty()) {
				programId = programList.get(0).getProgramId();
			}
			
			List<WorkshopFaq> faqList = List.of();
			int dataCount = 0;
			
			// 카운트
			if (programId != null) {
				Map<String, Object> cmap = new HashMap<>();
				cmap.put("programId", programId);
				dataCount = service.faqDataCount(cmap);
				
				if(dataCount > 0) {
					total_page = paginateUtil.pageCount(dataCount, size);
				}
				if(current_page > total_page) {
					current_page = total_page > 0 ? total_page : 1;
				}
				offset = (current_page - 1) * size;
				if (offset < 0) offset = 0;
				
				// 목록
				Map<String, Object> fmap = new HashMap<>();
				fmap.put("programId", programId);
				fmap.put("offset", offset);
				fmap.put("size", size);
				faqList = service.listFaq(fmap);
			} else {
				offset = 0;
			}
			
			String cp = req.getContextPath();
	        String listUrl = cp + "/admin/workshop/faq/manage?programId=" + programId;
	        String paging = paginateUtil.pagingUrl(current_page, total_page, listUrl);
			
			model.addAttribute("page", current_page);
			model.addAttribute("paging", paging);
			model.addAttribute("size", size);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("programList", programList);
			model.addAttribute("programId", programId);
			model.addAttribute("faqList", faqList);

		} catch (Exception e) {
			log.info("faqManage : ", e);
		}

		return "admin/workshop/faqManage";
	}

	// FAQ 등록
	@PostMapping("/faq/write")
	public String writeSubmitFaq(WorkshopFaq dto, HttpSession session,
			@RequestParam(name = "page", defaultValue = "1") String page) throws Exception {
		try {
			service.insertFaq(dto);
			session.setAttribute("msg", "FAQ가 등록되었습니다.");
		} catch (Exception e) {
			log.info("writeSubmitProgram : ", e);
			session.setAttribute("msg", "FAQ 등록에 실패했습니다.");
		}
		return "redirect:/admin/workshop/faq/manage?programId=" + dto.getProgramId();
	}

	// FAQ 수정
	@PostMapping("/faq/update")
	public String updateFaq(WorkshopFaq dto, HttpSession session) throws Exception {
		try {
			service.updateFaq(dto);
			session.setAttribute("msg", "FAQ가 수정되었습니다.");
		} catch (Exception e) {
			log.info("writeSubmitProgram : ", e);
			session.setAttribute("msg", "FAQ 등록에 실패했습니다.");
		}
		return "redirect:/admin/workshop/faq/manage?programId=" + dto.getProgramId();
	}

	// FAQ 삭제
	@PostMapping("/faq/delete")
	public String deleteFaq(@RequestParam(name = "faqId") Long faqId, @RequestParam(name = "programId") Long programId,
			HttpSession session) throws Exception {
		try {
			service.deleteFaq(faqId);
			session.setAttribute("msg", "FAQ가 삭제되었습니다.");
		} catch (Exception e) {
			log.info("deleteFaq : ", e);
			session.setAttribute("msg", "FAQ가 삭제에 실패했습니.");
		}

		return "redirect:/admin/workshop/faq/manage?programId=" + programId;
	}

	// 참여자 목록
	@GetMapping("/participant/list")
	public String participantList(@RequestParam(name = "page", defaultValue = "1") int current_page,
			@RequestParam(name = "workshopId", required = false) Long workshopId, 
			HttpServletRequest req, Model model) {

		try {
			int size = 20;
	        int total_page = 0;
	        int offset = (Math.max(current_page, 1) - 1) * size;

	        Map<String, Object> wmap = new HashMap<>();
	        wmap.put("offset", offset);
	        wmap.put("size", size);
	        
	        int dataCount = service.workshopDataCount(wmap);
	        if (dataCount > 0) {
	            total_page = paginateUtil.pageCount(dataCount, size);
	        }

	        if (current_page > total_page) {
	            current_page = total_page > 0 ? total_page : 1;
	        }

	        offset = (current_page - 1) * size;
	        if (offset < 0) offset = 0;
	        wmap.put("offset", offset);

	        List<Workshop> workshopList = service.listWorkshop(wmap);
	        model.addAttribute("workshopList", workshopList);

	        if (workshopId == null && workshopList != null && !workshopList.isEmpty()) {
	            workshopId = workshopList.get(0).getWorkshopId();
	        }
	        model.addAttribute("workshopId", workshopId);

	        List<Participant> participantList = List.of();
	        if (workshopId != null) {
	            Map<String, Object> map = new HashMap<>();
	            map.put("workshopId", workshopId);
	            participantList = service.listParticipant(map);
	        }
	        model.addAttribute("participantList", participantList);

	        String cp = req.getContextPath();
	        String listUrl = cp + "/admin/workshop/participant/list";
	        if (workshopId != null) listUrl += "?workshopId=" + workshopId;

	        String paging = paginateUtil.pagingUrl(current_page, total_page, listUrl);

	        model.addAttribute("page", current_page);
	        model.addAttribute("size", size);
	        model.addAttribute("dataCount", dataCount);
	        model.addAttribute("paging", paging);
		} catch (Exception e) {
			log.info("participantList : ", e);
		}

		return "admin/workshop/participantList";
	}

	// 출석체크
	@PostMapping("/participant/attendance")
	@ResponseBody
	public Map<String, Object> updateAttendance(@RequestParam(name = "participantId") long participantId,
			@RequestParam(name = "isAttended") String isAttended) {

		try {
			Map<String, Object> map = new HashMap<>();
			map.put("participantId", participantId);
			map.put("isAttended", isAttended);
			service.updateAttendance(map);
			return Map.of("success", true);
		} catch (Exception e) {
			return Map.of("success", false, "message", e.getMessage());
		}
	}

	// 신청 상태
	@PostMapping("/participant/status")
	@ResponseBody
	public Map<String, Object> updateParticipantStatus(@RequestParam(name = "participantId") long participantId,
			@RequestParam(name = "participantStatus") String participantStatus) {

		try {
			Map<String, Object> map = new HashMap<>();
			map.put("participantId", participantId);
			map.put("participantStatus", participantStatus);
			service.updateParticipantStatus(map);
			return Map.of("success", true);
		} catch (Exception e) {
			return Map.of("success", false, "message", e.getMessage());
		}
	}

	// 포인트 목록
	@GetMapping("/points")
	public String reviewPointList(@RequestParam(name = "page", defaultValue = "1") int current_page,
			@RequestParam(name = "size", defaultValue = "20") int size,
			@RequestParam(name = "workshopId", required = false) Long workshopId, 
			HttpServletRequest req, Model model) {
		try {
			if (current_page < 1) current_page = 1;
	        if (size < 1) size = 20;
			
			Map<String, Object> q = new HashMap<>();
			if (workshopId != null) q.put("workshopId", workshopId);
			int total = workshopMapper.countReviewRewardRows(q); 
			
			int total_page = 0; 
			if(total > 0) {
				total_page = paginateUtil.pageCount(total, size);
			}
			if(current_page > total_page) {
				current_page = total_page > 0 ? total_page : 1;
			}
			
			int offset = (current_page - 1) * size;
			q.put("offset", offset);
			q.put("size", size);

			List<Map<String, Object>> rows = workshopMapper.listReviewRewardRows(q);
			
			String cp = req.getContextPath();
	        String listUrl = cp + "/admin/workshop/points";
	        String paging = paginateUtil.pagingUrl(current_page, total_page, listUrl);

			model.addAttribute("rows", rows);
			model.addAttribute("pointPolicy", 1000);
			model.addAttribute("page", current_page);
			model.addAttribute("size", size);
			model.addAttribute("total", total);
			model.addAttribute("paging", paging);
			model.addAttribute("workshopId", workshopId);

			return "admin/workshop/pointManage";
		} catch (Exception e) {
			log.error("reviewPointList : ", e);
			return "redirect:admin/workshop/list";
		}
	}

	// 포인트 지급
	@PostMapping("/points/pay")
	public String pay(@RequestParam(name = "workshopReviewId", required = false) Long workshopReviewId,
			@RequestParam(name = "participantId") long participantId,
			@RequestParam(name = "workshopId") long workshopId, HttpSession session) {
		if (workshopReviewId == null) {
			session.setAttribute("msg", "리뷰 ID가 비어있습니다.");
			return "redirect:/admin/workshop/points";
		}

		try {
			Long memberId = workshopMapper.findMemberIdByParticipantId(participantId);
			if (memberId == null) {
				session.setAttribute("msg", "회원 정보를 찾을 수 없습니다.");
				return "redirect:/admin/workshop/points";
			}

			boolean already = pointMapper.listMemberPoints(memberId).stream()
					.anyMatch(p -> p.getMemberId().equals(memberId) && p.getPostId() != null
							&& p.getPostId().longValue() == workshopReviewId.longValue() && p.getClassify() == 1
							&& p.getOrderId() == null);
			if (already) {
				session.setAttribute("msg", "이미 지급된 내역입니다.");
				return "redirect:/admin/workshop/points";
			}

			Point p = new Point();
			p.setMemberId(memberId);
			p.setReason("워크샵 후기 작성 보상");
			p.setClassify(1);
			p.setPoints(1000);
			p.setPostId(workshopReviewId);
			p.setOrderId(null);

			pointMapper.insertPoint(p);

			session.setAttribute("msg", "지급 완료되었습니다.");

		} catch (Exception e) {
			log.info("pay : ", e);
			session.setAttribute("msg", "지급 처리 중 오류가 발생했습니다.");
		}
		return "redirect:/admin/workshop/points";
	}

}
