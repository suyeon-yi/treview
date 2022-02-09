<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="panel panel-default">
	<div class="panel-heading">
		<h3>
			공지사항
		</h3>
	</div>
	<div class="panel-body">
	<table class="table">
		<c:forEach items="${noticeList }" var="vo">
		<tr class="noticeDataRow" data-no="${vo.no }">
			<td>${vo.no }</td>
			<td>${vo.title }</td>
			<td>${vo.startDate }</td>
			<td>${vo.endDate }</td>
			<td>${vo.updateDate }</td>
		</tr>
	</c:forEach>
	</table>
	</div>
</div>