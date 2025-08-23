package com.sp.app.model;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class GongguProduct {
	// 공동구매 상품정보
    private long gongguProductId;
    private String gongguProductName;
    private String gongguThumbnail;
    private long sale;
    private long originalPrice;
    private long gongguPrice;
    private String regDate;
    private int limitCount;
    private String deadline;
    private String updateDate;
    private String content;
    private String detailInfo; 
    private String limitInfo;
    
    // 공동구매 상품 추가 이미지
    private long gongguProductDetailId;
    private String detailPhoto;
    private List<String> detailPhotos;

    // 공동구매 상품 카테고리
 	private long categoryId;
 	private String categoryName;
 	private Long parentNum;
 	
 	// 공동구매 상품 재고
 	private long packageNum;
 	private int stock;
    private List<GongguPackage> packages; 
    
    // 공동구매 상품 리뷰 및 문의
    private double rate;
	private int reviewCount;
	private int questionCount;
	
	// 유저의 상품 찜 여부
	private int userWish;
    
}