package com.kh.like5.member.model.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter @Setter
@ToString
public class Customer {

	private int csNo; 
	private int memNo;
	private String csTitle;
	private String csContent;
	private Date regDate;
	private String status;
	private String ansContent;
	private Date ansDate;

	private String memName;
	private String nickname;
}
