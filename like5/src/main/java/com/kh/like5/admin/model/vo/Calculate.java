package com.kh.like5.admin.model.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter @Setter
@ToString
public class Calculate {
	
	private int calNo;
	private int memNo;
	private String memName;
	private Date calDate;
	private int calPrice;
	private String calStatus;
	private String calBank;
	private String calAccount;
	
	
}
