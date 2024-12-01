<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="author" content="고신원">
    <link rel="stylesheet" href="./style/signin.css" type="text/css">
    <title>Document</title>
</head>
<body>
    <div id="back">
        <video muted autoplay loop>
            <source src="./video/Forest.mp4">
        </video>
        <div id="white">
            <div id="formbox">
                <img src="./image/logo.png" alt="logo_no">
                <form method="post" action="signinProc.jsp">
                    <p>id <input type="text" name="id"></p>
                    <p>pwd<input type="password" name="pwd"></p>
                    <p>pwdch<input type="password" name="pwdch"></p>
                    <p>email<input type="text" name="email"></p>
                    <p>name<input type="text" name="name"></p>
                    <input type="submit" value="sign in" name="signin">
                </form>
                <p id="copy">Copyright(c) 2021.  name. All rights reserved</p>
            </div>
        </div>
        
    </div>
</body>
</html>

