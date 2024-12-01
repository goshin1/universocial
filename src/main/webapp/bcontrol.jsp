<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "board.bbcontrol" %>
<%@ page import="java.sql.*, manager.BasicMgr" %>  
<%@ page import = "java.io.PrintWriter" %>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="board" class="board.bboard" scope="page"/>
<jsp:setProperty name="board" property="bTitle"/>
<jsp:setProperty name="board" property="bContent"/>
<%-- author : 최지아 --%>
<%	
		
		request.setCharacterEncoding("utf-8");
		String id = null;
		id = (String)session.getAttribute("Id");
	
		if(id == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 후 이용 바랍니다.')");
		script.println("location.href = './login.jsp'");
		script.println("</script>");
		} else {
			if(board.getbTitle() == null || board.getbContent() == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {
		
				bbcontrol BC = new bbcontrol();
				int result = BC.write(board.getbTitle(), id, board.getbContent());

				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 작성에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = './majorboard.jsp'");
					script.println("</script>");
			}
		}
	}
%>

