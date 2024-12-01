<!-- messenger.jsp -->
<!-- 메신저 페이지 -->
<!-- author : 김현의 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="message.*" %>
<%@ page import="java.util.List" %>

<%
	request.setCharacterEncoding("UTF-8");

	request.setCharacterEncoding("UTF-8");
	
	String id = (String) session.getAttribute("Id");
	String target = request.getParameter("target");
	
	MsgManager manager = new MsgManager();

%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="author" content="고신원">
    <link href="style/header.css" rel="stylesheet" type="text/css">
    <link href="style/mainstyle.css" rel="stylesheet" type="text/css">
    <link href="style/messenger.css" rel="stylesheet" type="text/css">
    <link href="style/footer.css" rel="stylesheet" type="text/css">
    <title>메신저</title>
</head>
<body>
    <jsp:include page="header.jsp" flush="false" />
	
	<div id="messenger">
		<div class="left" id="users">
			<ul>
					<li>
						<p id="utitle">메신저</p>
					</li>
    			<%
    			// 모든 ID를 가져옵니다.
   				List<String> ids = manager.getMemberList();
   				for(String targets : ids){
   					if(targets.length() > 0 && !targets.equals(id)){
   				%>
   					<li>
   						<p><a class="msgChat" href="messenger.jsp?target=<%= targets %>"> <%=targets%></a></p>
   					</li>
   				<%
   					}
   				}
   				%>
 			</ul>
    	</div>
    	
    	<%	
   		// 타겟 파라미터 존재 시 채팅 박스 띄우기
   		if(target != null && target.length() > 0) { 
   		%>
   			<div class="right" id="chatbox">
    			<%
   					List<MessageInfo> milist = manager.getChattingLog(id, target); // 해당 id와 target이 나눈 MessageInfo를 가져옵니다.
   				%>
   				
   				<!-- 대화 로그 -->
   				<div id="chatlog">
   					<ul>
   					<%
   						for(MessageInfo mi : milist){ // MessageInfo -> 고유번호, 발신자 ID, 수신자 ID, 내용, 날짜로 구성됨 
   						 %> <li> <%
   							if(mi.getSenderID().equals(id)){ %>
   								<div class="chatlog_send">
   									<%=id %> : <%= mi.getContent() %>
   								</div>
   								<%
   							} else { %>
   								<div class="chatlog_recv">
   									<%=target %> : <%= mi.getContent() %>
   								</div>
   							<%
   							}
   						 %> </li> <%
   						} %>
   					</ul>
   					
   				</div>
   				
   				<!-- 대화 발신 상자 -->
   				<div id="chatsend">
   					<form action="messengerProc.jsp?target=<%=target %>" method="POST">
   						<input type="text" name="message" placeholder="보낼 내용을 입력해주세요.">
   						<input type="submit" value="보내기">
   					</form>
   				</div>
   			</div>
   		<% } %>
    	
    	<%
    	manager.close();
    	%>
    </div>
    <jsp:include page="footer.jsp" flush="false"/>
    <script src="script/headerscript.js"></script>
</body>
</html>