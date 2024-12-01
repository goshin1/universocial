<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- author : 고신원 --%>
<%
	// at
	request.setCharacterEncoding("utf-8");
	int num = 0;
	String id="", name = "", email="";
	id = request.getParameter("id");
	name = request.getParameter("name");
	email = request.getParameter("email");
	// managementProc
	// equals()로 변경
	
	String query = "select * from members";
	if(!id.equals("") & name.equals("") & email.equals("")){
		num = 1;
		query+=" where id = ?";
	}
	else if(!name.equals("") & id.equals("") & email.equals("")){
		num = 2;
		query+=" where name = ?";
	}
	else if(!email.equals("") & name.equals("") & id.equals("")){
		num = 3;
		query+=" where email = ?";
	}
	else if(!id.equals("") & !name.equals("") & email.equals("")){
		num = 4;
		query+=" where id = ? && name = ?";
	}
	else if(!id.equals("") & name.equals("") & !email.equals("")){
		num = 5;
		query+=" where id = ? && email = ?";
	}
	else if(id.equals("") & !name.equals("") & !email.equals("")){
		num = 6;
		query+="where name = ? && email = ?";
	}
	else if(!id.equals("") & !name.equals("") & !email.equals("")){
		num = 7;
		query+=" where id = ? && name = ? && email = ?";
	}
	else{
		
	}
	

	session.setAttribute("search","yes");
	session.setAttribute("query", query);
	session.setAttribute("num", num);
	session.setAttribute("id",id);
	session.setAttribute("name",name);
	session.setAttribute("email",email);
	response.sendRedirect("management.jsp");
%>

