package com.sp.app.service;

import java.util.List;

import com.sp.app.model.GongguProduct;

public interface GongguService {
	public List<GongguProduct> listPackageByCategoryId(long categoryId) throws Exception;
}
