package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.GongguOrder;
import com.sp.app.model.GongguProduct;
import com.sp.app.model.GongguProductDeliveryRefundInfo;

public interface GongguService {
	public List<GongguProduct> listGongguProducts(Map<String, Object> map) throws Exception;
	public int dataCount(Map<String, Object> map) throws Exception;
	
	public List<GongguProduct> listPackageByCategoryId(long categoryId) throws Exception;

	public GongguProduct findById(Map<String, Object> map) throws Exception;

    public List<GongguProduct> listGongguProductPhoto(long gongguProductId) throws Exception;
    
    public GongguProductDeliveryRefundInfo listDeliveryRefundInfo() throws Exception;
    
    public List<GongguProductDeliveryRefundInfo> listDeliveryFee() throws Exception;

    public int getParticipantCount(long gongguProductId) throws Exception;
    
    public List<GongguOrder> didIBuyProduct(Map<String, Object> map) throws Exception;
    
    public String findDetailInfoById(long gongguProductId) throws Exception;
}


