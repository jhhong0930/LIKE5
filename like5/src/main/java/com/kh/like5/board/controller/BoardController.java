package com.kh.like5.board.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.kh.like5.board.model.service.BoardService;
import com.kh.like5.board.model.vo.Board;
import com.kh.like5.board.model.vo.Reply;
import com.kh.like5.board.model.vo.Report;
import com.kh.like5.board.model.vo.Tag;
import com.kh.like5.common.model.vo.PageInfo;
import com.kh.like5.common.template.Pagination;

@Controller
public class BoardController {
	
	@Autowired
	private BoardService bService;
	
	//------------------ 한솔 -------------------------
	
	
	/**
	 * [한솔] QnaList 게시글 리스트 페이지 
	 */
	@RequestMapping("qnaList.bo")
	public ModelAndView qnaList(ModelAndView mv, @RequestParam(value="currentPage", defaultValue="1") int currentPage) {
		int listCount = bService.qnaListCount();
		
		// 페이징바 5개, 한 페이지당 글 10개 -> 추후 테스트 후 너무 길면 수정할 것
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 5, 7);
		ArrayList<Board> qnaList = bService.qnaList(pi);
		
		mv.addObject("pi", pi)
		  .addObject("qnaList", qnaList)
		  .setViewName("board/qna/qnaListView");
		
