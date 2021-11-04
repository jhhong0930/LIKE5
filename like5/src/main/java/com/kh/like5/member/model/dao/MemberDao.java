package com.kh.like5.member.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.like5.admin.model.vo.Calculate;
import com.kh.like5.board.model.vo.Board;
import com.kh.like5.board.model.vo.Reply;
import com.kh.like5.common.model.vo.PageInfo;
import com.kh.like5.member.model.vo.Customer;
import com.kh.like5.member.model.vo.Member;
import com.kh.like5.member.model.vo.Sponsorship;

@Repository
public class MemberDao {
	
	//-------------------------동규------------------------------------
	
	public Member loginMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.selectOne("memberMapper.loginMember", m);
	}
	
	public int insertMember(SqlSessionTemplate sqlSession, Member m) {
		
		return sqlSession.insert("memberMapper.insertMember", m);
		
	}
	
	public ArrayList<Board> newlylist(SqlSessionTemplate sqlSession, int memNo) {
		
		return (ArrayList)sqlSession.selectList("memberMapper.newlylist", memNo);
				
	}

	public ArrayList<Board> tempSavelist(SqlSessionTemplate sqlSession, int memNo) {
		
		return (ArrayList)sqlSession.selectList("memberMapper.tempSaveList", memNo);
		
	}

	public ArrayList<Reply> anslist(SqlSessionTemplate sqlSession, int memNo) {
		
		return (ArrayList)sqlSession.selectList("memberMapper.ansList", memNo);
		
	}

	public ArrayList<Sponsorship> price(SqlSessionTemplate sqlSession, int memNo) {
		
		return (ArrayList)sqlSession.selectList("memberMapper.Spon", memNo);
		
	}


	public ArrayList<Calculate> calculate(SqlSessionTemplate sqlSession, int memNo) {
		
		return (ArrayList)sqlSession.selectList("memberMapper.Calculate", memNo);
		
	}
	
	public int tempSaveListCount(SqlSessionTemplate sqlSession, int memNo) {
		
		return sqlSession.selectOne("memberMapper.tempSaveListCount", memNo);
	}
	
	public ArrayList<Board> tempSaveListDeatil(SqlSessionTemplate sqlSession, PageInfo pi, int memNo) {
		
		int offset = (pi.getCurrentPage()-1)*pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("memberMapper.tempSaveListDeatil", memNo, rowBounds);
		
	}
	
	public int memPostListDetailCount(SqlSessionTemplate sqlSession, int memNo) {
		
		return sqlSession.selectOne("memberMapper.memPostListDetailCount", memNo);

	}

	public ArrayList<Board> memPostListDetail(SqlSessionTemplate sqlSession, PageInfo pi, int memNo) {

		int offset = (pi.getCurrentPage()-1)*pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("memberMapper.memPostListDetail", memNo, rowBounds);
		
	}

	public int updateMember(SqlSessionTemplate sqlSession, Member m) {
		
		return sqlSession.update("memberMapper.updateMember",m);
		
	}


	public int deleteMember(SqlSessionTemplate sqlSession, int memNo) {
		
		return sqlSession.update("memberMapper.deleteMem", memNo);

	}
	
	public ArrayList<Customer> inquiry(SqlSessionTemplate sqlSession, PageInfo pi, int memNo) {
		
		int offset = (pi.getCurrentPage()-1)*pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("memberMapper.inquiryList", memNo, rowBounds);
		
	}

	public ArrayList<Sponsorship> donate(SqlSessionTemplate sqlSession, PageInfo pi, int memNo) {

		int offset = (pi.getCurrentPage()-1)*pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("memberMapper.donateList", memNo, rowBounds);
		
	}

	public int donateCount(SqlSessionTemplate sqlSession, int memNo) {

		return sqlSession.selectOne("memberMapper.donateCount", memNo);
		
	}

	public int inquiryCount(SqlSessionTemplate sqlSession, int memNo) {
		
		return sqlSession.selectOne("memberMapper.inquiryCount", memNo);
		
	}
	
	public ArrayList<Board> ansListDetail(SqlSessionTemplate sqlSession, PageInfo pi, int memNo) {
		
		int offset = (pi.getCurrentPage()-1)*pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("memberMapper.ansListDetail", memNo, rowBounds);
		
	}

	public int ansListCount(SqlSessionTemplate sqlSession, int memNo) {

		return sqlSession.selectOne("memberMapper.ansListCount", memNo);
		
	}
	
	public int insertcalculate(SqlSessionTemplate sqlSession, Calculate c) {
		
		return sqlSession.insert("memberMapper.insertcalculate", c);
		
	}
	
	public Member memberInfor(SqlSessionTemplate sqlSession, int memNo) {
		
		return sqlSession.selectOne("memberMapper.memberInfor", memNo);
		
	}
	
	
	/**
	 * [1:1문의] 작성
	 * @author seong
	 */
	
	public int insertInquiry(SqlSessionTemplate sqlSession, Customer c) {
		return sqlSession.insert("memberMapper.insertInquiry",c);
	}
	
	
	/**
	 * [QnA, 칼럼] - QnA, 칼럼 후원 insert
	 * @author Hansol
	 */
	public int sponInsert(SqlSessionTemplate sqlSession, Sponsorship s) {
		return sqlSession.insert("sponsorshipMapper.sponInsert", s);
	}

	
	/*신원 최근 공간 예약 리스트 조회
	public ArrayList<Booking> myRecentBookList(SqlSessionTemplate sqlSession, int memNo){
		return (ArrayList)sqlSession.selectList("memberMapper.selectMyRecentBookList", memNo);
	}
	*/
}
