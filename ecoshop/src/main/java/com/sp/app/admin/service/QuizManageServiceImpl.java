package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Service;

import com.sp.app.admin.mapper.QuizManageMapper;
import com.sp.app.admin.model.QuizManage;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class QuizManageServiceImpl implements QuizManageService {

	private final QuizManageMapper mapper;

	
	@Override
	public List<QuizManage> listQuiz(Map<String, Object> map) {
		
		List<QuizManage> list = null;
		
		try {
			list = mapper.listQuiz(map);
			
		} catch (Exception e) {
			log.info("listQuiz", e);
		}
		
		return list;
		
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		
		int result = 0;
		
		try {
			result = mapper.dataCount(map);
		} catch (Exception e) {
			log.info("dataCount: ", e);
		}
		
		return result;
	}

	@Override
	public void insertQuiz(QuizManage dto) throws Exception {
		
		try {	
			mapper.insertQuiz(dto);
		} catch (Exception e) {
			log.info("inserQuiz: ", e);
		}
	}
	
	@Override
	public QuizManage findByQuiz(long quizId) {

		QuizManage dto = null;
		
		try {
			dto = Objects.requireNonNull(mapper.findByQuiz(quizId));
		} catch (NullPointerException e) {
		} catch (ArrayIndexOutOfBoundsException e) {	
		} catch (Exception e) {
			log.info("findByQuiz: ", e);
		}
		
		return dto;		
	}


	@Override
	public void updateQuiz(QuizManage dto) throws Exception {
		
		try {
			mapper.updateQuiz(dto);
		} catch (Exception e) {
			log.info("updateQuiz: ", e);
			throw e;
		}
		
	}

	@Override
	public void deleteQUiz(long quizId) throws Exception {
		
		try {
			mapper.deleteQuiz(quizId);
		} catch (Exception e) {
			log.info("updateQuiz: ", e);
			throw e;
		}
		
	}

	
	
	

}
