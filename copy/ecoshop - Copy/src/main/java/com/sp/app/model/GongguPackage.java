package com.sp.app.model;

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
public class GongguPackage {
    private Long packageNum;
    private Long stock;
    private Long productCode;
    private Integer price;
}