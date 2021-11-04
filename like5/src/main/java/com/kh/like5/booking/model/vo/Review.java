package com.kh.like5.booking.model.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter @Setter
@ToString
public class Review {
	private int reviewNo;
	private int bookingNo;
	private int officeNo;
	private String reviewTitle;
	private String reviewContent;
	private String reviewWriter;
	private String reviewStar;
	private Date createDate;
	private String status;
}
