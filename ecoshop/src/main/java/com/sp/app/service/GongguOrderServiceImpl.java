package com.sp.app.service;

import java.util.Calendar;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicLong;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.GongguOrderMapper;
import com.sp.app.model.GongguOrder;
import com.sp.app.model.GongguReview;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class GongguOrderServiceImpl implements GongguOrderService {
	private final GongguOrderMapper mapper;
	private static AtomicLong count = new AtomicLong(0);
	
	@Override
	public String gongguproductOrderNumber() {
		String result = "";
		
		try {
			Calendar cal = Calendar.getInstance();
			String y = String.format("%04d", cal.get(Calendar.YEAR));
			String m = String.format("%02d", (cal.get(Calendar.MONTH) + 1));
			String d = String.format("%03d", cal.get(Calendar.DATE) * 7);
			
			String preNumber = y + m + d;
			String savedPreNumber = "0";
			long savedLastNumber = 0;
			String maxOrderNumber = mapper.findByMaxOrderNumber();
			if(maxOrderNumber != null && maxOrderNumber.length() > 9) {
				savedPreNumber = maxOrderNumber.substring(0, 9);
				savedLastNumber = Long.parseLong(maxOrderNumber.substring(9));
			}
			
			long lastNumber = 1;
			if(! preNumber.equals(savedPreNumber)) {
				count.set(0);
				lastNumber = count.incrementAndGet();
			} else {
				lastNumber = count.incrementAndGet();
				
				if( savedLastNumber >= lastNumber )  {
					count.set(savedLastNumber);
					lastNumber = count.incrementAndGet();
				}
			}
			
			result = preNumber + String.format("%09d", lastNumber);
			
		} catch (Exception e) {
			log.info("gongguproductOrderNumber : ", e);
		}
		
		return result;
	}

	@Override
	public void insertGongguOrder(GongguOrder dto, long gongguProductId) throws Exception {
	    try {
	        int cnt = 1;
	        dto.setGongguProductId(gongguProductId);
	        dto.setCnt(cnt);

	        GongguOrder productInfo = mapper.findByGongguProduct(gongguProductId);

	        int salePrice = productInfo.getSalePrice();
	        int totalAmount = cnt * salePrice;
	        int deliveryCharge = totalAmount >= 30000 ? 0 : 2000;
	        int totalPayment = totalAmount + deliveryCharge;

	        dto.setPrice(salePrice); 
	        dto.setTotalAmount(totalAmount);
	        dto.setDeliveryCharge(deliveryCharge);
	        dto.setPayment(totalPayment); 
	        dto.setItemCount(1);
	        
	        mapper.insertGongguOrder(dto);
	        mapper.insertGongguPayDetail(dto);
	        mapper.insertGongguOrderDelivery(dto);
	        mapper.insertGongguOrderDetail(dto);
	        
	    } catch (Exception e) {
	        log.error("insertGongguOrder : ", e);
	        throw e;
	    }
	}

	@Override
	public List<GongguOrder> listGongguOrderProduct(List<GongguOrder> list) {
		List<GongguOrder> listGongguProduct = null;
		
		try {
			listGongguProduct = mapper.listGongguOrderProduct(list);
		} catch (Exception e) {
			log.info("listGongguOrderProduct : ", e);
		}
		
		return listGongguProduct;
	}


	@Override
	public GongguOrder findByGongguProduct(long gongguProductId) {
	    GongguOrder dto = null;

	    try {
	        dto = mapper.findByGongguProduct(gongguProductId);
	    } catch (Exception e) {
	        log.error("findByGongguProduct : ", e);
	    }

	    return dto;
	}

	@Override
	public List<GongguOrder> didIBuyGonggu(Map<String, Object> map) {
		List<GongguOrder> list = null;
		try {
			list = mapper.didIBuyGonggu(map);
		} catch (Exception e) {
			log.info("didIBuyGonggu : ", e);
		}
		
		return list;
	}


	@Override
	public GongguReview myReviewOfGonggu(long gongguOrderDetailId) {
		GongguReview dto = null;
		try {
			dto = mapper.myReviewOfGonggu(gongguOrderDetailId);
		} catch (Exception e) {
			log.info("myReviewOfGonggu : ", e);
		}
		
		return dto;
	}

}
