<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "board.bbcontrol" %>
<%@ page import= "board.bboard" %>
<%@ page import="java.sql.*, manager.BasicMgr" %>  
<%@ page import = "java.io.PrintWriter" %>
<%-- author : 최지아 --%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="content-type" content="text/html; charset=utf-8" /> 
    <link href="style/header.css" rel="stylesheet" type="text/css">
    <link href="style/boardedit.css" rel="stylesheet" type="text/css">
    <link href="style/footer.css" rel="stylesheet" type="text/css">
    <title>게시글 작성</title>
   
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
	int bID = 0;
	if (request.getParameter("bID") != null) {
		bID = Integer.parseInt(request.getParameter("bID"));
	}
	
	bboard board = new bbcontrol().getboard(bID);

		if(request.getParameter("bTitle") == null || request.getParameter("bContent") == null
				|| request.getParameter("bTitle").equals("") || request.getParameter("bContent").equals("")) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
	} else {
		bbcontrol BC = new bbcontrol();
		int result = BC.update(bID, request.getParameter("bTitle"), request.getParameter("bContent"));
		if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글 수정에 실패했습니다.')");
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

%>
</body>
</html>