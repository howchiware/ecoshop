package com.sp.app.model;

import java.util.List;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class ProductOrder {
	// 상품 정보
	private long productId;
	private long productCode;
	private String productName;
	private String thumbnail;
	private int price;
	private int sale;
	private int point;
	private int savedPoint;
	private int delivery;
	private int optionCount;
	
	// 유저 정보
	private Long memberId;
	private String userId;
	
	// 주문 정보
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
	
	private long stockNum;
	private int totalStock;
	
	private Long optionDetailNum;
	private Long optionDetailNum2;
	private String optionValue;
	private String optionValue2;
	
	private String optionName;
	private String optionName2;
	private List<String> optionNames;
	private List<String> optionNames2;

	private List<Long> productCodes;

	private List<Long> stockNums;
	private List<Long> optionDetailNums;
	private List<Long> optionDetailNums2;
	private List<String> optionValues;
	private List<String> optionValues2;
	private List<Integer> buyQtys;
	private List<Integer> productMoneys;
	private List<Integer> prices;
	private List<Integer> salePrices;
	private List<Integer> points;
	
	// 장바구니 정보
	private Long cartId;
	
	// 배송지 정보
	private String recipientName;
	private String tel;
	private String zip;
	private String addr1;
	private String addr2;
	private String pickup;
	private String accessInfo;
	private String passcode;
	private String requestMemo;
	
	// 결제 내역 정보
	private String imp_uid;
	private String payMethod;
	private String cardName;
	private String cardNumber;
	private String applyNum;
	private String applyDate;
}
