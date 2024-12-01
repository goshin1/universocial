<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, manager.*" %>
<%-- author : 고신원 --%>
<%
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");
	Connection conn = null;
	PreparedStatement pstmt = null;

	BasicMgr mgr = new BasicMgr();
	try{
		conn = mgr.getConnection();
		//deleteMem.jsp
		
		String query2 = "delete from message where senderID = ? or receiverID = ?";
		pstmt = conn.prepareStatement(query2);
		pstmt.setString(1,id);
		pstmt.setString(2,id);
		pstmt.executeUpdate();
		
		
		String query3 = "delete from board where userID = ?";
		pstmt = conn.prepareStatement(query3);
		pstmt.setString(1,id);
		pstmt.executeUpdate();
		

		String query5 = "delete from reply where userID = ?";
		pstmt = conn.prepareStatement(query5);
		pstmt.setString(1,id);
		pstmt.executeUpdate();
		
		
		String query6 = "delete from score where userID = ?";
		pstmt = conn.prepareStatement(query6);
		pstmt.setString(1,id);
		pstmt.executeUpdate();
		

		String query7 = "delete from members where id = ?";
		pstmt = conn.prepareStatement(query7);
		pstmt.setString(1,id);
		pstmt.executeUpdate();
		response.sendRedirect("management.jsp");
	}catch(Exception e){
		out.println(e.getMessage());
	}

%>