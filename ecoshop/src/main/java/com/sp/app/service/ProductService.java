package com.sp.app.service;

import java.util.List;

import com.sp.app.model.Product;

public interface ProductService {
	public List<Product> listProductByCategoryId(long categoryId) throws Exception;
}
