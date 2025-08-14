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
	// 주문 정보 
    private Long gongguOrderDetailId;
    private Long cnt;
    private Boolean userDelete; 
    private Long gongguProductId; 
    private String orderId; 

    private List<Integer> productMoneys;
    private List<Integer> prices;
    private List<Integer> gongguPrice;
    
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
 	
 	// 결제 정보
 	private String imp_uid;
 	private String payMethod;
 	private String cardName;
 	private String cardNumber;
 	private String applyNum;
 	private String applyDate;
 	
}