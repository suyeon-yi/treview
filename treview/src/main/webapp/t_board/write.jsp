<%@page import="com.treview.t_board.service.T_boardWriteService"%>
<%@page import="com.treview.t_board.vo.T_boardVO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//서버에서 저장할 localhost 뒤에 붙는 위치를 설정한다.
String path = "/upload/t_board/";
String realpath = request.getServletContext().getRealPath(path);
System.out.println("write.jsp - realpath : " + realpath);
//저장 용량 제한한다.
int size = 10*1024*1024; //10MB

//파일을 업로드한다.
MultipartRequest multi 
= new MultipartRequest(request, realpath, size, "utf-8", new DefaultFileRenamePolicy());

//데이터를 수집한다. - 제목, 여행장소, 여행시작일, 여행종료일, 참여인원, 사진, 내용, 태그, 작성자
String title = multi.getParameter("title");
String place = multi.getParameter("place");
String startDate = multi.getParameter("startDate");
String endDate = multi.getParameter("endDate");
String staff = multi.getParameter("staff");
String mainImage = multi.getFilesystemName("mainImage");
String image1 = multi.getFilesystemName("image1");
String image2 = multi.getFilesystemName("image2");
String image3 = multi.getFilesystemName("image3");
String image4 = multi.getFilesystemName("image4");
String content = multi.getParameter("content");
String tags = multi.getParameter("tags"); 

T_boardVO vo = new T_boardVO();
vo.setTitle(title);
vo.setPlace(place);
vo.setStartDate(startDate);
vo.setEndDate(endDate);
vo.setStaff(staff);
vo.setMainImage(path + mainImage);
vo.setImage1(path + image1);
vo.setImage2(path + image2);
vo.setImage3(path + image3);
vo.setImage4(path + image4);
vo.setContent(content);
vo.setTags(tags);

System.out.println("write.jsp - vo : " + vo);

//DB에서 데이터를 가져온다.
T_boardWriteService service = new T_boardWriteService();
int result = service.service(vo);
//자동으로 리스트로 이동한다.
response.sendRedirect("list.jsp");
%>
