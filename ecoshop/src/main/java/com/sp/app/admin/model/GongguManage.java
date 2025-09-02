package com.sp.app.admin.model;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

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
public class GongguManage {
    private long gongguProductId;
    private String gongguProductName;
    private String gongguThumbnail;
    private long originalPrice;
    private long sale;
    private long gongguPrice;
    private String regDate;
    private Integer limitCount;
    private String updateDate;
    private String content;
    private String detailInfo; 
    private int productShow;
    private MultipartFile gongguThumbnailFile;
    
    private String startDate;
	private String endDate;
	private String sday;
	private String stime;
	private String eday;
	private String etime;

    private long categoryId; 
    private String categoryName;
    
    private int gongguProductCount; 
    private int delivery;
    private MultipartFile selectFile;
    
    private long gongguProductDetailId;
	private String detailPhoto;
	private long fileNum;
	private String filename;
	private List<MultipartFile> addFiles;
	private List<Long> gongguProductIds;
	
	private int totalStock;
	private long productId;
	private String productName;
	private int classify;
	
	

}
