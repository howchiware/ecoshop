package com.sp.app.service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.concurrent.atomic.AtomicLong;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.GongguOrderMapper;
import com.sp.app.model.GongguOrder;
import com.sp.app.model.GongguPayment;
import com.sp.app.model.GongguReview;
import com.sp.app.state.OrderState;

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
	public boolean didIBuyGonggu(Map<String, Object> map) {
	    try {
	        int count = mapper.countBuyGonggu(map); 
	        return count > 0;
	    } catch (Exception e) {
	        log.info("didIBuyGonggu : ", e);
	    }
	    return false;
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

	@Override
	public int countGongguPayment(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = mapper.countGongguPayment(map);
		} catch (Exception e) {
			log.info("countGongguPayment : ", e);
		}
		
		return result;
	}

	// 결제리스트
	@Override
	public List<GongguPayment> listGongguPayment(Map<String, Object> map) {
		List<GongguPayment> gongguList = null;
		
		try {
			// OrderState.ORDERSTATEINFO : 주문상태 정보
			// OrderState.DETAILSTATEINFO : 주문상세상태 정보
			
			String orderState;
			
			gongguList = mapper.listGongguPayment(map);

			Date endDate = new Date();
			long gap;
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			
			for(GongguPayment dto : gongguList) {
				dto.setOrderDate(dto.getOrderDate().replaceAll("-", ".").substring(5,10));
				dto.setOrderStateInfo(OrderState.ORDERSTATEINFO[dto.getOrderState()]);
				dto.setDetailStateInfo(OrderState.DETAILSTATEINFO[dto.getDetailState()]);
				
				if(dto.getOrderState() == 7 || dto.getOrderState() == 9) {
					orderState = "결제완료";
				} else {
					orderState = OrderState.ORDERSTATEINFO[dto.getOrderState()];
				}
				if(dto.getDetailState() > 0) {
					orderState = OrderState.DETAILSTATEINFO[dto.getDetailState()];
				}
				dto.setStateProduct(orderState);
				
				// 배송 완료후 지난 일자
				if(dto.getOrderState() == 5 && dto.getStateDate() != null) {
					Date beginDate = formatter.parse(dto.getStateDate());
					gap = (endDate.getTime() - beginDate.getTime()) / (24 * 60 * 60 * 1000);
					dto.setAfterDelivery(gap);
				}
			}

		} catch (Exception e) {
			log.info("listGongguPayment : ", e);
		}
		
		return gongguList;
	}

	// 구매 리스트
	@Override
	public List<GongguPayment> listGongguPurchase(Map<String, Object> map) {
		List<GongguPayment> gongguList = null;
		
		try {
			gongguList = mapper.listGongguPurchase(map);
		} catch (Exception e) {
			log.info("listGongguPurchase : ", e);
		}
		
		return gongguList;
	}

	@Override
	public GongguPayment findByGongguOrderDetail(Map<String, Object> map) {
		GongguPayment dto = null;
		
		try {
			dto = Objects.requireNonNull(mapper.findByGongguOrderDetail(map));
			
			if((dto.getOrderState() == 1 || dto.getOrderState() == 7 || dto.getOrderState() == 9)
					&& dto.getDetailState() == 0) {
				dto.setDetailStateInfo("상품 준비중");
			} else {
				dto.setDetailStateInfo(OrderState.DETAILSTATEMANAGER[dto.getDetailState()]);
			}
			
		} catch (NullPointerException e) {
		} catch (Exception e) {
			log.info("findByOrderDetail : ", e);
		}
		
		return dto;
	}

	@Override
	public GongguOrder findByGongguOrderDelivery(Map<String, Object> map) {
		GongguOrder dto = null;
		
		try {
			dto = mapper.findByGongguOrderDelivery(map);
		} catch (Exception e) {
			log.info("findByGongguOrderDelivery : ", e);
		}
		
		return dto;
	}

	@Override
	public void updateGongguOrderDetailState(Map<String, Object> map) throws Exception {
		try {
			// gongguOrderDetail 테이블 상태 변경
			mapper.updateGongguOrderDetailState(map);
			
			// gongguDetailStateInfo 테이블에 상태 변경 내용 및 날짜 저장
			mapper.insertGongguDetailStateInfo(map);
			
		} catch (Exception e) {
			log.info("updateGongguOrderDetailState : ", e);
			
			throw e;
		}
	}

	@Override
	public void updateGongguOrderHistory(long gongguOrderDetailId) throws Exception {
		try {
			mapper.updateGongguOrderHistory(gongguOrderDetailId);
		} catch (Exception e) {
			log.info("updateOrderHistory : ", e);
			
			throw e;
		}
	}

}
