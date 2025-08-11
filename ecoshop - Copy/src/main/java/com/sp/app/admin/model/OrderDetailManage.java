package com.sp.app.admin.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class OrderDetailManage {
	private long productCode;
	private String productName;
	private int optionCount;
	private int price;
    private int delivery;
    private int cancelAmount;
    private Long memberId;
    private String userId;
    private String name;
    
    
    private String orderId;
	private long orderDetailId;
	private String orderDate;
	private int usedPoint;
	private int payment;
	private int totalAmount;
	private int deliveryCharge;
	private int salePrice;
	private int qty;
	private int productMoney;
    private int savedPoint;
	private String orderStateDate;
	
	private Long optionDetailNum;
	private String optionValue;
	private Long optionDetailNum2;
	private String optionValue2;
	
	private int orderState;
	private String orderStateInfo;
	private int detailState;
	private String detailStateInfo;
	private String stateMemo;
	private String stateDate;
	private String stateProduct;
	
	private String deliveryName; // 택배사
	private String invoiceNumber; // 송장번호
}
