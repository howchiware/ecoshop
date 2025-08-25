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
	public void insertGongguOrder(GongguOrder dto) throws Exception {
		try {
			// 주문 정보 저장
			mapper.insertGongguOrder(dto);

			// 결재 내역 저장
			mapper.insertGongguPayDetail(dto);
			
			// 상세 주문 정보 및 주문 상태 저장
		
			dto.setGongguProductId(dto.getGongguProductId());
			dto.setCnt(dto.getCnt());
				
			dto.setProductMoney(dto.getProductMoney());
			dto.setPrice(dto.getPrice());
			
			// 상세 주문 정보 저장
			mapper.insertGongguOrderDetail(dto);

			// 배송지 저장 
			mapper.insertGongguOrderDelivery(dto);
		} catch (Exception e) {
			log.info("insertGongguOrder : ", e);
			
			throw e;
		}
}

	@Override
	public List<GongguOrder> listGongguOrderProduct(List<Map<String, Long>> list) {
		List<GongguOrder> listGongguProduct = null;
		
		try {
			listGongguProduct = mapper.listGongguOrderProduct(list);
		} catch (Exception e) {
			log.info("listGongguOrderProduct : ", e);
		}
		
		return listGongguProduct;
	}


	@Override
	public GongguOrder findByGongguProduct(long gongguProductNum) {
		// TODO Auto-generated method stub
		return null;
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
