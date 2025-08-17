package com.sp.app.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Product;

@Mapper
public interface ProductMapper {
	public List<Product> listProductByCategoryId(long categoryId) throws Exception;
}
