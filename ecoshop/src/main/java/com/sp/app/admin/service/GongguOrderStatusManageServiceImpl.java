package com.sp.app.admin.service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Service;

import com.sp.app.admin.mapper.GongguOrderManageMapper;
import com.sp.app.admin.model.GongguOrderDetailManage;
import com.sp.app.admin.model.GongguOrderManage;

import com.sp.app.mapper.GongguOrderMapper;
import com.sp.app.state.OrderState;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class GongguOrderStatusManageServiceImpl implements GongguOrderStatusManageService {
	private final GongguOrderManageMapper mapper;
	private final GongguOrderMapper orderMapper;
	
	@Override
	public int orderCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = mapper.orderCount(map);
		} catch (Exception e) {
			log.info("orderCount : ", e);
		}
		
		return result;
	}
	
	@Override
	public List<GongguOrderManage> listOrder(Map<String, Object> map) {
		List<GongguOrderManage> list = null;

		// OrderState.ORDERSTATEINFO : 주문상태 정보
		// OrderState.DETAILSTATEMANAGER : 주문상세상태 정보(관리자)
		
		try {
			list = mapper.listOrder(map);
			for(GongguOrderManage dto : list) {
				dto.setOrderStateInfo(OrderState.ORDERSTATEINFO[dto.getOrderState()]);
			}
		} catch (Exception e) {
			log.info("listOrder : ", e);
		}
		
		return list;
	}
	
	@Override
	public GongguOrderManage findByOrderId(String orderId) {
		GongguOrderManage dto = null;
		
		// OrderState.ORDERSTATEINFO : 주문상태 정보
		
		try {
			dto = Objects.requireNonNull(mapper.findByOrderId(orderId));
			
			dto.setOrderStateInfo(OrderState.ORDERSTATEINFO[dto.getOrderState()]);
		} catch (NullPointerException e) {
		} catch (Exception e) {
			log.info("findByOrderId : ", e);
		}
		
		return dto;
	}
	
	@Override
	public List<GongguOrderDetailManage> listOrderDetails(String orderId) {
		List<GongguOrderDetailManage> list = null;

		// OrderState.DETAILSTATEMANAGER : 주문상세상태 정보(관리자)
		
		try {
			list = mapper.listOrderDetails(orderId);
			
			for(GongguOrderDetailManage dto : list) {
				dto.setDetailStateInfo(OrderState.DETAILSTATEMANAGER[dto.getDetailState()]);
			}
		} catch (Exception e) {
			log.info("listOrderDetails : ", e);
		}
		
		return list;
	}
	
	@Override
	public int detailCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = mapper.detailCount(map);
		} catch (Exception e) {
			log.info("detailCount : ", e);
		}
		
		return result;
	}
	
	@Override
	public List<GongguOrderDetailManage> listDetails(Map<String, Object> map) {
		List<GongguOrderDetailManage> list = null;
		
		try {
			list = mapper.listDetails(map);
			
			for(GongguOrderDetailManage dto : list) {
				dto.setDetailStateInfo(OrderState.DETAILSTATEMANAGER[dto.getDetailState()]);
			}			
		} catch (Exception e) {
			log.info("listDetails : ", e);
		}
		return list;
	}
	
	@Override
	public GongguOrderDetailManage findByDetailId(Long gongguOrderDetailId) {
		GongguOrderDetailManage dto = null;
		
		try {
			dto = Objects.requireNonNull(mapper.findByDetailId(gongguOrderDetailId));
			
			dto.setDetailStateInfo(OrderState.DETAILSTATEMANAGER[dto.getDetailState()]);
		} catch (NullPointerException e) {
		} catch (Exception e) {
			log.info("findByDetailId : ", e);
		}
		
		return dto;
	}
	
	@Override
	public void updateOrder(String mode, Map<String, Object> map) throws Exception {
		try {
			if(mode.equals("state")) {
				mapper.updateOrderState(map);
			} else if(mode.equals("invoiceNumber")) { // 송장번호 등록
				mapper.updateOrderInvoiceNumber(map);
			} else if(mode.equals("delivery")) { // 배송 변경
				mapper.updateOrderState(map);
			} else if(mode.equals("cancelAmount")) { // 주문취소 금액 수정
				mapper.updateCancelAmount(map);
			}
		} catch (Exception e) {
			log.info("updateOrder : ", e);
			
			throw e;
		}
	}
	
	@Override
	public void updateOrderDetailState(Map<String, Object> map) throws Exception {
		try {
			String orderNum = (String)map.get("orderId");
			int detailState = Integer.parseInt((String)map.get("detailState"));
			int productMoney = Integer.parseInt((String)map.get("productMoney"));
			int payment = Integer.parseInt((String)map.get("payment"));
			
			// 주문에 대한 전체 취소 금액 가져오기
			int cancelAmount = 0;
			if(detailState == 3 || detailState == 5 || detailState == 12) {
				// totalCancelAmount = dao.selectOne("adminOrder.readTotalCancelAmount", orderNum);
				cancelAmount = Integer.parseInt((String)map.get("cancelAmount"));
			}
			
			// orderDetail 테이블 상태 변경
			mapper.updateOrderDetailState(map);
			
			// detailStateInfo 테이블에 상태 변경 내용 및 날짜 저장
			mapper.insertDetailStateInfo(map);

			// productOrder 테이블 취소금액 변경
			// 환불-개별판매취소(관리자),주문취소완료(관리자),반품완료(관리자)
			if(detailState == 3 || detailState == 5 || detailState == 12) {
				cancelAmount += productMoney;
				int amount = cancelAmount;
				if(cancelAmount > payment) {
					amount = payment;
				}
				
				map.put("cancelAmount", amount);

				mapper.updateCancelAmount(map);
				
				// 주문정보의 상태 변경
				int totalOrderCount = mapper.totalOrderCount(orderNum);
				if(totalOrderCount == 0) { // 모두 취소
					if(detailState == 3) {
						map.put("orderState", 6); // 전체판매취소(관리자)
					} else if(detailState == 5) {
						map.put("orderState", 8); // 전체주문취소
					} else {
						map.put("orderState", 10); // 전체반품취소
					}
				} else { // 부분 취소
					if(detailState == 3) {
						map.put("orderState", 7); // 부분판매취소(관리자)
					} else if(detailState == 5) {
						map.put("orderState", 9); // 부분주문취소
					} else {
						map.put("orderState", 11); // 부분반품취소
					}
				}
				mapper.updateOrderState(map);
				}
			} catch (Exception e) {
				log.info("updateOrderDetailState : ", e);
				
				throw e;
			}
		}
		
	@Override
	public List<Map<String, Object>> listDeliveryCompany() {
		List<Map<String, Object>> list = null;
		
		try {
			list = mapper.listDeliveryCompany();
		} catch (Exception e) {
			log.info("listDeliveryCompany : ", e);
		}
		
		return list;
	}
	
	@Override
	public List<Map<String, Object>> listDetailStateInfo(long gongguOrderDetailId) {
		List<Map<String, Object>> list = null;
		
		// OrderState.DETAILSTATEMANAGER : 주문상세상태 정보(관리자)
		try {
			list = mapper.listDetailStateInfo(gongguOrderDetailId);
			
			String detailStateInfo;
			for(Map<String, Object> map : list) {
				int detailState = ((BigDecimal) map.get("DETAILSTATE")).intValue(); 
				detailStateInfo = OrderState.DETAILSTATEMANAGER[detailState];
				map.put("DETALSTATEINFO", detailStateInfo);
			}
		} catch (Exception e) {
			log.info("listDetailStateInfo : ", e);
		}
		
		return list;
	}
	
	@Override
	public GongguOrderManage findByDeliveryId(String orderId) {
		GongguOrderManage dto = null;
		
		try {
			dto = mapper.findByDeliveryId(orderId);
		} catch (Exception e) {
			log.info("findByDeliveryId : ", e);
		}
		
		return dto;
	}
	
	@Override
	public Map<String, Object> findByPayDetail(String orderId) {
		Map<String, Object> map = null;
		
		try {
			map = mapper.findByPayDetail(orderId);
		} catch (Exception e) {
			log.info("findByPayDetail : ", e);
		}
		
		return map;
	}

	@Override
	public GongguOrderManage findPrevByOrderId(String orderId) {
		GongguOrderManage dto = null;
		
		// OrderState.ORDERSTATEINFO : 주문상태 정보
		
		try {
			dto = Objects.requireNonNull(mapper.findPrevByOrderId(orderId));
			
		} catch (NullPointerException e) {
		} catch (Exception e) {
			log.info("findPrevByOrderId : ", e);
		}
		
		return dto;
	}
	
	@Override
	public GongguOrderManage findNextByOrderId(String orderId) {
		GongguOrderManage dto = null;
		
		// OrderState.ORDERSTATEINFO : 주문상태 정보
		
		try {
			dto = Objects.requireNonNull(mapper.findNextByOrderId(orderId));
			
		} catch (NullPointerException e) {
		} catch (Exception e) {
			log.info("findPrevByOrderId : ", e);
		}
		
		return dto;
	}
}
