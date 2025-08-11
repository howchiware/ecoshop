package com.sp.app.admin.model;

import java.util.List;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class ProductStockManage {
	private long stockNum;
	private long productCode;
	private Long optionDetailNum;
	private Long detailNum2;
	private int totalStock;
	
	private List<Long> stockNums;
	private List<Long> optionDetailNums;
	private List<Long> optionDetailNums2;
	private List<Integer> totalStocks;
	
	private String productName;
	private String optionName;
	private String optionName2;
	private String optionValue;
	private String optionValue2;
}
