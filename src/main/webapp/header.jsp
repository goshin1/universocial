<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="manager.*" %>
<%-- author : 고신원 수정 안한 것 --%>
<header>
	<div id="overheader">
		<a href="index.jsp" id="logo"><img src="image/logo.png" alt="logo_no"></a>
        <form method="post" name="search" action="searchb.jsp">
        	<select style="margin-right:5px;" class="form-control" name="searchField">
				<option value="bTitle">제목</option>
				<option value="bContent">내용</option>
				<option value="userID">작성자</option>
			</select>
			<input type="text" class="form-control" name="searchText" placeholder=" search..">
        	<button id="searchbtn" type="submit" class="btn btn-success">검색</button>
        </form>
        <div id="move">
        <%
        	String id = null;
        	id = (String)session.getAttribute("Id");
        	if(id != null){
        %>		
        	<a href="./logoutProc.jsp" id="logout">logout</a>
        <% } else { %>
        	<a href="./login.jsp" id="login">login</a>
        <%} %> 
        </div>
	</div>
    <div id="underheader">
        <ul id="mainList">
            <li><a href="index.jsp">메인</a><hr/></li>
            <li><a href="majorboard.jsp">전공게시판</a><hr/></li>
            <li><a href="libboard.jsp">교양게시판</a><hr/></li>
            <%
            	String check = "no1";
            	if(id != null){
            		%>
            		<li><a href="messenger.jsp">메신저</a><hr/></li>
            		<%
            		BasicMgr mgr = new BasicMgr();
                	check = mgr.management(id);
                	if(check.equals("yes")){
            			%>
            			<li><a href="management.jsp">회원관리</a><hr/></li>
            			<%
            		} else { %>
            			<li><a href="chkpwd.jsp?request=modifyprofile.jsp">정보수정</a><hr/></li>
            			<li><a href="./score.jsp">학점계산</a><hr/></li>
            	<% }
            	}
            %>
   		</ul>
	</div>
</header>