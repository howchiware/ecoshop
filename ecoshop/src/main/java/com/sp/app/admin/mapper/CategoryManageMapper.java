package com.sp.app.admin.mapper;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.CategoryManage;

@Mapper
public interface CategoryManageMapper {
	public List<CategoryManage> listCategory() throws SQLException;
	public void insertCategory(CategoryManage dto) throws SQLException;
	public void updateCategory(CategoryManage dto) throws SQLException;
	public void deleteCategory(long categoryId) throws SQLException;
}
