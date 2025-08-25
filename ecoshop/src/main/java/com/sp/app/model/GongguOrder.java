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
public class GongguOrder {
	// 공동구매 주문 정보 
	private long gongguOrderDetailId;
    private long gongguProductId;
    private String orderId;
    private int cnt;
    private int userDelete;
    private int price;
    private int detailState;

    private Long memberId;
    private String orderDate;
    private int totalAmount; // 총 상품금액
    private int payment; // 배송비 포함 총 결제 금액
    private String orderState;
    private int deliveryCharge; // 배송비
    private int productMoney; // 상품별 결제금액
    private int salePrice; // 할인가
    
    // gongguProduct 테이블 정보
    private String gongguProductName;
    private String gongguThumbnail;
    private int originalPrice;
    private int sale;

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
 	
 	// 환불 정보
 	private long deliveryRefundInfoNum; 
    private String deliveryInfo;      
    private String refundInfo;         

    // 배송비 정보
    private long deliveryFeeNum;       
    private int deliveryFee;          
    private String deliveryLocation;  
    
 	// 결제 정보
 	private String imp_uid;
 	private String payMethod;
 	private String cardName;
 	private String cardNumber;
 	private String applyNum;
 	private String applyDate;
 	
}