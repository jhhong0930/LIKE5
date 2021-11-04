package com.kh.like5.admin.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.like5.admin.model.vo.Calculate;
import com.kh.like5.admin.model.vo.Faq;
import com.kh.like5.board.model.vo.Board;
import com.kh.like5.board.model.vo.Report;
import com.kh.like5.board.model.vo.Tag;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.like5.admin.model.dao.AdminDao;
import com.kh.like5.common.model.vo.PageInfo;
import com.kh.like5.member.model.vo.Customer;
import com.kh.like5.member.model.vo.Member;
import com.kh.like5.member.model.vo.Sponsorship;

@Service
public class AdminServiceImpl implements AdminService{

	@Autowired
	private AdminDao adDao;
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int selectMemCount() {
		return adDao.selectMemCount(sqlSession);
	}

	@Override
	public ArrayList<Member> selectMemList(PageInfo pi) {
		return adDao.selectMemList(sqlSession, pi);
	}

	@Override
	public int selectSearchMemCount(HashMap<String, String> map) {
		return adDao.selectSearchMemCount(sqlSession, map);
	}

	@Override
	public ArrayList<Member> selectSearchMemList(PageInfo pi, HashMap<String, String> map) {
		return adDao.selectSearchMemList(sqlSession, pi, map);
	}

	@Override
	public int deleteMem(int memNo) {
		return adDao.deleteMem(sqlSession, memNo);
	}
	

	@Override
	public int getBoardCount() {
		return adDao.getBoardCount(sqlSession);
	}

	@Override
	public ArrayList<Board> getBoardList(PageInfo pi) {
		return adDao.getBoardList(sqlSession, pi);
	}

	@Override
	public int getSearchBoardCount(HashMap<String, String> map) {
		return adDao.getSearchBoardCount(sqlSession, map);
	}

	@Override
	public ArrayList<Board> getSearchBoardList(PageInfo pi, HashMap<String, String> map) {
		return adDao.getSearchBoardList(sqlSession, pi, map);
	}

	@Override
	public int deleteBoard(int bno) {
		return adDao.deleteBoard(sqlSession, bno);
	}
	
	// 1:1문의 게시글-페이징
	@Override
	public int selectCsTwoCount() {
		return adDao.selectCsTwoCount(sqlSession);
	}
	// 1:1문의 게시글-리스트조회
	@Override
	public ArrayList<Customer> selectCsTwoList(PageInfo pi) {
		return adDao.selectCsTwoList(sqlSession, pi);
	}
	// 1:1문의 게시글 - 검색(페이징)
	@Override
	public int searchCsMemCount(HashMap<String, String> map) {
		return adDao.searchCsMemCount(sqlSession, map);
	}
	// 1:1문의 게시글 - 검색(게시글조회)
	@Override
	public ArrayList<Customer> searchCsMemList(PageInfo pi, HashMap<String, String> map) {
		return adDao.searchCsMemList(sqlSession, pi, map);
	}
	// 1:1 문의글 상세 조회
	@Override
	public Customer selectCustomer(int csNo) {
		return adDao.selectCustomer(sqlSession, csNo);
	}
	// 1:1문의 답변 등록
	@Override
	public int insertCsAns(Customer cs) {
		return adDao.insertCsAns(sqlSession, cs);
	}
	// 1:1문의 답변 수정
	@Override
	public int updateCsAns(Customer cs) {
		return adDao.updateCsAns(sqlSession, cs);
	}
	
