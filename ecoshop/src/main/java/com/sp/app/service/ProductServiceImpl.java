package com.sp.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.ProductMapper;
import com.sp.app.model.Product;
import com.sp.app.model.ProductDeliveryRefundInfo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ProductServiceImpl implements ProductService {
	private final ProductMapper productMapper;
	
	@Override
	public List<Product> listProductByCategoryId(Map<String, Object> map) throws Exception {
		List<Product> list = null;
		try {
			list = productMapper.listProductByCategoryId(map);
			
		} catch (Exception e) {
			log.info("listProductByCategoryId :", e);
		}
		
		return list;
	}
	

	@Override
	public List<Product> listAllProducts() throws Exception {
		List<Product> list = null;
		try {
			list = productMapper.listAllProducts();
			
		} catch (Exception e) {
			log.info("listAllProducts :", e);
		}
		
		return list;
	}

	@Override
	public Product findById(long productId) throws Exception {
		Product dto = null;
		try {
			dto = productMapper.findById(productId);
		} catch (Exception e) {
			log.info("findById :", e);
		}
		
		return dto;
	}
	
	@Override
	public Product findByCategoryId(long categoryId) {
		Product dto = null;
		
		try {
			dto = productMapper.findByCategoryId(categoryId);
		} catch (Exception e) {
			log.info("findByCategoryId : ", e);
		}
		
		return dto;
	}

	@Override
	public List<Product> listProductPhoto(long productId) {
		List<Product> list = null;
		
		try {
			list = productMapper.listProductPhoto(productId);
		} catch (Exception e) {
			log.info("listProductPhoto :", e);
		}
		
		return list;
	}

	@Override
	public List<Product> listProductOption(long productNum) {
		List<Product> list = null;
		
		try {
			list = productMapper.listProductOption(productNum);
		} catch (Exception e) {
			log.info("listProductOption : ", e);
		}
		
		return list;
	}

	@Override
	public List<Product> listOptionDetail(long optionNum) {
		List<Product> list = null;
		
		try {
			list = productMapper.listOptionDetail(optionNum);
		} catch (Exception e) {
			log.info("listOptionDetail : ", e);
		}
		
		return list;
	}

	@Override
	public List<Product> listOptionDetailStock(Map<String, Object> map) {
		List<Product> list = null;
		
		try {
			// 옵션별 상품 재고
			list = productMapper.listOptionDetailStock(map);
		} catch (Exception e) {
			log.info("listOptionDetailStock : ", e);
		}
		
		return list;
	}

	@Override
	public ProductDeliveryRefundInfo listDeliveryRefundInfo() {
		ProductDeliveryRefundInfo dto = null;
		
		try {
			dto = productMapper.listDeliveryRefundInfo();
			
			dto.setDeliveryInfo(dto.getDeliveryInfo().replaceAll("\n", "<br>"));
			dto.setRefundInfo(dto.getRefundInfo().replaceAll("\n", "<br>"));
				
		} catch (Exception e) {
			log.info("listDeliveryRefundInfo : ", e);
		}
		
		return dto;
	}

	@Override
	public List<ProductDeliveryRefundInfo> listDeliveryFee() {
		List<ProductDeliveryRefundInfo> list = null;
		
		try {
			list = productMapper.listDeliveryFee();
		} catch (Exception e) {
			log.info("listDeliveryFee : ", e);
		}
		
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = productMapper.dataCount(map);
		} catch (Exception e) {
			log.info("dataCount : ", e);
		}
		return result;
	}


}
