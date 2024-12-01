<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "libboard.lbcontrol" %>
<%@ page import="java.sql.*, manager.BasicMgr" %>  
<%@ page import = "java.io.PrintWriter" %>
<jsp:useBean id="libboard" class="libboard.libboard" scope="page"/>
<jsp:setProperty name="libboard" property="bTitle"/>
<jsp:setProperty name="libboard" property="bContent"/>
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
			if(libboard.getbTitle() == null || libboard.getbContent() == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				lbcontrol BC = new lbcontrol();
				int result = BC.write(libboard.getbTitle(), id, libboard.getbContent());
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = './libboard.jsp'");
					script.println("</script>");
			}
		}
	}
%>

