<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Damoa_pro.dm_login" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	
	dm_login logon = dm_login.getInstance();
	int check = logon.userCheck(id, passwd);
	
	if(check == 1){
		dm_login logon1 = dm_login.getInstance();
		String category = logon1.userCategory(id);
		session.setAttribute("id",id);
		session.setAttribute("category",category);
		response.sendRedirect("dm_Main.jsp");
	}else if(check == 0){%>
	<script>
		alert("비밀번호가 맞지 않습니다.");
		history.go(-1);
	</script>
	<%}else{ %>
	<script>
		alert("아이디가 맞지 않습니다.");
		history.go(-1);
	</script>
		
	<%}%>
