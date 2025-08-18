package com.sp.app.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.ProductMapper;
import com.sp.app.model.Product;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ProductServiceImpl implements ProductService {
	private final ProductMapper productMapper;
	
	@Override
	public List<Product> listProductByCategoryId(long categoryId) throws Exception {
		try {
			return productMapper.listProductByCategoryId(categoryId);
		} catch (Exception e) {
			log.info("listProductByCategoryId :", e);
		}
		
		return null;
	}

}
