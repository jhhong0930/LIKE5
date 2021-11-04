package com.kh.like5.admin.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.like5.admin.model.vo.Calculate;
import com.kh.like5.admin.model.vo.Faq;
import com.kh.like5.board.model.vo.Board;
import com.kh.like5.board.model.vo.Report;
import com.kh.like5.board.model.vo.Tag;
import com.kh.like5.common.model.vo.PageInfo;
import com.kh.like5.member.model.vo.Customer;
import com.kh.like5.member.model.vo.Member;
import com.kh.like5.member.model.vo.Sponsorship;

public interface AdminService {

	// 회원관리 관련 select문-페이징처리
	int selectMemCount();
	// 회원관리 관련 select문 -회원정보 가져오기
	ArrayList<Member> selectMemList(PageInfo pi);
	// 회원관련 검색기능
	public int selectSearchMemCount(HashMap<String,String> map);
	public ArrayList<Member> selectSearchMemList(PageInfo pi, HashMap<String, String> map);
	// 회원관리-회원삭제기능(update혹은 delete구문)
	int deleteMem(int memNo);
	
	// 1:1문의 메인페이지 select문
	int selectCsTwoCount();
	ArrayList<Customer> selectCsTwoList(PageInfo pi);
	 // 1:1문의 검색 기능 select문
	public int searchCsMemCount(HashMap<String,String> map);
	public ArrayList<Customer> searchCsMemList(PageInfo pi, HashMap<String, String> map);
	
	// 1:1문의 상세페이지 select문
	Customer selectCustomer(int csNo);
	// 1:1문의 답변 페이지 update문 (1:1문의 메인페이지로 )
	int insertCsAns(Customer cs);
	// 1:1문의 수정 페이지 update문 (1:1문의 메인페이지로 )
	int updateCsAns(Customer cs);
	
	
	// 후원관리 메인 페이지 select문-페이징처리
	int selectSponCount();
	// 후원관리 메인 페이지 select문 - 후원정보 가져오기
	ArrayList<Sponsorship> selectSponList(PageInfo pi);
	// 후원관리 메인페이지 검색관련 기능
	public int searchDonaCount(HashMap<String,String> map);
	public ArrayList<Sponsorship> searchDonaList(PageInfo pi, HashMap<String, String> map);
	
	// 후원상세 페이지 select문(후원내용)-페이징처리
	int selectSponsorCount(int smemNo);
	// 후원상세 페이지 select문(후원내용)-내용가져오기
	Sponsorship selectSponMem(int smemNo);
	ArrayList<Sponsorship> selectSponsorList(PageInfo pi, int smemNo);
	
	// 후원상세 페이지 select문(정산내용)-페이징처리
	// 후원상세 페이지 select문(정산내용)-내용가져오기
	// tag 메인페이지 select문
	// 정산상세 페이지 select문(정산내용)-페이징처리
	int selectCalCount(int smemNo);
	// 정산상세 페이지 select문(정산내용)-내용가져오기
	Calculate selectTotalCal(int smemNo);
	ArrayList<Calculate> selectCalList(PageInfo pi, int smemNo);
	
	// tag 메인페이지 select문 
	// tag 메인페이지 select문
	ArrayList<Tag> tagList();

	// tag 조회 페이지 select문-페이징처리
	int getTagCount(String tagName);
	ArrayList<Board> tagDetailList(PageInfo pi, String tagName);

	// tag 조회 페이지 select문-게시글불러오기
	
	
	// tag 수정페이지(관리자용) select문
	int selectTagsCount();
	ArrayList<Tag> selectAllTags(PageInfo pi);
	// tag 수정페이지 insert문
	int addTag(String tagName);
	// tag 수정페이지 Modal update문
	int updateTag(Tag tag);
	// 게시글 리스트 조회
	int getBoardCount();
	ArrayList<Board> getBoardList(PageInfo pi);

	// 게시글 검색 리스트 조회
	int getSearchBoardCount(HashMap<String, String> map);
	ArrayList<Board> getSearchBoardList(PageInfo pi, HashMap<String, String> map);

	// 게시글 삭제 기능
	int deleteBoard(int bno);

	// 신고내역 리스트 조회
	int getReportCount();
	ArrayList<Report> getReportList(PageInfo pi);

	// 신고내역 검색 리스트 조회
	int getSearchReportCount(HashMap<String, String> map);
	ArrayList<Report> getSearchReportList(PageInfo pi, HashMap<String, String> map);

	// 신고내역 삭제 기능
	int deleteReport(int rno);

	// FAQ 리스트 조회
	ArrayList<Faq> getFaqList();

	// FAQ 조회
	Faq getFaq(int fno);

	// FAQ 작성 기능
	int insertFaq(Faq f);

	// FAQ 수정 기능
	int updateFaq(Faq f);

	// FAQ 삭제 기능
	int deleteFaq(int fno);


	
}
