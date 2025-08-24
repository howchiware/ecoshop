package com.sp.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.ReportsMapper;
import com.sp.app.model.Reports;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ReportsServiceImpl implements ReportsService {
	private final ReportsMapper mapper;
	
	@Override
	public void insertReports(Reports dto) throws Exception {
		try {
			mapper.insertReports(dto);
		} catch (Exception e) {
			log.info("insertReports : ", e);
			
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
	public List<Reports> listReports(Map<String, Object> map) {
		List<Reports> list = null;
		
		try {
			list = mapper.listReports(map);
		} catch (Exception e) {
			log.info("listReports : ", e);
		}
		
		return list;
	}

	@Override
	public int dataGroupCount(Map<String, Object> map) {
		int result = 0;

		try {
			result = mapper.dataGroupCount(map);
		} catch (Exception e) {
			log.info("dataGroupCount : ", e);
		}

		return result;
	}

	@Override
	public List<Reports> listGroupReports(Map<String, Object> map) {
		List<Reports> list = null;
		
		try {
			list = mapper.listGroupReports(map);
		} catch (Exception e) {
			log.info("listGroupReports : ", e);
		}
		
		return list;
	}

	@Override
	public Reports findById(Long reportId) {
		Reports dto = null;
		
		try {
			dto = mapper.findById(reportId);
		} catch (Exception e) {
			log.info("findById : ", e);
		}
		
		return dto;
	}

	@Override
	public int dataRelatedCount(Map<String, Object> map) {
		int result = 0;

		try {
			result = mapper.dataRelatedCount(map);
		} catch (Exception e) {
			log.info("dataRelatedCount : ", e);
		}

		return result;
	}

	@Override
	public List<Reports> listRelatedReports(Map<String, Object> map) {
		List<Reports> list = null;
		
		try {
			list = mapper.listRelatedReports(map);
		} catch (Exception e) {
			log.info("listRelatedReports : ", e);
		}
		
		return list;
	}

	@Override
	public void updateReports(Reports dto) throws Exception {
		try {
			mapper.updateReports(dto);
		} catch (Exception e) {
			log.info("updateReports : ", e);
		}
	}

	@Override
	public void updateBlockPosts(Map<String, Object> map) throws Exception {
		try {
			mapper.updateBlockPosts(map);
		} catch (Exception e) {
			log.info("updateReports : ", e);
		}
	}

	@Override
	public void deletePosts(Map<String, Object> map) throws Exception {
		try {
			mapper.deletePosts(map);
		} catch (Exception e) {
			log.info("deletePosts : ", e);
		}
	}

	@Override
	public Reports findByPostsId(Map<String, Object> map) {
		Reports dto = null;
		
		try {
			dto = mapper.findByPostsId(map);
		} catch (Exception e) {
			log.info("findByPostsId : ", e);
		}
		
		return dto;
	}
	
	@Override
	public Reports getReportStats() {
		 return mapper.getReportStats();
	}
}
