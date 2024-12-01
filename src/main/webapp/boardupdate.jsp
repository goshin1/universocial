<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "board.bboard" %>
<%@ page import= "board.bbcontrol" %>
<%@ page import="java.sql.*, manager.BasicMgr, member.MemberBean" %> 
<%@ page import= "java.io.PrintWriter" %>

    <!-- author : 최지아 -->
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
    <title>게시글 수정</title>
   
</head>
<body>
   <%
   	request.setCharacterEncoding("utf-8");
	int bID = 0;
	if (request.getParameter("bID") != null) {
		bID = Integer.parseInt(request.getParameter("bID"));
	}
	
	if (bID == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다.')");
		script.println("location.href = './majorboard.jsp'");
		script.println("</script>");
	}
	bboard board = new bbcontrol().getboard(bID);
%>
   <div id="body"> 
 <jsp:include page="header.jsp" flush="false" />
 
  <form method="post" action="updateAct.jsp?bID=<%=bID%>">
 <table style="width:1300px; height:500px; text-align:center; margin:20px; border: 1px solid #ddd">
	<tbody>
		<tr>
			<td><input type="Text" value=<%=board.getbTitle()%> style="font-size:16px; width:80%; height:50px; margin-top:10px;" class="form-control" name="bTitle" maxlength="50"></td>
 		</tr>
 		<tr>
 			<td><textarea style="font-size:13px; width:80%; height:400px;"class="form-control" name="bContent" maxlength="2048"><%=board.getbContent()%></textarea></td>
  		</tr>
  	</tbody>
 </table>
 		<input style="float:right; width:60px; height:30px; background-color:white; border:1px solid rgb(172,172,172); margin-right:120px;"
 		type="submit" class="btn btn-primary pull-right" value="수정">
</form>
</div>
</body>
<jsp:include page="footer.jsp" flush="false"/>
<script src="script/headerscript.js"></script>
</html>