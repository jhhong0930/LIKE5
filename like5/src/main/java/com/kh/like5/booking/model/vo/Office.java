package com.kh.like5.booking.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter @Setter
@ToString
public class Office {
	private int officeNo;
	private String branch;
	private String address;
	private String manager;
	private String facility;
	private String typeName;
	private int person;
	private int price;
	private String offImgPath;
}
