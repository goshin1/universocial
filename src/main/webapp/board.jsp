<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "board.bboard" %>
<%@ page import= "board.bbcontrol" %>
<%@ page import= "reply.Reply" %>
<%@ page import= "reply.replycon" %>
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
    <link href="style/board.css" rel="stylesheet" type="text/css">
    <link href="style/footer.css" rel="stylesheet" type="text/css">
    <title>게시글</title>
   <%
   	request.setCharacterEncoding("utf-8");
    String id = null;
	id = (String)session.getAttribute("Id");
	
	if (session.getAttribute("id") != null) {
		id = (String) session.getAttribute("id");
	}
	
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
	
	int pageNumber=1;

	if(request.getParameter("pageNumber")!=null){
		pageNumber=Integer.parseInt(request.getParameter("pageNumber"));
	}

	
	bboard board = new bbcontrol().getboard(bID);
%>
</head>
<body>
   <div id="body"> 
 <jsp:include page="header.jsp" flush="false"/>
  <a id="aas" href="majorboard.jsp" class="btn btn-primary">목록</a>
 <%
 	if(id != null && id.equals(board.getUserID())) {
 	%>
 		<a id="aas" href="boardupdate.jsp?bID=<%=bID%>" class="btn btn-primary">수정</a>
 		<a onclick="return confirm('정말로 삭제하시겠습니까?')" id="aas" href="deleteAct.jsp?bID=<%=bID%>" class="btn btn-primary">삭제</a>
 <%
 	}
 %>
 	<div id = "noticeBoard">
 	<div id="title">
		 <p><%= board.getbTitle() %></p>
 	</div>
 	<div class = "nick">
 		<span style="float: left;"><%= board.getUserID() %></span>
 		<span style="float: right;"><%= board.getbDate().substring(0,11) + board.getbDate().substring(11, 13) + "시" + board.getbDate().substring(14,16)+"분" %></span>
 	</div>
 	<div class = "content">
 	<table>
 	<tr>
 	<%-- <td><img width="500px" height="500px"></td> --%>
 	<td><span><%= board.getbContent() %></span></td>
 	</tr>
 	</table>
 	</div>
 </div>

<form method="post" action="replyAct.jsp?bID=<%= bID %>">
<table style="width:1400px; text-align:center; border-collapse: collapse;">
 <tr height="30">
 <th colspan="3" align="center" bgcolor = "#4ce800">
 <font color="white" style="font-weight:bold">댓글</font>
 </th></tr>
					<tbody>
					
						<%
							replycon reply=new replycon();
							ArrayList<Reply> list=reply.getList(bID);
							for(int i=list.size()-1;i>=0;i--){
						%>

						<tr>
							<td style="padding:15px 0 15px 0; border-bottom: 1px solid #ddd; text-align: left;"><%= list.get(i).getReplyContent() %></td>
							<td style="border-bottom: 1px solid #ddd;"><%= list.get(i).getrDate().substring(0,11) + list.get(i).getrDate().substring(11, 13) + "시" + list.get(i).getrDate().substring(14,16)+"분" %></td>
							<td style="border-bottom: 1px solid #ddd; text-align: right;"><%= list.get(i).getUserID() %></td>
							 <%
							 int replyID = list.get(i).getReplyID();
							 
							 if(id != null && id.equals(list.get(i).getUserID())) {
							 %>
							 <td><a onclick="return confirm('댓글을 삭제하시겠습니까?')" id="aas" href="rdelAct.jsp?replyID=<%=replyID%>" class="btn btn-primary">삭제</a></td>
							 <%
							 }
							 %>
						</tr>
					<%
								}
					%>
						<tr><td style="padding-left:200px;"><textarea class="form-control"
								placeholder="댓글을 입력하세요." name="replyContent" maxlength="2048"style="width:800px; height:48px; margin-top:10px;"></textarea>
				<input type="submit" class="aas" value="작성" style="background-color:white; height:25px;"></td></tr>
				</tbody>
				</table>
		</form>
 </div>
 <jsp:include page="footer.jsp" flush="false"/>
 <script type="text/javascript" src="script/headerscript.js"></script>
</body>
</html>