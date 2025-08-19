package com.sp.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Product {
	// 상품 정보
	private long productId;
	private long productCode;
	private String productName;
	private int price;
	private String thumbnail;
	private int sale;
	private String reg_date;
	private int optionCount;
	private int productShow;
	private String update_date;
	private int point;
	private String content;
	private String detailInfo;
	private int delivery;

	// 상품 추가 이미지
	private long productPhotoNum;
	private String photoName;
	
	// 상품 카테고리
	private long categoryId;
	private String categoryName;
	private Long parentNum;
	
	// 상품 옵션
	private Long optionNum;
	private String optionName;
	private Long optionDetailNum;
	private String optionValue;
	private Long optionNum2;
	private String optionName2;
	private Long optionDetailNum2;
	private String optionValue2;
	
	// 상품 재고
	private long stockNum;
	private int totalStock;
	
	// 상품 리뷰
	private double rate;
	private int reviewCount;
	private int inquiryCount;
	
	// 유저의 상품 찜 여부
	private int userWish;
	
}
