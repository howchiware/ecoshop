package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.Product;
import com.sp.app.model.ProductDeliveryRefundInfo;

public interface ProductService {
	public int dataCount(Map<String, Object> map);
	public List<Product> listProductByCategoryId(Map<String, Object> map) throws Exception;
	public List<Product> listAllProducts() throws Exception;
	// public List<Product> listProductByCategoryId(long categoryId) throws Exception;
	public Product findById(long productId) throws Exception;
	public Product findByCategoryId(long categoryId);
	
	public List<Product> listProductPhoto(long productId);
	
	public List<Product> listProductOption(long productId);
	public List<Product> listOptionDetail(long optionNum);
	public List<Product> listOptionDetailStock(Map<String, Object> map);
	
	public ProductDeliveryRefundInfo listDeliveryRefundInfo();
	public List<ProductDeliveryRefundInfo> listDeliveryFee();
}
