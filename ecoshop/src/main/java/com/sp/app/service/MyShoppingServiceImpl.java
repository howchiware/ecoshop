package com.sp.app.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.MyShoppingMapper;
import com.sp.app.model.Destination;
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
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<ProductOrder> listCart(Long member_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteCart(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void insertLike(Map<String, Object> map) throws SQLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<ProductLike> listLike(Long member_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ProductLike findByLikeId(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteLike(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void insertDestination(Destination dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int destinationCount(Long member_id) {
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

}
