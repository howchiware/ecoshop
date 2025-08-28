package com.sp.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class GongguReviewHelpful {
	private long gongguOrderDetailId;
	private long memberId;
	private int reviewHelpful;
}
