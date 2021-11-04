package com.kh.like5.member.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.like5.admin.model.vo.Calculate;
import com.kh.like5.board.model.vo.Board;
import com.kh.like5.board.model.vo.Reply;
import com.kh.like5.common.model.vo.PageInfo;
import com.kh.like5.member.model.dao.MemberDao;
import com.kh.like5.member.model.vo.Customer;
import com.kh.like5.member.model.vo.Member;
import com.kh.like5.member.model.vo.Sponsorship;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberDao mDao;

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public Member loginMember(Member m) {
		return mDao.loginMember(sqlSession, m);
	}

	@Override
	public int insertMember(Member m) {
		
		return mDao.insertMember(sqlSession, m);
		
	}

	@Override
	public int updateMember(Member m) {
		
		return mDao.updateMember(sqlSession, m);
		
	}

	@Override
	public int deleteMember(int memNo) {
		
		return mDao.deleteMember(sqlSession, memNo);
		
	}
	
	@Override
	public int tempSaveListCount(int memNo) {
		
		return mDao.tempSaveListCount(sqlSession, memNo);
		
	}

	@Override
	public ArrayList<Board> tempSaveListDetail(PageInfo pi, int memNo) {
		
		return mDao.tempSaveListDeatil(sqlSession, pi, memNo);
		
	}
	
	@Override
	public int memPostListDetailCount(int memNo) {
		
		return mDao.memPostListDetailCount(sqlSession, memNo);
		
	}

	@Override
	public ArrayList<Board> memPostListDetail(PageInfo pi, int memNo) {
		
		return mDao.memPostListDetail(sqlSession, pi, memNo);
		
	}
	
	@Override
	public ArrayList<Customer> inquiry(PageInfo pi, int memNo) {

		return mDao.inquiry(sqlSession, pi, memNo);
		
	}

	@Override
	public ArrayList<Sponsorship> donate(PageInfo pi, int memNo) {
		
		return mDao.donate(sqlSession, pi, memNo);
		
	}

	@Override
	public int donateCount(int memNo) {

		return mDao.donateCount(sqlSession, memNo);
		
	}

	@Override
	public int inquiryCount(int memNo) {
		
		return mDao.inquiryCount(sqlSession, memNo);
		
	}


	@Override
	public ArrayList<Board> ansListDetail(PageInfo pi, int memNo) {
		
		return mDao.ansListDetail(sqlSession, pi, memNo);
	}

	@Override
	public int ansListCount(int memNo) {
		
		return mDao.ansListCount(sqlSession, memNo);
	}
	
	@Override
	public int insertcalculate(Calculate c) {
		
		return mDao.insertcalculate(sqlSession, c);
		
	}
	
	@Override
	public Member memberInfor(int memNo) {
		
		return mDao.memberInfor(sqlSession, memNo);
		
	}


	/**
	 * [1:1문의] 작성
	 * @author seong
	 */
	@Override
	public int insertInquiry(Customer c) {
		return mDao.insertInquiry(sqlSession, c);
	}
	
	
	@Override
	public ArrayList<Board> newlylist(int memNo) {
		
		return mDao.newlylist(sqlSession, memNo);
		
	}

	@Override
	public ArrayList<Reply> anslist(int memNo) {
		
		return mDao.anslist(sqlSession, memNo);
		
	}

	@Override
	public ArrayList<Board> tempSavelist(int memNo) {
		
		return mDao.tempSavelist(sqlSession, memNo);
		
	}

	@Override
	public ArrayList<Sponsorship> price(int memNo) {

		return mDao.price(sqlSession, memNo);
		
	}

	@Override
	public ArrayList<Calculate> calculate(int memNo) {
		
		return mDao.calculate(sqlSession, memNo);
		
	}
	
	/**
	 * [QnA, 칼럼] - QnA, 칼럼 후원 insert	 @author Hansol
	 */
	@Override
	public int sponInsert(Sponsorship s) {
		return mDao.sponInsert(sqlSession, s);
	}
	
/*
	@Override
	public ArrayList<Booking> myRecentBookList(int memNo) {
		return mDao.myRecentBookList(sqlSession, memNo);
	}
	
*/




	

	
}
