<!-- modifyprofileProc.jsp -->
<!-- 회원 정보 수정 Process -->
<!-- author : 김현의 -->
<!-- redirect, target 파라미터 필요 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, manager.*" %>
<%-- author : 고신원 --%>
<%

	request.setCharacterEncoding("utf-8");
	//페이지에 들어온 유저 아이디
	String user = (String) session.getAttribute("Id");
	String redirect = request.getParameter("redirect"); // 프로세스 후 돌려보낼 jsp 파일
	String target = request.getParameter("target"); // 정보 수정하고자 하는 아이디		

	BasicMgr manager = new BasicMgr();

	
	boolean admin = manager.management(user).equals("yes"); // 어드민 모드?
	
	
	if(target == null){ // target이 null이면 정보 수정 페이지를 통해 온 것.(어드민 X)
		target = user; // 따라서 변경하고자 하는 아이디는 본인의 아이디
	}
	
	String id, name, email, pwd, pwdch;
	id = request.getParameter("id");
	name = request.getParameter("name");
	email = request.getParameter("email");
	pwd = request.getParameter("pwd");
	pwdch = request.getParameter("pwdch");
	
	String result = null;
	
	// 값들이 비어있으면 기본값으로
	if(id == null || id.length() == 0) 
		id = manager.getType(target, BasicMgr.ProfileType.ID);
	if(name == null || name.length() == 0)
		name = manager.getType(target, BasicMgr.ProfileType.NAME);
	if(email == null || email.length() == 0)
		email = manager.getType(target, BasicMgr.ProfileType.EMAIL);
	if(pwd == null || pwd.length() == 0){
		pwd = manager.getType(target, BasicMgr.ProfileType.PWD);
		pwdch = pwd;
	}
	
	// 아이디 변경
	if(!id.equals(target)){
		if(manager.getType(id, BasicMgr.ProfileType.ID) != null){ // 이미 존재하는 아이디라면
			result = "IDExists"; 											// result IDExists 반환
		}
	}
	
	// 패스워드 변경
	if(!pwd.equals(pwdch)){							// 비밀번호 확인과 일치하지 않으면
		result = "incorrectPassword";				// result incorrectPassword 반환
	}
	
	
	if(result == null){
		try{
			boolean success = manager.changeProfile(target, id, pwd, name, email);
			if(success){
				session.setAttribute("Id", id); // ID 세션 변경
				result = "success";
			}
			else
				result = "changeProfileFailed";
		} catch(Exception io){
			System.out.println(io.getMessage());
			result = "unknownError";
		}
	}
	
	%>
	
	<% 
	
	if(result.equals("success")){
		response.sendRedirect("./index.jsp");
	} else {
		response.sendRedirect("./modifyprofile.jsp?redirect=" + redirect);
	}
	
%>
