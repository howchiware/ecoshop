package com.sp.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.GongguMapper;
import com.sp.app.model.GongguOrder;
import com.sp.app.model.GongguProduct;
import com.sp.app.model.GongguProductDeliveryRefundInfo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class GongguServiceImpl implements GongguService {
	private final GongguMapper gongguMapper;
	
	public List<GongguProduct> listGongguProducts(Map<String, Object> map) throws Exception {
	    List<GongguProduct> dtoList = null;
	    try {
	        dtoList = gongguMapper.listGongguProducts(map);

	        if (dtoList != null) {
	            for (GongguProduct dto : dtoList) {
	                long originalPrice = dto.getOriginalPrice();
	                long sale = dto.getSale();
	                
	                long gongguPrice = originalPrice;
	                if (sale > 0) {
	                    gongguPrice = (long) (originalPrice - (originalPrice * sale / 100.0));
	                }
	                dto.setGongguPrice(gongguPrice);

	                List<GongguProduct> photos = gongguMapper.listGongguProductPhoto(dto.getGongguProductId());
	                dto.setDetailPhotos(photos);
	            }
	        }
	        return dtoList;
	    } catch (Exception e) {
	        log.error("listGongguProducts : ", e);
	        throw e;
	    }
	}
    
    @Override
    public int dataCount(Map<String, Object> map) throws Exception {
        int count = 0;
        try {
            count = gongguMapper.dataCount(map);
        } catch (Exception e) {
            log.error("dataCount : ", e);
            throw e;
        }
        return count;
    }
    
	@Override
	public List<GongguProduct> listPackageByCategoryId(long categoryId) throws Exception {
	    try {
	        List<GongguProduct> dtoList = gongguMapper.listPackageByCategoryId(categoryId);

            if (dtoList != null) {
                for (GongguProduct dto : dtoList) {
                    long originalPrice = dto.getOriginalPrice();
                    long sale = dto.getSale();
                    
                    long gongguPrice = originalPrice;
                    if (sale > 0) {
                        gongguPrice = (long) (originalPrice - (originalPrice * sale / 100.0));
                    }
                    dto.setGongguPrice(gongguPrice);
                }
            }
	        return dtoList;
	    } catch (Exception e) {
	        log.error("listPackageByCategoryId : ", e);
	    }

	    return null;
	}

	@Override
    public GongguProduct findById(Map<String, Object> map) throws Exception {
        GongguProduct dto = null;
        try {
            dto = gongguMapper.findById(map); 
        } catch (Exception e) {
            log.error("findById : ", e);
            throw e;
        }
        return dto;
    }

    @Override
    public List<GongguProduct> listGongguProductPhoto(long gongguProductId) throws Exception {
        List<GongguProduct> list = null;
        try {
            list = gongguMapper.listGongguProductPhoto(gongguProductId);
        } catch (Exception e) {
            log.error("listGongguProductPhoto : " , e);
            throw e;
        }
        return list;
    }

    @Override
    public GongguProductDeliveryRefundInfo listDeliveryRefundInfo() throws Exception {
        GongguProductDeliveryRefundInfo dto = null;
        try {
            dto = gongguMapper.listDeliveryRefundInfo();
        } catch (Exception e) {
            log.error("listDeliveryRefundInfo : ", e);
            throw e;
        }
        return dto;
    }

    @Override
    public List<GongguProductDeliveryRefundInfo> listDeliveryFee() throws Exception {
        List<GongguProductDeliveryRefundInfo> list = null;
        try {
            list = gongguMapper.listDeliveryFee();
        } catch (Exception e) {
            log.error("listDeliveryFee : ", e);
            throw e;
        }
        return list;
    }

    @Override
    public int getParticipantCount(long gongguProductId) throws Exception {
        int count = 0;
        try {
            count = gongguMapper.getParticipantCount(gongguProductId);
        } catch (Exception e) {
            log.error("getParticipantCount : ", e);
            throw e;
        }
        return count;
    }

    @Override
    public List<GongguOrder> didIBuyProduct(Map<String, Object> map) throws Exception {
        List<GongguOrder> list = null;
        try {
            list = gongguMapper.didIBuyProduct(map);
        } catch (Exception e) {
            log.error("didIBuyProduct : ", e);
            throw e;
        }
        return list;
    }

    @Override
    public String findDetailInfoById(long gongguProductId) throws Exception {
        return gongguMapper.findDetailInfoById(gongguProductId);
    }


}