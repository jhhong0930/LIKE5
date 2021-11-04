package com.kh.like5.common.model.vo;

import java.sql.Date;
import java.util.ArrayList;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter @Setter
@ToString
public class Attachment {
	private int fileNo;
	private int refBno;
	private int refFno;
	private Date uploadDate;
	private String status;
	private String filePath;
	
	private ArrayList<Attachment> atlist;
}
