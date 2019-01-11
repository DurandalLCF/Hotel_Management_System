<%@page import="type.Book"%>
<%@page import="database.BookDao"%>
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
	String othercost=request.getParameter("othercost");
	String billno=request.getParameter("billno");
	
	BookDao bookDao=new BookDao();
	Book book=bookDao.Selectone(billno);
	
	HttpSession sessionmain=request.getSession();
	String loadingempno=(String)sessionmain.getAttribute("EmpNo");
	
	String sql="insert into bill values("+billno+",'"+loadingempno+"','"+
				book.getClientNo()+"',"+book.getPay()+","+othercost+");";
	
	if(bookDao.Change(sql)){
		sql="update Book set PayStatus='yes' where BookNo="+billno+";";
		if(bookDao.Change(sql)){
	%>
	<script type="text/javascript">
		alert("OK!");
		top.location='paid.jsp';
	</script>
<%} }else {%>
	<script type="text/javascript">
		alter("Fail!");
		top.location='nonpayment.jsp';
	</script>
<%} %>
</body>
</html>