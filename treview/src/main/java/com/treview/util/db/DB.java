package com.treview.util.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DB {

	private final static String DRIVER = "oracle.jdbc.driver.OracleDriver";
	private final static String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	private final static String UID = "treview";
	private final static String UPW = "treview";
	
	private static boolean checkDriver = false;
	
	static {
		try {
			Class.forName(DRIVER);
			checkDriver = true;
			System.out.println("드라이버 확인 완료.");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	} // static 초기화 블록의 끝
	
	public static Connection getConnection() throws Exception{
		if(checkDriver)
			return DriverManager.getConnection(URL, UID, UPW); 
		throw new Exception("드라이버가 존재하지 않습니다.");
	}
	
	public static void close(Connection con, PreparedStatement pstmt) throws Exception{
		if(con != null) con.close();
		if(pstmt != null) pstmt.close();
	}
	
	public static void close(Connection con, PreparedStatement pstmt, ResultSet rs) throws Exception{
		close(con, pstmt);
		if(rs != null) rs.close();
	}
	
} // DB 클래스의 끝
