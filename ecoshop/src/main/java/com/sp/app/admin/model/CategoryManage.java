package com.sp.app.admin.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class CategoryManage {
	private long categoryId;
	private String categoryName;
	private int orderNo;
	private int enabled;
}
