<%@page import="database.ClientDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>
<%
	String id=request.getParameter("No");
	String sql="delete from client where ClientNo="+id+";";
	ClientDao clientDao=new ClientDao();
	
	if(clientDao.Change(sql)){
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