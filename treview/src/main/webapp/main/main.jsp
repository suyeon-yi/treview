<%@page import="com.treview.t_board.vo.T_boardVO"%>
<%@page import="com.treview.t_board.service.T_boardListService"%>
<%@page import="java.util.List"%>
<%@page import="com.webjjang.util.PageObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//PageObject 생성
PageObject pageObject = new PageObject();
//데이터 가져오기 - 이미지 리스트(3), 공지사항 리스트(5), 게시판 리스트(5)
//이미지 데이터 가져오기
//ImageListService imageListService = new ImageListService();
//데이터의 갯수를 3개로 정한다.
//pageObject.setPerPageNum(3);
//List<ImageVO> imageList = imageListService.service(pageObject);

//공지사항 데이터 가져오기
//NoticeListService noticeListService = new NoticeListService();
//데이터의 갯수를 3개로 정한다.
pageObject.setPerPageNum(5);
//List<NoticeVO> noticeList = noticeListService.service(pageObject);

//게시판 데이터 가져오기
T_boardListService t_boardListService = new T_boardListService();
//위에서 데이터 개수를 5개로 정해놨다.
List<T_boardVO> t_boardList = t_boardListService.service(pageObject);

//EL 이나 JSTL을 사용하려면 서버 기본 저장 객체에 담아야한다.
//request.setAttribute("imageList", imageList);
//request.setAttribute("noticeList", noticeList);
request.setAttribute("t_boardList", t_boardList);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main</title>
<style type="text/css">
.imageDataRow:hover, .noticeDataRow:hover, .boardDataRow:hover{
	background: #eee;
	cursor: pointer;
}
</style>
<script type="text/javascript">
$(function(){
	$(".imageDataRow, .noticeDataRow, .t_boardDataRow").click(function(){
		//alert("click");
		var no = $(this).data("no");
		var url = "/";
		if($(this).hasClass("imageDataRow")) url = url + "image";
		if($(this).hasClass("noticeDataRow")) url = url + "notice";
		if($(this).hasClass("t_boardDataRow")) url = url + "t_board";
		url += "/view.jsp?no=" + no + "&inc=1";
		location = url;
	});
});
</script>
</head>
<body>
<div class="jumbotron text-center">
  <h1>treview</h1>
  <p>즐거웠던 여행을 공유하고 소개하는 treview 입니다.</p> 
</div>
	<div class="row">
		<div class="col-md-4">
			<jsp:include page="/include/imageList.jsp" />
		</div>
		<div class="col-md-4">
			<jsp:include page="/include/noticeList.jsp" />
		</div>
		<div class="col-md-4">
			<jsp:include page="/include/t_boardList.jsp" />
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<jsp:include page="/include/noticeList.jsp" />
		</div>
	</div>
</body>
</html>