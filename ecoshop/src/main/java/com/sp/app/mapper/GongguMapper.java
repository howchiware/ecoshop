package com.sp.app.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.GongguProduct;
import com.sp.app.model.GongguProductDeliveryRefundInfo;


@Mapper
public interface GongguMapper {
	public List<GongguProduct> listPackageByCategoryId(long categoryId) throws Exception;
	public GongguProduct findById(long gongguProductId) throws Exception;
	
	public List<GongguProduct> listGongguProductPhoto(long gongguProductId);
	
	public GongguProductDeliveryRefundInfo listDeliveryRefundInfo();
	public List<GongguProductDeliveryRefundInfo> listDeliveryFee();
}
