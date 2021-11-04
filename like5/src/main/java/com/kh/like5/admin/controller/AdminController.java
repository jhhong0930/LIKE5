package com.kh.like5.admin.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.like5.admin.model.service.AdminService;
import com.kh.like5.admin.model.vo.Calculate;
import com.kh.like5.admin.model.vo.Faq;
import com.kh.like5.board.model.vo.Board;
import com.kh.like5.board.model.vo.Report;
import com.kh.like5.board.model.vo.Tag;
import com.kh.like5.common.model.vo.PageInfo;
import com.kh.like5.common.template.Pagination;
import com.kh.like5.member.model.vo.Customer;
import com.kh.like5.member.model.vo.Member;
import com.kh.like5.member.model.vo.Sponsorship;

import lombok.extern.java.Log;

@Controller
@Log
public class AdminController {
	
	@Autowired
	private AdminService adService;

	// about 페이지
	@RequestMapping("about.ad")
	public String about() {
		return "admin/about";
	}


	// ============================= [지현] =============================

	// 회원관리 페이지
    @RequestMapping("member.ad")
    public  ModelAndView memberPage(ModelAndView mv, @RequestParam(value="currentPage", defaultValue="1") int currentPage) {
    	
    	int listCount = adService.selectMemCount();
    	
    	PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 5, 15);
    	ArrayList<Member> list = adService.selectMemList(pi);
    	
    	mv.addObject("pi", pi)
		  .addObject("list", list)
		  .setViewName("admin/adminMember");
    	
