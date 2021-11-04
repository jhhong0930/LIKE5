package com.kh.like5.booking.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.like5.booking.model.vo.Booking;
import com.kh.like5.booking.model.vo.Office;
import com.kh.like5.booking.model.vo.Review;
import com.kh.like5.common.model.vo.Attachment;
import com.kh.like5.common.model.vo.PageInfo;

public interface BookingService {

	//1.검색 결과 조회(사용자)
	ArrayList<Office> selectOfficeList(Booking b);

	//1.2. 자동검색어추천(사용자)
	ArrayList<Office> autoComplete(String searchKeyword);
	
	//1.3. 예약하기(사용자)
	int insertBook(Booking b);

	//1.4. 예약날짜(사용자)
	ArrayList<Booking> selectB(int officeNo);
	
	//2.리스트 전체 조회 + 페이징(관리자)
	int selectListCount();
	ArrayList<Office> selectListAll(PageInfo pi);
	ArrayList<Office> selectListAll();

	//3.오피스 등록(관리자)
	int insertOffice(Office o, ArrayList<Attachment> list);

	//4.오피스 수정(관리자)
	int updateOffice(Office o, ArrayList<Attachment> list);

	//5.오피스 삭제(관리자)
	int deleteOffice(int ono);
	int deleteOfficeWithAtt(int ono);

	//5.1 오피스 imgPath조회
	String[] selectOffImgPaths(int[] officeNo);
	
	//5.2 오피스 attachment path조회
	ArrayList<Attachment> selectFilePaths(int[] officeNo);
	
	//5.3 오피스 배열로 삭제
	int deleteOffices(int[] officeNo);
	
	//6.검색 + 페이징(관리자)
	int selectSearchListCount(HashMap<String, String> map);
	ArrayList<Office> selectSearchList(HashMap<String, String> map, PageInfo pi);

	//7.오피스 상세 조회(관리자)
	Office selectOffice(int officeNo);
	ArrayList<Attachment> selectOfficeAtt(int officeNo);

	/**
	 * 추가 부분 - 박정빈
	 *
	 */
	//8. 첨부파일 조회(사진)
	ArrayList<Attachment> selectList(int refFno);

	//9. 예약정보조회
	Booking selectBooking(int officeNo);
	
	//10. 마이페이지 예약 조회 + 페이징
	int selectListCountBook(int memNo);
	ArrayList<Booking> selectMyBookList(int memNo, PageInfo pi);
	
	//11. 마이페이지 상세 조회
	Booking selectMyBook(int bookingNo);
	ArrayList<Review> selectReview(int officeNo);
	//11.3 마이페이지 예약 수정
	int updateMyBook(Booking b);
	//11.4 마이페이지 예약 취소
	int deleteMyBook(int bno);
	
	//12. 공간예약관리 조회용 (페이징)
	int selectSpaceCount();
	ArrayList<Booking> selectSpace(PageInfo pi);
	
	// 13. 공간예약 선택 삭제 기능
	public void delete(String bookingNo);
	
	// 14. 공간예약 상세조회
	Booking selectOfficeSpace(int bookingNo);
}
