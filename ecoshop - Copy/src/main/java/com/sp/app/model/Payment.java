package com.sp.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Payment {
	private Long memberId;
	private String userId;
	
	private long productCode;
	private long productId;
	private String productName;
	private int optionCount;
	private String thumbnail;
	private int price;
	private int savedPoint;
	private int delivery;
	
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
	
	private String payMethod;
	private String cardName;
	private String cardNumber;
	private String applyNum;
	private String applyDate;
	
	private long optionDetailNum;
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

	private String orderStateDate; // 상태변경일
	private String deliveryName; // 배송업체
	private String invoiceNumber; // 송장 번호
	private long afterDelivery; // 배송완료 후 날짜

	private int reviewWrite; // 리뷰 유무
}
