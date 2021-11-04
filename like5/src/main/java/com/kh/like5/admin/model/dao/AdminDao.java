package com.kh.like5.admin.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.like5.admin.model.vo.Calculate;
import com.kh.like5.admin.model.vo.Faq;
import com.kh.like5.board.model.vo.Board;
import com.kh.like5.board.model.vo.Report;
import com.kh.like5.board.model.vo.Tag;
import com.kh.like5.common.model.vo.PageInfo;
import com.kh.like5.member.model.vo.Customer;
import com.kh.like5.member.model.vo.Member;
import com.kh.like5.member.model.vo.Sponsorship;

@Repository
public class AdminDao {

	// ============================= [지현] =============================

	// 관리자-회원관리 기능
	// 회원 정보 불러오기
	public int selectMemCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("memberMapper.selectMemCount");
	}
	
	public ArrayList<Member> selectMemList(SqlSessionTemplate sqlSession, PageInfo pi){
		
		int offset = (pi.getCurrentPage()-1)*pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
	
		return (ArrayList)sqlSession.selectList("memberMapper.selectMemList",null, rowBounds);
	}
	
	// 검색 기능 
	public int selectSearchMemCount(SqlSessionTemplate sqlSession, HashMap<String, String>map) {
		return sqlSession.selectOne("memberMapper.selectSearchMemCount", map);
	}
	
	public ArrayList<Member> selectSearchMemList(SqlSessionTemplate sqlSession, PageInfo pi, HashMap<String, String>map){
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("memberMapper.selectSearchMemList", map, rowBounds);
	}

	// 회원 삭제 기능
	public int deleteMem(SqlSessionTemplate sqlSession, int memNo) {
		return sqlSession.update("memberMapper.deleteMem", memNo);
	}
	
	//1:1문의 게시글 불러오기 
	public int selectCsTwoCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("customerMapper.selectCsTwoCount");
	}
	
	public ArrayList<Customer> selectCsTwoList(SqlSessionTemplate sqlSession, PageInfo pi){
		int offset = (pi.getCurrentPage()-1)*pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("customerMapper.selectCsTwoList",null, rowBounds);
	}
	
	// 1:1 문의 검색 기능
	public int searchCsMemCount(SqlSessionTemplate sqlSession, HashMap<String,String>map) {
		return sqlSession.selectOne("customerMapper.searchCsMemCount", map);
	}
	public ArrayList<Customer> searchCsMemList(SqlSessionTemplate sqlSession, PageInfo pi, HashMap<String, String>map){
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("customerMapper.searchCsMemList", map, rowBounds);
	}
	
	// 1:1 문의 상세 페이지
	public Customer selectCustomer(SqlSessionTemplate sqlSession, int csNo) {
		return sqlSession.selectOne("customerMapper.selectCustomer", csNo);
	}
	// 1:1문의 관리자 답변 등록 (update)
	public int insertCsAns(SqlSessionTemplate sqlSession, Customer cs) {
		return sqlSession.update("customerMapper.insertCsAns", cs);
	}
	// 1:1문의 관리자 답변 수정 update
	public int updateCsAns(SqlSessionTemplate sqlSession, Customer cs) {
		return sqlSession.update("customerMapper.updateCsAns", cs);
	}
	
	// 후원관리 메인 - 페이징
	public int selectSponCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("sponsorshipMapper.selectSponCount");
	}
	// 후원관리 메인 - 리스트 조회
	public ArrayList<Sponsorship> selectSponList(SqlSessionTemplate sqlSession, PageInfo pi){
		int offset = (pi.getCurrentPage()-1)*pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("sponsorshipMapper.selectSponList", null, rowBounds);
	}
	// 후원관리 검색 기능 - 페이징
	public int searchDonaCount(SqlSessionTemplate sqlSession, HashMap<String,String>map) {
		return sqlSession.selectOne("sponsorshipMapper.searchDonaCount", map);
	}
	// 후원관리 검색 기능 - 리스트조회
	public ArrayList<Sponsorship> searchDonaList(SqlSessionTemplate sqlSession, PageInfo pi, HashMap<String, String>map){
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("sponsorshipMapper.searchDonaList",map,rowBounds);
	}
	// 후원상세 - 페이징
	public int selectSponsorCount(SqlSessionTemplate sqlSession, int smemNo) {
		return sqlSession.selectOne("sponsorshipMapper.selectSponsorCount", smemNo);
	}
	// 후원상세 - smem정보
	public Sponsorship selectSponMem(SqlSessionTemplate sqlSession, int smemNo) {
		return sqlSession.selectOne("sponsorshipMapper.selectSponMem",smemNo);
	}
	// 후원상세 - 리스트 조회
	public ArrayList<Sponsorship> selectSponsorList(SqlSessionTemplate sqlSession, PageInfo pi, int smemNo){
		int offset = (pi.getCurrentPage()-1)*pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("sponsorshipMapper.selectSponsorList", smemNo, rowBounds);
	}
	// 정산상세-페이징
	public int selectCalCount(SqlSessionTemplate sqlSession, int smemNo) {
		return sqlSession.selectOne("calculateMapper.selectCalCount",smemNo);
	}
	// 정산상세 -총정산금 조회
	public Calculate selectTotalCal(SqlSessionTemplate sqlSession, int smemNo) {
		return sqlSession.selectOne("calculateMapper.selectTotalCal",smemNo);
	}
	// 정산상세 - 리스트 조회
	public ArrayList<Calculate> selectCalList(SqlSessionTemplate sqlSession, PageInfo pi, int smemNo){
		int offset = (pi.getCurrentPage()-1)*pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("calculateMapper.selectCalList", smemNo, rowBounds);
	}
	
	// TAG 리스트 조회
	public ArrayList<Tag> tagList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("tagMapper.tagList");
	}
	// Tag관리자페이지 - 페이징
	public int selectTagsCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("tagMapper.selectTagsCount");
	}
	// Tag관리자페이지 - 리스트조회
	public ArrayList<Tag> selectAllTags(SqlSessionTemplate sqlSession, PageInfo pi){
		int offset = (pi.getCurrentPage()-1)*pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
	return (ArrayList)sqlSession.selectList("tagMapper.selectAllTags",null, rowBounds);
	}

	// TAG 상세조회
	public int getTagCount(SqlSessionTemplate sqlSession, String tagName) {
		return sqlSession.selectOne("boardMapper.getTagCount", tagName);
	}

	public ArrayList<Board> tagDetailList(SqlSessionTemplate sqlSession, PageInfo pi, String tagName) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());

		return (ArrayList)sqlSession.selectList("boardMapper.tagDetailList", tagName, rowBounds);
	}
	
		
	// Tag관리자 페이지 - 태그 추가하기
	public int addTag(SqlSessionTemplate sqlSession, String tagName) {
		return sqlSession.insert("tagMapper.addTag", tagName);
	}
	// Tag관리자 페이지- 태그 수정하기
	public int updateTag(SqlSessionTemplate sqlSession, Tag tag) {
		return sqlSession.update("tagMapper.updateTag", tag);
	}

	// ============================= [재환] =============================

	// 게시글 리스트 조회
	public int getBoardCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("boardMapper.getBoardCount");
	}

	public ArrayList<Board> getBoardList(SqlSessionTemplate sqlSession, PageInfo pi) {

		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());

		return (ArrayList)sqlSession.selectList("boardMapper.getBoardList", null, rowBounds);

	}

	// 게시글 검색 리스트 조회
	public int getSearchBoardCount(SqlSessionTemplate sqlSession, HashMap<String, String>map) {
		return sqlSession.selectOne("boardMapper.getSearchBoardCount", map);
	}

	public ArrayList<Board> getSearchBoardList(SqlSessionTemplate sqlSession, PageInfo pi, HashMap<String, String>map){

		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());

		return (ArrayList)sqlSession.selectList("boardMapper.getSearchBoardList", map, rowBounds);
	}

	// 게시글 삭제 기능
	public int deleteBoard(SqlSessionTemplate sqlSession, int bno) {
		return sqlSession.update("boardMapper.deleteBoard", bno);
	}

	// 신고내역 리스트 조회
	public int getReportCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("boardMapper.getReportCount");
	}

	public ArrayList<Report> getReportList(SqlSessionTemplate sqlSession, PageInfo pi) {

		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());

		return (ArrayList) sqlSession.selectList("boardMapper.getReportList", null, rowBounds);

	}

	// 신고내역 검색 리스트 조회
	public int getSearchReportCount(SqlSessionTemplate sqlSession, HashMap<String, String>map) {
		return sqlSession.selectOne("boardMapper.getSearchReportCount", map);
	}

	public ArrayList<Report> getSearchReportList(SqlSessionTemplate sqlSession, PageInfo pi, HashMap<String, String>map) {

		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());

		return (ArrayList) sqlSession.selectList("boardMapper.getSearchReportList", map, rowBounds);

	}

	// 신고내역 삭제 기능
	public int deleteReport(SqlSessionTemplate sqlSession, int rno) {
		return sqlSession.delete("boardMapper.deleteReport", rno);
	}

	// FAQ 리스트 조회
	public ArrayList<Faq> getFaqList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("adminMapper.getFaqList");
	}

	// FAQ 상세 조회
	public Faq getFaq(SqlSessionTemplate sqlSession, int fno) {
		return sqlSession.selectOne("adminMapper.getFaq", fno);
	}

	// FAQ 작성 기능
	public int insertFaq(SqlSessionTemplate sqlSession, Faq f) {
		return sqlSession.insert("adminMapper.insertFaq", f);
	}

	// FAQ 수정 기능
	public int updateFaq(SqlSessionTemplate sqlSession, Faq f) {
		return sqlSession.update("adminMapper.updateFaq", f);
	}

	// FAQ 삭제 기능
	public int deleteFaq(SqlSessionTemplate sqlSession, int fno) {
		return sqlSession.delete("adminMapper.deleteFaq", fno);
	}
	
	
}
