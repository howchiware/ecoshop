package com.sp.app.service;

import com.sp.app.model.Advertisement;

public interface AdvertisementService {
	public void insertAdvertisement(Advertisement dto, String uploadPath) throws Exception;
	
}
