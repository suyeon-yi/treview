<%@page import="com.treview.t_board.vo.T_boardVO"%>
<%@page import="java.util.List"%>
<%@page import="com.treview.t_board.service.T_boardListService"%>
<%@page import="com.webjjang.util.PageObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>    
<%
PageObject pageObject = PageObject.getInstance(request);
pageObject.setPerPageNum(4);

String pt = request.getParameter("pt");
if(pt == null)pt = "new";

pageObject.setPeriod(pt);

T_boardListService service = new T_boardListService();
List<T_boardVO> list = service.service(pageObject);

System.out.println(list);
String style = "background : #0099ff; color : white";

request.setAttribute("list", list);
request.setAttribute("pt", pt);
request.setAttribute("style", style);
request.setAttribute("pageObject", pageObject);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>여행 후기 공유</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<style type="text/css">
.dataRow:hover{
	cursor: pointer;
	background: #eee;
}
.button { /*나도 등록하기 버튼을 위한 스타일*/
  background-color: #4CAF50; /* Green */
  border: none;
  color: white;
  padding: 6px 22px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 14px;
  margin: 4px 2px;
  cursor: pointer;
}
.button1 {
  background-color: white; 
  color: black; 
  border: 2px solid #4CAF50;
}

</style>
<script type="text/javascript">
//alert("리스트")
</script>
</head>
<body>
<div class="container">
<h2>여행 공유</h2>
<div class="btn-group">
<a href="list.jsp?pt=new" style='${(pt=="new")?style:""}'class="btn btn-default">최신순</a>
<a href="list.jsp?pt=pop" style='${(pt=="pop")?style:""}'class="btn btn-default">인기순</a>
</div>
<c:if test="${!empty login }">
<a href="writeForm.jsp" class="button button1" style="float: right;">나도 등록하기</a>
</c:if>
<p></p>
<div class="row">
		
		<c:forEach items="${list }" var = "vo" varStatus="vs">
		<div class="col-md-3">
		<div class="thumbnail dataRow" onclick="location='view.jsp?no=${vo.no}&inc=1'" >
			<img src="${vo.mainImage }" alt="Photo Lists" style="width:100%; height: 300px;" name="mainImage">
			<div class="caption">
			[${vo.no }]
			<br>${vo.title }
			<br>${vo.name }(${vo.id })
			<br>조회수 ${vo.hit } | 좋아요 ${vo.likes }
			</div>
		</div>
		</div>
		<c:if test="${vs.count % 4 == 0 && vs.count != list.size() }">
		${"</div>" }
		${"<div class='row'>" }
		</c:if>
	  </c:forEach>
</div>
	<div class="col-md-12">
				<pageNav:pageNav listURI="list.jsp" pageObject="${pageObject }" query="&pt=${pt }"/>
				</div>
</div>
</body>
</html>