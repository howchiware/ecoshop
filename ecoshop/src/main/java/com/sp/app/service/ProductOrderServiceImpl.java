package com.sp.app.service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicLong;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.ProductOrderMapper;
import com.sp.app.model.Point;
import com.sp.app.model.ProductOrder;
import com.sp.app.model.ProductReview;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ProductOrderServiceImpl implements ProductOrderService {
	private final ProductOrderMapper mapper;

	private static AtomicLong count = new AtomicLong(0);
	
	@Override
	public String productOrderNumber() {
		// 상품 주문 번호 생성
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
			log.info("productOrderNumber : ", e);
		}
		
		return result;
	}

	@Override
	public void insertOrder(ProductOrder dto) throws Exception {
		try {
			// 주문 정보 저장
			mapper.insertOrder(dto);

			// 결재 내역 저장
			mapper.insertPayDetail(dto);
			
			// 상세 주문 정보 및 주문 상태 저장
			for(int i=0; i < dto.getProductCodes().size(); i++) {
				dto.setProductCode(dto.getProductCodes().get(i));
				dto.setQty(dto.getBuyQtys().get(i));
				if(dto.getOptionDetailNums().get(i) != 0) {
					dto.setOptionDetailNum(dto.getOptionDetailNums().get(i));
				}
				if(dto.getOptionDetailNums2().get(i) != 0) {
					dto.setOptionDetailNum2(dto.getOptionDetailNums2().get(i));
				}
				dto.setProductMoney(dto.getProductMoneys().get(i));
				dto.setPrice(dto.getPrices().get(i));
				dto.setPoint(dto.getPoints().get(i));

				// 상세 주문 정보 저장
				mapper.insertOrderDetail(dto);
				
				// 판매 개수만큼 재고 감소 -----
				dto.setStockNum(dto.getStockNums().get(i));
				mapper.updateProductStockDec(dto);
			}
			
			// 사용 포인트 저장(포인트 적립은 구매 확정에서)
			if(dto.getUsedPoint() > 0) {
				LocalDateTime now = LocalDateTime.now();
				String dateTime = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
				
				Point up = new Point();
				up.setMemberId(dto.getMemberId());
				up.setOrderId(dto.getOrderId());
				up.setPoints(-dto.getUsedPoint());
				up.setClassify(2); // 1:적립, 2:사용, 3:소멸, 4:주문취소/판매취소
				up.setBaseDate(dateTime);
				up.setReason("상품 구매");
				mapper.insertUserPoint(up);
			}
			
			if(dto.getPoints().size() > 0) {
				for(int p : dto.getPoints()) {
					LocalDateTime now = LocalDateTime.now();
					String dateTime = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
					
					Point up = new Point();
					up.setMemberId(dto.getMemberId());
					up.setOrderId(dto.getOrderId());
					up.setPoints(p);
					up.setClassify(1); // 1:적립, 2:사용, 3:소멸, 4:주문취소/판매취소
					up.setBaseDate(dateTime);
					up.setReason("상품 구매");
					mapper.insertUserPoint(up);
					
				}
			}
			
			// 배송지 저장 
			mapper.insertOrderDelivery(dto);
			
		} catch (Exception e) {
			log.info("insertOrder : ", e);
			
			throw e;
		}
	}

	@Override
	public List<ProductOrder> listOrderProduct(List<Map<String, Long>> list) {
		List<ProductOrder> listProduct = null;
		
		try {
			listProduct = mapper.listOrderProduct(list);
		} catch (Exception e) {
			log.info("listOrderProduct : ", e);
		}
		
		return listProduct;
	}

	@Override
	public List<ProductOrder> listOptionDetail(List<Long> detailNums) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ProductOrder findByOrderDetail(long orderDetailNum) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ProductOrder findByProduct(long productNum) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ProductOrder findByOptionDetail(long detailNum) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Point findByUserPoint(Long memberId) {
		Point dto = null;
		
		try {
			dto = mapper.findByUserPoint(memberId);
		} catch (Exception e) {
			log.info("findByUserPoint : ", e);
		}
		
		return dto;
	}

	@Override
	public List<ProductOrder> didIBuyThis(Map<String, Object> map) {
		List<ProductOrder> list = null;
		try {
			list = mapper.didIBuyThis(map);
		} catch (Exception e) {
			log.info("didIBuyThis : ", e);
		}
		
		return list;
	}

	@Override
	public ProductReview myReviewOfThis(long orderDetailId) {
		ProductReview dto = null;
		try {
			dto = mapper.myReviewOfThis(orderDetailId);
		} catch (Exception e) {
			log.info("myReviewOfThis : ", e);
		}
		
		return dto;
	}

	@Override
	public void insertPoint(ProductOrder dto) throws Exception {
		try {
			mapper.insertPoint(dto);
		} catch (Exception e) {
			log.info("myReinsertPointviewOfThis : ", e);
		}
	}

}
