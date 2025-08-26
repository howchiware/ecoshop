package com.sp.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class GongguPayment {
	// Member 관련
	private Long memberId;
	private String loginId;

	// GongguProduct 관련
	private long gongguProductId;
	private String gongguProductName;
	private String gongguThumbnail;
	private int originalPrice;
	private int sale;
	private int gongguPrice; // 실제 판매가
	private int deliveryFee; // 배송비 (상품 자체 배송비)

	// productOrder 관련
	private String orderId;
	private String orderDate;
	private int totalAmount; // 총 상품 금액 (배송비 제외)
	private int usedPoint;
	private int payment; // 총 결제 금액 (배송비 포함)
	private int orderState;
	private String orderStateInfo; // 주문 상태명
	private String orderStateDate; // 주문 현황 날짜
	private String deliveryName;
	private String invoiceNumber;
	private long afterDelivery; // 배송 완료 후 날짜 (리뷰 작성을 위한 기준)

	// gongguOrderDetail 관련
	private long gongguOrderDetailId;
	private int cnt; 
	private int price; // 주문 당시 상품 가격 
	private int detailState;
	private String detailStateInfo; // 주문 상세 상태명
	private String stateMemo; // 상태 변경 사유
	private String stateDate; // 상태 변경일
	private String stateProduct; // 주문 상세 상태명 (JSP 출력용)

	// Payment(결제내역) 테이블 관련
	private String payMethod;
	private String cardName;
	private String cardNumber;
	private String applyNum;
	private String applyDate;
	private String imp_uid;

	private int reviewWrite; // 리뷰 작성 여부 (0:미작성, 1:작성)
}
