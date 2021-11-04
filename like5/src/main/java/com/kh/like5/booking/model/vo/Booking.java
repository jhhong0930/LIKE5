package com.kh.like5.booking.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter @Setter
@ToString
public class Booking {
	private int bookingNo;
	private int officeNo;
	private int memNo;
	private String startDate;
	private String endDate;
	private String requestDate;
	private String modifyDate;
	private String status;
	private int person;
	private String phone;
	private String bAsk;
	private int total;
	private String branch;
	private String typeName;
	private int price;
	private String memName;
	
}
