<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.treview.t_board.service.T_boardUpdateService"%>
<%@page import="com.treview.t_board.vo.T_boardVO"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String strNo = request.getParameter("no");
long no = Long.parseLong(strNo);
String title = request.getParameter("title");
String place = request.getParameter("place");
String startDate = request.getParameter("startDate");
String endDate = request.getParameter("endDate");
String staff = request.getParameter("staff");
String content = request.getParameter("content");
String tags = request.getParameter("tags"); 

T_boardVO vo = new T_boardVO();
vo.setNo(no);
vo.setTitle(title);
vo.setPlace(place);
vo.setStartDate(startDate);
vo.setEndDate(endDate);
vo.setStaff(staff);
vo.setContent(content);
vo.setTags(tags);

System.out.println("update.jsp - vo : " + vo);

//DB에서 데이터를 가져온다.
T_boardUpdateService service = new T_boardUpdateService();
int result = service.service(vo);

System.out.println("result : " + result);

//자동으로 글보기로 이동한다.
response.sendRedirect("view.jsp?no=" + no + "&inc=0");
%>
