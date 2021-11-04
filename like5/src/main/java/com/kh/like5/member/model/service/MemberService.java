package com.kh.like5.member.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.like5.admin.model.vo.Calculate;
import com.kh.like5.board.model.vo.Board;
import com.kh.like5.board.model.vo.Reply;
import com.kh.like5.booking.model.vo.Booking;
import com.kh.like5.common.model.vo.PageInfo;
import com.kh.like5.member.model.vo.Customer;
import com.kh.like5.member.model.vo.Member;
import com.kh.like5.member.model.vo.Sponsorship;

public interface MemberService {
	
	// 로그인용 서비스
	Member loginMember(Member m);
	
	// 회원가입용 서비스
	int insertMember(Member m);
	
	// 정보수정용 서비스
	int updateMember(Member m);
	
	// 회원탈퇴용 서비스
	int deleteMember(int memNo);
	
	// 1:1 문의 작성하기 서비스
	int insertInquiry(Customer c);
	
	ArrayList<Board> newlylist(int memNo);

	ArrayList<Reply> anslist(int memNo);

	ArrayList<Board> tempSavelist(int memNo);

	ArrayList<Sponsorship> price(int memNo);

	ArrayList<Calculate> calculate(int memNo);
	
	int tempSaveListCount(int memNo);

	ArrayList<Board> tempSaveListDetail(PageInfo pi, int memNo);

	int memPostListDetailCount(int memNo);

	ArrayList<Board> memPostListDetail(PageInfo pi, int memNo);

	ArrayList<Customer> inquiry(PageInfo pi, int memNo);

	ArrayList<Sponsorship> donate(PageInfo pi, int memNo);

	int donateCount(int memNo);

	int inquiryCount(int memNo);

	ArrayList<Board> ansListDetail(PageInfo pi, int memNo);

	int ansListCount(int memNo);

	int insertcalculate(Calculate c);

	Member memberInfor(int memNo);
	
	/**
	 * [QnA, 칼럼] - QnA, 칼럼 후원 insert	@author Hansol
	 */
	int sponInsert(Sponsorship s);
	
	//공간리스트(신원)
	//ArrayList<Booking> myRecentBookList(int memNo);
	
}
