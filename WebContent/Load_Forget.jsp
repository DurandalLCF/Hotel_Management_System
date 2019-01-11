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
	String name=request.getParameter("username");
	String Pass=request.getParameter("password");
	String IDCard=request.getParameter("ID");
	String Empnum=request.getParameter("number");
	EmpDao dao = new EmpDao();
	
	if(Pass==null){
		response.sendRedirect("load.jsp");
	}
	if(IDCard==null){
		if(dao.CheckLoad(Empnum,Pass)){
			out.print("ok");
			int limit = 1;
			if(dao.CheckLimit(Empnum))
				limit = 0;
			session.setAttribute("loading", true);
			session.setAttribute("limit", limit);
			session.setAttribute("EmpNo", Empnum);%>
			<script type="text/javascript">
				alert("OK!");
			</script>
		<%  response.sendRedirect("index.jsp");
		}
		else{%>
			<script type="text/javascript">
				alert("Fail!");
			</script>
		<%	response.sendRedirect("load.jsp");
		}
	}
	else{
		if(dao.ModifyPass(name, Empnum, IDCard, Pass)){%>
			<script type="text/javascript">
				alert("OK!");
			</script>
		<%  response.sendRedirect("load.jsp");
		}
		else{%>
			<script type="text/javascript">
				alert("Fail!");
				window.history.back(-1); 
			</script>
		<%}
	}
%>
</body>
</html>