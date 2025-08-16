package com.sp.app.admin.model;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class ProductManage {
	private long productId;
	private String productCode;
	private String productName;
	private int classify;
	private int price;
	private int point;
	private int salePrice;
	private int delivery;
	private int productShow;
	private int optionCount;
	private String content;
	private String detailInfo;
	private String thumbnail;
	private String reg_date;
	private String update_date;
	private MultipartFile thumbnailFile;
	
	private long categoryId;
	private String categoryName;
	private Long parentNum;

	private long productPhotoNum;
	private String photoName;
	private List<MultipartFile> addFiles;
	
	private Long optionNum;
	private String optionName;
	private Long parentOption;

	private Long optionNum2;
	private String optionName2;
	
	private Long optionDetailNum;
	private String optionValue;
	private List<Long> optionDetailNums;
	private List<String> optionValues;

	private Long optionDetailNum2;
	private String optionValue2;
	private List<Long> optionDetailNums2;
	private List<String> optionValues2;
	private List<Long> productIds;
	
	
	private int totalStock;
	
	// 수정전 옵션
	private long prevOptionNum;
	private long prevOptionNum2;
}
