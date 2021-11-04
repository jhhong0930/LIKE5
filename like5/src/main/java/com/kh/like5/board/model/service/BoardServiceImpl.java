package com.kh.like5.board.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.like5.board.model.dao.BoardDao;
import com.kh.like5.board.model.vo.Board;
import com.kh.like5.board.model.vo.Reply;
import com.kh.like5.board.model.vo.Report;
import com.kh.like5.board.model.vo.Tag;
import com.kh.like5.common.model.vo.PageInfo;

@Service
public class BoardServiceImpl implements BoardService {

	
	@Autowired
	private BoardDao bDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	/**
	 *  [공통] 게시글 상세보기시 조회수 증가
	 *  @author seong
	 */
	@Override
	public int increaseCount(int bno) {
		return bDao.increaseCount(sqlSession, bno);
	}
	
	/**
	 *  [커뮤니티] 전체 목록 리스트 페이징 처리시 필요한 게시글 전체 count
	 *  @author seong
	 */
	@Override
	public int comListCount() {
		return bDao.comListCount(sqlSession);
	}
	
	/**
	 *  [커뮤니티] 전체 목록 리스트 조회
	 *  @author seong
	 */
	@Override
	public ArrayList<Board> comList(PageInfo pi) {
		return bDao.comList(sqlSession,pi);
	}
	
	/**
	 * [커뮤니티] - 키워드 검색 결과 list count
	 * @author seong
	 */
	
	@Override
	public int comSearchListCount(HashMap<String, String> map) {
		return bDao.comSearchListCount(sqlSession, map);
	}

	
	/**
	 * [커뮤니티] - 키워드 검색 결과 조회 
	 * @author seong
	 */
	
	@Override
	public ArrayList<Board> comSearchList(PageInfo pi, HashMap<String, String> map) {
		return bDao.comSearchList(sqlSession, pi, map);
	}
	
	/**
	 * [커뮤니티] - 카테고리별 게시글 list count
	 * @author seong
	 */
	
	@Override
	public int comOrderByListCount(String condition) {
		return bDao.comOrderByListCount(sqlSession, condition);
	}
	
	/**
	 * [커뮤니티] 전체 | 일상 | 스터디 모집 | 카테고리별 조회
	 * @author seong
	 */
	@Override
	public ArrayList<Board> comOrderByCategory(PageInfo pi, String condition) {
		return bDao.comOrderByCategory(sqlSession, pi, condition);
	}

	/**
	 * [커뮤니티]최신 | 조회수 | 댓글수 기준으로 조회
	 * @author seong
	 */
	@Override
	public ArrayList<Board> comOrderByCount(PageInfo pi, String condition) {
		return bDao.comOrderByCount(sqlSession,pi,condition);
	}

	
	/**
	 *  [커뮤니티 | 칼럼] 게시글 상세보기
	 *  @author seong
	 */
	
	@Override
	public Board boardDetail(int bno) {
		return bDao.boardDetail(sqlSession, bno);
	}

	/**
	 * [커뮤니티, QnA] 댓글 | 대댓글 전체 조회
	 * @author seong
	 */
	@Override
	public ArrayList<Reply> selectReplyList(int bno) {
		return bDao.selectReplyList(sqlSession, bno);
	}
	
	/**
	 * [커뮤니티, QnA] 댓글 작성하기
	 * @author seong
	 */
	
	@Override
	public int insertReply(Reply r) {
		return bDao.insertReply(sqlSession, r);
	}

	/**
	 * [커뮤니티, QnA] 대댓글 작성하기
	 * @author seong
	 */
	@Override
	public int insertReplies(Reply r) {
		return bDao.insertReplies(sqlSession, r);
	}
	
	/**
	 * [커뮤니티 | 칼럼] 게시글 작성하기
	 * @author seong
	 */
	
	@Override
	public int insertComAndCol(Board b) {
		return bDao.insertComAndCol(sqlSession, b);
	}

	/**
	 * [커뮤니티] 게시글 삭제하기
	 * @author seong
	 */
	
