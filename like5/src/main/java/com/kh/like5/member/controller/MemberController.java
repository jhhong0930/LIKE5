package com.kh.like5.member.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.like5.admin.model.vo.Calculate;
import com.kh.like5.board.model.vo.Board;
import com.kh.like5.board.model.vo.Reply;
import com.kh.like5.common.model.vo.PageInfo;
import com.kh.like5.common.template.Pagination;
import com.kh.like5.member.model.service.MemberService;
import com.kh.like5.member.model.vo.Customer;
import com.kh.like5.member.model.vo.Member;
import com.kh.like5.member.model.vo.Sponsorship;

@Controller
public class MemberController {
	
	@Autowired
	private MemberService mService;
	
	//------------------------------------동규------------------------------------
	
	@RequestMapping("insertPage.me")
	public String insertPage() {
		
		return "member/insertMem";
		
	}
	
	@RequestMapping("insert.me")
	public String insertMember(Member m, Model model, MultipartFile upfile, HttpSession session, String bankName) {
		
		if(!upfile.getOriginalFilename().equals("")) {
			String changeName = saveFile(session, upfile);
			m.setMemProfile("resources/images/memProfile/" + changeName);
		}
		
		if(bankName.equals("kb")) {
			m.setBank("국민은행");
		}else if(bankName.equals("shin")) {
			m.setBank("신한은행");
		}else if(bankName.equals("we")){
			m.setBank("우리은행");
		}else if(bankName.equals("kko")){
			m.setBank("카카오뱅크");
		}else {
			m.setBank(null);
		}
		
		int result = mService.insertMember(m);
		
		if(result > 0) {
			return "redirect:/";
		}else {
			model.addAttribute("errorMsg", "회원가입 실패");
			return "common/errorPage";
		}
		
	}
	
	@RequestMapping("login.me")
	public ModelAndView login(Member m, HttpSession session, ModelAndView mv) {
		
		Member loginUser = mService.loginMember(m);
		
		if(loginUser == null) { // 로그인 실패 => 에러페이지
			mv.addObject("errorMsg", "로그인 실패!");
			mv.setViewName("common/errorPage");
		}else { // 로그인 성공 => 메인페이지
			session.setAttribute("loginUser", loginUser);
			mv.setViewName("redirect:/");
		}
		
		return mv;
	}
	
	@RequestMapping("insertcalculate.me")
	public ModelAndView insertcalculate(HttpSession session, Calculate c, ModelAndView mv) {
		
		
		int memNo = c.getMemNo();
		
		if(c.getCalPrice() > 9999) { // 로그인 실패 => 에러페이지
			int insertcalculate = mService.insertcalculate(c);
			mv.setViewName("redirect:myPage.me?memNo=" + memNo);
		}else { // 로그인 성공 => 메인페이지
			mv.addObject("errorMsg", "10,000원이상 정산신청해주세요!");
			mv.setViewName("common/errorPage");
		}

		return mv;
	}
	
	@RequestMapping("logout.me")
	public String logoutMember(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	@RequestMapping("inquiry.me")
	public ModelAndView inquiry(ModelAndView mv, HttpSession session, Member m, @RequestParam(value="currentPage", defaultValue="1") int currentPage) {
		
		int memNo = m.getMemNo();
		int listCount = mService.inquiryCount(memNo);
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 10);
		ArrayList<Customer> list = mService.inquiry(pi, memNo);
		
		mv.addObject("pi", pi)
		  .addObject("list", list)
		  .setViewName("member/memInquiryList");
		
		System.out.println(list);
		
      return mv;
		
	}
	
	@RequestMapping("donate.me")
	public ModelAndView donate(ModelAndView mv, HttpSession session, Member m, @RequestParam(value="currentPage", defaultValue="1") int currentPage) {
		
		int memNo = m.getMemNo();
		int listCount = mService.donateCount(memNo);
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 10);
		ArrayList<Sponsorship> list = mService.donate(pi, memNo);
		
		mv.addObject("pi", pi)
		  .addObject("list", list)
		  .setViewName("member/memDonate");
		
