<%@page import="com.treview.t_board.vo.T_boardVO"%>
<%@page import="com.treview.t_board.service.T_boardViewService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
//데이터를 수집한다. - 수정하고자 하는 글의 글번호가 넘어와야한다.
String strNo = request.getParameter("no");
long no = Long.parseLong(strNo);
System.out.println("view.jsp - no : " + no);
//DB에서 데이터를 가져온다.
T_boardViewService service = new T_boardViewService();
T_boardVO vo = service.service(no, 0);
//데이터를 확인한다.
System.out.println(vo);

request.setAttribute("vo", vo);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>여행 후기 수정</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script type="text/javascript" src="/js/formUtil.js"></script>
<style type="text/css">
input,textarea{
	background: #eee;
}
</style>
<script type="text/javascript">
$(function(){
	
	//입력란의 배경색을 #eee(옅은 회색) 만들어 놓고, 입력하는 입력란에 배경색을 흰색으로 바꿔준다.
	$("input, textarea").css("background", "#eee");
	
	$("#writeForm").submit(function(){
		
		//필수 입력 항목 검사 - 제목, 여행장소, 여행일정, 참여인원, 사진, 내용, 작성자 - 태그는 필수입력 항목이 아니다.
		
		if(emptyCheck("#title", "제목")) return false;
		if(emptyCheck("#place", "여행장소")) return false;
		if(emptyCheck("#startDate", "여행시작일")) return false;
		if(emptyCheck("#endDate", "여행종료일")) return false;
		if(emptyCheck("#staff", "참여인원")) return false;
		if(emptyCheck("#image", "여행사진")) return false;
		if(emptyCheck("#content", "내용")) return false;
		
		//길이 제한 검사를 한다. - 제목, 여행장소, 내용, 태그, 작성자
		if(!lengthCheck("#title", "제목", 4, 100)) return false;
		if(!lengthCheck("#place", "여행장소", 4, 100)) return false;
		if(!lengthCheck("#content", "내용", 4, 1000)) return false;
		if(!lengthCheck("#tags", "태그", 0, 100)) return false;
		
		//날짜 패턴 검사를 한다. - 여행 시작일, 여행 종료일
		if(!regTest(reg_date, "#startDate", "yyyy-mm-dd")) return false;
		if(!regTest(reg_date, "#endDate", "yyyy-mm-dd")) return false;
	
	});
});
</script>
</head>
<body>
<div class="container">
<h2>여행 공유</h2>
<form action="update.jsp" method="post" enctype="multipart/form-data" class="form-horizontal">
		<div class="form-group">
			<label for="no" class="control-label col-sm-2" >번호</label>
			<div class="col-sm-10">
			<input name="no" value="${vo.no }" readonly="readonly" style="backgroud: #eee" class="form-control" id="no">
			</div>
		</div>
		
		<div class="form-group">
			<label for="title" class="control-label col-sm-2" >제목</label>
			<div class="col-sm-10">
			<input name="title" value="${vo.title }" id="title" class="form-control">
			</div>
		</div>
		
	<div class="form-group">
		<label for="place" class="control-label col-sm-2">여행장소</label>
		<div class="col-sm-10">
		<input name="place" value="${vo.place }" id="place" class="form-control" >
		</div>
	</div>
		
	<div class="form-group">
		<label for="schedule" class="control-label col-sm-2">여행일정</label>
		<div class="col-sm-10">
		<input type="text" id="startDate" name="startDate" value="${vo.startDate }">
				<label for="endDate">~</label>
				<input type="text" id="endDate" name="endDate" value="${vo.endDate }">
		</div>	
	</div>	
			
		<div class="form-group">
		<label for="staff" class="control-label col-sm-2">참여인원</label>
			<div class="col-sm-10">
				<label>
				<input type="radio" name="staff" value="1명" ${vo.staff eq "1명" ? "checked" : ""} >1명
				</label>
				<label>
				<input type="radio" name="staff" value="2명" ${vo.staff eq "2명" ? "checked" : ""}>2명
				</label>
				<label>
				<input type="radio" name="staff" value="3명 이상" ${vo.staff eq "3명 이상" ? "checked" : ""}>3명 이상
				</label>
			</div>
		</div>
			
		<div class="form-group">
		<label for="photo" class="control-label col-sm-2">여행사진</label>
		<div class="col-sm-10">
			    사진 한 장당 크기는 10MB 이내로 등록 가능합니다.
			<br>사진은 최대 5장까지 등록 가능합니다.
			<br>사진의 크기는 가로 936px  세로 500px입니다.
			<br>
			<div id="changeImageDiv">
			<input type="hidden" name="no" value="${vo.no }" >
			<input multiple="multiple" type="file" name="oldMianImage" required="required">
			<input multiple="multiple" type="file" name="oldImage1" required="required">
			<input multiple="multiple" type="file" name="oldImage2" required="required">
			<input multiple="multiple" type="file" name="oldImage3" required="required">
			<input multiple="multiple" type="file" name="oldImage4" required="required">
			</div>	
			</div>	
		</div>	
		
		<div class="form-group">
			<label for="content" class="control-label col-sm-2" >내용</label>
			<div class="col-sm-10">
			<textarea rows="7" cols="80" name="content" id="content" class="form-control">${vo.content }</textarea>
			</div>
		</div>
		
		<div class="form-group">
		<label for="tags" class="control-label col-sm-2">태그</label>
		<div class="col-sm-10">
		<input name="tags" value="${vo.tags }" id="tags" class="form-control" >
		</div>
		</div>
		
		
		<div class="text-center">
				<button type="submit" class="btn btn-default">수정</button>
				<button type="reset" class="btn btn-default">새로입력</button>
				<button type="button" onclick="history.back()" class="btn btn-default">취소</button>
			</div>
</form>
</div>
</body>
</html>