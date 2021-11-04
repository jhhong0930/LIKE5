package com.kh.like5.booking.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.like5.booking.model.dao.BookingDao;
import com.kh.like5.booking.model.vo.Booking;
import com.kh.like5.booking.model.vo.Office;
import com.kh.like5.booking.model.vo.Review;
import com.kh.like5.common.model.vo.Attachment;
import com.kh.like5.common.model.vo.PageInfo;

@Service
public class BookingServiceImpl implements BookingService{

	@Autowired
	private BookingDao bDao;
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public ArrayList<Office> selectOfficeList(Booking b) {
	
		return bDao.selectOfficeList(sqlSession, b);
	}
	
	@Override
	public ArrayList<Office> autoComplete(String searchKeyword){
		return bDao.autoComplete(sqlSession, searchKeyword);
	}
	
	@Override
	public int insertBook(Booking b) {
		return bDao.insertBook(sqlSession, b);
	}

	@Override
	public ArrayList<Booking> selectB(int officeNo) {
		return bDao.selectB(sqlSession, officeNo);
	}
	
	@Override
	public int selectListCount() {
		return bDao.selectListCount(sqlSession);
	}

	@Override
	public ArrayList<Office> selectListAll(PageInfo pi) {
		return bDao.selectListAll(sqlSession, pi);
	}

	@Override
	public ArrayList<Office> selectListAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int insertOffice(Office o, ArrayList<Attachment> list) {
		int result1 = bDao.insertOffice(sqlSession, o);
		int result2 = 1;
		if(!list.isEmpty()) {
			result2 = bDao.insertOfficeAtt(sqlSession, list);
		}
		return result1*result2;
	}

	@Override
	public int updateOffice(Office o, ArrayList<Attachment> list) {
		int result1 = bDao.updateOffice(sqlSession, o);
		System.out.println("서비스단list"+list);
		int result2 = 1;
		
		if(!list.isEmpty()) {
			result2 = bDao.updateOfficeAtt(sqlSession, list);
		}
		System.out.println("result1" + result1);
		System.out.println("restul2" + result2);//-->0이 뜸
		return result1*result2;
	}

	@Override
	public int deleteOffice(int ono) {
		int result = bDao.deleteOffice(sqlSession, ono);
		return result;
	}
	
	@Override
	public int deleteOfficeWithAtt(int ono) {
		int result1 = bDao.deleteOffice(sqlSession, ono);
		int result2 = bDao.deleteOfficeAtt(sqlSession, ono);
		return result1 * result2;
	}
	
	@Override
	public String[] selectOffImgPaths(int[] officeNo){
		return bDao.selectOffImgPaths(sqlSession, officeNo);
	}
	
	@Override
	public ArrayList<Attachment> selectFilePaths(int[] officeNo){
		return bDao.selectFilePaths(sqlSession, officeNo);
	}
	
	@Override
	public int deleteOffices(int[] officeNo) {
		int result1 = bDao.deleteOffices(sqlSession, officeNo);
		int result2 = 1;
		if(!selectFilePaths(officeNo).isEmpty()) {
			result2 = bDao.deleteFilePaths(sqlSession, officeNo);
		}
		return result1 * result2;
	}
	
	@Override
	public int selectSearchListCount(HashMap<String, String> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public ArrayList<Office> selectSearchList(HashMap<String, String> map, PageInfo pi) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Office selectOffice(int officeNo) {
		return bDao.selectOffice(sqlSession, officeNo);
	}

	@Override
	public ArrayList<Attachment> selectOfficeAtt(int officeNo) {
		return bDao.selectOfficeAtt(sqlSession, officeNo);
	}
	
	/*추가 - 첨부파일 조회(사진)*/
	@Override
	public ArrayList<Attachment> selectList(int refFno) {
		/*System.out.println(refFno);*/
		return bDao.selectList(sqlSession, refFno);
	}

	@Override
	public Booking selectBooking(int officeNo) {
		return bDao.selectBooking(sqlSession, officeNo);
	}
	
	/*리뷰 조회*/
	@Override
	public ArrayList<Review> selectReview(int officeNo) {
		/*System.out.println(officeNo);*/
		return bDao.selectReview(sqlSession, officeNo);
	}

	@Override
	public ArrayList<Booking> selectMyBookList(int memNo, PageInfo pi) {
		return bDao.selectMyBookList(sqlSession, memNo, pi);
	}

	@Override
	public int selectListCountBook(int memNo) {
		return bDao.selectListCountBook(sqlSession, memNo);
	}

	@Override
	public Booking selectMyBook(int bookingNo) {
		return bDao.selectMyBook(sqlSession, bookingNo);
	}

	@Override
	public int updateMyBook(Booking b) {
		return  bDao.updateMyBook(sqlSession, b);
	}

	@Override
	public int deleteMyBook(int bno) {
		return bDao.deleteMyBook(sqlSession, bno);
	}

	@Override
	public int selectSpaceCount() {
		return bDao.selectSpaceCount(sqlSession);
	}

	@Override
	public ArrayList<Booking> selectSpace(PageInfo pi) {
		return bDao.selectSpace(sqlSession, pi);
	}
	
	/*선택 삭제 기능*/
	@Override
	public void delete(String bookingNo) {
		bDao.delete(sqlSession, bookingNo);
		
	}

	@Override
	public Booking selectOfficeSpace(int bookingNo) {
		return bDao.selectOfficeSpace(sqlSession, bookingNo);
	}

}
