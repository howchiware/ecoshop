package com.sp.app.admin.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class GongguOrderManage {
	private String orderId;
	private Long memberId;
	private String userId;
	private String name;
	private String orderDate;
	
	private int totalAmount;
	private int deliveryCharge;
	private int payment;
	private int cancelAmount;
	private int orderState;
	private String orderStateInfo;
	
	private String orderStateDate; // 상태변경일자
	private String deliveryName; // 택배사
	private String invoiceNumber; // 송장번호
	
	private int totalOrderCount; // 주문 상품수
	private int detailCancelCount; // 취소건수(판매취소, 주문취소완료, 반품접수, 반품완료)
	private int cancelRequestCount; // 배송전 주문 취소요청수, 반품요청수
	private int exchangeRequestCount; // 배송후 교환 요청수
	
	// 결제 정보
	private String imp_uid;
	private String payMethod;
	private String cardName;
	private String cardNumber;
	private String applyNum;
	private String applyDate;
	
	// 배송 정보
	private String recipientName;
	private String tel;
	private String zip;
	private String addr1;
	private String addr2;
	private String pickup;
	private String accessInfo;
	private String passcode;
	private String requestMemo;	
}
