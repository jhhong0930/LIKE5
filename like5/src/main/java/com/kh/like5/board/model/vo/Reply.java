package com.kh.like5.board.model.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter @Setter
@ToString
public class Reply {
	
	private int repNo;
	private int boaNo;
	private int memNo;
	private String repContent;
	private Date repEnrollDate;
	private String repAdoption;
	private String repStatus;
	private int refRepNo;
	private int refLevel;
	private String nickname; // 닉네임
	private String category; // 카테고리 추가
    private String memProfile; // 프로필 이미지
}