	@Override
	public int deleteComAndCol(int bno) {
		return bDao.deleteComAndCol(sqlSession, bno);
	}

	/**
	 * [커뮤니티 | 칼럼] - 게시글 수정하기
	 * @author seong
	 */

	@Override
	public int updateComAndCol(Board b) {
		return bDao.updateComAndCol(sqlSession, b);
	}
	
	/**
	 * [커뮤니티] - 게시글 신고하기
	 * @author seong
	 */
	@Override
	public int reportCommunity(Report r) {
		return bDao.reportCommunity(sqlSession, r);
	}
	

	/**
	 *  [칼럼] 전체 목록 리스트 페이징 처리시 필요한 게시글 전체 count
	 *  @author seong
	 */
	
	@Override
	public int colListCount() {
		return bDao.colListCount(sqlSession);
	}
	
	
	/**
	 *  [칼럼] - 전체 목록 리스트 조회
	 *  @author seong
	 */
	
	@Override
	public ArrayList<Board> colList(PageInfo pi) {
		return bDao.colList(sqlSession, pi);
	}
	
	/**
	 * [커뮤니티]최신 | 조회수 | 좋아요 기준으로 조회
	 * @author seong
	 */
	@Override
	public ArrayList<Board> colOrderByCount(PageInfo pi, String condition) {
		return bDao.colOrderByCount(sqlSession, pi, condition);
	}


	/**
	 *  게시글 상세 조회 시 로그인한 회원의  좋아요 여부
	 * @author seong
	 */
	@Override
	public int likesCount(Board b) {
		return bDao.likesCount(sqlSession, b);
	}

	/**
	 *  게시글 상세 조회 시 로그인한 회원의  스크랩 여부
	 * @author seong
	 */

	@Override
	public int scrapCount(Board b) {
		return bDao.scrapCount(sqlSession, b);
	}
	
	/**
	 *  게시글 상세 조회 시 로그인한 회원의  후원 여부
	 * @author seong
	 */
	
	@Override
	public int sponsorCount(Board b) {
		return bDao.sponsorCount(sqlSession, b);
	}
	

	/**
	 * Ajax로 좋아요 | 스크랩 등록
	 * @author seong
	 */
	
	@Override
	public int likeAndScrap(HashMap<String,Object>map) {
		return bDao.likeAndScrap(sqlSession, map);
	}
	
	/**
	 * [ 스크랩 | 좋아요 ] count 증가
	 * @author seong
	 */
	@Override
	public int increaseCounts(HashMap<String,Object>map) {
		return bDao.increaseCounts(sqlSession, map);
	}

	
	/**
	 * Ajax로 좋아요 | 스크랩 해제
	 * @author seong
	 */
	
	@Override
	public int UnlikeAndUnScrap(HashMap<String, Object> map) {
		return bDao.UnlikeAndUnScrap(sqlSession, map);
	}
	
	
	/**
	 * [ 스크랩 | 좋아요 ] count 감소
	 * @author seong
	 */
	@Override
	public int decreaseCounts(HashMap<String, Object> map) {
		return bDao.decreaseCounts(sqlSession, map);
	}


	/**
	 * Ajax [ 칼럼 ] 관심 칼럼 조회
	 * @author seong
	 */
	@Override
	public ArrayList<Board> topBoardList() {
		return bDao.topBoardList(sqlSession);
	}
	
	/**
	 * [ 칼럼 ] 임시저장 등록
	 * @author seong
	 */
	@Override
	public int colStorageInsert(Board b) {
		return bDao.colStorageInsert(sqlSession, b);
	}
	
	/**
	 * [ 칼럼 ] 임시저장 글 조회
	 * @author seong
	 */
	
	@Override
	public Board selectTemSave(int bno) {
		return bDao.selectTemSave(sqlSession, bno);
	}
	
	
	//------------------ 한솔 -------------------------
	
	/**
	 * [QnA] - QnaList 총 게시글 개수 조회
	 * @author Hansol
	 */
	@Override
	public int qnaListCount() {
		return bDao.qnaListCount(sqlSession);
	}

