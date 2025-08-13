package com.sp.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class DisplayProduct {
	private long productCode;
	private String productName;
	private int price;
	private int salePrice;
	private int savedPoint;
	private int delivery;
	private String thumbnail;

	private long categoryId;
	private String categoryName;
	
	private double rate;
	private int reviewCount;
	private int likeCount;
	private int userLike; // 유저의 상품 찜 여부
}
