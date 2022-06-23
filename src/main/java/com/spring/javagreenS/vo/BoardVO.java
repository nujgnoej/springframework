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
	
	// '이전글','다음글'을 위한 변수설정
	private int preIdx;
	private int nextIdx;
	private String preTitle;
	private String nextTitle;
	
	// 댓글의 개수를 저장하기 위한 필드
	private int replyCount;
}
