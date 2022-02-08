package com.treview.t_board.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.treview.t_board.vo.T_boardVO;
import com.treview.util.db.DB;
import com.webjjang.util.PageObject;


public class T_boardDAO {
	
	//필요한 객체를 불러온다.
	//연결하기 위해 필요한 객체인 Connection를 불러오며 변수명은 con으로 정한다. 값은 null로 한다.
	Connection con = null;
	//SQL에 작성된 쿼리문을 실행하는 객체인 PreparedStatement를 불러오며 변수명은 pstmt로 정한다. 값은 null로 한다.
	PreparedStatement pstmt = null;
	//결과값을 출력하는 객체인 ResultSet을 불러오며 변수명은 rs로 정한다. ResultSet은 select문에서만 사용하며, 값은 null로 한다.
	ResultSet rs = null;
	
	//list - 페이징 처리 사용을 위해 PageObject를 받는다.
	public List<T_boardVO> list(PageObject pageObject) throws Exception {
		// TODO Auto-generated method stub
		List<T_boardVO> list = null;
		System.out.println("list - " + list);
		//예외처리
		try {
			//1.2. driver를 확인하고 연결한다.
			con = DB.getConnection();
			System.out.println("con - " + con);
			//3. sql문을 입력한다.
			//리스트에서 최신순, 인기순 정렬을 위해 switch문을 사용한다.
			//3-1. 순서에 맞는 원본 데이터를 가져온다.
			String sql = " SELECT t.no, t.title, t.mainImage, t.id, m.name, t.hit, t.likes "
					+ " from t_board t, member m "
					+ " where t.id = m.id ";
			switch (pageObject.getPeriod()) {
			case "new":
				sql += " ORDER BY no DESC";
				break;
			case "pop":
				sql += " ORDER BY hit DESC, no DESC";
				break;
			}
			//3-2. 가져온 데이터로부터 다시 불러오면서 순서 번호를 붙인다.
			sql = " SELECT rownum rnum, no, title, mainImage, id, name, hit, likes FROM (" + sql + ") ";
			//3-3. 페이지에 맞는 데이터를 가져온다.
			sql = " SELECT rnum, no, title, mainImage, id, name, hit, likes FROM (" + sql + ") "
					+ " where rnum between ? and ?";
			System.out.println("T_boardDAO.list() - sql : " + sql);
			//4.con객체의 prepareStatement(sql)메소드를 호출해 pstmt로 가져온다.
			pstmt = con.prepareStatement(sql);
			pstmt.setLong(1, pageObject.getStartRow());
			pstmt.setLong(2, pageObject.getEndRow());
			System.out.println("pstmt - " + pstmt);
			System.out.println("pageObject - "  + pageObject);
			//5.executeQuery를 이용해서 sql문을 처리하고 rs로 변환한다.
			rs = pstmt.executeQuery();
			System.out.println("rs - " + rs);
			//6.결과값을 출력하는 객체 rs의 값이 null이 아닐때 다음 줄에 결과값을 출력한다.
			if(rs != null) {
				while(rs.next()) {
					if(list == null) list = new ArrayList<T_boardVO>();
					T_boardVO vo = new T_boardVO();
					vo.setNo(rs.getLong("no"));
					vo.setTitle(rs.getString("title"));
					vo.setMainImage(rs.getString("mainImage"));
					vo.setId(rs.getString("id"));
					vo.setName(rs.getString("name"));
					vo.setHit(rs.getLong("hit"));
					vo.setLikes(rs.getLong("likes"));
					
					list.add(vo);
					
					System.out.println("vo - "+vo);
					System.out.println("list -" + list);
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			try {
				//7.사용한 객체를 닫는다.
				DB.close(con, pstmt, rs);
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}
		return list;
	}

	//페이징 처리를 위한 메소드를 작성한다.
	public long getTotalRow(PageObject pageObject) {
		// TODO Auto-generated method stub
		long totalRow = 0;
		// 예외처리
		try {
			// 1. 2.driver를 확인하고 연결한다.
			con = DB.getConnection();
			//3.  sql문을 작성한다.
			String sql = "select count(*)  from t_board";
			//4.con객체의 prepareStatement(sql)메소드를 호출해 pstmt로 가져온다.
			pstmt = con.prepareStatement(sql);
			//5.executeQuery를 이용해서 sql문을 처리하고 rs로 변환한다.
			rs = pstmt.executeQuery();
			//6.결과값을 출력하는 객체 rs의 값이 null이 아닐때 다음 줄에 결과값을 출력한다.
			if(rs != null && rs.next()) {
				totalRow = rs.getLong(1);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			try {
				//7.사용한 객체를 닫는다.
				DB.close(con, pstmt, rs);
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}
		return totalRow;
	}


	//view
	public T_boardVO view(long no) throws Exception {
		// TODO Auto-generated method stub
		T_boardVO vo = null;
		//예외처리
		try {
			// 1. 2.driver를 확인하고 연결한다.
			con = DB.getConnection();
			//3.  sql문을 작성한다.
			String sql = "SELECT t.no, t.hit, t.likes, t.title, m.name, t.id, t.place, to_char(t.startDate, 'yyyy-mm-dd')startDate, "
					+ " to_char(t.endDate, 'yyyy-mm-dd')endDate, t.staff, t.mainImage, t.image1, t.image2, t.image3, t.image4, "
					+ "  t.content, t.tags "
					+ " from t_board t, member m "
					+ " where (t.id = m.id) AND (no = ?) ";
			//4.con객체의 prepareStatement(sql)메소드를 호출해 pstmt로 가져온다.
			pstmt = con.prepareStatement(sql);
			//1번 물음표의 값은 no이므로 long타입으로 보낸다.no의 값은 위에서 2번 데이터로 가져온다.
			pstmt.setLong(1, no);
			//5.executeQuery를 이용해서 sql문을 처리하고 rs로 변환한다.
			rs = pstmt.executeQuery();
			//6.결과값을 출력하는 객체 rs의 값이 null이 아닐때 다음 줄에 결과값을 출력한다.
			if(rs != null && rs.next()) {
				vo = new T_boardVO();
				vo.setNo(rs.getLong("no"));
				vo.setHit(rs.getLong("hit"));
				vo.setLikes(rs.getLong("likes"));
				vo.setTitle(rs.getString("title"));
				vo.setName(rs.getString("name"));
				vo.setId(rs.getString("id"));
				vo.setPlace(rs.getString("place"));
				vo.setStartDate(rs.getString("startDate"));
				vo.setEndDate(rs.getString("endDate"));
				vo.setStaff(rs.getString("staff"));
				vo.setMainImage(rs.getString("mainImage"));
				vo.setImage1(rs.getString("image1"));
				vo.setImage2(rs.getString("image2"));
				vo.setImage3(rs.getString("image3"));
				vo.setImage4(rs.getString("image4"));
				vo.setContent(rs.getString("content"));
				vo.setTags(rs.getString("tags"));
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			try {
				//7.사용한 객체를 닫는다.
				DB.close(con, pstmt, rs);
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}
		return vo;
	}


	//조회수 증가를 위한 메소드
	public void increase(long no) throws Exception {
		// TODO Auto-generated method stub
		try {
			// 1. 2.driver를 확인하고 연결한다.
			con = DB.getConnection();
			//3.  sql문을 작성한다.
			String sql = "UPDATE t_board SET hit = hit + 1 where no = ?";
			//4.con객체의 prepareStatement(sql)메소드를 호출해 pstmt로 가져온다.
			pstmt = con.prepareStatement(sql);
			pstmt.setLong(1, no);
			//5.executeUpdate()의 값을 int타입의 result로 받는다.
			pstmt.executeUpdate();
			//6.출력될 값이 없으므로 데이터 확인을 한다.
			System.out.println(no + "번의 조회수가 1 증가 되었습니다.");
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			try {
				//7.사용한 객체를 닫는다.
				DB.close(con, pstmt);
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}
	}


	//write
	public int write(T_boardVO vo) throws Exception {
		// TODO Auto-generated method stub
		int result = 0;
		//예외처리
		try {
			// 1. 2.driver를 확인하고 연결한다.
			con = DB.getConnection();
			//3.  sql문을 작성한다.
			String sql = "insert into t_board(no, title, place, startDate, endDate, staff, mainImage, image1, image2, image3, image4, content, tags) "
					+ " values(t_board_seq.nextval, ?,?,?,?,?,?,?,?,?,?,?,?)";
			//4.con객체의 prepareStatement(sql)메소드를 호출해 pstmt로 가져온다.
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vo.getTitle());
			pstmt.setString(2, vo.getPlace());
			pstmt.setString(3, vo.getStartDate());
			pstmt.setString(4, vo.getEndDate());
			pstmt.setString(5, vo.getStaff());
			pstmt.setString(6, vo.getMainImage());
			pstmt.setString(7, vo.getImage1());
			pstmt.setString(8, vo.getImage2());
			pstmt.setString(9, vo.getImage3());
			pstmt.setString(10, vo.getImage4());
			pstmt.setString(11, vo.getContent());
			pstmt.setString(12, vo.getTags());
			//5.executeUpdate()의 값을 int타입의 result로 받는다.
			result = pstmt.executeUpdate();
			//6.출력될 데이터 값이 없으므로 작성이 완료되었다는 문구를 출력한다.
			System.out.println("게시글 작성이 완료되었습니다.");
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			try {
				//7.사용한 객체를 닫는다.
				DB.close(con, pstmt);
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}
		
		return result;
	}


	//update
	public int update(T_boardVO vo) {
		// TODO Auto-generated method stub
		int result = 0;
		//예외처리
		try {
			// 1. 2.driver를 확인하고 연결한다.
			con = DB.getConnection();
			//3.  sql문을 작성한다.
			String sql = "UPDATE t_board "
					+ " SET title =?, place=?, startDate=?, endDate=?, staff=?, mainImage=?, image1=?, image2=?, image3=?, image4=?,content=?, tags=? "
					+ " WHERE no = ?";
			//4.con객체의 prepareStatement(sql)메소드를 호출해 pstmt로 가져온다.
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vo.getTitle());
			pstmt.setString(2, vo.getPlace());
			pstmt.setString(3, vo.getStartDate());
			pstmt.setString(4, vo.getEndDate());
			pstmt.setString(5, vo.getStaff());
			pstmt.setString(6, vo.getMainImage());
			pstmt.setString(7, vo.getImage1());
			pstmt.setString(8, vo.getImage2());
			pstmt.setString(9, vo.getImage3());
			pstmt.setString(10, vo.getImage4());
			pstmt.setString(11, vo.getContent());
			pstmt.setString(12, vo.getTags());
			pstmt.setLong(13, vo.getNo());
			//5.executeUpdate()의 값을 int타입의 result로 받는다.
			result = pstmt.executeUpdate();
			//6.출력될 데이터 값이 없으므로 수정이 완료되었다는 문구를 출력한다.
			System.out.println("수정되었습니다.");
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			try {
				//7.사용한 객체를 닫는다.
				DB.close(con, pstmt);
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}
		
		return result;
	}


	//delete
	public int delete(long no) throws Exception{
		// TODO Auto-generated method stub
		int result = 0;
		//예외처리
		try {
			// 1. 2.driver를 확인하고 연결한다.
			con = DB.getConnection();
			//3.  sql문을 작성한다.
			String sql = "DELETE from t_board where no = ?";
			//4.con객체의 prepareStatement(sql)메소드를 호출해 pstmt로 가져온다.
			pstmt = con.prepareStatement(sql);
			pstmt.setLong(1, no);
			//5.executeUpdate()의 값을 int타입의 result로 받는다.
			result = pstmt.executeUpdate();
			//6.출력될 데이터 값이 없으므로 삭제가 완료되었다는 문구를 출력한다.
			System.out.println("삭제되었습니다.");
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			try {
				//7.사용한 객체를 닫는다.
				DB.close(con, pstmt);
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}
		
		return result;
	}


}
