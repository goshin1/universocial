<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "board.bbcontrol" %>
<%@ page import = "board.bboard" %>
<%@ page import = "java.util.ArrayList" %>
    <!-- author : 최지아 -->
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="content-type" content="text/html; charset=utf-8" /> 
    <link href="style/header.css" rel="stylesheet" type="text/css">
    <link href="style/majorboard.css" rel="stylesheet" type="text/css">
    <link href="style/footer.css" rel="stylesheet" type="text/css">
    <title>전공게시판</title>
   
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	int pageNumber = 1;
	if (request.getParameter("pageNumber") != null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
%>
   <div id="body"> 
 <jsp:include page="header.jsp" flush="false" />
 <div class="sub">
 <div class="dropdown">
  <button class="dropbtn">기계공학부</button>
  <div class="dropdown-content">
    <a href="#">기계공학과</a>
    <a href="#">기계설계공학과</a>
  </div>
</div>
 <div class="dropdown">
  <button class="dropbtn">로봇자동화공학부</button>
  <div class="dropdown-content">
    <a href="#">로봇공학과</a>
    <a href="#">자동화공학과</a>
  </div>
</div>
 <div class="dropdown">
  <button class="dropbtn">전기전자통신공학부</button>
  <div class="dropdown-content">
    <a href="#">전기공학과</a>
    <a href="#">정보전자공학과</a>
    <a href="#">정보통신공학과</a>
    <a href="#">반도체전자공학과</a>
  </div>
</div>
 <div class="dropdown">
  <button class="dropbtn">컴퓨터공학부</button>
  <div class="dropdown-content">
    <a href="#">컴퓨터소프트웨어공학과</a>
    <a href="#">컴퓨터정보공학과</a>
  </div>
</div>
 <div class="dropdown">
  <button class="dropbtn">생활환경공학부</button>
  <div class="dropdown-content">
    <a href="#">건축과</a>
    <a href="#">실내환경디자인과</a>
    <a href="#">생명화학공학과</a>
    <a href="#">식품공학과</a>
    <a href="#">시각정보디자인과</a>
  </div>
</div>
 <div class="dropdown">
  <button class="dropbtn">경영학부</button>
  <div class="dropdown-content">
    <a href="#">경영학과</a>
    <a href="#">세무회계학과</a>
    <a href="#">유통마케팅과</a>
    <a href="#">호텔관광과</a>
    <a href="#">경영정보학과</a>
  </div>
</div>
 </div>
 
  <a href="boardedit.jsp"><img src="./image/pencil.png" class="write"></img></a>
 
 <table style="margin-left:100px; width:1300px; height:100%; margin: 20px; border-bottom: 1px solid #ddd;">
	<tbody>
	<%
		bbcontrol bc = new bbcontrol();
		ArrayList<bboard> list = bc.getList(pageNumber);
		for(int i = 0; i<list.size(); i++) {
	%>
	<tr height="30px" style="text-align:left;">
			<td style="font-size:16px; width:800px; border-left: 3px solid rgb(76, 232, 0); padding: 15px 0 15px 20px; font-weight:bold;">
			<a href="board.jsp?bID=<%= list.get(i).getbID() %>"><%= list.get(i).getbTitle()%></a></td>
			<td><img src ="image/logo.png" width="50px" height ="50px"></td>
			<td style="font-size:13px;"><%= list.get(i).getUserID() %></td>
			<td style="text-align:right; font-size:10px;">
			<%= list.get(i).getbDate().substring(0, 11) + list.get(i).getbDate().substring(11, 13) + "시" + list.get(i).getbDate().substring(14, 16) + "분" %></td></tr>
  	<%
		}
  	%>
  	</tbody>
 </table>
<%
 	if(pageNumber != 1) {
 		%> <a style="margin-left:700px; font-weight:bold; font-size:10px; color:(172,172,172);" href="majorboard.jsp?pageNumber=<%=pageNumber - 1%>" class="btn btn-success">이전</a>
<%
 	} if (bbcontrol.nextPage(pageNumber + 1)) { %>
 <a style="margin-left:700px; float:center; font-weight:bold; font-size:10px; color:(172,172,172);" href="majorboard.jsp?pageNumber=<%=pageNumber + 1%>" class="btn btn-success">다음</a>
<%
 	}
%>
    <jsp:include page="footer.jsp" flush="false"/>
</div>
    <script type="text/javascript" src="script/headerscript.js"></script>
</body>
</html>