<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, manager.BasicMgr" %>  
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="content-type" content="text/html; charset=utf-8" /> 
    <meta name="author" content="고신원">
    <link href="style/header.css" rel="stylesheet" type="text/css">
    <link href="style/management.css" rel="stylesheet" type="text/css">
    <title>회원관리</title>
</head>
<body>
    <jsp:include page="header.jsp" flush="false"/>

    <div id="body">
        <form id="searchMem" method="get" action="managementProc.jsp">
            <p>아이디<input name="id" type="text"></p>
            <p>이름<input name="name" type="text"></p>
            <p>이메일<input name="email" type="text"></p>
            <p><input name="search" type="submit" value="검색"></p>
        </form>
        <table>
            <tr>
                <th>번호</th>
                <th>아이디</th>
                <th>이름</th>
                <th>이메일</th>
                <th>변경</th>
                <th>삭제</th>
            </tr>
			<%
			request.setCharacterEncoding("utf-8");
			BasicMgr mgr = new BasicMgr();
			mgr.createConnection();
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs;

			String id, name, email, search;
			
			int num = 0;
			
			try{	
				
				conn = mgr.getConnection();
				String query;
				search = (String)session.getAttribute("search");
				query = "select * from members";
				
				if(search != null){
					query = (String)session.getAttribute("query");
					num = (int)session.getAttribute("num");
				}
				
				pstmt = conn.prepareStatement(query);
				if(num == 1){
					id = (String)session.getAttribute("id");
					pstmt.setString(1, id);
				}
				else if(num == 2){
					name = (String)session.getAttribute("name");
					pstmt.setString(1, name);
				}
				else if(num == 3){
					email = (String)session.getAttribute("email");
					pstmt.setString(1, email);
				}
				else if(num == 4){
					id = (String)session.getAttribute("id");
					pstmt.setString(1, id);
					name = (String)session.getAttribute("name");
					pstmt.setString(2, name);
				}
				else if(num == 5){
					id = (String)session.getAttribute("id");
					pstmt.setString(1, id);
					email = (String)session.getAttribute("email");
					pstmt.setString(2, email);
				}
				else if(num == 6){
					name = (String)session.getAttribute("name");
					pstmt.setString(1, name);
					email = (String)session.getAttribute("email");
					pstmt.setString(2, email);
				}
				else if(num == 7){
					id = (String)session.getAttribute("id");
					pstmt.setString(1, id);
					name = (String)session.getAttribute("name");
					pstmt.setString(2, name);
					email = (String)session.getAttribute("email");
					pstmt.setString(3, email);
				} 
				
				
				
				rs = pstmt.executeQuery();
				int count = 0;
				while(rs.next()){
					count++;
			%>
            <tr class="row">
                <td><%=count %></td>
                <td><%=rs.getString("id") %></td>
                <td><%=rs.getString("name") %></td>
                <td><%=rs.getString("email") %></td>
                <td class="tdbtn" onclick="location.href='modifyprofile.jsp?target=<%=rs.getString("id")%>&redirect=management.jsp'">변경</td>
                <td class="tdbtn" onclick="location.href='deleteMem.jsp?id=<%=rs.getString("id")%>'">삭제</td>
            </tr>
            <%
				}
			}catch(Exception e){
				out.println(e.getMessage()); 
			}finally{
				if(pstmt != null)try{pstmt.close();}catch(SQLException e){}
				if(conn != null)try{conn.close();}catch(SQLException e){}
			}
            %>
        </table>

    </div>
    <jsp:include page="footer.jsp" flush="false"/>
    <script src="script/script.js"></script>
    <script type="text/javascript" src="script/headerscript.js"></script>
</body>
</html>