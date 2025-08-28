package com.sp.app.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.GongguOrder;
import com.sp.app.model.GongguProduct;
import com.sp.app.model.GongguProductDeliveryRefundInfo;
import com.sp.app.model.Product;


@Mapper
public interface GongguMapper {
	public List<GongguProduct> listGongguProducts(Map<String, Object> map);
	List<GongguProduct> listPackageByCategoryId(long categoryId); 
    public int dataCount(Map<String, Object> map);
    public String findDetailInfoById(long gongguProductId) throws Exception;

	public GongguProduct findById(Map<String, Object> map) throws Exception;
	public List<GongguProduct> listGongguProductPhoto(long gongguProductId);
	
	public GongguProductDeliveryRefundInfo listDeliveryRefundInfo();
	public List<GongguProductDeliveryRefundInfo> listDeliveryFee();
	
    public int getParticipantCount(long gongguProductId);
    public List<GongguOrder> didIBuyProduct(Map<String, Object> map);
    
	public List<Product> listAllProducts() throws Exception;
	public List<Product> listFiveProducts() throws Exception;
	public List<Product> listThreeProducts() throws Exception;
	public Product findById(long productId) throws Exception;
	public Product findByCategoryId(long categoryId);

	
	
	
}
