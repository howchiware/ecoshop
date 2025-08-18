package com.sp.app.admin.model;

import java.util.List;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class GongguDeliveryRefundInfo {
	int deliveryRefundInfoNum;
	String deliveryInfo;
	String refundInfo;
	
	int deliveryFeeNum;
	int fee;
	String deliveryLocation;
	
	List<Integer> fees;
	List<String> deliveryLocations;
}
