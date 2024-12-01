<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <% request.setCharacterEncoding("UTF-8"); %>
    <!-- author : 최지아 -->
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="style/header.css" rel="stylesheet" type="text/css">
    <link href="style/boardedit.css" rel="stylesheet" type="text/css">
    <link href="style/footer.css" rel="stylesheet" type="text/css">
    <title>게시글 작성</title>
   
</head>
<body>
 <jsp:include page="header.jsp" flush="false" />
<div id="body">  
  <form method="post" action="bcontrol.jsp" enctype="multiport/form-data">
  	<input style="float:right; width:60px; height:30px; background-color:white; border:1px solid rgb(172,172,172); margin-right:250px; margin-top:20px;"
 		type="submit" class="btn btn-primary pull-right" value="작성">
 	<table style="width:1300px; height:500px; text-align:center; margin:20px;">
		<tbody>
			<tr>
				<td><input type="Text" style="font-size:16px; width:80%; height:50px; margin-top:10px;" class="form-control" placeholder="제목" name="bTitle" maxlength="50"></td>
 			</tr>
 			<tr>
 				<td><textarea style="font-size:13px; width:80%; height:400px;"class="form-control" placeholder="내용" name="bContent" maxlength="2048"></textarea></td>
  			</tr>
 			
  		</tbody>
 	</table> 		
 	
 </form>
</div>
<jsp:include page="footer.jsp" flush="false"/>
<script src="script/headerscript.js"></script>
</body>
</html>