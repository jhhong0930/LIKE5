package com.kh.like5.board.model.vo;

import lombok.Data;

import java.sql.Date;

@Data
public class Report {

    private int rno;
    private int mno;
    private String category;
    private int refNo;
    private Date reportDate;
    private String reason;
    private String nickname; // 사용자 닉네임
    private String title; // 게시글 글제목

}
