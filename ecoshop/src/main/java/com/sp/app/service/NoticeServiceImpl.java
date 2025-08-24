package com.sp.app.service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.NoticeMapper;
import com.sp.app.model.Notice;
import com.sp.app.common.StorageService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class NoticeServiceImpl implements NoticeService {
	private final NoticeMapper mapper;
	private final StorageService storageService;
	
	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;

		try {
			result = mapper.dataCount(map);
		} catch (Exception e) {
			log.info("dataCount : ", e);
		}

		return result;
	}

	@Override
	public List<Notice> listNoticeTop() {
		List<Notice> list = null;

		try {
			list = mapper.listNoticeTop();
		} catch (Exception e) {
			log.info("listNoticeTop : ", e);
		}

		return list;
	}

	@Override
	public List<Notice> listNotice(Map<String, Object> map) {
		List<Notice> list = null;

		try {
			list = mapper.listNotice(map);
		
			long gap;
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			LocalDateTime today = LocalDateTime.now();
			for (Notice dto : list) {
				LocalDateTime dateTime = LocalDateTime.parse(dto.getRegDate(), formatter);
				gap = dateTime.until(today, ChronoUnit.HOURS);
				dto.setGap(gap);
				
				dto.setRegDate(dto.getRegDate().substring(0, 10));
			}
			
		} catch (Exception e) {
			log.info("listNotice : ", e);
		}

		return list;
	}

	@Override
	public void updateHitCount(long noticeId) throws Exception {
		try {
			mapper.updateHitCount(noticeId);
		} catch (Exception e) {
			log.info("updateHitCount : ", e);
			
			throw e;
		}
		
	}

	@Override
	public Notice findById(long noticeId) {
		Notice dto = null;

		try {
			dto = mapper.findById(noticeId);
		} catch (Exception e) {
			log.info("findById : ", e);
		}

		return dto;
	}

	@Override
	public Notice findByPrev(Map<String, Object> map) {
		Notice dto = null;

		try {
			dto = mapper.findByPrev(map);
		} catch (Exception e) {
			log.info("findByPrev : ", e);
		}

		return dto;
	}

	@Override
	public Notice findByNext(Map<String, Object> map) {
		Notice dto = null;

		try {
			dto = mapper.findByNext(map);
		} catch (Exception e) {
			log.info("findByNext : ", e);
		}

		return dto;
	}

	@Override
	public List<Notice> listNoticeFile(long noticeId) {
		List<Notice> listFile = null;

		try {
			listFile = mapper.listNoticeFile(noticeId);
		} catch (Exception e) {
			log.info("listNoticeFile : ", e);
		}

		return listFile;
	}

	@Override
	public Notice findByFileId(long noticefileId) {
		Notice dto = null;

		try {
			dto = mapper.findByFileId(noticefileId);
		} catch (Exception e) {
			log.info("findByFileId : ", e);
		}

		return dto;
	}

	@Override
	public void deleteNoticeFile(Map<String, Object> map) throws Exception {
		try {
			mapper.deleteNoticeFile(map);
		} catch (Exception e) {
			log.info("deleteNoticeFile : ", e);
			
			throw e;
		}
		
		
	}

	@Override
	public boolean deleteUploadFile(String uploadPath, String filename) {
		return storageService.deleteFile(uploadPath, filename);
	}
	
}
