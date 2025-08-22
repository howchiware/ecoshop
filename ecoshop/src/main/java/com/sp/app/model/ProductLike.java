package com.sp.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class ProductLike {
	private Long productLikeNum;
	private Long memberId;
	private Long productCode;
	private String productLikeDate;
	private String productName;
	private int price;
	private int salePrice;
	private int savedPoint;
	private int delivery;
	private String thumbnail;
}
