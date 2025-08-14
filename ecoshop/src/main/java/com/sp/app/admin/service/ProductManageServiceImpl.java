package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.admin.model.ProductManage;
import com.sp.app.admin.model.ProductStockManage;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ProductManageServiceImpl implements ProductManageService {

	@Override
	public void insertProduct(ProductManage dto, String uploadPath) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateProduct(ProductManage dto, String uploadPath) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteProduct(long productId, String uploadPath) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteProductPhoto(long productPhotoNum, String uploadPath) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteOptionDetail(long optionDetailNum) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<ProductManage> listProduct(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ProductManage findById(long productId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ProductManage findByPrev(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ProductManage findByNext(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<ProductManage> listProductPhoto(long productId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<ProductManage> listProductOption(long productId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<ProductManage> listOptionDetail(long optionNum) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ProductManage findByCategory(long categoryNum) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<ProductManage> listCategory() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateProductStock(ProductStockManage dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<ProductStockManage> listProductStock(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean deleteUploadPhoto(String uploadPath, String photoName) {
		// TODO Auto-generated method stub
		return false;
	}

}
