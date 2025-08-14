package com.sp.app.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.common.StorageService;
import com.sp.app.mapper.WorkshopMapper;
import com.sp.app.model.Workshop;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class WorkshopServiceImpl implements WorkshopService {
	private final WorkshopMapper mapper;
	private final StorageService storageService;

	// 카테고리
	@Override
	public void insertCategory(Workshop dto, String CategoryName) {
		try {
			String name = CategoryName == null ? null : CategoryName.trim();

			dto.setCategoryName(name);
			mapper.insertProgramCategory(dto);
		} catch (Exception e) {
			log.info("insertCategory : ", e);

			throw e;
		}

	}

	@Override
	public List<Workshop> listCategory(Map<String, Object> map) {
		List<Workshop> list = null;

		try {
			list = mapper.listProgramCategory(map);

		} catch (Exception e) {
			log.info("list : ", e);
		}

		return list;
	}

	// 프로그램
	@Override
	public void insertProgram(Workshop dto, Long categoryId, String programTitle, String programContent)
			throws Exception {
		try {
			dto.setCategoryId(categoryId);
			dto.setProgramTitle(programTitle);
			dto.setProgramContent(programContent);

			mapper.insertProgram(dto);
		} catch (Exception e) {
			log.info("programContent : ", e);

			throw e;
		}

	}

	@Override
	public List<Workshop> listProgram(Map<String, Object> map) {
		List<Workshop> list = null;

		try {
			list = mapper.listProgram(map);
		} catch (Exception e) {
			log.info("listProgram : ", e);
		}
		return list;
	}

	@Override
	public Workshop findProgramById(long num) {
		Workshop dto = null;

		try {
			dto = mapper.findProgramById(num);
		} catch (Exception e) {
			log.info("findProgramById : ", e);
		}
		return dto;
	}

	@Override
	public void updateProgram(Workshop dto) throws Exception {
		try {
			mapper.updateProgram(dto);
		} catch (Exception e) {
			log.info("updateProgram : ", e);

			throw e;
		}

	}

	@Override
	public void deleteProgram(long num) throws Exception {
		try {
			mapper.deleteProgram(num);
		} catch (Exception e) {
			log.info("deleteProgram : ", e);

			throw e;
		}

	}

	// 담당자
	@Override
	public void insertManager(Workshop dto) throws Exception {
		try {
			mapper.insertManager(dto);
		} catch (Exception e) {
			log.info("workshopManager : ", e);

			throw e;
		}

	}

	@Override
	public List<Workshop> listManager(Map<String, Object> map) {
		List<Workshop> list = null;

		try {
			list = mapper.listManager(map);
		} catch (Exception e) {
			log.info("listManager : ", e);

			throw e;
		}

		return list;
	}

	@Override
	public Workshop findManagerById(long num) {
		Workshop dto = null;

		try {
			dto = mapper.findManagerById(num);
		} catch (Exception e) {
			log.info("findManagerById : ", e);

			throw e;
		}

		return dto;
	}

	@Override
	public void updateManager(Workshop dto) throws Exception {
		try {
			mapper.updateManager(dto);
		} catch (Exception e) {
			log.info("updateProgram : ", e);

			throw e;
		}
	}

	@Override
	public void deleteManager(long num) throws Exception {
		try {
			mapper.deleteManager(num);
		} catch (Exception e) {
			log.info("deleteManager : ", e);

			throw e;
		}
	}

	// 워크샵
	@Override
	public void insertWorkshop(Workshop dto) throws Exception {
		try {
			mapper.insertWorkshop(dto);
		} catch (Exception e) {
			log.info("insertWorkshop : ", e);

			throw e;
		}

	}

	@Override
	public List<Workshop> listWorkshop(Map<String, Object> map) {
		List<Workshop> list = null;

		try {
			list = mapper.listWorkshop(map);
		} catch (Exception e) {
			log.info("listWorkshop : ", e);

			throw e;
		}
		return list;
	}

	@Override
	public Workshop findWorkshopById(long num) {
		Workshop dto = null;

		try {
			dto = mapper.findWorkshopById(num);

		} catch (Exception e) {
			log.info("findWorkshopById : ", e);

			throw e;
		}
		return dto;
	}

	@Override
	public void updateWorkshop(Workshop dto) throws Exception {
		try {
			mapper.updateWorkshop(dto);
		} catch (Exception e) {
			log.info("updateWorkshop : ", e);

			throw e;
		}

	}

	@Override
	public void deleteWorkshop(long num) throws Exception {
		try {
			mapper.deleteWorkshop(num);
		} catch (Exception e) {
			log.info("deleteWorkshop : ", e);

			throw e;
		}

	}

	@Override
	public int workshopDataCount(Map<String, Object> map) {
		int result = 0;

		try {
			result = mapper.workshopDataCount(map);
		} catch (Exception e) {
			log.info("workshop DataCount : ", e);
		}
		return result;
	}

	// 워크샵 사진
	@Override
	public void insertWorkshopPhoto(Workshop dto) throws Exception {
		try {
			mapper.insertWorkshopPhoto(dto);
		} catch (Exception e) {
			log.info("insertWorkshopPhoto : ", e);
			throw e;
		}
	}

	@Override
	public List<Workshop> listWorkshopPhoto(Map<String, Object> map) {
		List<Workshop> list = null;

		try {
			list = mapper.listWorkshopPhoto(map);

		} catch (Exception e) {
			log.info("listWorkshopPhoto : ", e);
		}

		return list;
	}

	@Override
	public Workshop findWorkshopPhotoById(long num) {
		Workshop dto = null;

		try {
			dto = mapper.findWorkshopPhotoById(num);
		} catch (Exception e) {
			log.info("findWorkshopPhotoById : ", e);
		}
		return dto;
	}

	@Override
	public void deleteWorkshopPhotoById(long photoId, String uploadPath) throws Exception {
	    try {
	        Workshop dto = findWorkshopPhotoById(photoId);
	        if (dto == null) return;

	        mapper.deleteWorkshopPhotoById(photoId);

	        String path = dto.getWorkshopImagePath();
	        if (path != null && !path.isEmpty()) {
	            try {
	                storageService.deleteFile(uploadPath, path);
	            } catch (Exception fe) {
	                log.warn("파일 삭제 실패(photoId={}, path={}): {}", photoId, path, fe.getMessage());
	            }
	        }
	    } catch (Exception e) {
	        log.info("deleteWorkshopPhotoById : ", e);
	        throw e;
	    }
	}

	@Override
	public void deleteWorkshopPhotosByWorkshopId(long workshopId, String uploadPath) throws Exception {
	    try {
	        Map<String, Object> map = new HashMap<>();
	        map.put("workshopId", workshopId);

	        List<Workshop> listFile = listWorkshopPhoto(map);
	        if (listFile != null) {
	            for (Workshop dto : listFile) {
	                String p = dto.getWorkshopImagePath();
	                if (p != null && !p.isEmpty()) {
	                    try {
	                        storageService.deleteFile(uploadPath, p);
	                    } catch (Exception fe) {
	                        log.warn("파일 삭제 실패(workshopId={}, photoId={}, path={}): {}", workshopId, dto.getPhotoId(), p, fe.getMessage());
	                    }
	                }
	            }
	        }

	        mapper.deleteWorkshopPhotosByWorkshopId(workshopId);
	    } catch (Exception e) {
	        log.info("deleteWorkshopPhotoById : ", e);
	        throw e;
	    }
	}


	@Override
	public int workshopPhotoDataCount(Map<String, Object> map) {
		int result = 0;

		try {
			result = mapper.workshopPhotoDataCount(map);
		} catch (Exception e) {
			log.info("workshopPhotoDataCount", e);
		}
		return result;
	}

}
