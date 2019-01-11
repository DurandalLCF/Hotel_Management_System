<%@page import="database.DescDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Modify Room</title>
</head>
<body>
<%
	String no = request.getParameter("no");
	String name = request.getParameter("name");
	String price = request.getParameter("price");
	String gross = request.getParameter("gross");
	String surplus = request.getParameter("surplus");
	
	DescDao dao = new DescDao();
	
	String sql = "call UpdateDescription("+no+",'"+name+"',"+price+","+gross+","+surplus+");";
	if(dao.Change(sql)){
%>
<script type="text/javascript">
		alert("OK!");
		window.history.back(-1); 
</script>
<%} else {%>
<script type="text/javascript">
		alter("Fail!");
		window.history.back(-1); 
</script>
<%} %>
</body>
</html>