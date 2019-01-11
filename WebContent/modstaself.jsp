<%@page import="type.Employee"%>
<%@page import="database.EmpDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Account Settings</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link type="text/css" href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link type="text/css" href="bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet">
        <link type="text/css" href="css/theme.css" rel="stylesheet">
        <link type="text/css" href="images/icons/css/font-awesome.css" rel="stylesheet">
        <link type="text/css" href='http://fonts.googleapis.com/css?family=Open+Sans:400italic,600italic,400,600'
            rel='stylesheet'>
</head>
<body>
<%
	String id=request.getParameter("No");
	EmpDao dao=new EmpDao();
	Employee emp=dao.selectOne(id);
%>
<%
	HttpSession sessionmain=request.getSession();
	int limit=(int)sessionmain.getAttribute("limit");
	String loadingempno=(String)sessionmain.getAttribute("EmpNo");
%>
	<div class="navbar navbar-fixed-top">
        <div class="navbar-inner">
            <div class="container">
                <a class="btn btn-navbar" data-toggle="collapse" data-target=".navbar-inverse-collapse">
                    <i class="icon-reorder shaded"></i></a><a class="brand" href="index.jsp">HOTEL </a>
                <div class="nav-collapse collapse navbar-inverse-collapse">
                    <ul class="nav pull-right">
                        <li class="nav-user dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            <img src="images/user.png" class="nav-avatar" />
                            <b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li><a href="modstaself.jsp?No=<%=loadingempno %>">Account Settings</a></li>
                                <li><a href="Logout.jsp">Logout</a></li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <div class="wrapper">
            <div class="container">
                <div class="row">
                    <div class="span3">
                        <div class="sidebar">
                            <ul class="widget widget-menu unstyled">
                                <li class="active"><a href="index.jsp"><i class="menu-icon icon-dashboard"></i>Guest 
                                </a></li>
                            </ul>
                            
                            <ul class="widget widget-menu unstyled">
								<li class="active"><a href="book.jsp"><i class="menu-icon icon-bold"></i>Book 
                                </a></li>
                            </ul>
                            
                            <ul class="widget widget-menu unstyled">
                                <li><a class="collapsed" data-toggle="collapse" href="#billslog"><i class="menu-icon icon-tasks">
                                </i><i class="icon-chevron-down pull-right"></i><i class="icon-chevron-up pull-right">
                                </i>Bills </a>
                                    <ul id="billslog" class="collapse unstyled">
                                        <li><a href="nonpayment.jsp"><i class="icon-inbox"></i>Non-Payment </a></li>
                                        <li><a href="paid.jsp"><i class="icon-inbox"></i>Paid </a></li>
                                    </ul>
                                </li>
                            </ul>
                            
							
                            <ul class="widget widget-menu unstyled">
                            	<li>
                            	<li><a class="collapsed" data-toggle="collapse" href="#Clientlog"><i class="menu-icon icon-book">
                                </i><i class="icon-chevron-down pull-right"></i><i class="icon-chevron-up pull-right">
                                </i>Client </a>
                                    <ul id="Clientlog" class="collapse unstyled">
                                        <li><a href="client.jsp"><i class="icon-inbox"></i>List </a></li>
                                        <li><a href="addcli.jsp"><i class="icon-inbox"></i>Add New Client </a></li>
                                    </ul>
                                </li>
                                <%if(limit==0) {%><li>
                                <li><a class="collapsed" data-toggle="collapse" href="#stafflog"><i class="menu-icon icon-paste">
                                </i><i class="icon-chevron-down pull-right"></i><i class="icon-chevron-up pull-right">
                                </i>Staff </a>
                                    <ul id="stafflog" class="collapse unstyled">
                                        <li><a href="staff.jsp"><i class="icon-inbox"></i>List </a></li>
                                        <li><a href="addsta.jsp"><i class="icon-inbox"></i>Add New Staff </a></li>
                                    </ul>
                                </li><%} %>
                                <li><a href="department.jsp"><i class="menu-icon icon-table"></i>Department </a></li>
                            </ul>
							
                            
                            <ul class="widget widget-menu unstyled">
                                <li><a href="Logout.jsp"><i class="menu-icon icon-signout"></i>Logout </a></li>
                            </ul>
                        </div>
                    </div>


					<div class="span9">
						<div class="content">
							<div class="module">
								<div class="module-head">
									<h3>Staff Message</h3>
								</div>
								<div class="module-body">
									<form class="form-horizontal row-fluid" name="message" action="ModStaDB.jsp">	
										<div class="control-group">
											<label class="control-label" for="basicinput">EmpNo</label>
											<div class="controls">
												<input type="text" name="sno" id="basicinput" value="<%=emp.getEmployeeNo() %>" class="span8" readonly="readonly">
											</div>
										</div>
										
										<div class="control-group">
											<label class="control-label" for="basicinput">DeptNo</label>
											<div class="controls">
												<input type="text" name="dno" id="basicinput" value="<%=emp.getDeptNo() %>" class="span8" readonly="readonly">
											</div>
										</div>
																	
										<div class="control-group">
											<label class="control-label" for="basicinput">Name</label>
											<div class="controls">
												<input type="text" name="name" id="basicinput" value="<%=emp.getEmployeeName() %>" class="span8">
											</div>
										</div>
										
										<div class="control-group">
											<label class="control-label">Sex</label>
											<div class="controls">
												<label class="radio">
													<input type="radio" name="sex" value="man" <%if(emp.getSex().equals("man")){%>checked<%} %>>Man
												</label> 
												<label class="radio">
													<input type="radio" name="sex" value="woman" <%if(emp.getSex().equals("woman")){%>checked<%} %>>Woman
												</label>
											</div>
										</div>
										
										<div class="control-group">
											<label class="control-label" for="basicinput">Birthday</label>
											<div class="controls">
												<input type="date" name="birth" class="span8" value="<%=emp.getBirth() %>">
											</div>
										</div>
										
										<div class="control-group">
											<label class="control-label" for="basicinput">ID Number</label>
											<div class="controls">
												<input type="text" name="id" id="basicinput" value="<%=emp.getID() %>" class="span8">
											</div>
										</div>
										
										<div class="control-group">
											<label class="control-label" for="basicinput">Telephone</label>
											<div class="controls">
												<input type="text" name="tel" id="basicinput" value="<%=emp.getTel() %>" class="span8">
											</div>
										</div>
										
										<div class="control-group">
											<label class="control-label" for="basicinput">Address</label>
											<div class="controls">
												<input type="text" name="loc" id="basicinput" value="<%=emp.getAddress() %>" class="span8">
											</div>
										</div>
										
										<div class="control-group">
											<label class="control-label" for="basicinput">Job</label>
											<div class="controls">
												<input type="text" name="job" id="basicinput" value="<%=emp.getJob() %>" class="span8" readonly="readonly">
											</div>
										</div>
										
										<div class="control-group">
											<label class="control-label" for="basicinput">Hiredate</label>
											<div class="controls">
												<input type="date" name="hire" class="span8" value="<%=emp.getEmployeeDate() %>" readonly="readonly">
											</div>
										</div>
										
										<div class="control-group">
											<label class="control-label" for="basicinput">Salary</label>
											<div class="controls">
												<input type="text" name="sal" id="basicinput" value="<%=emp.getSal() %>" class="span8" readonly="readonly">
											</div>
										</div>
										
										<div class="control-group">
											<label class="control-label" for="basicinput">Password</label>
											<div class="controls">
												<input type="text" name="password" id="basicinput" value="<%=emp.getPassWord() %>" class="span8">
											</div>
										</div>
										
										<div class="control-group">
											<label class="control-label" for="basicinput">Remark</label>
											<div class="controls">
												<textarea name="remark" class="span8"><%=emp.getRemark() %></textarea>
											</div>
										</div>
										
										<div class="control-group">
												<div class="controls">
													<button type="button" class="btn" onclick="dealt()">Modify</button>
												</div>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
            </div>
        </div>

		<script type="text/javascript">
			function dealt(){
				sno=document.message.sno.value;
				dno=document.message.dno.value;
				name=document.message.name.value;
				birth=document.message.birth.value;
				id=document.message.id.value;
				tel=document.message.tel.value;
				loc=document.message.loc.value;
				job=document.message.job.value;
				hire=document.message.hire.value;
				sal=document.message.sal.value;
				password=document.message.password.value;
				
				if(sno==""||dno==""||name==""||birth==""||id==""||password==""
						||tel==""||loc==""||job==""||hire==""||sal==""){
					alert("Information cannot be empty!");
					return ;
				}
				
				number = "0123456789";
				for (i = 0; i < sno.length;i++) {
					c = sno.charAt(i);
					if (number.indexOf(c) == -1) {
						alert("StaffNO must be number!");
						return ;
					}
				}
				
				for (i = 0; i < dno.length;i++) {
					c = dno.charAt(i);
					if (number.indexOf(c) == -1) {
						alert("DepartmentNO must be number!");
						return ;
					}
				}
				
				for (i = 0; i < sal.length;i++) {
					c = sal.charAt(i);
					if (number.indexOf(c) == -1) {
						alert("Salary must be number!");
						return ;
					}
				}
				
				message.submit();
			}
		</script>
		
        <script src="scripts/jquery-1.9.1.min.js" type="text/javascript"></script>
        <script src="scripts/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>
        <script src="bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="scripts/flot/jquery.flot.js" type="text/javascript"></script>
        <script src="scripts/flot/jquery.flot.resize.js" type="text/javascript"></script>
        <script src="scripts/datatables/jquery.dataTables.js" type="text/javascript"></script>
        <script src="scripts/common.js" type="text/javascript"></script>
	</body>
</html>