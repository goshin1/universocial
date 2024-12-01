<!-- messengerProc.jsp -->
<!-- 메신저 발송 페이지 -->
<!-- author : 김현의 -->
<!-- 호출 시 session 단에 Id, parameter로 target, message 필요 -->


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="message.*" %>
<%	
	request.setCharacterEncoding("utf-8");
	
	String Id = (String) session.getAttribute("Id");
	String target = request.getParameter("target");
	String message = request.getParameter("message");
	
	MsgManager manager = new MsgManager();
	manager.send(Id, target, message);
	manager.close();
	response.sendRedirect("./messenger.jsp?target=" + target);
	
%>

