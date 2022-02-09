<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//index.jsp 기본 페이지에 오면은 자동으로 /main/main.jsp 바로 이동 시켜 버린다.
response.sendRedirect("/main/main.jsp");
%>
