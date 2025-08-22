package com.sp.app.admin.model;

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
public class GongguPackageManage {
    private long gongguProductId;
    private long productCode;
    private String productName;
    private long packageNum;
    private int stock;
    private int price;
}

