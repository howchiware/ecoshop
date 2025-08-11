package com.sp.app.admin.model;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.sp.app.model.GongguPackage;

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
    private Long gongguProductId;
    private String gongguProductName;
    private String gongguThumbnail;
    private Long originalPrice;
    private Long gongguPrice;
    private String regDate;
    private Integer limitCount;
    private String deadline;
    private Long categoryId; 
    private String updateDate;
    private String content;
    private String detailInfo; 
    private String limitInfo;
    private List<String> detailPhotos;
    private List<GongguPackage> packages; 
   
    private MultipartFile gongguThumbnailFile; 
	private List<MultipartFile> addPhotoFiles;
	private long gonggufileId; 
	private String saveFilename;
	private String originalFilename;
	private long fileSize;
	private int fileCount;
	private List<MultipartFile> selectFile; 

}
