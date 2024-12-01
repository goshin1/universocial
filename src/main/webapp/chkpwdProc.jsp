<!-- chkpwd.jsp -->
<!-- 회원 정보 수정 페이지 입장 전, 비밀번호 확인 페이지 Process -->
<!-- author : 김현의 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, manager.*" %>
<%	
	request.setCharacterEncoding("utf-8");
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs;
	
	String jsp = request.getParameter("request");
	//System.out.println("jsp : " + jsp);
	
	try{

		
		BasicMgr mgr = new BasicMgr();
		
		request.setCharacterEncoding("UTF-8");
		
		String id = (String) session.getAttribute("Id");
		String pwd = (String) request.getParameter("pwd");

		String query = "select * from members where id = ? && pwd = ?";
		
		mgr.getConnection();
		conn = mgr.getConnection();
		pstmt = conn.prepareStatement(query);
		pstmt.setString(1, id);
		pstmt.setString(2, pwd);
		
		rs = pstmt.executeQuery();
		rs.next();
		
		if(rs.getString("id").equals(id) && rs.getString("pwd").equals(pwd)){
			response.sendRedirect("./" + jsp);
		} else {
			throw new Exception("Value of id of pwd is null");
		}
		
	}catch(Exception e){
		session.setAttribute("errMsg", "잘못된 비밀번호입니다.");
		response.sendRedirect("./chkpwd.jsp?request=" + jsp);
	}finally{
		if(pstmt != null)try{pstmt.close();}catch(SQLException e){}
		if(conn != null)try{conn.close();}catch(SQLException e){}
	}
	

	
%>

