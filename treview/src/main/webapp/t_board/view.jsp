<%@page import="com.treview.t_board.vo.T_boardVO"%>
<%@page import="com.treview.t_board.service.T_boardViewService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
//데이터를 수집한다. - 글번호, 조회수
//게시글 1회 선택 당 조회수 1증가한다.
//조회수는 list.jsp에서 인기순 글보기시 사용된다.
String strNo = request.getParameter("no");
long no = Long.parseLong(strNo);
System.out.println(no);
String strInc = request.getParameter("inc");
long inc = Long.parseLong(strInc);
System.out.println(inc);
//DB에서 데이터를 가져온다.(글번호, 조회수 증가)
T_boardViewService service = new T_boardViewService();
T_boardVO vo = service.service(no, inc);
//게시글의 내용에 엔터를 적용하기 위해 줄바꿈 데이터(\n)을 <br>태그로 변경한다.
vo.setContent(vo.getContent().replace("\n", "<br>"));
//데이터를 확인한다.
System.out.println("view.jsp - vo : " + vo);
request.setAttribute("vo", vo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>여행 후기 보기</title>
<style type="text/css">
#viewImg{
	width: 400px;
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
}

#changeImageDiv{
	display: none;
}

</style>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

</head>
<body>
<div class="container">
<h2>여행 공유</h2>
<div class="form-group" style="float: right;">
	<label for="no">번호</label>${vo.no} | <label for="hit">조회수</label>${vo.hit } 
</div>	
	<div class="title" style="text-align: center;">
	<h3>${vo.title}</h3>
	</div>
<table class="table">
<thead>
      <tr>
        <th>작성자</th>
        <th>여행장소</th>
        <th>여행일정</th>
        <th>참여인원</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>${vo.name }(${vo.id })</td>
        <td>${vo.place }</td>
        <td>${vo.startDate } ~ ${vo.endDate }</td>
        <td>${vo.staff }</td>
      </tr>
</table>
<div id="myCarousel" class="carousel slide" data-ride="carousel">
    <!-- Indicators -->
    <ol class="carousel-indicators">
      <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
      <li data-target="#myCarousel" data-slide-to="1"></li>
      <li data-target="#myCarousel" data-slide-to="2"></li>
      <li data-target="#myCarousel" data-slide-to="3"></li>
      <li data-target="#myCarousel" data-slide-to="4"></li>
    </ol>

    <!-- Wrapper for slides -->
    <div class="carousel-inner">
      <div class="item active">
        <img src="${vo.mainImage }" alt="${vo.title }" style="width:100%; height: auto;" name="mainImage">
      </div>

      <div class="item">
        <img src="${vo.image1 }" alt="${vo.title }" style="width:100%; height: auto;" name="image1">
      </div>
    
      <div class="item">
        <img src="${vo.image2 }" alt="${vo.title }" style="width:100%; height: auto;" name="image2">
      </div>
      
      <div class="item">
        <img src="${vo.image3 }" alt="${vo.title }" style="width:100%; height: auto;" name="image3">
      </div>
      
      <div class="item">
        <img src="${vo.image4 }" alt="${vo.title }" style="width:100%; height: auto;"  name="image4">
      </div>
    </div>

    <!-- Left and right controls -->
    <a class="left carousel-control" href="#myCarousel" data-slide="prev">
      <span class="glyphicon glyphicon-chevron-left"></span>
      <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#myCarousel" data-slide="next">
      <span class="glyphicon glyphicon-chevron-right"></span>
      <span class="sr-only">Next</span>
    </a>
  </div>
  <hr>
		<div class="content" style="text-align: center">
		${vo.content }
		</div>
		<hr>
		<div class="tags">
		${vo.tags}
		</div>
		
<hr>
<div class="text-center">
<c:if test="${!empty login }">
<a href="updateForm.jsp?no=${vo.no }" class="btn btn-default">수정</a>
<a href="delete.jsp?no=${vo.no }" class="btn btn-default">삭제</a>
</c:if>
<a href="list.jsp?page=${param.page }&perPageNum=${param.perPageNum}" class="btn btn-default">리스트</a>
</div>
</div>
</body>
</html>