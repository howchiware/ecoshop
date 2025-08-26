package com.sp.app.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.admin.model.MemberManage;
import com.sp.app.common.StorageService;
import com.sp.app.mapper.WorkshopMapper;
import com.sp.app.model.Participant;
import com.sp.app.model.Workshop;
import com.sp.app.model.WorkshopFaq;
import com.sp.app.model.WorkshopReview;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class WorkshopServiceImpl implements WorkshopService {

	private final WorkshopMapper mapper;
	private final StorageService storageService;

	// ** 관리자 **
	// 카테고리
	@Override
	public void insertCategory(Workshop dto) {
		try {
			if (dto.getCategoryName() != null) {
				dto.setCategoryName(dto.getCategoryName().trim());
			}

			mapper.insertCategory(dto);
		} catch (Exception e) {
			log.info("insertCategory : ", e);

			throw e;
		}

	}

	@Override
	public List<Workshop> listCategory(Map<String, Object> map) {
		List<Workshop> list = null;

		try {
			list = mapper.listCategory(map);

		} catch (Exception e) {
			log.info("list : ", e);
		}

		return list;
	}

	@Override
	public void updateCategory(Workshop dto) {
		try {
			mapper.updateCategory(dto);
		} catch (Exception e) {
			log.info("updateProgram : ", e);

			throw e;
		}

	}

	@Override
	public void deleteCategory(Long categoryId) {
		try {
			mapper.deleteCategory(categoryId);
		} catch (Exception e) {
			log.info("updateProgram : ", e);

			throw e;
		}
	}

	@Override
	public void categoryActive(Long categoryId, Integer active) {
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("categoryId", categoryId);
			map.put("active", active);

			mapper.categoryActive(map);
		} catch (Exception e) {
			log.info("updateProgram : ", e);

			throw e;
		}
	}

	// 프로그램
	@Override
	public void insertProgram(Workshop dto) throws Exception {
		try {
			if (dto.getProgramTitle() != null) {
				dto.setProgramTitle(dto.getProgramTitle().trim());
			}
			mapper.insertProgram(dto);

		} catch (Exception e) {
			log.info("insertProgram : ", e);

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
	public Workshop findProgramById(Long num) {
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
	public void deleteProgram(Long num) throws Exception {
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
			if (dto == null)
				return;

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
							log.warn("파일 삭제 실패(workshopId={}, photoId={}, path={}): {}", workshopId, dto.getPhotoId(),
									p, fe.getMessage());
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

	@Override
	public List<Participant> listParticipant(Map<String, Object> map) {
		try {
			return mapper.listParticipant(map);
		} catch (Exception e) {
			log.info("listParticipant : ", e);

			throw e;
		}
	}

	@Override
	public int hasApplied(Map<String, Object> map) {
		int result = 0;

		try {
			result = mapper.hasApplied(map);
		} catch (Exception e) {
			log.info("hasApplied : ", e);

			throw e;
		}
		return result;
	}

	@Override
	public List<WorkshopFaq> listFaq(Map<String, Object> map) {
		try {
			return mapper.listFaq(map);
		} catch (Exception e) {
			log.info("listFaq : ", e);

			throw e;
		}
	}

	// ** 사용자 **
	@Override
	public List<Workshop> listUserWorkshop(Map<String, Object> map) {
		try {
			return mapper.listUserWorkshop(map);
		} catch (Exception e) {
			log.info("listUserWorkshop : ", e);

			throw e;
		}
	}

	@Override
	public int userWorkshopDataCount(Map<String, Object> map) {
		int result = 0;

		try {
			result = mapper.userWorkshopDataCount(map);
		} catch (Exception e) {
			log.info("userWorkshopDataCount : ", e);
		}
		return result;
	}

	@Override
	public Workshop findWorkshopDetail(long workshopId) {
		Workshop dto = null;

		try {
			dto = mapper.findWorkshopDetail(workshopId);
		} catch (Exception e) {
			log.info("findWorkshopDetail : ", e);
		}
		return dto;
	}

	@Override
	public Workshop findWorkshopStatusAndCapacity(long workshopId) throws Exception {
		Workshop dto = null;

		try {
			dto = mapper.findWorkshopStatusAndCapacity(workshopId);
		} catch (Exception e) {
			log.info("findWorkshopStatusAndCapacity : ", e);
		}
		return dto;
	}

	@Override
	public void applyWorkshop(Map<String, Object> map) throws Exception {
		try {
			mapper.applyWorkshop(map);
		} catch (Exception e) {
			log.info("applyWorkshop : ", e);

			throw e;
		}

	}

	@Override
	public void cancelApplication(Map<String, Object> map) throws Exception {
		try {
			mapper.cancelApplication(map);
		} catch (Exception e) {
			log.info("cancelApplication : ", e);

			throw e;
		}

	}

	@Override
	public List<WorkshopReview> listUserReview(Map<String, Object> map) {
		try {
			return mapper.listUserReview(map);
		} catch (Exception e) {
			log.info("listUserReview : ", e);

			throw e;
		}
	}

	@Override
	public int reviewDataCount(Map<String, Object> map) {
		int result = 0;

		try {
			result = mapper.reviewDataCount(map);
		} catch (Exception e) {
			log.info("reviewDataCount : ", e);
		}
		return result;
	}

	@Override
	public void insertReview(WorkshopReview dto) throws Exception {
		try {
			mapper.insertReview(dto);
		} catch (Exception e) {
			log.info("insertReview : ", e);

			throw e;
		}

	}

	@Override
	public boolean isParticipantOfMember(long participantId, long memberId) {
		return mapper.isParticipantOfMember(participantId, memberId) > 0;
	}

	@Override
	public void insertFaq(WorkshopFaq dto) throws Exception {
		mapper.insertFaq(dto);

	}

	@Override
	public void updateFaq(WorkshopFaq dto) throws Exception {
		mapper.updateFaq(dto);

	}

	@Override
	public void deleteFaq(Long faqId) throws Exception {
		mapper.deleteFaq(faqId);

	}

	@Override
	public Long findProgramIdByWorkshopId(Long workshopId) {
		try {

			return mapper.findProgramIdByWorkshopId(workshopId);

		} catch (Exception e) {
			log.info("findProgramIdByWorkshopId : ", e);

			return null;
		}
	}

	@Override
	public WorkshopFaq findFaqById(Long faqId) {
		WorkshopFaq dto = null;

		try {
			dto = mapper.findFaqById(faqId);

		} catch (Exception e) {
			log.info("findFaqById : ", e);

			throw e;
		}
		return dto;
	}

	@Override
	public int updateParticipantStatus(Map<String, Object> map) {
		int result = 0;

		try {
			result = mapper.updateParticipantStatus(map);
		} catch (Exception e) {
			log.info("markAttendance : ", e);

			throw e;
		}
		return result;
	}

	@Override
	public int updateAttendance(Map<String, Object> map) {
		int result = 0;

		try {
			result = mapper.updateAttendance(map);
		} catch (Exception e) {
			log.info("markAttendance : ", e);

			throw e;
		}
		return result;
	}

	@Override
	public Long findParticipantById(long memberId, long workshopId) {
		try {

			return mapper.findParticipantById(memberId, workshopId);
		} catch (Exception e) {
			log.info("findParticipantById : ", e);
			return null;
		}
	}

	@Override
	public void updateWorkshopStatus(Workshop dto) {
		mapper.updateWorkshopStatus(dto);

	}

	@Override
	public MemberManage findMemberById(long memberId) {
		try {

			return mapper.findMemberById(memberId);
		} catch (Exception e) {
			log.info("findMemberById : ", e);
			return null;
		}
	}

	@Override
	public List<Workshop> listWorkshopMain(Map<String, Object> map) {
		List<Workshop> list = null;

		try {
			list = mapper.listWorkshop(map);
		} catch (Exception e) {
			log.info("listWorkshopMain : ", e);

			throw e;
		}
		return list;
	}

	@Override
	public List<Workshop> listActiveCategory() {
		return mapper.listActiveCategory();
	}
	
	

}
