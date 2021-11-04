package com.kh.like5.booking.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;

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
import com.kh.like5.booking.model.service.BookingService;
import com.kh.like5.booking.model.vo.Booking;
import com.kh.like5.booking.model.vo.Office;
import com.kh.like5.booking.model.vo.Review;
import com.kh.like5.common.model.vo.Attachment;
import com.kh.like5.common.model.vo.PageInfo;
import com.kh.like5.common.template.Pagination;
import com.kh.like5.member.model.vo.Member;


@Controller
public class BookingController {
	
	@Autowired
	private BookingService bService;
	
	/**
	 * [신원]오피스예약메인페이지
	 */
	@RequestMapping("bMain.bk")
	public String bMain() {
		return "booking/bMain";
	}
	
	@ResponseBody
	@RequestMapping(value="autoBranch.bk", produces="application/json; charset=utf-8")
	public String autoComplete(String searchKeyword) {
		System.out.println(searchKeyword);
		ArrayList<Office> list = bService.autoComplete(searchKeyword);
		return new Gson().toJson(list);
	}
	
	/**
	 * [신원]오피스검색결과
	 */
	@RequestMapping("searchOffice.bk")
	public String searchOffice(Booking b, Model model, HttpServletRequest request) {
		ArrayList<Office> list = bService.selectOfficeList(b);
		model.addAttribute("list",list);
		model.addAttribute("b", b);
		return "booking/bResult";
		
	}
	
	@RequestMapping("list.bk")
	public String selectListAll(@RequestParam(value="currentPage", defaultValue="1") int currentPage, Model model) {
		int listCount = bService.selectListCount();
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 5);
		
