<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, manager.*" %>
<%-- author : 고신원 --%>
<%
	request.setCharacterEncoding("utf-8");
	BasicMgr mgr = new BasicMgr();
	Connection conn = mgr.getConnection();
	PreparedStatement pstmt = null;
	ResultSet rs;
	try{
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
		String pwdch = request.getParameter("pwdch");
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		// siginProc.jsp
		if(id.equals("") | pwd.equals("") | pwdch.equals("") | name.equals("") | email.equals(""))
			response.sendRedirect("signin.jsp");
		
			
		
		if(!pwd.equals(pwdch))
			response.sendRedirect("signin.jsp");
		
		String query = "select id from members";
		pstmt = conn.prepareStatement(query);
		rs = pstmt.executeQuery();
		while(rs.next()){
			if(rs.getString("id").equals(id))
				response.sendRedirect("signin.jsp");
		}
		pstmt.close();
		
		String query2 = "insert into members values(?, ?, ?, ?)";
		pstmt = conn.prepareStatement(query2);
		pstmt.setString(1, id);
		pstmt.setString(2, pwd);
		pstmt.setString(3, name);
		pstmt.setString(4, email);
		pstmt.executeUpdate();
		
		
		response.sendRedirect("login.jsp");
		
	}catch(Exception e){
		out.println(e.getMessage());
	}finally{
		if(pstmt != null)try{pstmt.close();}catch(SQLException e){}
		if(conn != null)try{conn.close();}catch(SQLException e){}
	}
	
	
%>
