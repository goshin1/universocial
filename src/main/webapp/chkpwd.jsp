<!-- chkpwd.jsp -->
<!-- 회원 정보 수정 페이지 입장 전, 비밀번호 확인 페이지 -->
<!-- author : 김현의 -->
<!-- redirect, request 파라미터 필요 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String redirect = request.getParameter("redirect");
	String req = request.getParameter("request");
	if(redirect == null) redirect = "index.jsp";
	String errMsg = (String) session.getAttribute("errMsg");
	if(errMsg == null) errMsg = "";
%>
<!DOCTYPE html>
<html>
<head>	
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="author" content="고신원">
    <link href="style/header.css" rel="stylesheet" type="text/css">
    <link href="style/chkpwd.css" rel="stylesheet" type="text/css">
    <link href="style/footer.css" rel="stylesheet" type="text/css"> 
    <link href="style/mainstyle.css" rel="stylesheet" type="text/css">
    <title>Document</title>
</head>
<body>
    <jsp:include page="header.jsp" flush="false"/>
    <div id="body">
	    <div id="formbox">
	    	<div id="forminnerbox">
		    	<div id="describe">
		    		보안을 위해 현재 사용하고 계신 비밀번호를 입력해주세요.
		    	</div><br>
		 
		    	<form method="post" action="chkpwdProc.jsp?request=<%=req %>&redirect=<%=redirect %>" >
		    		<input type="password" name="pwd" placeholder="비밀번호 입력"><br/>
		    		<input type="submit" value="완료" name="check">
		    		<input type="hidden" value="chk" name="type">
		    	</form>
		    	
		    	<div id="warn">
		    		<%=errMsg %>
		    		<%
		    			session.removeAttribute("errMsg");
		    		%>
		    	</div>
		    </div>
	    </div>
    </div>
    
    <jsp:include page="footer.jsp" flush="false"/>
    <script type="text/javascript" src="script/headerscript.js"></script>
</body>
</html>