        return mv;
    }
    
    // 회원관리-검색기능
    @RequestMapping("searchMem.ad")
    public ModelAndView searchMemList(ModelAndView mv, @RequestParam(value="currentPage", defaultValue="1") int currentPage, String condition , String keyword) {
    	
    	HashMap<String,String> map = new HashMap<>();
    	map.put("condition", condition);
    	map.put("keyword", keyword);
    	
    	int listCount = adService.selectSearchMemCount(map);
    	
    	PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 5, 15);
    	ArrayList<Member> list = adService.selectSearchMemList(pi,map);
    	
    	mv.addObject("pi",pi)
    	  .addObject("list",list)
    	  .addObject("condition", condition)
    	  .addObject("keyword", keyword)
    	  .setViewName("admin/adminMember");
    	
    	return mv;
    	
    }

	// 회원탈퇴 처리 기능
	@RequestMapping("deleteMem.ad")
	public String  deleteMem(int memNo, Model model, HttpSession session ) {

		// 회원의 탈퇴 상태를 'Y'로 업데이트 해주기
		int result= adService.deleteMem(memNo);
		// 기존의 페이지로 돌아갈 수 있게 해주기
		if(result>0) { //제대로 삭제된 경우
			session.setAttribute("alertMsg", "해당 회원이 성공적으로 탈퇴 처리 되었습니다!");
			return "redirect:member.ad";
		}else {
			model.addAttribute("errorMsg", "게시글 삭제 실패");
			return "common/errorPage";
		}


	}
	
	// 1:1문의 메인페이지 불러오기&리스트 조회
	@RequestMapping("csTwo.ad")
	public ModelAndView csTwoList(ModelAndView mv, @RequestParam(value="currentPage", defaultValue="1") int currentPage) {
		
		int listCount = adService.selectCsTwoCount();
    	
    	PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 5, 10);
    	ArrayList<Customer> list = adService.selectCsTwoList(pi);
    	
    	mv.addObject("pi", pi)
		  .addObject("list", list)
		  .setViewName("admin/csMainTwo");
    	
        return mv;
	}
	
	// 1:1문의 관리 검색기능
	@RequestMapping("searchCs.ad")
	public ModelAndView searchCsMemList(ModelAndView mv, @RequestParam(value="currentPage", defaultValue="1") int currentPage, String condition , String keyword) {
		HashMap<String,String> map = new HashMap<>();
    	map.put("condition", condition);
    	map.put("keyword", keyword);
    	
    	int listCount = adService.searchCsMemCount(map);
    	
    	PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 5, 10);
    	ArrayList<Customer> list = adService.searchCsMemList(pi,map);
    	
    	mv.addObject("pi",pi)
    	  .addObject("list",list)
    	  .addObject("condition", condition)
    	  .addObject("keyword", keyword)
    	  .setViewName("admin/csMainTwo");
    	
    	return mv;
	}
	
	// 1:1 문의 페이지 상세
	@RequestMapping("csDetail.ad")
	public ModelAndView csDetail(int csNo, ModelAndView mv) {
		Customer cs = adService.selectCustomer(csNo);
		
		mv.addObject("cs",cs).setViewName("admin/csDetail");
		return mv;
	}
	
	// 1:1문의 페이지 답변달기
	@RequestMapping("insertCsAns.ad")
	public String insertCsAns(Customer cs, HttpSession session) {
		// 관리자의 답변 update해주기
		int result = adService.insertCsAns(cs);
		// 이에 성공했다면 Customer 객체 다시 받아와서 redirect로 해당 페이지 혹은 list페이지로 돌아갈 수 있도록 하기
		if(result>0) { // 성공했을 경우 
			session.setAttribute("alertMsg", "관리자님 답변이 성공적으로 등록되었습니다");
			return "redirect:csTwo.ad";
			
		}else { // 실패한 경우
			session.setAttribute("errorMsg", "관리자님 답변 등록에 실패했습니다.");
			return "common/errorPage";
		}
		
	}
	//1:1문의 페이지 답변 수정
	@RequestMapping("updateCsAns.ad")
	public String updateCsAns(Customer cs, HttpSession session) {
		// 관리자의 답변 update해주기
		int result = adService.updateCsAns(cs);
		// 이에 성공했다면 Customer 객체 다시 받아와서 redirect로 해당 페이지 혹은 list페이지로 돌아갈 수 있도록 하기
		if(result>0) { // 성공했을 경우 
			session.setAttribute("alertMsg", "관리자님 답변이 성공적으로 수정되었습니다.");
			return "redirect:csTwo.ad";
			
		}else { // 실패한 경우
			session.setAttribute("errorMsg", "관리자님 답변 등록에 실패했습니다.");
			return "common/errorPage";
		}
		
	}
	
	
	
	
	// 후원관리 - 메인페이지 불러오기 & 리스트 조회
	@RequestMapping("donation.ad")
	public ModelAndView donaMain(ModelAndView mv, @RequestParam(value="currentPage", defaultValue="1") int currentPage) {
		// 우선 페이징 처리를 위해서는 총 갯수를 알아야겠징
		int listCount = adService.selectSponCount();
		
		// 페이징 처리 & SponList 받아오기
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 5, 10);
    	ArrayList<Sponsorship> list = adService.selectSponList(pi);
		
    	mv.addObject("pi", pi)
		  .addObject("list", list)
		  .setViewName("admin/donationMain");
    	
    	
		return mv;
	}
	
	// 후원관리 - 검색 기능
	@RequestMapping("searchDona.ad")
	public ModelAndView searchDonaList(ModelAndView mv, @RequestParam(value="currentPage", defaultValue="1") int currentPage, String condition , String keyword) {
		HashMap<String,String> map = new HashMap<>();
    	map.put("condition", condition);
    	map.put("keyword", keyword);
    	
    	int listCount = adService.searchDonaCount(map);
    	// 페이징 처리 및 리스트 받아오기
    	PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 5, 10);
    	ArrayList<Sponsorship> list = adService.searchDonaList(pi,map);
    	
    	mv.addObject("pi",pi)
	  	  .addObject("list",list)
	  	  .addObject("condition", condition)
	  	  .addObject("keyword", keyword)
	  	  .setViewName("admin/donationMain");
	  	
	  	return mv;
    	
	}
	
	// 후원관리 - 상세 페이지로 넘어가기 => 후원내역
	@RequestMapping("donaDetailOne.ad")
	public ModelAndView donaDetailOne(int smemNo, ModelAndView mv, @RequestParam(value="currentPage", defaultValue="1") int currentPage ) {
		// 특정회원의 smem_no를 받아와서 넘겨주면서 페이징 처리도 해줘야 한다 이말이야...^^
		// 내역을 페이징 처리하고(후원한 회원들 조회하는 sql문 기준임==> list2가 기준이 되는거징!!!)
		//int smemNo = 5;
		int listCount = adService.selectSponsorCount(smemNo);
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 5, 10);
		
		// 리스트도 조회해 와야한다궁(list1== smem_no회원& list2 == 후원한 회원들 정보)
		Sponsorship spMem = adService.selectSponMem(smemNo); // 얘는 하나니까 페이징 처리를 할 필요가 없음
		ArrayList<Sponsorship> list2 = adService.selectSponsorList(pi, smemNo);	//
		
		mv.addObject("pi", pi)
		  .addObject("spMem", spMem)
		  .addObject("list2", list2)
		  .setViewName("admin/donationDetailOne");
		
		return mv;
	}
	
	// 후원관리 - 상세 페이지로 넘어가기 => 정산내역
	@RequestMapping("donaDetailTwo.ad")
	public ModelAndView donaDetailTwo(int smemNo,ModelAndView mv, @RequestParam(value="currentPage", defaultValue="1") int currentPage) {
		// 페이징 처리 해줄거고(기준은 list가 되어야 한다 이말이지!)
		// 단, 받아온 smem_no를 넘겨서 정보를 받아와야햄
		int listCount = adService.selectCalCount(smemNo);
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 5, 5);
		
		// 총 정산금도 조회 해줄거고(total)
		Calculate calMem = adService.selectTotalCal(smemNo);
		// 리스트 조회도 해줄거야 (list)
		ArrayList<Calculate> list = adService.selectCalList(pi, smemNo);
		
		mv.addObject("pi", pi)
		  .addObject("calMem", calMem)
		  .addObject("list", list)
		  .setViewName("admin/donationDetailTwo");
		
		return mv;
	}
	
	// tag 메인페이지
	@RequestMapping("tags.ad")
	public String tagList(Model model) {
		model.addAttribute("list", adService.tagList());
		return "admin/tagMain";
	}

	// tag 관리자 페이지-기본
	@RequestMapping("tagAdmin.ad")
	public ModelAndView tagAdmin(ModelAndView mv, @RequestParam(value="currentPage", defaultValue="1") int currentPage) {
		// 페이징처리
		int listCount = adService.selectTagsCount();
		
		// 리스트 조회
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 5, 10);
    	ArrayList<Tag> list = adService.selectAllTags(pi);
    	mv.addObject("pi", pi)
		  .addObject("list", list)
		  .setViewName("admin/tagAdmin");
  	
      return mv;
    	
	}
	
	// tag관리자 페이지 -추가하기 (redirect로 tagAdmin.ad불러오기)& 추가되면 알림창 뜨고 나서 불러오기
	@RequestMapping("addTag.ad")
	public String addTag(String tagName, HttpSession session) {
		// 사용자가 입력한 tag값을 가져옴
		// db에 insert해줌
		int result = adService.addTag(tagName);
		
		// 성공적으로 insert시에는 alert창으로 성공적으로 되었다는 알림이 뜨게 만들어줌&다시 관리 페이지 redirect
		if(result>0) {
			
			session.setAttribute("alertMsg", "입력하신 태그가 성공적으로 추가되었습니다.");
			return "redirect:tagAdmin.ad";
		}else {// 아닌 경우는 에러가 뜨게 해야겠지
			session.setAttribute("errorMsg", "관리자님 태그 등록에 실패했습니다.");
			return "common/errorPage";
		}
		
		
		
	}
	// tag관리자 페이지 -수정하기(redirect로 tagAdmin.ad불러오기)& 수정되면 수정되었다고 알람뜨기
	@RequestMapping("updateTag.ad")
	public String udpateTag(String tagName,int tagNo, HttpSession session) {
		
		Tag tag = new Tag(tagNo, tagName);
		
		int result = adService.updateTag(tag);
		
		if(result>0) {
			session.setAttribute("alertMsg", "태그명이 성공적으로 수정됐습니다.");
			return "redirect:tagAdmin.ad";
		}else {
			session.setAttribute("errorMsg", "관리자님 태그 수정에 실패했습니다.");
			return "common/errorPage";
		}
	}
		
		

	// tag 게시글 끌어오는 페이지
	@RequestMapping("tagDetail.ad")
	public ModelAndView tagDetail(ModelAndView mv, @RequestParam(value="currentPage", defaultValue="1") int currentPage, String tagName) {

		int listCount = adService.getTagCount(tagName);

		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 10);
		ArrayList<Board> list = adService.tagDetailList(pi, tagName);

		log.info("listCount = " + listCount);
		adService.tagDetailList(pi, tagName).forEach(board -> log.info("list: " + board));

		mv.addObject("pi", pi)
				.addObject("list", list)
				.addObject("tagName", tagName)
				.setViewName("admin/tagDetail");

		return mv;
	}
	
	
	
	
	

	// ============================= [재환] =============================

    // 게시글 관리 페이지
	@RequestMapping("board.ad")
	public ModelAndView boardList(ModelAndView mv, @RequestParam(value="currentPage", defaultValue="1") int currentPage) {

		int listCount = adService.getBoardCount();

		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 15);
		ArrayList<Board> list = adService.getBoardList(pi);

		mv.addObject("pi", pi)
				.addObject("list", list)
				.setViewName("admin/adminBoard");

		adService.getBoardList(pi).forEach(board -> log.info("list: " + board));

		return mv;
	}

	// 게시글 관리 페이지 검색 기능
	@RequestMapping("searchBoard.ad")
	public ModelAndView boardSearchList(ModelAndView mv, @RequestParam(value="currentPage", defaultValue="1") int currentPage, String condition , String keyword) {

		HashMap<String,String> map = new HashMap<>();
		map.put("condition", condition);
		map.put("keyword", keyword);

		int listCount = adService.getSearchBoardCount(map);

		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 5, 15);
		ArrayList<Board> list = adService.getSearchBoardList(pi,map);

		mv.addObject("pi",pi)
				.addObject("list",list)
				.addObject("condition", condition)
				.addObject("keyword", keyword)
				.setViewName("admin/adminBoard");

		return mv;

	}

	// 게시글 삭제 기능
	@RequestMapping("deleteBoard.ad")
	public String  deleteBoard(int bno, Model model, HttpSession session ) {

		int result= adService.deleteBoard(bno);

		if(result>0) { //제대로 삭제된 경우
			session.setAttribute("alertMsg", "게시글 삭제 성공!");
			return "redirect:board.ad";
		}else {
			model.addAttribute("errorMsg", "게시글 삭제 실패");
			return "common/errorPage";
		}

	}

	// 고객센터 - 신고내역 관리 페이지
	@RequestMapping("customer.ad")
	public ModelAndView reportList(ModelAndView mv, @RequestParam(value="currentPage", defaultValue="1") int currentPage) {

		int listCount = adService.getReportCount();

		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 15);
		ArrayList<Report> list = adService.getReportList(pi);

		mv.addObject("pi", pi)
				.addObject("list", list)
				.setViewName("admin/csReport");

		adService.getReportList(pi).forEach(board -> log.info("list: " + board));

		return mv;
	}

	// 신고내역 검색 기능
	@RequestMapping("searchReport.ad")
	public ModelAndView reportSearchList(ModelAndView mv, @RequestParam(value="currentPage", defaultValue="1") int currentPage, String condition , String keyword) {

		HashMap<String,String> map = new HashMap<>();
		map.put("condition", condition);
		map.put("keyword", keyword);

		int listCount = adService.getSearchReportCount(map);

		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 5, 15);
		ArrayList<Report> list = adService.getSearchReportList(pi,map);

		mv.addObject("pi",pi)
				.addObject("list",list)
				.addObject("condition", condition)
				.addObject("keyword", keyword)
				.setViewName("admin/csReport");

		return mv;

	}

	// 신고내역 삭제 기능
	@RequestMapping("deleteReport.ad")
	public String deleteReport(int rno, Model model, HttpSession session) {

		int result= adService.deleteReport(rno);
		System.out.println(rno);

		if(result>0) { //제대로 삭제된 경우
			session.setAttribute("alertMsg", "게시글 삭제 성공!");
			return "redirect:customer.ad";
		}else {
			model.addAttribute("errorMsg", "게시글 삭제 실패");
			return "common/errorPage";
		}

	}

	// FAQ 페이지
	@RequestMapping("faq.ad")
	public ModelAndView faqList(ModelAndView mv) {

		ArrayList<Faq> list = adService.getFaqList();

		mv.addObject("list", list)
				.setViewName("admin/faq");

		adService.getFaqList().forEach(faq -> log.info("list: " + faq));

		return mv;
	}

	// FAQ 작성하기 페이지
	@RequestMapping("enrollForm.faq")
	public String faqEnrollForm() {
		return "admin/faqEnrollForm";
	}

	// FAQ 작성 기능
	@RequestMapping("insertFaq.ad")
	public String insertFaq(Faq f, HttpSession session, Model model) {

		int result = adService.insertFaq(f);

		if (result > 0) {
			session.setAttribute("alertMsg", "등록 성공");
			return "redirect:faq.ad";
		} else {
			model.addAttribute("errorMsg", "등록 실패");
			return "common/errorPage";
		}

	}

	// FAQ 수정하기 페이지
	@RequestMapping("updateForm.faq")
	public String faqUpdateForm(int fno, Model model) {

		model.addAttribute("f", adService.getFaq(fno));

		return "admin/faqUpdateForm";

	}

	// FAQ 수정 기능
	@RequestMapping("updateFaq.ad")
	public String updateFaq(Faq f, HttpSession session, Model model) {

		int result = adService.updateFaq(f);

		if(result > 0) {
			session.setAttribute("alertMsg", "수정 성공");
			return "redirect:faq.ad";
		}else {
			model.addAttribute("errorMsg", "수정 실패");
			return "common/errorPage";
		}

	}

	// FAQ 삭제 기능
	@RequestMapping("deleteFaq.ad")
	public String deleteFaq(int fno, HttpSession session, Model model) {

		int result = adService.deleteFaq(fno);

		if(result > 0) {
			session.setAttribute("alertMsg", "삭제 성공");
			return "redirect:faq.ad";
		}else {
			model.addAttribute("errorMsg", "삭제 실패");
			return "common/errorPage";
		}

	}

}
