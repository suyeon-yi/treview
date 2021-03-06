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
<title>main</title> <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="css/custom.css">
<style type="text/css">
.imageDataRow:hover, .noticeDataRow:hover, .t_boardDataRow:hover{
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
 <div class="container">
		<div id="myCarousel" class="carousel slide" data-ride="carousel" style="width: 100%">
			<ol class="carousel-indicators">
				<li data-target="#myCarousel" data-slide-to="1" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="2"></li>
				<li data-target="#myCarousel" data-slide-to="3"></li>
			</ol>
			<div class="carousel-inner">
				<div class="item active">
					<img src="/images/1.jpg">
				</div>
				<div class="item">
					<img src="/images/2.jpg">
				</div>
				<div class="item">
					<img src="/images/3.jpg">
				</div>
			</div>
			<a class="left carousel-control" href="#myCarousel" data-slide="prev">
				<span class="glyphicon glyphicon-chevron-left"></span>
			</a>
			<a class="right carousel-control" href="#myCarousel" data-slide="next">
				<span class="glyphicon glyphicon-chevron-right"></span>
			</a>
		</div>
	</div>
	<br/>
	<div class="row">
		<div class="col-md-4">
			팀장님꺼
			<jsp:include page="/include/imageList.jsp" />
		</div>
		<div class="col-md-4">
			진호꺼
			<jsp:include page="/include/noticeList.jsp" />
		</div>
		<div class="col-md-4">
			<jsp:include page="/include/t_boardList.jsp" />
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
		     혜진씨꺼
			<jsp:include page="/include/noticeList.jsp" />
		</div>
	</div>
</body>
</html>