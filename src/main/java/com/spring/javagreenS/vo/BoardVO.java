package com.spring.javagreenS.vo;

import lombok.Data;

public @Data class BoardVO {
	private int idx;
	private String nickName;
	private String title;
	private String email;
	private String homePage;
	private String content;
	private String wDate;
	private int readNum;
	private String hostIp;
	private int good;
	private String mid;
	
	// 날짜형식필드를 '문자'와 '숫자'로 저장시켜주기 위한 변수를 선언
	private int diffTime;
	
	// 기존 content의 내용을 담기위한 필드
	private String oriContent;
	
	// 댓글의 개수를 저장하기 위한 필드
	private int replyCount;
}
