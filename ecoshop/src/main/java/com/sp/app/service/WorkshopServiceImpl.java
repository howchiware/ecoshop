package com.sp.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.WorkshopMapper;
import com.sp.app.model.Workshop;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class WorkshopServiceImpl implements WorkshopService {
	private final WorkshopMapper mapper;

	@Override
	public void insertCategory(Workshop dto, String CategoryName) {
		try {
			String name = CategoryName == null ? null : CategoryName.trim();

			dto.setCategoryName(name);
			mapper.insertProgramCategory(dto);
		} catch (Exception e) {
			log.info("insertCategory : ", e);

			throw new RuntimeException();
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

	@Override
	public void insertProgram(Workshop dto, Long categoryId, String programTitle, String programContent) {
		try {
			dto.setCategoryId(categoryId);
			dto.setProgramTitle(programTitle);
			dto.setProgramContent(programContent);

			mapper.insertProgram(dto);
		} catch (Exception e) {
			log.info("programContent : ", e);

			throw new RuntimeException();
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
		} catch (NullPointerException e) {
		} catch (Exception e) {
			log.info("deleteProgram : ", e);

			throw e;
		}

	}

}
