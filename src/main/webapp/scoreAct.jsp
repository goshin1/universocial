<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="score.scorecon" %>
<%@ page import="java.sql.*, manager.BasicMgr" %>  
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%-- author : 최지아 --%>
<jsp:useBean id="score" class="score.Score" scope="page"/>
<jsp:setProperty name="score" property="subname"/>
<jsp:setProperty name="score" property="credit"/>
<jsp:setProperty name="score" property="gscore"/>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>학점 액션</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		String id = null;
		id = (String)session.getAttribute("Id");
		
		int scoreID = 0;
		
		if (request.getParameter("scoreID") != null) {
			scoreID = Integer.parseInt(request.getParameter("scoreID"));
		}
		
		if(id==null){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('로그인이 필요합니다.')");
			script.println("location.href='./login.jsp'");
			script.println("</script>");	
		}
		else{
			if(
				score.getSubname() == null || score.getCredit() == -1 || score.getGscore() == -1){
				PrintWriter script= response.getWriter();
				script.println("<script>");
				script.println("alert('전부 입력해주세요.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else{
				scorecon scorec = new scorecon();
				int result = scorec.write(scoreID, score.getSubname(), score.getCredit(), score.getGscore(), id);

				if(result==-1){
					PrintWriter script= response.getWriter();
					script.println("<script>");
					script.println("alert('추가에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				else{
					PrintWriter script= response.getWriter();
					script.println("<script>");
					script.println("location.href='./score.jsp'");
					script.println("</script>");
				}
			}
		}
	%>
</body>
</html>