package com.sp.app.service;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.sp.app.common.StorageService;
import com.sp.app.mapper.ChallengeMapper;
import com.sp.app.mapper.PointMapper;
import com.sp.app.model.Challenge;
import com.sp.app.model.Point;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ChallengeServiceImpl implements ChallengeService {

	private final ChallengeMapper mapper;
	private final PointMapper pointMapper;
	private final StorageService storageService;

	/** Java DayOfWeek(1=MON..7=SUN) -> 0(SUN)..6(SAT) 변환 */
	private int calcTodayDow() {
		int dow = LocalDate.now().getDayOfWeek().getValue(); // 1~7 (MON..SUN)
		return (dow == DayOfWeek.SUNDAY.getValue()) ? 0 : dow; // SUN->0, MON..SAT 그대로(1..6)
	}

	@Override
	public List<Challenge> listDailyAll() {
		try {
			return mapper.listDailyAll();
		} catch (Exception e) {
			log.info("listDailyAll :", e);

		}
		return List.of();
	}

	@Override
	public Challenge getTodayDaily() {
		return getTodayDaily(calcTodayDow());
	}

	@Override
	public Challenge getTodayDaily(int todayDow) {
		try {
			return mapper.getTodayDaily(todayDow);
		} catch (Exception e) {
			log.info("getTodayDaily :", e);

		}
		return null;
	}

	@Override
	public List<Challenge> listSpecialMore(Long lastId, Integer size, String sort) {

		return listSpecialMore(lastId, size, sort, null);
	}

	@Override
	public Challenge findDailyDetail(long challengeId) {
		try {
			return mapper.findDailyDetail(challengeId);
		} catch (Exception e) {
			log.info("findDailyDetail :", e);

		}
		return null;
	}

	@Override
	public Challenge findSpecialDetail(long challengeId) {
		try {
			return mapper.findSpecialDetail(challengeId);
		} catch (Exception e) {
			log.info("findSpecialDetail :", e);

		}
		return null;
	}

	@Override
	public int countTodayDailyJoin(long memberId, long challengeId) {
		try {
			return mapper.countTodayDailyJoin(memberId, challengeId);
		} catch (Exception e) {
			log.info("countTodayDailyJoin :", e);

		}
		return 0;
	}

	@Override
	public Long nextParticipationId() {
		try {
			return mapper.nextParticipationId();
		} catch (Exception e) {
			log.info("nextParticipationId :", e);

		}
		return null;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public void insertParticipation(Challenge dto) throws Exception {
		try {
			if (dto.getParticipationStatus() == null) {
				dto.setParticipationStatus(0);
			}
			mapper.insertParticipation(dto);
		} catch (Exception e) {
			log.info("insertParticipation :", e);
			throw e;
		}

	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public void updateParticipation(Challenge dto) throws Exception {
		try {
			mapper.updateParticipation(dto);
		} catch (Exception e) {
			log.info("updateParticipation :", e);
			throw e;
		}

	}

	@Override
	public List<Map<String, Object>> selectSpecialProgress(long participationId) {
		try {
			return mapper.selectSpecialProgress(participationId);
		} catch (Exception e) {
			log.info("selectSpecialProgress :", e);

		}
		return List.of();
	}

	@Override
	public Challenge getDailyByWeekday(int weekday) {
		try {
			return mapper.selectDailyByWeekday(weekday);
		} catch (Exception e) {
			log.info("getDailyByWeekday : ", e);
		}
		return null;
	}

	@Override
	public List<Challenge> listSpecialMore(Long lastId, Integer size, String sort, String lastEndDate) {
		try {
			int pageSize = (size == null || size <= 0 || size > 50) ? 6 : size;
			String s = (sort == null || sort.isBlank()) ? "RECENT" : sort;

			Map<String, Object> param = new java.util.HashMap<>();
			param.put("lastId", lastId);
			param.put("size", pageSize);
			param.put("sort", s);
			param.put("lastEndDate", lastEndDate);

			return mapper.listSpecialMore(param);
		} catch (Exception e) {
			log.info("listSpecialMore :", e);
		}
		return List.of();
	}

	// 데일리 챌린지 인증 제출 및 포인트지급
	@Override
	@Transactional(rollbackFor = Exception.class)
	public void submitDailyChallenge(Challenge dto, MultipartFile photoFile) throws Exception {
		try {
			// 0) 오늘이 해당 데일리 챌린지 요일인지 검증 (서버 가드)
	        Challenge dailyInfo = mapper.findDailyDetail(dto.getChallengeId());
	        if (dailyInfo != null && dailyInfo.getWeekday() != null) {
	            int todayDow0to6 = calcTodayDow(); // SUN=0, MON..SAT=1..6
	            if (!dailyInfo.getWeekday().equals(todayDow0to6)) {
	                throw new IllegalStateException("오늘은 이 데일리 챌린지 참여일이 아닙니다.");
	            }
	        }

	        // 1) 데일리 챌린지 중복 참여 확인
	        int count = mapper.countTodayDailyJoin(dto.getMemberId(), dto.getChallengeId());
	        if (count > 0) {
	            throw new IllegalStateException("오늘은 이미 참여한 챌린지입니다.");
	        }
			// 2. 파일 저장 (사진이 있을 경우)
			String saveFilename = null;
			if (photoFile != null && !photoFile.isEmpty()) {
				String challengePath = storageService.getRealPath("/uploads/challenge");
				saveFilename = storageService.uploadFileToServer(photoFile, challengePath);
				dto.setPhotoUrl(saveFilename);
			}

			// 3. 참여 기록(challengeParticipation) 및 인증 게시글(certificationPost) 저장
			Long participationId = mapper.nextParticipationId();
			dto.setParticipationId(participationId);

			// 직접 매퍼 호출
			if (dto.getParticipationStatus() == null)
				dto.setParticipationStatus(0);
			mapper.insertParticipation(dto);

			Long postId = mapper.nextPostId();
			dto.setPostId(postId);

			// 데일리 챌린지는 dayNumber가 NULL
			dto.setDayNumber(null);
			dto.setApprovalStatus(3); // 3: 자동승인
			dto.setIsPublic("Y");

			mapper.insertCertificationPost(dto);

			// 4. 인증 사진(certificationPhoto) 저장 (파일이 업로드된 경우에만)
			if (saveFilename != null) {
				Long photoId = mapper.nextPhotoId();
				dto.setPhotoId(photoId);
				mapper.insertCertificationPhoto(dto);
			}

			// 5. 포인트 지급
			Challenge challengeInfo = mapper.findDailyDetail(dto.getChallengeId());
			if (challengeInfo != null && challengeInfo.getRewardPoints() > 0) {
				Point p = new Point();
				p.setMemberId(dto.getMemberId());
				p.setReason(challengeInfo.getTitle() + " 챌린지 참여 보상");
				p.setClassify(1);
				p.setPoints(challengeInfo.getRewardPoints());
				p.setPostId(postId);

				log.info("reward points={}, memberId={}, postId={}", challengeInfo.getRewardPoints(), dto.getMemberId(),
						postId);

				int rows = pointMapper.insertPoint(p);
				log.info("point insert rows={}", rows);
				if (rows != 1) {
					throw new IllegalStateException("포인트 적립 실패");
				}
			}

			// 6. 참여 상태 업데이트
			dto.setParticipationStatus(4); // 4: 자동승인
			int upd = mapper.updateParticipation(dto);
			if (upd != 1) {
				throw new IllegalStateException("참여 상태 업데이트 실패");
			}

		} catch (Exception e) {
			log.error("Failed to submit daily challenge: ", e);
			throw e;
		}
	}

	// SPECIAL 1~3일차 제출
	@Override
	@Transactional(rollbackFor = Exception.class)
	public void submitSpecialDay(Challenge dto, MultipartFile photoFile) throws Exception {
		try {
			// 입력 파라미터
			log.info("[SPECIAL] submit start - memberId={}, challengeId={}, dayNumber={}", dto.getMemberId(),
					dto.getChallengeId(), dto.getDayNumber());

			// 0) 입력검사
			if (dto.getContent() == null || dto.getContent().trim().length() < 20) {
				throw new IllegalArgumentException("인증글은 20자 이상 작성해야 합니다.");
			}
			if (photoFile == null || photoFile.isEmpty()) {
				throw new IllegalArgumentException("스페셜 챌린지는 사진 업로드가 필요합니다.");
			}
			if (dto.getDayNumber() == null || dto.getDayNumber() < 1 || dto.getDayNumber() > 3) {
				throw new IllegalArgumentException("dayNumber는 1~3 사이여야 합니다.");
			}

			// 1) 기간 체크
			Challenge sp = mapper.findSpecialDetail(dto.getChallengeId());
			if (sp == null)
				throw new IllegalStateException("해당 스페셜 챌린지가 존재하지 않습니다.");

			java.time.LocalDate today = java.time.LocalDate.now();
			java.time.LocalDate start = java.time.LocalDate.parse(sp.getStartDate());
			java.time.LocalDate end = java.time.LocalDate.parse(sp.getEndDate());
			if (today.isBefore(start) || today.isAfter(end)) {
				throw new IllegalStateException("챌린지 기간이 아닙니다.");
			}

			// 2) 참여 레코드(없으면 생성)
			Challenge activePart = mapper.selectActiveParticipation(dto.getMemberId(), dto.getChallengeId());
			// 참여건
			log.info("[SPECIAL] active participation = {}",
					(activePart == null ? "NONE" : activePart.getParticipationId()));

			if (activePart == null) {
				if (dto.getDayNumber() != 1) {
					throw new IllegalStateException("1일차부터 순서대로 인증해야 합니다.");
				}
				Long participationId = mapper.nextParticipationId();
				dto.setParticipationId(participationId);
				dto.setParticipationStatus(0); // 진행
				insertParticipation(dto);
			} else {
				dto.setParticipationId(activePart.getParticipationId());
			}

			// 3) 순서/중복 방지
			Integer maxDay = mapper.selectMaxDayNumber(dto.getParticipationId()); // null -> 0
			int expectedNext = (maxDay == null ? 1 : (maxDay + 1));
			int dup = mapper.existsPostByParticipationAndDay(dto.getParticipationId(), dto.getDayNumber());

			// 순서/중복 체크
			log.info("[SPECIAL] maxDay={}, expectedNext={}, dup={}", maxDay, expectedNext, dup);

			if (dto.getDayNumber() > expectedNext) {
				throw new IllegalStateException("이전 일차 인증부터 완료해야 합니다. 다음 예상 일차: " + expectedNext);
			}
			if (dup > 0) {
				throw new IllegalStateException(dto.getDayNumber() + "일차 인증은 이미 등록되었습니다.");
			}

			// 4) 파일 저장
			String saveFilename = null;
			if (photoFile != null && !photoFile.isEmpty()) {
				String challengePath = storageService.getRealPath("/uploads/challenge");
				saveFilename = storageService.uploadFileToServer(photoFile, challengePath);
				dto.setPhotoUrl(saveFilename);
			}

			// 5) 인증글/사진 INSERT (대기)
			Long postId = mapper.nextPostId();
			dto.setPostId(postId);
			dto.setApprovalStatus(0); // 대기
			dto.setIsPublic("Y");
			mapper.insertCertificationPost(dto);

			if (saveFilename != null) {
				Long photoId = mapper.nextPhotoId();
				dto.setPhotoId(photoId);
				mapper.insertCertificationPhoto(dto);
			}

			// 저장 결과
			log.info("[SPECIAL] saved postId={}, photoFile={}", postId, saveFilename);

			// 6) 상태는 진행 유지. 포인트는 관리자 승인 완료 시 별도 로직에서 지급.

		} catch (Exception e) {
			log.error("submitSpecialDay failed:", e);
			throw e;
		}
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public void requestSpecialFinalApproval(long participationId, long memberId) throws Exception {
		Challenge part = mapper.findParticipationById(participationId);
		if (part == null || !part.getMemberId().equals(memberId)) {
			throw new IllegalStateException("권한이 없습니다.");
		}
		int cnt = mapper.countSpecialPosts(participationId);
		if (cnt < 3)
			throw new IllegalStateException("3일 인증이 모두 필요합니다.");

		Challenge upd = new Challenge();
		upd.setParticipationId(participationId);
		upd.setParticipationStatus(1); // 승인대기
		mapper.updateParticipation(upd);
	}

	@Override
	public Integer getNextSpecialDay(long challengeId, long memberId) {
		try {
			// 진행/대기 중 참여건(최근 1건)
			Challenge part = mapper.selectActiveParticipation(memberId, challengeId);
			if (part == null)
				return 1; // 아직 시작안했으면 1일차

			Long participationId = part.getParticipationId();
			Integer maxDay = mapper.selectMaxDayNumber(participationId); // null이면 0 취급
			int doneMax = (maxDay == null ? 0 : maxDay);

			if (doneMax >= 3)
				return null; // 1~3일 모두 완료면 null, 아니면 다음 일차
			return doneMax + 1;
		} catch (Exception e) {
			log.warn("getNextSpecialDay error", e);

			return 1; // 1리틴

		}

	}

	@Override
	public List<Challenge> listMyChallenges(long memberId) {
		try {
			return mapper.listMyChallenges(memberId);
		} catch (Exception e) {
			log.error("listMyChallenges error: ", e);
		}
		return List.of();
	}

	@Override
	public int countMyChallenges(long memberId) {
		try {
			return mapper.countMyChallenges(memberId);
		} catch (Exception e) {
			log.error("countMyChallenges error:", e);
			return 0;
		}
	}

	@Override
	public List<Challenge> listMyChallengesPaged(long memberId, int offset, int size) {
		try {
			return mapper.listMyChallengesPaged(memberId, offset, size);
		} catch (Exception e) {
			log.error("listMyChallengesPaged error:", e);
			return List.of();
		}
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int updatePostVisibility(long postId, long memberId, String isPublic) throws Exception {
		if (!"Y".equals(isPublic) && !"N".equals(isPublic)) {
			throw new IllegalArgumentException("isPublic must be 'Y' or 'N'");
		}
		return mapper.updatePostVisibility(postId, memberId, isPublic);
	}

	@Override
	public int countPublicSpecialPosts(String kwd) {
		try {
			return mapper.countPublicSpecialPosts(kwd);
		} catch (Exception e) {
			log.error("countPublicSpecialPosts error:", e);
			return 0;
		}
	}

	@Override
	public List<Challenge> listPublicSpecialPostsPaged(int offset, int size, String sort, String kwd) {
		try {

			int pageSize = (size <= 0 || size > 60) ? 12 : size;
			String s = (sort == null || sort.isBlank()) ? "RECENT" : sort;

			return mapper.listPublicSpecialPostsPaged(offset, pageSize, s, kwd);
		} catch (Exception e) {
			log.error("listPublicSpecialPostsPaged error:", e);
			return List.of();
		}
	}

	@Override
	public int countMySpecialPosts(long memberId, Long challengeId, String kwd) {
		try {
			return mapper.countMySpecialPosts(memberId, challengeId, kwd);
		} catch (Exception e) {
			log.error("countMySpecialPosts :", e);
		}
		return 0;
	}

	@Override
	public List<Challenge> listMySpecialPostsPaged(long memberId, Long challengeId, int offset, int size, String kwd) {
		try {
			return mapper.listMySpecialPostsPaged(memberId, challengeId, offset, size, kwd);

		} catch (Exception e) {
			log.error("listMySpecialPostsPaged :", e);
		}
		return List.of();
	}

	@Override
	public Challenge findPublicSpecialPost(long postId) {
		try {
			return mapper.findPublicSpecialPost(postId);
		} catch (Exception e) {
			log.error("findPublicSpecialPost error: ", e);
		}
		return null;
	}

	@Override
	public List<String> listPostPhotos(long postId) {
		try {
			return mapper.listPostPhotos(postId);
		} catch (Exception e) {
			log.error("listPostPhotos :", e);
		}
		return List.of();
	}

	@Override
	public List<Challenge> listSpecialBundlesPaged(int offset, int size, String sort) {
		try {
			int pageSize = (size <= 0 || size > 60) ? 12 : size;
			String s = (sort == null || sort.isBlank()) ? "RECENT" : sort;
			return mapper.listSpecialBundlesPaged(offset, pageSize, s);
		} catch (Exception e) {
			log.error("listSpecialBundlesPaged:", e);
			return List.of();
		}
	}

	@Override
	public List<Challenge> listPublicThreadByParticipation(long participationId) {
		try {
			return mapper.listPublicThreadByParticipation(participationId);
		} catch (Exception e) {
			log.error("listPublicThreadByParticipation:", e);
			return List.of();
		}
	}
}