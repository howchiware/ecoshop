package com.sp.app.admin.model;

import java.util.List;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class ProductDeliveryRefundInfoManage {
	int deliveryRefundInfoNum;
	String deliveryInfo;
	String RefundInfo;
	
	int deliveryFeeNum;
	int fee;
	String deliveryLocation;
	
	List<Integer> fees;
	List<String> deliveryLocations;
}
