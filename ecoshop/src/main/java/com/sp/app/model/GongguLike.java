package com.sp.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class GongguLike {
	private Long gongguProductLikeNum;
	private Long memberId;
	private Long gongguProductId;
	private String likeDate;
	private String gongguProductName;
	private int originalprice;
	private int sale;
	private int price;
	private int delivery;
	private String gongguThumbnail;
}