<%@page import="database.ClientDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String id=request.getParameter("id");
	String name=request.getParameter("name");
	String sex=request.getParameter("sex");
	String tel=request.getParameter("tel");
	String birth=request.getParameter("birth");
	String remark=request.getParameter("remark");
	
	ClientDao dao = new ClientDao();  
	
	if(dao.addClient(id, name, sex, tel, birth, remark)){
%>
<script type="text/javascript">
		alert("OK!");
		top.location='client.jsp';
</script>
<%} else {%>
<script type="text/javascript">
		alter("Fail!");
		top.location='client.jsp';
</script>
<%} %>
</body>
</html>