	// 후원내역 메인 - 페이징처리
	@Override
	public int selectSponCount() {
		return adDao.selectSponCount(sqlSession);
	}
	/// 후원내역 메인 - 리스트 조회
	@Override
	public ArrayList<Sponsorship> selectSponList(PageInfo pi) {
		return adDao.selectSponList(sqlSession, pi);
	}
	// 후원내역 검색- 페이징
	@Override
	public int searchDonaCount(HashMap<String, String> map) {
		return adDao.searchDonaCount(sqlSession, map);
	}
	// 후원내역 검색 - 리스트 조회
	@Override
	public ArrayList<Sponsorship> searchDonaList(PageInfo pi, HashMap<String, String> map) {
		return adDao.searchDonaList(sqlSession, pi, map);
	}
	// 후원상세 - 페이징 처리
	@Override
	public int selectSponsorCount(int smemNo) {
		return adDao.selectSponsorCount(sqlSession, smemNo);
	}
	// 후원상세 smem 정보조회
	@Override
	public Sponsorship selectSponMem(int smemNo) {
		return adDao.selectSponMem(sqlSession, smemNo);
	}
	// 후원상세 sponsor정보조회
	@Override
	public ArrayList<Sponsorship> selectSponsorList(PageInfo pi, int smemNo) {
		return adDao.selectSponsorList(sqlSession, pi, smemNo);
	}
	// 정산상세 페이징
	@Override
	public int selectCalCount(int smemNo) {
		return adDao.selectCalCount(sqlSession, smemNo);
	}
	// 정산상세 총 정산금 조회
	@Override
	public Calculate selectTotalCal(int smemNo) {
		return adDao.selectTotalCal(sqlSession, smemNo);
	}
	// 정산상세 리스트 조회
	@Override
	public ArrayList<Calculate> selectCalList(PageInfo pi, int smemNo) {
		return adDao.selectCalList(sqlSession, pi, smemNo);
	}
	
	// tag관리자페이지-페이징
	@Override
	public int selectTagsCount() {
		return adDao.selectTagsCount(sqlSession);
	}
	// tag관리자페이지-리스트 조회
	@Override
	public ArrayList<Tag> selectAllTags(PageInfo pi) {
		return adDao.selectAllTags(sqlSession, pi);
	}
	// tag관리자 페이지 - 태그 추가 insert
	@Override
	public int addTag(String tagName) {
		return adDao.addTag(sqlSession, tagName);
	}
	// tag관리자페이지 - 태그 update
	@Override
	public int updateTag(Tag tag) {
		return adDao.updateTag(sqlSession,tag);
	}

	@Override
	public ArrayList<Tag> tagList() {
		return adDao.tagList(sqlSession);
	}

	@Override
	public int getTagCount(String tagName) {
		return adDao.getTagCount(sqlSession, tagName);
	}

	@Override
	public ArrayList<Board> tagDetailList(PageInfo pi, String tagName) {
		return adDao.tagDetailList(sqlSession, pi, tagName);
	}


	@Override
	public int getReportCount() {
		return adDao.getReportCount(sqlSession);
	}

	@Override
	public ArrayList<Report> getReportList(PageInfo pi) {
		return adDao.getReportList(sqlSession, pi);
	}

	@Override
	public int getSearchReportCount(HashMap<String, String> map) {
		return adDao.getSearchReportCount(sqlSession, map);
	}

	@Override
	public ArrayList<Report> getSearchReportList(PageInfo pi, HashMap<String, String> map) {
		return adDao.getSearchReportList(sqlSession, pi, map);
	}

	@Override
	public int deleteReport(int rno) {
		return adDao.deleteReport(sqlSession, rno);
	}

	@Override
	public ArrayList<Faq> getFaqList() {
		return adDao.getFaqList(sqlSession);
	}

	@Override
	public Faq getFaq(int fno) {
		return adDao.getFaq(sqlSession, fno);
	}

		@Override
	public int insertFaq(Faq f) {
		return adDao.insertFaq(sqlSession, f);
	}

	@Override
	public int updateFaq(Faq f) {
		return adDao.updateFaq(sqlSession, f);
	}

	@Override
	public int deleteFaq(int fno) {
		return adDao.deleteFaq(sqlSession, fno);
	}

	

	
	

	
	

	
	

	

	

	

}
