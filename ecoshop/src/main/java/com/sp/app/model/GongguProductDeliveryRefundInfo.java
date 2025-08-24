package com.sp.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class GongguProductDeliveryRefundInfo {
	int deliveryRefundInfoNum;
	String deliveryInfo;
	String refundInfo;
	
	int deliveryFeeNum;
	int deliveryFee;
	String deliveryLocation;

}
