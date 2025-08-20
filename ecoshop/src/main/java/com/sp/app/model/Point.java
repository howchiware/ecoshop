package com.sp.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Point {
	private Long pointId;
    private Long memberId;
    private String baseDate;   // 포인트 발생일
    private String reason;    // 사유
    private int classify;    // 1:적립, 2:사용, 3:소멸, 4:주문취소
    private int points;      // 적립/차감 포인트
    private Long postId;     // 인증 게시물
    private int balance;    // 누적 포인트 잔액
    private String orderId;
		
}
