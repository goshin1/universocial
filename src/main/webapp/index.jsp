<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="author" content="고신원">
    <link href="style/header.css" rel="stylesheet" type="text/css">
    <link href="style/style.css" rel="stylesheet" type="text/css">
    <link href="style/footer.css" rel="stylesheet" type="text/css">
    <title>메인</title>
    <%
    	String errMsg = (String) session.getAttribute("errMsg");
        if(errMsg != null) {
    %>
       		<script type="text/javascript">
            	alert("<%=errMsg%>");
            </script>
    <%
    		session.removeAttribute("errMsg");
        } %>
</head>
<body>
    <jsp:include page="header.jsp" flush="false" />

    <div id="body">
        <div class="slideshow-container">
            <div class="mySlides fade">
                <div class="numbertext">1 / 3</div>
                <img src="image/main1.png" style="width:100%">

            </div>

            <div class="mySlides fade">
                <div class="numbertext">2 / 3</div>
                <img src="image/main2.png" style="width:100%">
            </div>

            <div class="mySlides fade">
                <div class="numbertext">3 / 3</div>
                <img src="image/main3.png" style="width:100%">
            </div>
            <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
            <a class="next" onclick="plusSlides(1)">&#10095;</a>
        </div>

        <div id="content">
                <div id="content">
            		<div id="conLeft">
            			<%
            				String id = null;
        					id = (String)session.getAttribute("Id");
        					if(id != null){
        				%>
                		<form id="loginForm" action="logoutProc.jsp" method="post">
                			<p id="loginId"><%=id %>님 어서오세요!</p>
                    		<input type="submit" value="logout" name="logout">
                		</form>
       					 <% } else { %>
        				<form id="loginForm" action="loginProc.jsp" method="post">
                    		<input type="text" name="id" placeholder="id"><br/>
                    		<input type="password" name="pwd" placeholder="pwd"><br/>
                    		<input type="submit" value="login" name="sub"><br/>
                    		<input type="button" value="sign in" name="signIn" onclick="location.href='signin.jsp'">
                    		<input type="hidden" value="main" name="type">
                		</form>
        				<%} %> 
                		
                		<a href="#" id="banner">
                			<div id="blink">바로가기</div>
                    		<img src="image/banner.png" alt="banner_no">
                		</a>
            		</div>
            		<div id="conRight">
                		<div id="notice">
                    		<p id="notice_p">공지사항 및 이벤트</p>
                    		<hr/>
                    		<div class="block">
                        		<p>2021 동양미래EXPO(제39회 졸업작품전시회) 개최 안내</p>
                        		<span>전시기간 : 2021.10.26.(화)~10.29.(금), 4일간</span>
                    		</div>
                    		<div class="block">
                        		<p>[학생] 2021 코로나 방지 캠페인</p>
                        		<span>참여기간 : 2021.11.26.(화)~12.29.(금), 34일간</span>
                    		</div>
                		</div>
                		<div id="noticeBoard">
                    		<div class="board">
                        		<div class="board_h">
                            		<span>전공게시판</span>
                            		<img src="image/arrow.png" alt="arrow_no">
                        		</div>
                        		<p>컴소과) IOT프로그래밍 고수 있나요? ㅠㅠ</p>
                        		<p>기설과) 솔리드 윅스 질문</p>
                        		<p>화공과) 전공심화 하시는 분 있나요?</p>
                        
                    		</div>
                   	 		<div class="board">
                        		<div class="board_h">
                            		<span>교양게시판</span>
                            		<img src="image/arrow.png" alt="arrow_no">
                        		</div>
                        		<p>싱글라이프 오늘 줌 수업 있나요?</p>
                        		<p>영화와 음악 과제 아시는 분?</p>
                        		<p>오늘 독서인문학 줌 수업 들으신분?</p>
                    		</div>
                		</div>
            		</div>
        		</div>
    </div>
    <jsp:include page="footer.jsp" flush="false"/>
    <script type="text/javascript" src="script/script.js"></script>
    <script type="text/javascript" src="script/headerscript.js"></script>
</body>
</html>