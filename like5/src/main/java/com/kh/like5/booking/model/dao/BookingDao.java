package com.kh.like5.booking.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.like5.booking.model.vo.Booking;
import com.kh.like5.booking.model.vo.Office;
import com.kh.like5.booking.model.vo.Review;
import com.kh.like5.common.model.vo.Attachment;
import com.kh.like5.common.model.vo.PageInfo;

@Repository
public class BookingDao {

	public ArrayList<Office> selectOfficeList(SqlSessionTemplate sqlSession, Booking b){
		return (ArrayList)sqlSession.selectList("bookingMapper.selectOfficeList", b);
	}

	public ArrayList<Office> autoComplete(SqlSessionTemplate sqlSession, String searchKeyword){
		return (ArrayList)sqlSession.selectList("bookingMapper.autoComplete", searchKeyword);
	}
	public int insertBook(SqlSessionTemplate sqlSession, Booking b) {
		return sqlSession.insert("bookingMapper.insertBook", b);
	}

	//예약된 날짜 가져오기
	public ArrayList<Booking> selectB(SqlSessionTemplate sqlSession, int officeNo){
		return(ArrayList)sqlSession.selectList("bookingMapper.selectB", officeNo);
	}
	public int selectListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("bookingMapper.selectListCount");
	}

	public ArrayList<Office> selectListAll(SqlSessionTemplate sqlSession, PageInfo pi){

		int offset = (pi.getCurrentPage()-1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		RowBounds  rowBounds = new RowBounds(offset, limit);
		return (ArrayList)sqlSession.selectList("bookingMapper.selectListAll", null, rowBounds);
	}

	public Office selectOffice(SqlSessionTemplate sqlSession, int officeNo) {
		return sqlSession.selectOne("bookingMapper.selectOffice", officeNo);
	}

	public ArrayList selectOfficeAtt(SqlSessionTemplate sqlSession, int officeNo) {
		return (ArrayList)sqlSession.selectList("bookingMapper.selectOfficeAtt", officeNo);
	}
	public int insertOffice(SqlSessionTemplate sqlSession, Office o) {
		return sqlSession.insert("bookingMapper.insertOffice", o);
	}

	public int insertOfficeAtt(SqlSessionTemplate sqlSession, ArrayList<Attachment> list) {
		int result = 0;
		for(Attachment att : list) {
			result = sqlSession.insert("bookingMapper.insertOfficeAtt", att);
		}
		return result;
	}
	/*
	public int insertOfficeReAtt(SqlSessionTemplate sqlSession, ArrayList<Attachment> list) {
		int result = 0;
		for(Attachment att : list) {
			result = sqlSession.insert("bookingMapper.insertOfficeReAtt", att);
		}
		return result;
	}
	*/
	
	public int updateOffice(SqlSessionTemplate sqlSession, Office o) {
		return sqlSession.update("bookingMapper.updateOffice", o);
	}

	public int updateOfficeAtt(SqlSessionTemplate sqlSession, ArrayList<Attachment> list) {
		int result = 0;
		System.out.println("처음"+list);
		for(Attachment att : list) {
			if(att.getFileNo()!=0) {
				result = sqlSession.update("bookingMapper.updateOfficeAtt", att);
			} else if(att.getRefFno() != 0) {
				result = sqlSession.insert("bookingMapper.insertOfficeReAtt", att);
			}
			
		}
		System.out.println("끝" + list);
		return result;
	}

	public int deleteOffice(SqlSessionTemplate sqlSession, int ono) {
		return sqlSession.delete("bookingMapper.deleteOffice", ono);
	}
	
	public int deleteOfficeAtt(SqlSessionTemplate sqlSession, int ono) {
		return sqlSession.delete("bookingMapper.deleteOfficeAtt", ono);
	}
	
	public String[] selectOffImgPaths(SqlSessionTemplate sqlSession, int[] officeNo) {
		String[] offImgPaths = new String[officeNo.length];
		for(int i=0; i<officeNo.length; i++) {
			//System.out.println("for" + officeNo[i]);
			int ckeck = officeNo[i];
			offImgPaths[i] = sqlSession.selectOne("bookingMapper.selectOffImgPaths", ckeck);
		}
		System.out.println("offImgPaths: " + offImgPaths);
		return offImgPaths;
	}
	
	public ArrayList<Attachment> selectFilePaths(SqlSessionTemplate sqlSession, int[] officeNo) {
		ArrayList<Attachment> filePaths= null;
		for(int check : officeNo) {
			filePaths = (ArrayList)sqlSession.selectList("bookingMapper.selectFilePaths", check);
		}
		return filePaths;
	}
	
	public int deleteOffices(SqlSessionTemplate sqlSession, int[] officeNo) {
		int result = 0;
		for(int check : officeNo) {
			result = sqlSession.delete("bookingMapper.deleteOffices", check);
		}
		//System.out.println("result1: " + result);
		return result;
	}
	
	public int deleteFilePaths(SqlSessionTemplate sqlSession, int[] officeNo) {
		int result = 0;
		for(int check:officeNo) {
			result = sqlSession.delete("bookingMapper.deleteFilePaths", check);
		}
		//System.out.println("result2: " + result);
		return result;
	}
	/*추가 - 첨부파일 조회 + 사진*/
	public ArrayList<Attachment> selectList(SqlSessionTemplate sqlSession, int refFno){
		/*System.out.println(refFno);*/
		ArrayList<Attachment> pics= (ArrayList)sqlSession.selectList("selectAtList", refFno);
		/*System.out.println(pics);*/
		return pics;

	}
	//뭐에 쓰는거더라??
	public Booking selectBooking(SqlSessionTemplate sqlSession, int officeNo) {
		return sqlSession.selectOne("bookingMapper.selectBooking", officeNo);
	}

	//마이페이지 조회용
	public ArrayList<Booking> selectMyBookList(SqlSessionTemplate sqlSession,int memNo, PageInfo pi) {
		int offset = (pi.getCurrentPage()-1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, limit);

		return (ArrayList)sqlSession.selectList("bookingMapper.selectMyBookList", memNo, rowBounds);
	}
	public int selectListCountBook(SqlSessionTemplate sqlSession, int memNo) {
		return sqlSession.selectOne("bookingMapper.selectListCountBook", memNo);
	}

	/*리뷰 조회*/
	public ArrayList<Review> selectReview(SqlSessionTemplate sqlSession, int officeNo){
		/*System.out.println(officeNo);*/
		ArrayList<Review> pis = (ArrayList)sqlSession.selectList("selectReview", officeNo);
		/*System.out.println(pis);*/
		return pis;
	}

	public Booking selectMyBook(SqlSessionTemplate sqlSession, int bookingNo) {
		return sqlSession.selectOne("bookingMapper.selectMyBook", bookingNo);
	}
	
	public int updateMyBook(SqlSessionTemplate sqlSession, Booking b) {
		return sqlSession.update("bookingMapper.updateMyBook", b);
	}
	
	public int deleteMyBook(SqlSessionTemplate sqlSession, int bno) {
		return sqlSession.update("bookingMapper.deleteMyBook", bno);
	}
	
	public int selectSpaceCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("bookingMapper.selectSpaceCount");
	}
	
	/*예약 관리 전체 조회*/
	public ArrayList<Booking> selectSpace(SqlSessionTemplate sqlSession, PageInfo pi){
		int offset = (pi.getCurrentPage()-1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		RowBounds  rowBounds = new RowBounds(offset, limit);
		return (ArrayList)sqlSession.selectList("bookingMapper.selectSpace", null, rowBounds);
	}
	
	/*예약 관리 선택 삭제*/
	public void delete(SqlSessionTemplate sqlSession, String bookingNo) {
		sqlSession.delete("bookingMapper.delete", bookingNo);
	}
	
	/*예약 관리 리스트 상세 조회*/
	public Booking selectOfficeSpace(SqlSessionTemplate sqlSession, int bookingNo) {
		return sqlSession.selectOne("bookingMapper.selectOfficeSpace", bookingNo);
	}
}
