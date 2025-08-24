package com.sp.app.admin.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class GongguProductDeliveryRefundInfoManage {
	int deliveryRefundInfoNum;
	String deliveryInfo;
	String refundInfo;
	
	int deliveryFeeNum;
	int fee;
	String deliveryLocation;
}
