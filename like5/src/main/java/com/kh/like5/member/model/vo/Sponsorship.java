package com.kh.like5.member.model.vo;

import java.sql.Date;
import java.util.ArrayList;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter @Setter
@ToString
public class Sponsorship {

	private int sponNo;
	private int  memNo;
	private int smemNo;
	private int sponFee;
	private Date sponDate;
	private int sponCategory;
	private int refBoaNo;
	
	// 관라자단에서 필요해서 추가한 코드입니다.
	private String memName;
	private String nickName;
	private String email;
	private String accountNum;
	private String bank;
	
	private ArrayList<Sponsorship> sponsorList;
		
}
