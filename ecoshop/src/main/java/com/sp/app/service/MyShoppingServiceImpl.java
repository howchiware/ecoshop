package com.sp.app.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.MyShoppingMapper;
import com.sp.app.model.Destination;
import com.sp.app.model.Point;
import com.sp.app.model.ProductLike;
import com.sp.app.model.ProductOrder;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class MyShoppingServiceImpl implements MyShoppingService {
	private final MyShoppingMapper mapper;

	@Override
	public void insertCart(ProductOrder dto) throws Exception {
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("memberId", dto.getMemberId());
			
			for(int i = 0; i < dto.getStockNums().size(); i++) {
				dto.setProductCode(dto.getProductCodes().get(i));
				dto.setStockNum(dto.getStockNums().get(i));
				dto.setQty(dto.getBuyQtys().get(i));
				
				map.put("stockNum", dto.getStockNums().get(i));
				
				if(mapper.findByCartId(map) == null) {
					mapper.insertCart(dto);
				} else {
					mapper.updateCart(dto);
				}
			}
			
		} catch (Exception e) {
			log.info("insertCart : ", e);
			
			throw e;
		}
	}

	@Override
	public List<ProductOrder> listCart(Long memberId) {
		List<ProductOrder> list = null;
		
		try {
			list = mapper.listCart(memberId);
			
			for(ProductOrder dto : list) {
				dto.setProductMoney(dto.getPrice() * dto.getQty());				
			}
		} catch (Exception e) {
			log.info("listCart : ", e);
			
			throw e;
		}
		
		return list;
	}

	@Override
	public void deleteCart(Map<String, Object> map) throws Exception {
		try {
			mapper.deleteCart(map);
		} catch (Exception e) {
			log.info("deleteCart : ", e);
			
			throw e;
		}
	}

	@Override
	public void insertProductLike(Map<String, Object> map) throws SQLException {
		try {
			mapper.insertProductLike(map);
			
			Long memberId = (Long)map.get("memberId");
			
			// 최근 30개만 남기고 삭제
			mapper.deleteOldestProductLikes(memberId);
		} catch (Exception e) {
			log.info("insertProductLike : ", e);
			
			throw e;
		}
	}

	@Override
	public List<ProductLike> listProductLike(Map<String, Object> map) {
		List<ProductLike> list = null;
		
		try {
			list = mapper.listProductLike(map);
		} catch (Exception e) {
			log.info("listProductLike : ", e);
		}
		
		return list;
	}

	@Override
	public ProductLike findByProductLikeId(Map<String, Object> map) {
		ProductLike dto = null;
		
		try {
			dto = mapper.findByProductLikeId(map);
		} catch (Exception e) {
			log.info("findByProductLikeId : ", e);
		}
		
		return dto;
	}

	@Override
	public void deleteProductLike(Map<String, Object> map) throws Exception {
		try {
			mapper.deleteProductLike(map);
		} catch (Exception e) {
			log.info("deleteProductLike : ", e);
			
			throw e;
		}
	}

	@Override
	public void insertDestination(Destination dto) throws Exception {
		try {
			String tel = dto.getTel1() + "-" + dto.getTel2() + "-" + dto.getTel3();
			dto.setTel(tel);
			
			if(dto.getDefaultDest() == 1) {
				Map<String, Object> map = new HashMap<>();
				map.put("memberId", dto.getMemberId());
				map.put("defaultDest", 0);
				mapper.updateDefaultDestination(map);
			}
			
			mapper.insertDestination(dto);
			
			// 최근 10개만 남기고 삭제
			mapper.deleteOldestDestination(dto.getMemberId());			
		} catch (Exception e) {
			log.info("insertDestination : ", e);
			
			throw e;
		}
	}

	@Override
	public int destinationCount(Long memberId) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Destination> listDestination(Long memberId) {
		List<Destination> list = null;
		
		try {
			list = mapper.listDestination(memberId);
			
			for(Destination dto : list) {
				String [] tel = dto.getTel().split("-");
				if(tel.length == 3) {
					dto.setTel1(tel[0]);
					dto.setTel2(tel[1]);
					dto.setTel3(tel[2]);
				}
			}
			
		} catch (Exception e) {
			log.info("listDestination : ", e);
		}
		
		return list;
	}

	@Override
	public void updateDestination(Destination dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateDefaultDestination(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteDestination(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Destination defaultDelivery(Long memberId) {
		Destination dto = null;
		
		try {
			dto = mapper.defaultDelivery(memberId);
		} catch (Exception e) {
			log.info("defaultDelivery : ", e);
		}
		
		return dto;
	}

	@Override
	public List<Point> listPointHistory(Map<String, Object> map) {
		List<Point> list = null;
		
		try {
			list = mapper.listPointHistory(map);
			
			// - 1:적립, 2:사용, 3:소멸, 4:주문취소
			for(Point dto : list) {
				if(dto.getClassify() == 1) {
					dto.setClassifyStr("적립");
				} else if(dto.getClassify() == 2) {
					dto.setClassifyStr("사용");
				} else if(dto.getClassify() == 3) {
					dto.setClassifyStr("소멸");
				} else if(dto.getClassify() == 4) {
					dto.setClassifyStr("주문취소");
				}
			}
			
		} catch (Exception e) {
			log.info("listDestination : ", e);
		}
		
		return list;
	}
	
	@Override
	public int productLikeDataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = mapper.productLikeDataCount(map);
		} catch (Exception e) {
			log.info("productLikeDataCount : ", e);
		}
		
		return result;
	}

	@Override
	public int pointDataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = mapper.pointDataCount(map);
		} catch (Exception e) {
			log.info("pointDataCount : ", e);
		}
		
		return result;
	}

}
