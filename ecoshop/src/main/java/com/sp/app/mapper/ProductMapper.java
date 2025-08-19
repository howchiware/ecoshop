package com.sp.app.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Product;
import com.sp.app.model.ProductDeliveryRefundInfo;

@Mapper
public interface ProductMapper {
	public List<Product> listProductByCategoryId(long categoryId) throws Exception;
	public Product findById(long productId) throws Exception;
	
	public List<Product> listProductPhoto(long productId);
	
	public List<Product> listProductOption(long productId);
	public List<Product> listOptionDetail(long optionNum);
	public List<Product> listOptionDetailStock(Map<String, Object> map);
	
	public ProductDeliveryRefundInfo listDeliveryRefundInfo();
	public List<ProductDeliveryRefundInfo> listDeliveryFee();
}
