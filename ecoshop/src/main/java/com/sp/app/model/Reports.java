package com.sp.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Reports {
	private long reportId; // 기본키
	private String target; // 신고된 테이블
	private Long targetNum; // 신고된 테이블의 컬럼
	private Long reporterId; // 신고자 아이디
	private String contentType; // 콘텐츠타입(posts, photo, reply, replyAnswer) <-- 게시물인지, 사진인지, 댓글인지, 답글인지
	private String contentTitle; // 콘텐츠제목(자유게시판, 포토갤러리, ...)
	private String reasonCode; // 신고 사유 코드(SPAM(스팸/광고), ABUSE(욕설/비방), PORNOGRAPHY(음란물), INAPPROPRIATE(부적절한 콘텐츠), COPYRIGHT(저작권 침해), OTHER(기타, ETC)
	private String reasonDetail; // 신고할 때 적는 메시지
	private String reportDate; // 신고일
	private String reportIp; // 신고자 IP
	private int reportStatus; // 처리상태(1:신고접수, 2:처리완료, 3:기각)
	private String actionTaken; // 조치사항(관리자가 입력)
	private Long processorId; // 조치사항(관리자가 입력)
	private String processedDate; // 처리일
	
	private int reportsCount; // 신고 건수
	private String reporterName; // 신고자 이름
	private String processorName; // 관리자 이름

	// 게시글 정보
	private String writerId; // (신고) 작성자 아이디
	private String writer; // (신고) 작성자
	private String subject; // (신고) 제목
	private String content; // 신고
	private String imageFilename;
	private int block; // 블라인드 처리
	
	private String mode;
	
	private int waitReport;
    private int allReport;
    private int compReport;
    private int cancleReport;
}
