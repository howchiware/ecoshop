package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sp.app.admin.mapper.NoticeManageMapper;
import com.sp.app.admin.model.NoticeManage;
import com.sp.app.common.StorageService;
import com.sp.app.exception.StorageException;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class NoticeManageServiceImpl implements NoticeManageService {
	private final NoticeManageMapper mapper;
	private final StorageService storageService;
	
	@Override
	public void insertNotice(NoticeManage dto, String uploadPath) throws Exception {
		try {
			long seq = mapper.noticeSeq();
			dto.setNoticeId(seq);

			mapper.insertNotice(dto);

			// 파일 업로드
			if (! dto.getSelectFile().isEmpty()) {
				insertNoticeFile(dto, uploadPath);
			}
		} catch (Exception e) {
			log.info("insertNotice : ", e);
			
			throw e;
		}
		
	}

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
	public List<NoticeManage> listNoticeTop() {
		List<NoticeManage> list = null;

		try {
			list = mapper.listNoticeTop();
		} catch (Exception e) {
			log.info("listNoticeTop : ", e);
		}

		return list;
	}

	@Override
	public List<NoticeManage> listNotice(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateHitCount(long num) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public NoticeManage findById(long num) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public NoticeManage findByPrev(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public NoticeManage findByNext(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateNotice(NoticeManage dto, String uploadPath) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteNotice(long num, String uploadPath) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<NoticeManage> listNoticeFile(long num) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public NoticeManage findByFileId(long fileNum) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteNoticeFile(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public boolean deleteUploadFile(String uploadPath, String filename) {
		// TODO Auto-generated method stub
		return false;
	}

	protected void insertNoticeFile(NoticeManage dto, String uploadPath) throws Exception {
		for (MultipartFile mf : dto.getSelectFile()) {
			try {
				String saveFilename =  Objects.requireNonNull(storageService.uploadFileToServer(mf, uploadPath));

				String originalFilename = mf.getOriginalFilename();
				long fileSize = mf.getSize();

				dto.setOriginalFilename(originalFilename);
				dto.setSaveFilename(saveFilename);
				dto.setFileSize(fileSize);

				mapper.insertNoticeFile(dto);
			} catch (NullPointerException e) {
			} catch (StorageException e) {
			} catch (Exception e) {
				throw e;
			}
		}
	}


}
