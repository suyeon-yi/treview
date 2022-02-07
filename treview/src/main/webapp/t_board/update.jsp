<%@page import="travel.t_board.vo.T_boardVO"%>
<%@page import="java.io.File"%>
<%@page import="travel.t_board.service.T_boardUpdateService"%>
<%@page import="travel.t_board.service.T_boardWriteService"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//서버에서 저장할 localhost 뒤에 붙는 위치를 설정한다.
String path = "/upload/t_board/";
String realpath = request.getServletContext().getRealPath(path);
System.out.println("changeImage.jsp - realpath : " + realpath);
//서버에서 저장할 localhost 뒤에 붙는 위치를 설정한다.
int size = 10*1024*1024; //10MB
//파일을 업로드한다.
MultipartRequest multi 
= new MultipartRequest(request, realpath, size, "utf-8", new DefaultFileRenamePolicy());
//데이터를 수집한다. - 글번호, 제목, 여행장소, 여행시작일, 여행종료일, 참여인원, 사진, 내용, 태그, 작성자, 이전 사진

String strNo = multi.getParameter("no");
long no = Long.parseLong(strNo);
String title = multi.getParameter("title");
String place = multi.getParameter("place");
String startDate = multi.getParameter("startDate");
String endDate = multi.getParameter("endDate");
String staff = multi.getParameter("staff");
String photo = multi.getFilesystemName("photo");
String content = multi.getParameter("content");
String tags = multi.getParameter("tags"); 
String writer = multi.getParameter("writer");
String oldImage = multi.getParameter("oldPhoto");

T_boardVO vo = new T_boardVO();
vo.setNo(no);
vo.setTitle(title);
vo.setPlace(place);
vo.setStartDate(startDate);
vo.setEndDate(endDate);
vo.setStaff(staff);
vo.setPhoto(path + photo);
vo.setContent(content);
vo.setTags(tags);
vo.setWriter(writer);

System.out.println("update.jsp - vo : " + vo);

//DB에서 데이터를 가져온다.
T_boardUpdateService service = new T_boardUpdateService();
int result = service.service(vo);

System.out.println("result : " + result);

//자동으로 글보기로 이동한다.
response.sendRedirect("view.jsp?no=" + no + "&inc=0");
%>