		ArrayList<Office> list = bService.selectListAll(pi);
		
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		
		return "booking/aOfficeList";
	}
	
	@RequestMapping("detail.bk")
	public ModelAndView selectOffice(int ono, ModelAndView mv,HttpSession session) {
		int officeNo = ono;
		//attachment에도 접근해서 list로 가져와서 화면에 뿌려줘야함...
		Office o = bService.selectOffice(officeNo);
		ArrayList<Attachment> list = bService.selectOfficeAtt(officeNo);
		System.out.println(list);
		if(o != null) {
			//session.setAttribute("ott", o);
			//session.setAttribute("alist", list);
			mv.addObject("o", o).setViewName("booking/aOfficeDetailView");
			mv.addObject("list", list).setViewName("booking/aOfficeDetailView");
		} else {
			mv.addObject("errorMsg", "조회 실패").setViewName("common/errorPage");
		}
		return mv;
	}

	@RequestMapping("insertForm.bk")
	public String enrollForm() {
		return "booking/aOfficeInsertForm";
	}
	
	@RequestMapping("insertOf.bk")
	public String insertOffice(Office o, HttpServletRequest request, MultipartFile[] file, HttpSession session, Model model) {
		String[] facilityArr = request.getParameterValues("facility");
		String facility ="";
		if(facilityArr != null) {
			facility = String.join(",", facilityArr);
		}
		o.setFacility(facility);
		
		ArrayList<Attachment> list = new ArrayList<>();
		
		for(int i=0; i< file.length; i++) {
			if(!file[i].getOriginalFilename().equals("")) {
				Attachment att = new Attachment();
				if( i == 0) {
					String changeName = saveFile(file[i], session);
					o.setOffImgPath("resources/images/" + changeName);
				} else {
					String changeName = saveFile(file[i], session);
					att.setFilePath("resources/images/" + changeName);
					att.setRefBno(9);
					list.add(att);
				}
			}
		}

		int result = bService.insertOffice(o, list);
		
		if(result > 0) {
			session.setAttribute("alertMsg", "업로드 성공");
			return "redirect:list.bk";
		} else {
			model.addAttribute("errorMsg","업로드 실패");
			return "common/errorPage";
		}
	}
	
	public String saveFile(MultipartFile file, HttpSession session) {
		
		String savePath = session.getServletContext().getRealPath("resources/images/");
		
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
	
	@RequestMapping("updateOf.bk")
	public String updateOffice(Office o, Attachment att, HttpServletRequest request, HttpSession session, MultipartFile refileTop, MultipartFile[] refile, Model model) {
		//facility 부분 가져오기
		String[] facilityArr = request.getParameterValues("facility");
		String facility ="";
		if(facilityArr != null) {
			facility = String.join(",", facilityArr);
		}
		o.setFacility(facility);
		//오피스부분
		if(!refileTop.getOriginalFilename().equals("")) {
			System.out.println(o.getOffImgPath());
			new File(session.getServletContext().getRealPath(o.getOffImgPath())).delete();
			String changeName = saveFile(refileTop, session);
			o.setOffImgPath("resources/images/" + changeName);
		}
		
		ArrayList<Attachment> atlist = att.getAtlist();
		/*
		String[] path = request.getParameterValues("filePath");
		String[] num = request.getParameterValues("fileNo");
		
		int[] fnum = new int[num.length];
		for(int i=0; i<num.length; i++) {
			if(!num[i].equals("")) {
			fnum[i] = Integer.parseInt(num[i]);
			System.out.println("arr: " + fnum[i]);
			}
		}
*/
		ArrayList<Attachment> list = new ArrayList<>();
		
		for(int i=0; i<refile.length; i++) {
			//새 첨부파일
			if(!refile[i].getOriginalFilename().equals("")) {
				//Attachment att = new Attachment();

				//기존 파일이 존재
				if(!atlist.isEmpty() && atlist.get(i).getFileNo()!=0) {
					//System.out.println("p: " + path[i]);
					//System.out.println("fnum: "+fnum[i]);
					new File(session.getServletContext().getRealPath(atlist.get(i).getFilePath())).delete();
					String changeName = saveFile(refile[i], session);
					//att에 저장
					att.setFilePath("resources/images/" + changeName);
					att.setRefFno(o.getOfficeNo());
					att.setFileNo(atlist.get(i).getFileNo());
				} else {
					//기존 변경 없이 새파일을가져왔을경우
					String changeName = saveFile(refile[i], session);
					att.setFilePath("resources/images/" + changeName);
					att.setRefFno(o.getOfficeNo());
				}
				list.add(att);
				System.out.println(list);
			}
		}
		
		int result = bService.updateOffice(o, list);
		
		if(result > 0) {
			session.setAttribute("alertMsg", "업데이트성공");
			return "redirect:/detail.bk?ono="+ o.getOfficeNo();
		} else {
			model.addAttribute("errorMsg", "업데이트실패");
			return "common/errorPage";
		}
	}
	@RequestMapping("deleteOffice.bk")
	public String deleteOffice(Office o, Attachment att, HttpSession session , HttpServletRequest request, Model model) {
		ArrayList<Attachment> atlist = att.getAtlist();
		//오피스 단독만 삭제
		if(!atlist.isEmpty()) {
			int result = bService.deleteOffice(o.getOfficeNo());
			
			if(result > 0) {
				
				new File(session.getServletContext().getRealPath(o.getOffImgPath())).delete();
				session.setAttribute("alertMsg", "삭제 성공");
				return "redirect:/list.bk";
				
			} else {
				session.setAttribute("errorMsg", "삭제 실패");
				return "common/errorPage";
			}
			//첨부파일이 있을경우에 같이 삭제
		} else {
			int result = bService.deleteOfficeWithAtt(o.getOfficeNo());
			
			if(result > 0) {
				new File(session.getServletContext().getRealPath(o.getOffImgPath())).delete();
				for(int i=0; i<atlist.size(); i++) {
					new File(session.getServletContext().getRealPath(atlist.get(i).getFilePath())).delete();
				}
				session.setAttribute("alertMsg", "삭제 성공");
				return "redirect:/list.bk";
			} else {
				session.setAttribute("errorMsg", "삭제 실패");
				return "common/errorPage";
			}
		}
		
	}
	/*
	@RequestMapping("deleteOffice.bk")
	public String deleteOffice(int ono, HttpSession session , HttpServletRequest request, Model model) {
		//int memNo = ((Member)request.getSession().getAttribute("loginUser")).getMemNo();
		String offImgPath = ((Office)request.getSession().getAttribute("ott")).getOffImgPath();
		ArrayList<Attachment> list = ((ArrayList)request.getSession().getAttribute("alist"));
		System.out.println(list);
		//오피스 단독만 삭제
		if(list.isEmpty()) {
			int result = bService.deleteOffice(ono);
			
			if(result > 0) {
				
				new File(session.getServletContext().getRealPath(offImgPath)).delete();
				session.setAttribute("alertMsg", "삭제 성공");
				return "redirect:/list.bk";
				
			} else {
				session.setAttribute("errorMsg", "삭제 실패");
				return "common/errorPage";
			}
			//첨부파일이 있을경우에 같이 삭제
		} else {
			int result = bService.deleteOfficeWithAtt(ono);
			
			if(result > 0) {
				new File(session.getServletContext().getRealPath(offImgPath)).delete();
				for(int i=0; i<list.size(); i++) {
					new File(session.getServletContext().getRealPath(list.get(i).getFilePath())).delete();
				}
				session.setAttribute("alertMsg", "삭제 성공");
				return "redirect:/list.bk";
			} else {
				session.setAttribute("errorMsg", "삭제 실패");
				return "common/errorPage";
			}
		}
		
	}
*/
	@RequestMapping("deleteOffices.bk")
	public String deleteOffices(HttpSession session , HttpServletRequest request, Model model,@RequestParam(value="currentPage", defaultValue="1") int currentPage) {
		//officeNos 부분 가져오기
		String[] officeArr = request.getParameterValues("officeNos");
		//System.out.println("arr: " + officeArr.toString());
		//parsing
		int[] officeNo = new int[officeArr.length];
		for(int i=0; i<officeArr.length; i++) {
			officeNo[i] = Integer.parseInt(officeArr[i]);
		}
		//System.out.println("officeNos: "+officeNo);
		if(officeArr != null) {
			
			//오피스 번호로 삭제전에 offImgPath 조회하기
			String[] offImgPaths = bService.selectOffImgPaths(officeNo);
			
			//오피스 번호로 첨부파일들 filePath조회
			ArrayList<Attachment> filePaths = bService.selectFilePaths(officeNo);
			
			int result = bService.deleteOffices(officeNo);
			//삭제성공시 물리적 루트에서 사진 삭제
			if(result > 0) {
				for(int i=0; i<offImgPaths.length; i++) {
					//System.out.println(i + " : " + offImgPaths[i]); 
					new File(session.getServletContext().getRealPath(offImgPaths[i])).delete();
				}
				
				for(int i=0; i<filePaths.size(); i++) {
					//System.out.println(filePaths.get(i).getFilePath());
					new File(session.getServletContext().getRealPath(filePaths.get(i).getFilePath())).delete();
				}
			} else {
				session.setAttribute("errorMsg", "삭제 실패");
				return "common/errorPage";
			}
		}
		
		//다시 삭제된 리스트조회하기
		int listCount = bService.selectListCount();
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 5);
		
		ArrayList<Office> list = bService.selectListAll(pi);
		
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		
		return "booking/aOfficeList";
	}
	
	/**
	 * 추가부분 - 상세조회 클릭시 연동 페이지(officeDetail)
	 */
	/*첨부파일 조회 + 사진*/
	/*
	@RequestMapping("detail.bo")
    public String officeDetailPage(int ono, Booking b, Model model) {
		
		
		ArrayList<Attachment> at = bService.selectList(ono);
		model.addAttribute("at", at);
		Office o = bService.selectOffice(ono);
		model.addAttribute("o", o);
		model.addAttribute("b", b);

        return "booking/officeDetail";
        
    }
	*/
	/*첨부파일 조회 + 사진 + 리뷰 조회*/
	@RequestMapping("detail.bo")
	public String officeDetailPage(int ono, Model model) {
		ArrayList<Attachment> at = bService.selectOfficeAtt(ono);
		model.addAttribute("at", at);
		Office o = bService.selectOffice(ono);
		model.addAttribute("o", o);
		ArrayList<Review> rv = bService.selectReview(ono);
		model.addAttribute("rv", rv);
		
		return "booking/officeDetail";
	}
	/*날짜 선택에 따른 시작,끝 추가*/
	@RequestMapping("paymentForm.bk")
	public String paymentForm(int officeNo, Model model, String startDate, String endDate) {
		
		Office o = bService.selectOffice(officeNo);
		
		//예약된 날짜들 받아오기
		ArrayList<Booking> list = bService.selectB(officeNo);
		model.addAttribute("list", list);
		model.addAttribute("o", o);	
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);
		return "booking/bPayment";
	}
	
	@RequestMapping("research.bk")
	public String research(Booking b, Model model) {
		System.out.println("re: "+b);
		ArrayList<Office> list = bService.selectOfficeList(b);

		model.addAttribute("list",list);
		model.addAttribute("b", b);
		
		return"booking/bResult";
	}
	
	@RequestMapping("import.ts")
	public String iamport() {
		return"booking/importTest";
	}
	
	@RequestMapping("submitBook.bk")
	public String insertBook(Booking b, Office o ,HttpServletRequest request, HttpSession session, Model model) {
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		String person = request.getParameter("person");
		int officeNo = Integer.parseInt(request.getParameter("officeNo"));
		int memNo = ((Member)request.getSession().getAttribute("loginUser")).getMemNo();
		
		System.out.println(memNo);
		
		b.setStartDate(startDate);
		b.setEndDate(endDate);
		b.setOfficeNo(officeNo);
		b.setMemNo(memNo);
		
		int result = bService.insertBook(b);
		if(result > 0) {
			model.addAttribute("o", o);
			model.addAttribute("b", b);
			return"booking/officeEnd";
		} else {
			model.addAttribute("errorMsg", "예약실패");
			return "common/errorPage";
		}
	}
	
	@RequestMapping("myBookList.bk")
	public String selectMyBookList(@RequestParam(value="currentPage", defaultValue="1") int currentPage, HttpServletRequest request, HttpSession session, Model model) {

		int memNo = ((Member)request.getSession().getAttribute("loginUser")).getMemNo();
		//반환되는 게시글 개수
		int listCount = bService.selectListCountBook(memNo);
		//page설정
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 5);
		//게시글조회
		ArrayList<Booking> list = bService.selectMyBookList(memNo, pi);
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		
		return "booking/myBookList";
	}
	
	@ResponseBody
	@RequestMapping(value="myDetail.bk", produces="application/json; charset=utf-8")
	public String selectMyBook(int bookingNo) {
		Booking b = bService.selectMyBook(bookingNo);
		return new Gson().toJson(b);
	}
	
	@RequestMapping("modifyMyBook.bk")
	public String updateMyBook(Booking b, HttpServletRequest request, HttpSession session, int bookNo, Model model) {
		int memNo = ((Member)request.getSession().getAttribute("loginUser")).getMemNo();
		b.setBookingNo(bookNo);
		int result = bService.updateMyBook(b);
		if(result > 0) {
			return "redirect:/myBookList.bk?mno=" + memNo;
		} else {
			model.addAttribute("errorMsg", "예약수정실패");
			return "common/errorPage";
		}
		
	}
	
	@RequestMapping("cancelMyBook.bk")
	public String deleteMyBook(int bno, HttpServletRequest request, HttpSession session, Model model) {
		System.out.println(bno);
		int memNo = ((Member)request.getSession().getAttribute("loginUser")).getMemNo();
		int result = bService.deleteMyBook(bno);
		
		if(result>0) {
			return "redirect:/myBookList.bk?mno=" + memNo;
		} else {
			model.addAttribute("errorMsg", "예약수정실패");
			return "common/errorPage";
		}
	}
	
	/*공간 예약관리 화면 연결
	@RequestMapping("space.bo")
	public String officeSpace() {
		return "booking/officeManagement";
	}*/
	
	/*공간 예약관리 조회*/
	@RequestMapping("space.bo")
	public String selectSpace(@RequestParam(value="currentPage", defaultValue="1") int currentPage, Model model) {
		
		int listCount = bService.selectSpaceCount();
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 5);
		
		ArrayList<Booking> list = bService.selectSpace(pi);
		
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		
		return "booking/officeManagement";
	}
	
	/* 예약관리 게시물 선택삭제*/
	@RequestMapping(value = "/delete")
	 public String ajaxTest(HttpServletRequest request) {
        
        String[] ajaxMsg = request.getParameterValues("valueArr");
        int size = ajaxMsg.length;
        for(int i=0; i<size; i++) {
        	bService.delete(ajaxMsg[i]);
        }
        return "redirect:space.bo";
    }
	
	/*예약관리 리스트 상세조회*/
	@RequestMapping("Space2.bo")
	public ModelAndView selectOfficeSpace(int bno, ModelAndView mv) {
		int bookingNo = bno;
		
		Booking bi = bService.selectOfficeSpace(bookingNo);
		
		mv.addObject("bi", bi).setViewName("booking/officeSpace");
		System.out.println(bi);
		return mv;
	}
	
}
