<%@page import="com.treview.t_board.service.ImageChangeService"%>
<%@page import="com.treview.t_board.vo.T_boardVO"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 서버에서 저장할 localhost 뒤에 붙는 위치가 된다.
String path = "/upload/t_board/";
String realPath = request.getServletContext().getRealPath(path);
System.out.println("changeImage.jsp - realPath : " + realPath);
// 저장 용량 제한
int size = 10 * 1024 * 1024; // 10M

// 실제적으로 파일 업로드 하는 처리문
// new MultipartRequest(request, 저장위치, 용량제한, 엔코딩, 중복파일명 처리 객체)
MultipartRequest multi 
= new MultipartRequest(request, realPath, size, "utf-8", new DefaultFileRenamePolicy());

// 데이터 수집 - multi - 파일이름, 텍스트 데이터(번호)
String strNo = multi.getParameter("no");
long no = Long.parseLong(strNo);
String mainImage = multi.getFilesystemName("mainImage");
String image1 = multi.getFilesystemName("image1");
String image2 = multi.getFilesystemName("image2");
String image3 = multi.getFilesystemName("image3");
String image4 = multi.getFilesystemName("image4");
// DB 변경이 다 되면 삭제할 파일
String OldMainImage = multi.getParameter("OldMainImage");
String OldImage1 = multi.getParameter("OldImage1");
String OldImage2 = multi.getParameter("OldImage2");
String OldImage3 = multi.getParameter("OldImage3");
String OldImage4 = multi.getParameter("OldImage4");

// 실행 쿼리 - update image set fileName = ? where no = ?
T_boardVO vo = new T_boardVO();
vo.setNo(no);
vo.setMainImage(path + mainImage);
vo.setImage1(path + image1);
vo.setImage2(path + image2);
vo.setImage3(path + image3);
vo.setImage4(path + image4);

System.out.println("changeImage.jsp - vo : " + vo);

//DB 이미지 변경 - Controller(JSP) - Service - dao : MVC Model I
ImageChangeService service = new ImageChangeService();
int result = service.service(vo);

// result 가 0 보다 크면 변경이 되었으므로 이전 파일은 삭제한다.
// 이전 파일명으로 realPath를 구한다. -> File 객체로 만든다. delete() 호출해서 삭제한다.
File oldFile = new File("");
request.getServletContext().getRealPath(OldMainImage);
request.getServletContext().getRealPath(OldImage1);
request.getServletContext().getRealPath(OldImage2);
request.getServletContext().getRealPath(OldImage3);
request.getServletContext().getRealPath(OldImage4);

if(result > 0 && oldFile.exists())
	oldFile.delete();


// 자동으로 이미지 보기로 이동한다. 글번호를 전달
response.sendRedirect("view.jsp?no=" + vo.getNo());
%>
