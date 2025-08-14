package com.sp.app.admin.service;

import java.util.List;

import com.sp.app.admin.model.CategoryManage;

public interface CategoryManageService {
	
	public List<CategoryManage> listCategory() throws Exception;
	public void insertCategory(CategoryManage dto) throws Exception;
	public void updateCategory(CategoryManage dto) throws Exception;
	public void deleteCategory(long categoryId) throws Exception;
}
