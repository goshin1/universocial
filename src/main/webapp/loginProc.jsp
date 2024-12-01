<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, manager.*" %>
<%-- author : 고신원 --%>
<%	
	request.setCharacterEncoding("utf-8");
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs;
	
	String id = null;
	String pwd = null;
	String site = null;
	
	try{

		// loginProc
		BasicMgr mgr = new BasicMgr();
		
		request.setCharacterEncoding("UTF-8");
		
		
		
		id = request.getParameter("id");
		pwd = request.getParameter("pwd");
		site = request.getParameter("type");
		
		if(id.equals("") & pwd.equals("") | id == null & pwd == null)
			throw new Exception("Value of id of pwd is null");
		
		
		if(id.length() == 0 || pwd.length() == 0)
			throw new Exception("Value of id of pwd is null");
		
		String query = "select * from members where id = ? && pwd = ?";
		
		conn = mgr.getConnection();
		pstmt = conn.prepareStatement(query);
		pstmt.setString(1, id);
		pstmt.setString(2, pwd);
		
		rs = pstmt.executeQuery();
		rs.next();
		
		
		
		if(rs.getString("id").equals(id) && rs.getString("pwd").equals(pwd)){
			session.removeAttribute("errMsg");
			session.setAttribute("Id",id);
			response.sendRedirect("./index.jsp");
		}
		else{
			throw new Exception("Value of id of pwd is null");
		}
		
	}catch(Exception e){
		if(site.equals("main")){
			session.setAttribute("errMsg", "아이디 또는 비밀번호가 잘못 입력되었습니다.");
			response.sendRedirect("./index.jsp");
		}
		else{
			session.setAttribute("errMsg", "아이디 또는 비밀번호가 잘못 입력되었습니다.");
			response.sendRedirect("./login.jsp");
		}
				
	}finally{
		if(pstmt != null)try{pstmt.close();}catch(SQLException e){}
		if(conn != null)try{conn.close();}catch(SQLException e){}
	}
%>