      return mv;
		
	}
	
	@RequestMapping("myPage.me")
	public ModelAndView myPage(ModelAndView mv, HttpSession session, Member m) {
		
		int memNo = m.getMemNo();
		int price = 0;
		int settlement = 0;
		int settleable = 0;
		
		ArrayList<Sponsorship> sponList = mService.price(memNo);
		ArrayList<Calculate> calList = mService.calculate(memNo);
		ArrayList<Board> newlyList = mService.newlylist(memNo);
		ArrayList<Reply> ansList = mService.anslist(memNo);
		ArrayList<Board> tempSaveList = mService.tempSavelist(memNo);
		Member memberInfor = mService.memberInfor(memNo);
		
		for(int i=0; i <sponList.size(); i++) {
			price += 1000;
		}
		
		for(int i=0; i<calList.size(); i++) {
			settlement += calList.get(i).getCalPrice();
		}
		
		settleable = price - settlement;
		
		session.setAttribute("price", price);
		session.setAttribute("settleable", settleable);
		session.setAttribute("memberInfor", memberInfor);
		
		mv.addObject("newlyList", newlyList)
		  .addObject("ansList", ansList)
		  .addObject("tempSaveList", tempSaveList)
		  .setViewName("member/myPage");
		
		//System.out.println(newlyList);
		//System.out.println(ansList);
		//System.out.println(sponList);
		//System.out.println(price);
		//System.out.println(settleable);
		//System.out.println(memberInfor);
		
		return mv;
		
	}
	
	@RequestMapping("tempSaveListDetail.me")
	public ModelAndView tempSaveListDetail(ModelAndView mv, HttpSession session, Member m, @RequestParam(value="currentPage", defaultValue="1") int currentPage){

		int memNo = m.getMemNo();
		int listCount = mService.tempSaveListCount(memNo);
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 10);
		ArrayList<Board> list = mService.tempSaveListDetail(pi, memNo);
		
		mv.addObject("pi", pi)
		  .addObject("list", list)
		  .setViewName("member/tempSaveListDetail");
		
      return mv;
		
	}
	
	@RequestMapping("ansListDetail.me")
	public ModelAndView ansListDetail(ModelAndView mv, HttpSession session, Member m, @RequestParam(value="currentPage", defaultValue="1") int currentPage){

		int memNo = m.getMemNo();
		int listCount = mService.ansListCount(memNo);
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 10);
		ArrayList<Board> list = mService.ansListDetail(pi, memNo);
		
		mv.addObject("pi", pi)
		  .addObject("list", list)
		  .setViewName("member/ansListDetail");
		
      return mv;
		
	}
	
	@RequestMapping("memPostListDetail.me")
	public ModelAndView memPostListDetail(ModelAndView mv, HttpSession session, Member m, @RequestParam(value="currentPage", defaultValue="1") int currentPage){

		int memNo = m.getMemNo();
		int listCount = mService.memPostListDetailCount(memNo);
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 10);
		ArrayList<Board> list = mService.memPostListDetail(pi, memNo);
		
		mv.addObject("pi", pi)
		  .addObject("list", list)
		  .setViewName("member/memPostListDetail");
		
      return mv;
		
	}
	
	@RequestMapping("correctInfor.me")
	public String correctInfor() {
		
		return "member/correctInfor";
		
	}
	
	@RequestMapping("update.me")
	public String correctInfor(Member m, MultipartFile reupfile, HttpSession session, Model model, String bankName, String memPwd) {
		
		int memNo = m.getMemNo();
		//System.out.println(memNo);
		//System.out.println(bankName);
		
		if(!reupfile.getOriginalFilename().equals("")) {
			// 기존에 첨부파일이 있었을 경우 => 기존의 첨부파일 지우기
			if(m.getMemProfile() != null) {
				new File(session.getServletContext().getRealPath(m.getMemProfile())).delete();
			}
			String changeName = saveFile(session, reupfile);
			m.setMemProfile("resources/images/memProfile/" + changeName);
		}
		
		if(bankName.equals("kb")) {
			m.setBank("국민은행");
		}else if(bankName.equals("shin")) {
			m.setBank("신한은행");
		}else if(bankName.equals("we")){
			m.setBank("우리은행");
		}else if(bankName.equals("kko")){
			m.setBank("카카오뱅크");
		}else {
			m.setBank(null);
		}
		
		int result = mService.updateMember(m);
			
		if(result > 0) {
			return "redirect:myPage.me?memNo=" + memNo;
		}else {
			model.addAttribute("errorMsg", "프로필 수정 실패");
			return "common/errorPage";
		}
		
	}
	
	@RequestMapping("delete.me")
	public String deleteMember(HttpSession session, Member m) {
		
		mService.deleteMember(m.getMemNo());
		session.invalidate();
		return "redirect:/";
		
	}
	
	public String saveFile(HttpSession session, MultipartFile upfile) {
		
		String savePath = session.getServletContext().getRealPath("resources/images/memProfile/");
		
		String originName = upfile.getOriginalFilename();
		// 20210702170130(년월일시분초) + 23152(랜덤값) + .jpg(원본파일확장자)
		String currentTime = new SimpleDateFormat("yyyyMMdd").format(new Date());
		int ranNum = (int)(Math.random() * 90000 + 10000);
		String ext = originName.substring(originName.lastIndexOf("."));
		
		String changeName = currentTime + "_" + ranNum + ext;
		
		try {
			upfile.transferTo(new File(savePath + changeName));
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		
		return changeName;
		
	}
	
	
	//---------------------------------성은------------------------------------
	
	/**
	 * [1:1문의] - 작성 Form
	 * @author seong
	 */

	@RequestMapping("inqEnrollForm.me")
	public String inqEnrollForm() {
		return "member/memInquiry";
	}
	
	@RequestMapping("insertInquiry.me")
	public ModelAndView insertInquiry(ModelAndView mv,Customer c,HttpSession session) {
		
		int result = mService.insertInquiry(c);
		
		
		if(result>0) {
			session.setAttribute("alertMsg", "게시글 작성 성공!");
			mv.setViewName("common/main");
		}else {
			mv.addObject("errorPage", "게시글 작성 실패!");
			mv.setViewName("common/errorPage");
		}
		
		return mv;
	}
	
	
	//------------------------------- [한솔] ----------------------------------
	
	/**
	 * [QnA, 칼럼] - QnA, 칼럼 후원 insert
	 * @author Hansol
	 */
	
	@RequestMapping("sponInsert.me")
	public String sponInsert(Sponsorship s, HttpSession session, Model model, HttpServletRequest request) {
		int result = mService.sponInsert(s);
		String referer = (String)request.getHeader("referer");

		if(result > 0) {
			session.setAttribute("alertMsg", " 후원 결제가 성공적으로 완료되었습니다. ");
			return "redirect:" + referer;
		}else {
			model.addAttribute("errorMsg", " 후원 결제에 실패하였습니다. ");
			return "common/errorPage";
		}
	}
	
}
