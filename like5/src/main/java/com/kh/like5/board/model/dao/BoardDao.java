package com.kh.like5.board.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.like5.board.model.vo.Board;
import com.kh.like5.board.model.vo.Reply;
import com.kh.like5.board.model.vo.Report;
import com.kh.like5.board.model.vo.Tag;
import com.kh.like5.common.model.vo.PageInfo;

@Repository
public class BoardDao {

	//-----------------------성은
	
	/**
	 *[커뮤니티] - 전체 목록 리스트 페이징 처리시 필요한 게시글 전체 count
	 * @author seong
	 */
	public int comListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("boardMapper.comListCount");
	}
	
	/**
	 * [커뮤니티] - 전체 목록 리스트 조회
	 * @author seong 
	 */
	public ArrayList<Board>comList(SqlSessionTemplate sqlSession,PageInfo pi){
		int offset = (pi.getCurrentPage()-1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		RowBounds  rowBounds = new RowBounds(offset, limit);
		return (ArrayList)sqlSession.selectList("boardMapper.comList",null,rowBounds);
	}
	
	
	/**
	 * [커뮤니티] - 키워드 검색 결과 list count
	 * @author seong
	 */
	
	public int comSearchListCount(SqlSessionTemplate sqlSession,HashMap<String,String>map) {
		return sqlSession.selectOne("boardMapper.comSearchListCount",map);
	}
	
	/**
	 * [커뮤니티] - 키워드 검색 결과 조회 
	 * @author seong
	 */
	
	public ArrayList<Board> comSearchList(SqlSessionTemplate sqlSession,PageInfo pi,HashMap<String,String>map){
		int offset = (pi.getCurrentPage()-1)*pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset,pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("boardMapper.comSearchList",map,rowBounds);
	}
	
	/**
	 * [커뮤니티] - 카테고리별 게시글 list count
	 * @author seong
	 */
	
	public int comOrderByListCount(SqlSessionTemplate sqlSession,String condition) {
		return sqlSession.selectOne("boardMapper.comOrderByListCount",condition);
	}
	
	
	
	/**
	 * [커뮤니티] 전체 | 일상 | 스터디 모집 | 카테고리별 조회
	 * @author seong
	 */
	public ArrayList<Board> comOrderByCategory(SqlSessionTemplate sqlSession,PageInfo pi,String condition){
		int offset = (pi.getCurrentPage()-1)*pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset,pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("boardMapper.comOrderByCategory",condition,rowBounds);
	}
	
	/**
	 * [커뮤니티]최신 | 조회수 | 댓글수 기준으로 조회
	 * @author seong
	 */
	public ArrayList<Board> comOrderByCount(SqlSessionTemplate sqlSession,PageInfo pi,String condition){
		int offset = (pi.getCurrentPage()-1)*pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset,pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("boardMapper.comOrderByCount",condition,rowBounds);
	}
	
	/**
	 * [커뮤니티, QnA] 게시글 상세보기시 조회수 증가
	 *  @author seong
	 */
	
	public int increaseCount(SqlSessionTemplate sqlSession,int bno) {
		return sqlSession.update("boardMapper.increaseCount",bno);
				
	}
	
	/**
	 *[커뮤니티] 커뮤니티 게시글 상세보기
	 * @author seong
	 */
	
	public Board boardDetail(SqlSessionTemplate sqlSession,int bno) {
		return sqlSession.selectOne("boardMapper.boardDetail",bno);
	}
	
	/**
	 * [커뮤니티, QnA] 댓글 | 대댓글 전체 조회
	 * @author seong
	 */
	
	public ArrayList<Reply>selectReplyList(SqlSessionTemplate sqlSession,int bno){
		return (ArrayList)sqlSession.selectList("boardMapper.replyList",bno);
	}
	
	
	/**
	 * [커뮤니티, QnA] 댓글 작성하기
	 * @author seong
	 */
	
	public int insertReply(SqlSessionTemplate sqlSession,Reply r) {
		return sqlSession.insert("boardMapper.insertReply",r);
	}
	
	/**
	 * [커뮤니티, QnA] 대댓글 작성
	 * @author seong
	 */
	public int insertReplies(SqlSessionTemplate sqlSession,Reply r) {
		return sqlSession.insert("boardMapper.insertReplies",r);
	}
	
	/**
	 * [커뮤니티 | 칼럼] - 게시글 작성
	 * @author seong
	 */
	public int insertComAndCol(SqlSessionTemplate sqlSession, Board b) {
		return sqlSession.insert("boardMapper.insertComAndCol",b);
	}
	
	/**
	 * [커뮤니티 | 칼럼] - 게시글 삭제
	 * @author seong
	 */
	public int deleteComAndCol(SqlSessionTemplate sqlSession,int bno) {
		return sqlSession.update("boardMapper.deleteComAndCol",bno);
	}
	
	
	
	/**
	 * [커뮤니티 | 칼럼] - 게시글 수정
	 * @author seong
	 */
	public int updateComAndCol(SqlSessionTemplate sqlSession,Board b) {
		return sqlSession.update("boardMapper.updateComAndCol",b);
	}
	
	/**
	 * [커뮤니티] - 게시글 신고
	 * @author seong
	 */
	public int reportCommunity(SqlSessionTemplate sqlSession,Report r) {
		return sqlSession.insert("boardMapper.reportCommunity",r);
	}
	
	/**
	 *  [칼럼] 전체 목록 리스트 페이징 처리시 필요한 게시글 전체 count
	 *  @author seong
	 */
	
	public int colListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("boardMapper.colListCount");
	}

	/**
	 *  [칼럼] - 전체 목록 리스트 조회
	 *  @author seong
	 */
	
	public ArrayList<Board>colList(SqlSessionTemplate sqlSession,PageInfo pi){
		int offset = (pi.getCurrentPage()-1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		RowBounds  rowBounds = new RowBounds(offset, limit);
		return (ArrayList)sqlSession.selectList("boardMapper.colList",null,rowBounds);
	}
	
	

	/**
	 * [칼럼]최신 | 조회수 | 좋아요 기준으로 조회
	 * @author seong
	 */
	public ArrayList<Board> colOrderByCount(SqlSessionTemplate sqlSession,PageInfo pi,String condition){
		int offset = (pi.getCurrentPage()-1)*pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset,pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("boardMapper.colOrderByCount",condition,rowBounds);
	}
	
	/**
	 * [칼럼] 게시글 상세보기
	 * @author seong
	 */
	
	public Board colDetail(SqlSessionTemplate sqlSession,int bno) {
		return sqlSession.selectOne("boardMapper.comDetail",bno);
	}
	
	/**
	 *  게시글 상세 조회 시 로그인한 회원의  좋아요 여부
	 * @author seong
	 */
	
	public int likesCount(SqlSessionTemplate sqlSession,Board b) {
		return sqlSession.selectOne("boardMapper.likesCount",b);
	}
	

	/**
	 *  게시글 상세 조회 시 로그인한 회원의  스크랩 여부
	 * @author seong
	 */
	
	public int scrapCount(SqlSessionTemplate sqlSession,Board b) {
		return sqlSession.selectOne("boardMapper.scrapCount",b);
	}
	
	/**
	 *  게시글 상세 조회 시 로그인한 회원의  후원 여부
	 * @author seong
	 */
	
	public int sponsorCount(SqlSessionTemplate sqlSession,Board b) {
		return sqlSession.selectOne("boardMapper.sponsorCount",b);
	}
	
	
	/**
	 * [ 스크랩 | 좋아요 ]  등록
	 * @author seong
	 */
	public int likeAndScrap(SqlSessionTemplate sqlSession,HashMap<String,Object>map) {
		return sqlSession.insert("boardMapper.insertLike",map);
	}
	
	/**
	 * [ 스크랩 | 좋아요 ] count 증가
	 * @author seong
	 */
	public int increaseCounts(SqlSessionTemplate sqlSession,HashMap<String,Object>map) {
		return sqlSession.update("boardMapper.increaseCounts",map);
	}
	
	/**
	 * Ajax로 좋아요 | 스크랩 해제
	 * @author seong
	 */
	
	public int UnlikeAndUnScrap(SqlSessionTemplate sqlSession,HashMap<String,Object>map) {
		return sqlSession.insert("boardMapper.UnlikeAndUnScrap",map);
	}
	
	/**
	 * [ 스크랩 | 좋아요 ] count 감소
	 * @author seong
	 */
	public int decreaseCounts(SqlSessionTemplate sqlSession,HashMap<String,Object>map) {
		return sqlSession.update("boardMapper.decreaseCounts",map);
	}
	

	/**
	 * Ajax [ 칼럼 ] 관심 칼럼 조회
	 * @author seong
	 */
	public ArrayList<Board>topBoardList(SqlSessionTemplate sqlSession){
		return (ArrayList)sqlSession.selectList("boardMapper.topBoardList");
	}
	
	/**
	 * [ 칼럼 ] 임시저장
	 * @author seong
	 */
	public int colStorageInsert(SqlSessionTemplate sqlSession,Board b) {
		return sqlSession.insert("boardMapper.colStorageInsert",b);
	}
	
	/**
	 * [ 칼럼 ] 임시저장 글 조회
	 * @author seong
	 */
	public Board selectTemSave(SqlSessionTemplate sqlSession,int bno){
		return sqlSession.selectOne("boardMapper.selectTemSave",bno);
	}
	
	
	//------------------ 한솔 -------------------------

	/**
	 * [QnA] - QnaList 조회 시 유효한 게시글 총 개수 조회
	 * @author Hansol
	 */
	public int qnaListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("boardMapper.qnaListCount");
	}
	
	/**
	 * [QnA] - QnaList 사용자가 요청한 페이지에 뿌려줄 리스트 조회 (요청 페이지 번호, 불러올 글 개수)
	 * @author Hansol
	 */
	public ArrayList<Board> qnaList(SqlSessionTemplate sqlSession,PageInfo pi){
		int offset = (pi.getCurrentPage()-1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("boardMapper.qnaList", null, rowBounds);
	}
	
	/**
	 * [QnA] - QnaEnrollForm 게시글 insert
	 * @author Hansol
	 */
	public int qnaInsert(SqlSessionTemplate sqlSession, Board b) {
		return sqlSession.insert("boardMapper.qnaInsert", b);
	}
	
	/**
	 * [QnA] - QnaEnrollForm 게시글 임시저장
	 * @author Hansol
	 */
	public int qnaStorageInsert(SqlSessionTemplate sqlSession, Board b) {
		return sqlSession.insert("boardMapper.qnaStorageInsert", b);
	}
	
	/**
	 * [QnA] - QnaEnrollForm tag 리스트 조회
	 * @author Hansol
	 */
	public ArrayList<Tag> tagList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("tagMapper.tagList", null);
	}
	
	/**
	 * [QnA] - QnaDetailView 게시글 상세 조회
	 * @author Hansol
	 */
	public Board qnaDetail(SqlSessionTemplate sqlSession, int bno) {
		return sqlSession.selectOne("boardMapper.qnaDetail", bno);
	}
	
	/**
	 * [QnA] - QnaDetailView 게시글 delete
	 * @author Hansol
	 */
	public int qnaDelete(SqlSessionTemplate sqlSession, int bno) {
		return sqlSession.update("boardMapper.qnaDelete", bno);
	}
	
	/**
	 * [QnA] - QnaUpdateForm 게시글 update
	 * @author Hansol
	 */
	public int qnaUpdate(SqlSessionTemplate sqlSession, Board b) {
		System.out.println(b);
		return sqlSession.update("boardMapper.qnaUpdate", b);
	}
	
	
	/**
	 * [QnA] - QnaDetailView 답변(댓글) 채택
	 * @author Hansol
	 */
	public int adoptionReply(SqlSessionTemplate sqlSession, int repNo) {
		return sqlSession.update("boardMapper.adoptionReply", repNo);
	}
	
	
	//-----------------동규----------------
	
	public int itNewsCount(SqlSessionTemplate sqlSession) {
				
		return sqlSession.selectOne("boardMapper.itNewsCount");
				
	}

	public ArrayList<Board> itNews(SqlSessionTemplate sqlSession, PageInfo pi) {
				
		int offset = (pi.getCurrentPage()-1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
			
		return (ArrayList)sqlSession.selectList("boardMapper.itNews", null, rowBounds);
				
	}

	public Board itNewsDetail(SqlSessionTemplate sqlSession, int bno) {
				
		return sqlSession.selectOne("boardMapper.itNewsDetail", bno);
				
	}

	public int itNewsSearchCount(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
			
		return sqlSession.selectOne("boardMapper.itNewsSearchCount", map);
			
	}

	public ArrayList<Board> itNewsSearch(SqlSessionTemplate sqlSession, PageInfo pi, HashMap<String, String> map) {
			
		int offset = (pi.getCurrentPage()-1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
				
		return (ArrayList)sqlSession.selectList("boardMapper.itNewsSearch", map, rowBounds);
			
	}

	public int insertItNews(SqlSessionTemplate sqlSession, Board b) {

		return sqlSession.insert("boardMapper.insertItNews", b);
		
	}

	public int deleteItnews(SqlSessionTemplate sqlSession, int bno) {
		
		return sqlSession.insert("boardMapper.deleteItnews", bno);
		
	}

	public int upadateItNews(SqlSessionTemplate sqlSession, Board b) {
		
		return sqlSession.insert("boardMapper.upadateItNews", b);
		
	}
	
}
