<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="score.scorecon" %>
<%@ page import= "score.Score" %>
<%@ page import="java.sql.*, manager.BasicMgr" %>  
<%@ page import="java.io.PrintWriter" %>
<%-- author : 최지아 --%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="content-type" content="text/html; charset=utf-8" /> 
    <title>댓글 삭제</title>
</head>
<body>
<%	
		request.setCharacterEncoding("utf-8");
		String id = null;
		id = (String)session.getAttribute("Id");
	
		if(id == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요.')");
		script.println("location.href = './login.jsp'");
		script.println("</script>");
	}
		
	int scoreID = 0;
	
	if (request.getParameter("scoreID") != null) {
		scoreID = Integer.parseInt(request.getParameter("scoreID"));
	}
		scorecon scorec=new scorecon();
		
		int result = scorec.delete(scoreID);

			PrintWriter script= response.getWriter();
			script.println("<script>");
			script.println("location.href = './score.jsp'");
			script.println("</script>");
%>
</body>
</html>