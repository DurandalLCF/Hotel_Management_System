<%@page import="type.Cipher"%>
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
	String sno=request.getParameter("sno");
	String dno=request.getParameter("dno");
	String name=request.getParameter("name");
	String birth=request.getParameter("birth");
	String id=request.getParameter("id");
	String sex=request.getParameter("sex");
	String tel=request.getParameter("tel");
	String loc=request.getParameter("loc");
	String job=request.getParameter("job");
	String hire=request.getParameter("hire");
	String sal=request.getParameter("sal");
	String password=request.getParameter("password");
	String remark=request.getParameter("remark");
	
	Cipher cipher=new Cipher();
	password=cipher.Encrypt(password);
	
	EmpDao dao=new EmpDao();
	
	if(dao.modStaff(sno, dno, name, birth, id, sex, tel, 
			loc, job, hire, sal, password, remark)){
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