<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
%>    

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="author" content="고신원">
    <title>Document</title>
    <link href="./style/login.css" type="text/css" rel="stylesheet">
</head>
<body>
    <div id="back">
        <video muted autoplay loop>
            <source src="./video/Forest.mp4">
        </video>
        <div id="white">
            <div id="formbox">
                <img src="./image/logo.png" alt="logo_no">
                <form method="post" action="loginProc.jsp">
                    <input type="text" name="id" placeholder=" id"><br/>
                    <input type="password" name="pwd" placeholder="pwd"><br/>
                    <input type="button" value="sign in" name="signIn" onclick="location.href='signin.jsp'"><br/>
                    <input type="submit" value="login" name="sub">
                    <input type="hidden" value="login" name="type">
                    <%
                    	String errMsg = (String) session.getAttribute("errMsg");
                		if(errMsg != null) {
                    %>
                    	<script type="text/javascript">
                    		alert("<%=errMsg%>");
                    	</script>
                    <%		session.removeAttribute("errMsg");
                    	} %>
                </form>
                <p>Copyright(c) 2021.  name. All rights reserved</p>
            </div>
        </div>
        
    </div>
</body>
</html>