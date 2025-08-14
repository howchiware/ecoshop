package com.sp.app.admin.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.sp.app.admin.mapper.CategoryManageMapper;
import com.sp.app.admin.model.CategoryManage;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class CategoryManageServiceImpl implements CategoryManageService{
	private final CategoryManageMapper mapper;
	
	@Override
	public List<CategoryManage> listCategory() throws Exception {
		try {
			List<CategoryManage> listCategory = mapper.listCategory();

			return listCategory;
		} catch (Exception e) {
			log.info("listCategory : ", e);
			throw e;
		}
	}

	@Override
	public void insertCategory(CategoryManage dto) throws Exception{
		try {
			mapper.insertCategory(dto);
		} catch (Exception e) {
			log.info("insertCategory : ", e);
			throw e;
		}
	}

	@Override
	public void updateCategory(CategoryManage dto) throws Exception {
		try {
			mapper.updateCategory(dto);
		} catch (Exception e) {
			log.info("updateCategory : ", e);
			throw e;
		}
	}
	
	@Override
	public void deleteCategory(long categoryId) throws Exception {
		try {
			mapper.deleteCategory(categoryId);
		} catch (Exception e) {
			log.info("deleteCategory : ", e);
			throw e;
		}
	}
}
