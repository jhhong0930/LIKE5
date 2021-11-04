package com.kh.like5.board.model.vo;

import java.sql.Date;
import java.util.ArrayList;

import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

// [한솔] lombok 어노테이션, boardList 추가
@NoArgsConstructor
@Getter @Setter
@Data @ToString
public class Board {

    private int bno;
    private int mno;
    private String category;
    private String status;
    private String title;
    private String content;
    private Date enrollDate;
    private Date updateDate;
    private int count;
    private int like;
    private int scrap;
    private String tag;
    private String imgPath;
    private String nickname; // 사용자 닉네임
    private String reply;// 해당 게시판에 딸린 댓글 수 *일단,자료형은 String으로 선언함.
    
    private ArrayList<Board> boardList;

}
