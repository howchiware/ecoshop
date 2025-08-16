package com.sp.app.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.GongguProduct;

@Mapper
public interface GongguMapper {
	public List<GongguProduct> listPackageByCategoryId(long categoryId) throws Exception;
}