	/**
	 * [QnA] - QnaList 사용자가 요청한 페이지에 뿌려줄 리스트
	 * @author Hansol
	 */
	@Override
	public ArrayList<Board> qnaList(PageInfo pi) {
		return bDao.qnaList(sqlSession, pi);
	}

	/**
	 * [QnA] - QnaEnrollForm 게시글 작성
	 * @author Hansol
	 */
	@Override
	public int qnaInsert(Board b) {
		return bDao.qnaInsert(sqlSession, b);
	}
	
	/**
	 * [QnA] - QnaEnrollForm 게시글 임시저장
	 * @author Hansol
	 */
	@Override
	public int qnaStorageInsert(Board b) {
		return bDao.qnaStorageInsert(sqlSession, b);
	}

	/**
	 * [QnA] - QnaDetail 게시글 상세조회
	 * @author Hansol
	 */
	@Override
	public Board qnaDetail(int bno) {
		return bDao.qnaDetail(sqlSession, bno);
	}

	/**
	 * [QnA] - QnaDetail 게시글 삭제(status값 변경)
	 * @author Hansol
	 */
	@Override
	public int qnaDelete(int bno) {
		return bDao.qnaDelete(sqlSession, bno);
	}

	/**
	 * [QnA] - QnaUpdateForm 게시글 수정
	 * @author Hansol
	 */
	@Override
	public int qnaUpdate(Board b) {
		return bDao.qnaUpdate(sqlSession, b);
	}

	/**
	 * [QnA] - QnaList 키워드 검색 총 게시글 개수 조회
	 * @author Hansol
	 */
	@Override
	public int qnaSearchListCount(HashMap<String, String> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	/**
	 * [QnA] - QnaList 키워드 검색 결과 조희
	 * @author Hansol
	 */
	@Override
	public ArrayList<Board> qnaSearchListCount(PageInfo pi, HashMap<String, String> map) {
		// TODO Auto-generated method stub
		return null;
	}

	/**
	 * [QnA] - QnaList 정렬 기준별 총 게시글 개수 조회
	 * @author Hansol
	 */
	@Override
	public int qnaOrderByListCount(String condition) {
		// TODO Auto-generated method stub
		return 0;
	}

	/**
	 * [QnA] - QnaList 정렬 기준별 결과 조회
	 * @author Hansol
	 */
	@Override
	public ArrayList<Board> qnaOrderByCount(PageInfo pi, String condition) {
		// TODO Auto-generated method stub
		return null;
	}

	/**
	 * [QnA] - QnaEnrollForm 태그 리스트
	 * @author Hansol
	 */
	@Override
	public ArrayList<Tag> tagList() {
		return bDao.tagList(sqlSession);
	}
	
	/**
	 * [QnA] - QnaDetailView 답변(댓글) 채택
	 * @author Hansol
	 */
	@Override
	public int adoptionReply(int repNo) {
		return bDao.adoptionReply(sqlSession, repNo);
	}
	

	
	//-------------------동규-------------------------
	
	@Override
	public ArrayList<Board> itNews(PageInfo pi) {
						
	return bDao.itNews(sqlSession, pi);
						
	}

	@Override
	public int itNewsCount() {
						
		return bDao.itNewsCount(sqlSession);
						
	}

	@Override
	public Board itNewsDetail(int bno) {
				
		return bDao.itNewsDetail(sqlSession, bno);
				
	}

	@Override
	public int itNewsSearchCount(HashMap<String, String> map) {
			
		return bDao.itNewsSearchCount(sqlSession, map);
			
	}

	@Override
	public ArrayList<Board> itNewsSearch(PageInfo pi, HashMap<String, String> map) {

		return bDao.itNewsSearch(sqlSession, pi, map);
			
	}

	@Override
	public int insertItNews(Board b) {
		
		return bDao.insertItNews(sqlSession, b);

	}

	@Override
	public int upadateItNews(Board b) {
		
		return bDao.upadateItNews(sqlSession, b);
		
	}

	@Override
	public int deleteItnews(int bno) {
		
		return bDao.deleteItnews(sqlSession, bno);
		
	}

	







	


	




	
}
