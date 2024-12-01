<!-- modifyprofile.jsp -->
<!-- 회원 정보 수정 페이지 -->
<!-- author : 김현의 -->
<!-- 정보 수정 메뉴로 접근 시 Id, redirect 속성 필요 -->
<!-- 어드민 메뉴로 접근 시 Id, target, redirect 속성 필요 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, manager.*" %>



<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="author" content="고신원">
    <link href="style/header.css" rel="stylesheet" type="text/css">
    <link href="style/footer.css" rel="stylesheet" type="text/css">
    <link href="style/mainstyle.css" rel="stylesheet" type="text/css">
    <link href="style/modifyprofile.css" rel="stylesheet" type="text/css">
    <title>회원 정보 수정</title>
</head>



<body>

	<%
	request.setCharacterEncoding("utf-8");
	
	String id = (String) session.getAttribute("Id");
	String target = request.getParameter("target");
	String redirect = request.getParameter("redirect");
	
	BasicMgr manager = new BasicMgr();
	
	boolean admin = manager.management(id).equals("yes");
	
	if(!admin){ // 어드민이 아니면 자기 자신의 정보밖에 수정하지 못함.
		target = id;
	}
	
	String email = manager.getType(target, BasicMgr.ProfileType.EMAIL);
	String name = manager.getType(target, BasicMgr.ProfileType.NAME);

	%>
	
	
	
	<jsp:include page="header.jsp" flush="false" />
    <div id="body">
    	<div id="formbox">
    		<form method="post" action="modifyprofileProc.jsp?redirect=<%=redirect %>&target=<%=target%>">
             	<p>아이디 <input type="text" name="id" value=<%=target %>></p>
             	<p>새로운 비밀번호<input type="password" name="pwd"></p>
             	<p>비밀번호 확인<input type="password" name="pwdch"></p>
             	<p>이메일<input type="text" name="email" value=<%=email %>></p>
             	<p>이름<input type="text" name="name" value= <%=name %>></p>
             	<p><input type="submit" value="수정 완료" name="confirm"></p>
        		<p><a href="javascript:history.back()">취소</a></p>
        	</form>
        	<img alt="image_no" src="./image/info.jpg" id="info">
        	
    	</div>
    </div>
    
    <jsp:include page="footer.jsp" flush="false"/>
    <script type="text/javascript" src="script/headerscript.js"></script>
</body>
</html>