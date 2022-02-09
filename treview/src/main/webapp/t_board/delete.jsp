<%@page import="com.treview.t_board.service.T_boardDeleteService"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 데이터를 수집한다. 삭제하고자 하는 글의 글번호를 가져와야한다.
String strNo = request.getParameter("no");
long no = Long.parseLong(strNo);
String OldMainImage = request.getParameter("OldMainImage");
String OldImage1= request.getParameter("OldImage1");
String OldImage2= request.getParameter("OldImage2");
String OldImage3= request.getParameter("OldImage3");
String OldImage4= request.getParameter("OldImage4");

System.out.println("delete.jsp - no : " + no + ", oldMainImage : " + OldMainImage);

//DB에서 데이터를 가져온다.
T_boardDeleteService service = new T_boardDeleteService();
int result = service.service(no);

File oldFile = new File("");
request.getServletContext().getRealPath(OldMainImage);
request.getServletContext().getRealPath(OldImage1);
request.getServletContext().getRealPath(OldImage2);
request.getServletContext().getRealPath(OldImage3);
request.getServletContext().getRealPath(OldImage4);

if(result > 0 && oldFile.exists())
	oldFile.delete();

//자동으로 리스트로 보낸다.
response.sendRedirect("list.jsp");
%>

