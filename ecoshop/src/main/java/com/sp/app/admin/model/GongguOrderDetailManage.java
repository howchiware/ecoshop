package com.sp.app.admin.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class GongguOrderDetailManage {
	private long gongguProductId;
	private String gongguProductName;
	private int price;
    private int delivery;
    private int cancelAmount;
    private Long memberId;
    private String userId;
    private String name;
    
    private String orderId;
	private long gongguOrderDetailId;
	private String orderDate;
	private int payment;
	private int totalAmount;
	private int deliveryCharge;
	private int salePrice;
	private int productMoney;
	private String orderStateDate;
	private int classify;
	
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
