<%@page import="database.ClientDao"%>
<%@page import="database.BillDao"%>
<%@page import="type.Bill"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Paid</title>
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
	BillDao billDao = new BillDao();
	ArrayList<Bill> bills=billDao.SelectAll();
	ClientDao clientDao = new ClientDao();
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
									<h3>Paid</h3>
								</div>
								<div class="module-body table">
								<table class="datatable-1 table table-bordered table-striped display" >
									<thead>
										<tr>
										  <th>BillNO</th>
										  <th>EmpNO</th>
										  <th>ClientName</th>
										  <th>RoomCost</th>
										  <th>OtherCost</th>
										  <th>Operate</th>
										</tr>
									</thead>
									<tbody>
									<% for(int i=0;i<bills.size();i++){ 
											Bill tmp=bills.get(i);%>
										<tr>
										  <td><%=tmp.getBillNo() %></td>
										  <td><%=tmp.getEmployeeNo() %></td>
										  <td><%=clientDao.selectOne(""+tmp.getClientNo()).getClientName() %></td>
										  <td><%=tmp.getRoomCost() %></td>
										  <td><%=tmp.getOtherCost() %></td>
										  <td><a href="paiddetail.jsp?billno=<%=tmp.getBillNo() %>">Detail</a></td>
										</tr>
									<% } %>
									</tbody>
								</table>
							    </div>
							</div>
					    </div>							
                   </div>			

                 </div>
            </div>
        </div>

        <script src="scripts/jquery-1.9.1.min.js" type="text/javascript"></script>
        <script src="scripts/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>
        <script src="bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="scripts/flot/jquery.flot.js" type="text/javascript"></script>
        <script src="scripts/flot/jquery.flot.resize.js" type="text/javascript"></script>
        <script src="scripts/datatables/jquery.dataTables.js" type="text/javascript"></script>
        <script src="scripts/common.js" type="text/javascript"></script>
</body>
</html>