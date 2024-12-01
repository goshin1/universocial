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
    <title>검색</title>
   
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
 
 <table style="margin-left:100px; width:1300px; height:100%; margin: 20px; border-bottom: 1px solid #ddd; border-radius: 5px;">
	<tbody>
	<%
		bbcontrol bcon = new bbcontrol();
		ArrayList<bboard> list = bcon.getSearch(request.getParameter("searchField"), request.getParameter("searchText"));
		if (list.size() == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('검색결과가 없습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		for (int i = 0; i < list.size(); i++) {
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
    <jsp:include page="footer.jsp" flush="false"/>
</div>
    <script type="text/javascript" src="script/headerscript.js"></script>
</body>
</html>