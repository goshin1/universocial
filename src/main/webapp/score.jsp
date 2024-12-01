<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "score.Score" %>
<%@ page import= "score.scorecon" %>
<%@ page import= "java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
    <!-- author : 최지아 -->
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="content-type" content="text/html; charset=utf-8" /> 
    <link href="style/header.css" rel="stylesheet" type="text/css">
    <link href="style/score.css" rel="stylesheet" type="text/css">
    <link href="style/footer.css" rel="stylesheet" type="text/css">
    <title>학점 계산</title>
   <%
   	request.setCharacterEncoding("utf-8");
    String id = null;
	id = (String)session.getAttribute("Id");
	
	if (session.getAttribute("id") != null) {
		id = (String) session.getAttribute("id");
	}
	
	int scoreID = 0;
	
	if (request.getParameter("scoreID") != null) {
		scoreID = Integer.parseInt(request.getParameter("scoreID"));
	}
	
	scorecon score = new scorecon();
	ArrayList<Score> list=score.getList(scoreID,id);
%>				
</head>
<body>
   <div id="body"> 
 <jsp:include page="header.jsp" flush="false"/>
<table class="table">
 <tr><td class="td">평균
 </td><td style="float:left; margin:20px 0 20px 30px;"><%= score.getgave(id)%></td></tr>
 <tr><td class="td" style="margin-bottom:20px;">등수</td></tr>
				<tbody>
<%
							for(int i=list.size()-1;i>=0;i--){
								int sID = list.get(i).getScoreID();
				%>
					<tr><td>
						<table class="a"> 
						<tr>
						<td style="background-color:rgb(76, 232, 0); color:white; font-weight:bold;" ><%= list.get(i).getSubname() %>
						<td style="width:40px;"><%= list.get(i).getCredit() %>
						<td style="width:40px;"><%= list.get(i).getGscore() %>
						<td style="width:40px;"><%= score.getrank(list.get(i).getScoreID())%><td>
						<a onclick="return confirm('삭제하시겠습니까?')" id="aas" href="SdelAct.jsp?scoreID=<%=sID%>" class="btn btn-primary">삭제</a></td>
						</tr>
						</table>
						<%
							 }
						%>
						</td></tr>
				</tbody>
			</table>
			<form method="post" action="scoreAct.jsp">
			<table>
				<tr>
				<td style="text-align:center;">
				<input placeholder="과목명" name="subname" maxlength="40" style="width:150px; height:40px; margin:10px 10px 0 0; text-align:center;"></input>
				<input placeholder="학점" name="credit" style="width:60px; height:40px; margin-right:10px; text-align:center;"></input>
				<input placeholder="점수" name="gscore" style="width:60px; height:40px; margin-right:10px; text-align:center;"></input>
			<input type="submit" class="btn" value="추가" style="background-color:white; text-align:center; height:40px;"></td>
			</tr>
			</table>
	</form>
 </div>
     <jsp:include page="footer.jsp" flush="false"/>
 <script type="text/javascript" src="script/headerscript.js"></script>
</body>
</html>