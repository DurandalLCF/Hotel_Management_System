<%@page import="database.EmpDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>
<%
	EmpDao dao=new EmpDao();
	String id=request.getParameter("No");
	String sql="delete from employee where EmployeeNo="+id+";";
	
	if(dao.Change(sql)){
%>
<script type="text/javascript">
		alert("OK!");
		top.location='staff.jsp';
</script>
<%} else {%>
<script type="text/javascript">
		alter("Fail!");
		top.location='staff.jsp';
</script>
<%} %>
</body>
</html>