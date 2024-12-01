<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- author : 고신원 --%>
<%
	session.removeAttribute("Id");
	response.sendRedirect("./index.jsp");
%>