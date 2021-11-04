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
public class Member {
	
	private int memNo;
	private String email;
	private String memPwd;
	private String memName;
	private String nickName;
	private String memProfile;
	private String memCheck;
	private String bank;
	private String accountNum;
	private Date enrDate;
	private String userStatus;
	private String entYN;
	
	
	
	
	private ArrayList<Member> memList;
	
	// 해당 멤버의 후원금액 총합 구하려면 spon테이블에서 해당 회원이 후원받은거 다 조회해야함
	private ArrayList<Sponsorship> sponList;
	
	
	
	
}