		return mv;
	}
	
	/** 
	 * [한솔] QnaEnrollForm 게시글 작성 페이지
	 */
	@RequestMapping("qnaEnrollForm.bo")
	public ModelAndView qnaEnrollForm(ModelAndView mv) {
		ArrayList<Tag> tagList = bService.tagList();

		mv.addObject("tagList", tagList)
		  .setViewName("board/qna/qnaEnrollForm");
		
		return mv;
	}
	
	/** 
	 * [한솔] QnaEnrollForm 게시글 insert
	 */
	@RequestMapping("qnaInsert.bo")
	public String qnaInsert(Board b, MultipartFile upfile, HttpSession session, Model model) {
		int result = bService.qnaInsert(b);
		
		if(result > 0) {
			session.setAttribute("alertMsg", " 게시글이 성공적으로 등록되었습니다. ");
			return "redirect:qnaList.bo";
		}else {
			model.addAttribute("errorMsg", " 게시글 등록에 실패하였습니다. ");
			return "common/errorPage";
		}
	}

	/** 
	 * [한솔] QnaEnrollForm 게시글 임시저장 insert
	 */
	@RequestMapping("qnaStorageInsert.bo")
	public String qnaStorageInsert(Board b, HttpSession session, Model model) {
		int result = bService.qnaStorageInsert(b);
		
		if(result > 0) {
			session.setAttribute("alertMsg", " 게시글이 성공적으로 임시저장되었습니다. ");
			return "redirect:qnaList.bo";
		}else {
			model.addAttribute("errorMsg", " 게시글 임시저장에 실패하였습니다. ");
			return "common/errorPage";
		}
	}
	
	/** 
	 * [한솔] QnaDetailView 게시글 상세 페이지
	 */
	@RequestMapping("qnaDetail.bo")
	public ModelAndView qnaDetail(int bno, ModelAndView mv) {
		// 조회수 증가
		int result = bService.increaseCount(bno);
		
		// 조회수 성공적으로 증가 시 상세조회 진행
		if(result > 0) {
			Board b = bService.qnaDetail(bno);
			
			mv.addObject("b", b)
			  .setViewName("board/qna/qnaDetailView");
		}else {
			// 상세조회 실패 시
			mv.addObject("errMsg", " 게시글 상세조회에 실패하였습니다. ")
			  .setViewName("common/errorPage");
		}
		
		return mv;
	}
	
	/** 
	 * [한솔] QnaDetailView 게시글 delete
	 */
	@RequestMapping("qnaDelete.bo")
	public String qnaDelete(int bno, Model model, HttpSession session) {
		int result = bService.qnaDelete(bno);
		
		if(result > 0) {
			session.setAttribute("alertMsg", " 게시글이 삭제되었습니다. ");
			return "redirect:qnaList.bo";
		}else {
			model.addAttribute("errorMsg", " 게시글 삭제에 실패하였습니다. ");
			return "common/errorPage";
		}
	}
	
	/** 
	 * [한솔] QnaDatailView 게시글 수정하기 페이지 호출
	 */
	@RequestMapping("qnaUpdateForm.bo")
	public ModelAndView qnaUpdateForm(Board b, int bno, ModelAndView mv) {	
		Board qnaBoard = bService.qnaDetail(bno = b.getBno());
		String qnaStatus = b.getStatus();
		ArrayList<Tag> tagList = bService.tagList();
		
		mv.addObject("bno", bno)
		  .addObject("status", qnaStatus)
		  .addObject("tagList", tagList)
		  .addObject("qnaBoard", qnaBoard)
		  .setViewName("board/qna/qnaUpdateForm");
		
		return mv;
	}
	
	/** 
	 * [한솔] QnaUpdateForm 게시글 Update
	 */
	@RequestMapping("qnaUpdate.bo")
	public String qnaUpdate(Board b, HttpSession session, Model model) {
		int result = bService.qnaUpdate(b);
		
		if(result > 0) {
			session.setAttribute("alertMsg", " 게시글이 성공적으로 수정되었습니다. ");
			return "redirect:qnaList.bo";
		}else {
			model.addAttribute("errorMsg", " 게시글 수정에 실패하였습니다. ");
			return "common/errorPage";
		}
	}
	
	/** 
	 * [한솔] QnaDetailView 답변(댓글) 채택
	 */
	@RequestMapping("adoptionReply.bo")
	public String adoptionReply(int repNo, Model model, HttpSession session, HttpServletRequest request) {
		int result = bService.adoptionReply(repNo);
		String referer = (String)request.getHeader("referer");
		
		if(result > 0) {
			session.setAttribute("alertMsg", " 답변이 채택되었습니다. ");
			return "redirect:" + referer;
		}else {
			model.addAttribute("errorMsg", " 답변 채택에 실패하였습니다. ");
			return "common/errorPage";
		}
	}
	

	/* -------- 푸터 -------- */
	
	/** 
	 * [한솔] Footer 메인 페이지 (팀 소개) 
	 */
	@RequestMapping("teamAskMe.me")
	public String teamAskMe() {
		return "common/teamAskMe";
	}
	
	/** 
	 * [한솔] Footer 이용약관 
	 */
	@RequestMapping("terms.me")
	public String terms() {
		return "common/termsOfService";
	}
	
	/** 
	 * [한솔] Footer 법적고지 
	 */
	@RequestMapping("legal.me")
	public String legal() {
		return "common/legalResources";
	}
	
	/** 
	 * [한솔] Footer 개인정보처리방침
	 */
	@RequestMapping("privacy.me")
	public String privacy() {
		return "common/privacyPolicy";
	}
	
	
	
	//-------------------동규-------------------------
	
	@RequestMapping("itNews.bo")
	public ModelAndView itNews(ModelAndView mv, @RequestParam(value="currentPage", defaultValue="1") int currentPage) {
		int listCount = bService.itNewsCount();
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 10);
		ArrayList<Board> itNews = bService.itNews(pi);
		
		
		mv.addObject("pi", pi)
		  .addObject("itNews", itNews)
		  .setViewName("board/itNews/itNewsList");
		
		
		return mv;
				
	}
	
	
	@RequestMapping("itNewsDetail.bo")
	public ModelAndView itNewsDetail(int bno, ModelAndView mv) {
		
		int result = bService.increaseCount(bno);
		
		if(result > 0) {
			Board b = bService.itNewsDetail(bno);
			
			mv.addObject("b", b)
			  .setViewName("board/itNews/itNewsDetail");
		}else {
			// 상세조회 실패 시
			mv.addObject("errMsg", " 게시글 상세조회에 실패하였습니다. ")
			  .setViewName("common/errorPage");
		}
		
		return mv;
	
	}
	
	@RequestMapping("itNewsSearch.bo")
	public ModelAndView itNewsSearch(ModelAndView mv, @RequestParam(value="currentPage", defaultValue="1") int currentPage, String condition) {
		
		HashMap<String,String>map = new HashMap<>();
		map.put("condition", condition);
		
		int listCount = bService.itNewsSearchCount(map);
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 10);
		ArrayList<Board> itNews = bService.itNewsSearch(pi,map);
		
		
		mv.addObject("pi", pi)
		  .addObject("itNews", itNews)
		  .addObject("condition",condition)
		  .setViewName("board/itNews/itNewsList");
		
		
		return mv;
				
	}
	
	
	@RequestMapping("insertItNewsForm.bo")
	public String insertItNewsForm() {
		
		return "board/itNews/itNewsForm";
		
	}
	
	@RequestMapping("insertItNews.bo")
	public String insertItNews(Board b, HttpSession session, Model model) {
		
		int result = bService.insertItNews(b);
		
		if(result > 0) {
			session.setAttribute("alertMsg", " 게시글이 성공적으로 등록되었습니다. ");
			return "redirect:itNews.bo";
		}else {
			model.addAttribute("errorMsg", " 게시글 등록에 실패하였습니다. ");
			return "common/errorPage";
		}
	}
	
	@RequestMapping("upadateItNews.bo")
	public String upadateItNews(Board b, HttpSession session, Model model) {
		
		int result = bService.upadateItNews(b);
		
		if(result > 0) {
			session.setAttribute("alertMsg", " 게시글이 성공적으로 수정되었습니다. ");
			return "redirect:itNews.bo";
		}else {
			model.addAttribute("errorMsg", " 게시글 수정에 실패하였습니다. ");
			return "common/errorPage";
		}
	}
	
	
	@RequestMapping("upadateFormItNews.bo")
	public ModelAndView upadateformItNews(int bno, ModelAndView mv) {
		
		
		Board b = bService.itNewsDetail(bno);
			
		mv.addObject("b", b)
		  .setViewName("board/itNews/upadateformItNews");
		
		
		return mv;
	
	}
	
	
	@RequestMapping("deleteItnews.bo")
	public String deleteItnews(int bno, HttpSession session, Model model) {
			
		int result = bService.deleteItnews(bno);
		
		if(result > 0) {
			session.setAttribute("alertMsg", " 게시글이 성공적으로 삭제되었습니다. ");
			return "redirect:itNews.bo";
		}else {
			model.addAttribute("errorMsg", " 게시글 삭제에 실패하였습니다. ");
			return "common/errorPage";
		}
	
	}
	
	
	
	//-------------------성은-------------------------
	
	
	/**
	 * [커뮤니티] - 전체 목록 리스트 조회
	 * @author seong 
	 */
	@RequestMapping("comList.bo")
	public ModelAndView comList(@RequestParam(value="currentPage",defaultValue="1")int currentPage,ModelAndView mv){
		
		int listCount = bService.comListCount();
		
		PageInfo pi = Pagination.getPageInfo(listCount,currentPage,5,5);
		
		ArrayList<Board>comList = bService.comList(pi);


		mv.addObject("listCount",listCount)
		   .addObject("comList",comList)
		   .addObject("pi",pi)
		   .setViewName("board/community/comListView");
		
		return mv;
	}
	
	/**
	 * [커뮤니티] - 키워드 검색 결과 조회 
	 * @author seong
	 */
	
	@RequestMapping("comSearch.bo")
	public ModelAndView comSearchList(ModelAndView mv,@RequestParam(value="currentPage",defaultValue="1")
										int currentPage	,String condition,String keyword) {
		
		HashMap<String,String>map = new HashMap<>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		int listCount = bService.comSearchListCount(map);
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 5, 5);
		ArrayList<Board>comList = bService.comSearchList(pi,map);
		
		
		mv.addObject("pi",pi)
		  .addObject("comList",comList)
		  .addObject("condition",condition)
		  .addObject("keyword",keyword)
		  .addObject("listCount",listCount)
		  .setViewName("board/community/comListView");
		return mv;
	}
	
	/**
	 * [커뮤니티] - 전체 | 일상 | 스터디 모집 | 카테고리별 조회
	 * @author seong
	 */
	
	@RequestMapping("comOrderByCategory.bo")
	public ModelAndView comOrderByCategory(ModelAndView mv,@RequestParam(value="currentPage",defaultValue="1")
		int currentPage	,String condition) {
	
		int listCount = bService.comOrderByListCount(condition);
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 5, 5);
		ArrayList<Board>comList = bService.comOrderByCategory(pi,condition);
		
		mv.addObject("pi",pi)
		.addObject("comList",comList)
		.addObject("condition",condition)
		.addObject("listCount",listCount)
		.setViewName("board/community/comListView");
		return mv;
	}
	
	
	/**
	 * [커뮤니티]최신 | 조회수 | 댓글수 기준으로 조회
	 * @author seong
	 */
	@RequestMapping("comOrderByCount.bo")
	public ModelAndView comOrderByCount(ModelAndView mv,@RequestParam(value="currentPage",defaultValue="1")
										int currentPage, String condition,String flag) {
		
		int listCount = bService.comListCount();
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 5, 5);
		ArrayList<Board>comList = bService.comOrderByCount(pi, condition);
		
		mv.addObject("pi",pi)
		.addObject("comList",comList)
		.addObject("condition",condition)
		.addObject("listCount",listCount)
		.addObject("flag",flag)
		.setViewName("board/community/comListView");
		return mv;
	}
	
	/**
	 * [커뮤니티] - 글 작성 Form
	 * @author seong 
	 */
	@RequestMapping("comEnrollForm.bo")
	public ModelAndView comEnrollForm(ModelAndView mv) {
		mv.setViewName("board/community/comEnrollForm");
		return mv;
	}
	
	/**
	 * [커뮤니티] - 글 상세보기
	 * @author seong
	 */
	
	@RequestMapping("comDetail.bo")
	public ModelAndView comDetail(ModelAndView mv,int bno) {
		
		// 클릭시 조회수 증가
		int result = bService.increaseCount(bno);
		
		// 상세보기
		if(result>0) {
			Board b = bService.boardDetail(bno);
			mv.addObject("b",b)
			  .setViewName("board/community/comDetailView");
		}else {
			mv.addObject("errorMsg", "조회 실패!")
				.setViewName("common/errorPage");
		}
	
		return mv;
	}
	
	/**
	 * Ajax
	 * 댓글 | 대댓글 전체 조회
	 * @author seong
	 */
	@ResponseBody
	@RequestMapping(value="rlist.bo",produces="application/json; charset=utf-8")
	public String selectReplyList(int bno) {
		ArrayList<Reply>list = bService.selectReplyList(bno);
		return new Gson().toJson(list);
	}
	
	/**
	 * 댓글 작성하기
	 * @author seong
	 */
	@ResponseBody
	@RequestMapping("insertReply.bo")
	public String insertReply(Reply r,Model model) {
		int result = bService.insertReply(r);
		return result>0? "success" : "fail";		
	}
	
	/**
	 * 대댓글 작성하기
	 * @author seong
	 */
	@ResponseBody
	@RequestMapping("insertReplies.bo")
	public String insertReplies(Reply r,Board b,Model model) {
		int result = bService.insertReplies(r);
		return result>0?"success":"fail";
	}
	
	/**
	 * [커뮤니티 | 칼럼] 게시글 작성하기
	 * @author seong
	 */
	@RequestMapping("insert.bo")
	public ModelAndView insertComAndCol(Board b,ModelAndView mv,MultipartFile upfile,HttpSession session) {
		
		String category = b.getCategory();
		
		if(!upfile.getOriginalFilename().equals("")) {
			String changeName = saveFile(session,upfile); // "2021070217013023152.jpg"
			b.setImgPath("resources/images/board/" + changeName); // resource/uploadFiles/2021070217013023152.jpg
		}
		
		int result = bService.insertComAndCol(b);
		if(result>0) {
			session.setAttribute("alertMsg", "성공적으로 등록 되었어요 😀 ");
			//카테고리가 칼럼일 경우 칼럼 전체 리스트 페이지로 이동
			if(category.equals("칼럼")) {
				mv.setViewName("redirect:colList.bo");
			}else {
				//카테고리가 커뮤니티(일상|칼럼)일 경우 커뮤니티 전체 리스트 페이지로 이동	
				mv.setViewName("redirect:comList.bo");
			}
		}
		return mv;
	}
	
	
	/**
	 * [커뮤니티 | 칼럼] - 글 수정 Form
	 * @author seong
	 */
	
	@RequestMapping("updateForm.bo")
	public ModelAndView comUpdateForm(Board b,ModelAndView mv) {
		
		String category = b.getCategory();
		int bno = b.getBno();
		
		if(category!=null && category.equals("커뮤니티")) {
			mv.addObject("b",bService.boardDetail(bno))
			.setViewName("board/community/comUpdateForm");
		}else {
			mv.addObject("b",bService.boardDetail(bno))
			.setViewName("board/column/colUpdateForm");
		}
		return mv;
	}
	
	
	
	
	
	/**
	 * [커뮤니티 | 칼럼] - 게시글 수정하기
	 * @author seong
	 */
	@RequestMapping("update.bo")
	public ModelAndView updateCommunity(Board b, MultipartFile reupfile, ModelAndView mv,HttpSession session) {
		
		String category = b.getCategory();
		
		// 새로온 첨부파일이 있었을 때
		if(!reupfile.getOriginalFilename().equals("")) {
			if(b.getImgPath()!=null) {
				new File(session.getServletContext().getRealPath(b.getImgPath())).delete();
			}
			String changeName = saveFile(session,reupfile);
			b.setImgPath("resources/images/board/"+changeName);
		}
		
		int result = bService.updateComAndCol(b);
		
		if(result>0) {
			if(category.equals("칼럼")) {
				session.setAttribute("alertMsg", "성공적으로 수정되었습니다!");
				mv.setViewName("redirect:colList.bo?bno="+b.getBno());
			}else {
				session.setAttribute("alertMsg", "성공적으로 수정되었습니다!");
				mv.setViewName("redirect:comList.bo?bno="+b.getBno());
			}
			
		}
		return mv;
	}
		
	
	/**
	 * [커뮤니티 | 칼럼] 게시글 삭제하기
	 * @author seong
	 */
	
	@RequestMapping("delete.bo")
	public String deleteComAndCol(Board b,HttpSession session){
		
		int bno = b.getBno();
		String imgPath = b.getImgPath();
		String cagetory = b.getCategory();
		
		int result = bService.deleteComAndCol(bno);
		
		if(result>0) {
			//게시글 삭제시첨부파일도 지우기
			if(!imgPath.equals("")) {
				String removeImgPath = session.getServletContext().getRealPath(imgPath);
				new File(removeImgPath).delete();
			}
			session.setAttribute("alertMsg", "성공적으로 삭제되었습니다!");
		}
		
		if(!cagetory.equals("칼럼")) {
			return "redirect:comList.bo";
		}else {
			return "redirect:colList.bo";
		}
		
	
	}
	
	/**
	 * [커뮤니티] - 게시글 신고하기
	 * @author seong
	 */
	@RequestMapping("report.bo")
	public ModelAndView reportCommunity(Board b, Report r,ModelAndView mv,HttpSession session) {
		
		int result = bService.reportCommunity(r);
		int bno = b.getBno();
		if(result>0) {
			session.setAttribute("alertMsg", "신고 접수가 완료되었습니다!");
			mv.setViewName("redirect:comList.bo?bno="+b.getBno());
		}
		return mv;
	}
	
	/**
	 * [칼럼] - 전체 목록 리스트 조회
	 * @author seong
	 */
	
	@RequestMapping("colList.bo")
	public ModelAndView colList(@RequestParam(value="currentPage",defaultValue="1") int currentPage,ModelAndView mv) {
		
		int listCount = bService.colListCount();
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 5, 9);
		
		ArrayList<Board>colList = bService.colList(pi);
		
		mv.addObject("listCount",listCount)
		   .addObject("colList",colList)
		   .addObject("pi",pi)
		   .setViewName("board/column/colListView");
		return mv;
	}
	
	

	/**
	 * [커뮤니티]최신 | 조회수 | 좋아요 기준으로 조회
	 * @author seong
	 */
	
	@RequestMapping("colOrderByCount.bo")
	public ModelAndView colOrderByCount(ModelAndView mv,@RequestParam(value="currentPage",defaultValue="1")
										int currentPage, String condition,String flag) {
		
	int listCount = bService.colListCount();
	PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 5, 9);
	
	ArrayList<Board>colList = bService.colOrderByCount(pi, condition);
	
	  mv.addObject("pi",pi)
		.addObject("colList",colList)
		.addObject("condition",condition)
		.addObject("listCount",listCount)
		.addObject("flag",flag)
		.setViewName("board/column/colListView");
	  return mv;
	}
	
	
	
	/**
	 * [칼럼] - 글 작성 Form
	 * @author seong
	 */
	
	@RequestMapping("colEnrollForm.bo")
	public ModelAndView colEnrollForm(ModelAndView mv) {
		mv.setViewName("board/column/colEnrollForm");
		return mv;
	}
	
	/**
	 * [칼럼] - 글 상세보기
	 * @author seong
	 */

	@RequestMapping("colDetail.bo")
	public ModelAndView colDetail(ModelAndView mv,Board board) {
		
		int bno = board.getBno();
		
		// 게시글 조회수 증가 
		int result = bService.increaseCount(bno);
		
		// 유효한 게시글일 때
		if(result>0) {
			Board b = bService.boardDetail(bno);
			
			// 게시글 상세 조회 시 로그인한 회원이 해당 게시글 (좋아요,스크랩,후원)여부 확인
			int likesCount = bService.likesCount(board);
			int scrapCount = bService.scrapCount(board);
			int sponsorCount = bService.sponsorCount(board);
			
			// 좋아요 여부
			if(likesCount!=0) {
				mv.addObject("likes",likesCount);
			} 
			
			// 스크랩 여부
			if(scrapCount !=0) {
				mv.addObject("scrap",scrapCount);
			}
			
			// 후원 여부
			if(sponsorCount!=0) {
				mv.addObject("sponsor",sponsorCount);
			}
			
			mv.addObject("b",b).setViewName("board/column/colDetailView");
			
		}else {
			mv.addObject("errorMsg", "조회 실패!")
			.setViewName("common/errorPage");
		}
		return mv;
	}
	

	
	/**
	 *  Ajax로 좋아요 | 스크랩 등록
	 * @author seong
	 */
	@ResponseBody
	@RequestMapping("likeAndScrap.bo")
	public String likeAndScrap(int bno,int mno,String condition,ModelAndView mv,HttpSession session) {
		
		HashMap<String,Object>map = new HashMap<>();
		map.put("condition", condition);
		map.put("bno", bno);
		map.put("mno",mno);
		
		// 좋아요 | 스크랩 insert 
		int result = bService.likeAndScrap(map);
		
		// 성공적으로 insert가 되면 해당 컬럼에 count + 1
		if(result>0) {
			int increaseCounts = bService.increaseCounts(map);
		}
		
		return result>0? "success" : "fail";
	}
	

	/**
	 *  Ajax로 좋아요 | 스크랩 해제
	 * @author seong
	 */
	@ResponseBody
	@RequestMapping("UnlikeAndUnScrap.bo")
	public String UnlikeAndUnScrap(int bno,int mno,String condition,ModelAndView mv,HttpSession session) {
		
		HashMap<String,Object>map = new HashMap<>();
		map.put("condition", condition);
		map.put("bno", bno);
		map.put("mno",mno);
		
		int result = bService.UnlikeAndUnScrap(map);
		
		if(result>0) {
			int decreaseCounts = bService.decreaseCounts(map);
		}
		
		return result>0? "success" : "fail";
	}
	
	
	/**
	 * Ajax [ 칼럼 ] 관심 칼럼 조회
	 * @author seong
	 */
	
	@ResponseBody
	@RequestMapping(value="columnTop4.bo",produces="application/json; charset=utf-8")
	public String topBoardList() {
		ArrayList<Board>list = bService.topBoardList();
		return new Gson().toJson(list);
	}
	
	/**
	 * [ 칼럼 ] 임시저장 등록
	 * @author seong
	 */
	@RequestMapping("colTemSave.bo")
	public ModelAndView colStorageInsert(Board b,ModelAndView mv,HttpSession session) {
		
		int result = bService.colStorageInsert(b);
		
		if(result>0) {
			session.setAttribute("alertMsg", "임시 저장 성공!");
			mv.setViewName("redirect:colList.bo");
		}else {
			session.setAttribute("alertMsg", "임시 저장 실패 😅");
		}
		
		return mv;
		
	}
	
	/**
	 * [ 칼럼 ] 임시저장 글 조회  -->
	 * @author seong
	 */
	
	@RequestMapping("selectTemSave.bo")
	public ModelAndView selectTemSave(int bno,ModelAndView mv) {
		
		mv.addObject("b",bService.selectTemSave(bno))
			.setViewName("board/column/colUpdateForm");;
		
		return mv;
	}
	
	
	
	//-----------------------------------------------------------
	
	public String saveFile(HttpSession session,MultipartFile file) {
		
		String savePath = session.getServletContext().getRealPath("resources/images/board/");
		
		String originName = file.getOriginalFilename();
		//20210702(년월일) + 23432(랜덤값) + .jpg(원본파일확장자) 
		String currentTime = new SimpleDateFormat("yyyyMMdd").format(new Date());
		int ranNum = (int)(Math.random() * 90000 + 10000);
		String ext = originName.substring(originName.lastIndexOf("."));//.다음 인덱스부터의 문자열 추출
		
		String changeName = currentTime + "_" + ranNum + ext;
		
		try {
			file.transferTo(new File(savePath + changeName));
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		return changeName;
	}
	

	
	
}
