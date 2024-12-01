<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="reply.replycon" %>
<%@ page import="java.sql.*, manager.BasicMgr" %>  
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%-- author : 최지아 --%>
<jsp:useBean id="reply" class="reply.Reply" scope="page"/>
<jsp:setProperty name="reply" property="replyContent"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>댓글액션</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		String id = null;
		id = (String)session.getAttribute("Id");
		
		int bID = 0;
		
		if (request.getParameter("bID") != null) {
			bID = Integer.parseInt(request.getParameter("bID"));
		}
		
		if (bID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = './majorboard.jsp'");
			script.println("</script>");
		}
		
		if(id==null){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('로그인이 필요합니다.')");
			script.println("location.href='./login.jsp'");
			script.println("</script>");	
		}
		else{
			if(reply.getReplyContent()==null){
				PrintWriter script= response.getWriter();
				script.println("<script>");
				script.println("alert('댓글을 입력해주세요.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else{
				replycon replyc=new replycon();
				int result = replyc.write(bID, reply.getReplyContent(), id);
				
				if(result==-1){
					PrintWriter script= response.getWriter();
					script.println("<script>");
					script.println("alert('댓글 작성에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				else{
					String url="board.jsp?bID="+bID;
					PrintWriter script= response.getWriter();
					script.println("<script>");
					script.println("location.href='"+url+"'");
					script.println("</script>");
				}
			}
		}
	%>
</body>
</html>