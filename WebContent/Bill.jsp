<%@page import="type.Live"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Finish Message</title>
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
	String[] room=request.getParameterValues("roomch");
	String roomnum=null,name1=null,name2=null,id1=null,id2=null,date=null;
	ArrayList<Live> live=new ArrayList<Live>();
	
	for(int i=0;i<room.length;i++){
		roomnum=room[i];
		name1=request.getParameter("nameone"+roomnum);
		id1=request.getParameter("idone"+roomnum);
		name2=request.getParameter("nametwo"+roomnum);
		id2=request.getParameter("idtwo"+roomnum);
		date=request.getParameter("date"+roomnum);
		
		if(name1==""){
			if(name2==""){ %>
			<script type="text/javascript">
				alert("At least fill in one name!");
				window.history.back(-1); 
			</script>
		<% } 
		}
		
		else if(id2==""){
			if(id1==""){ %>
			<script type="text/javascript">
				alert("At least fill in one id!");
				window.history.back(-1); 
			</script>
		<% }
		} 
		
		Live tmp=new Live(Integer.parseInt(roomnum),id1,date,name1);
		live.add(tmp);
		tmp=new Live(Integer.parseInt(roomnum),id2,date,name2);
		live.add(tmp);
	}
	session.setAttribute("live", live);
	
	String indate=(String)session.getAttribute("indate");
	String outdate=(String)session.getAttribute("outdate");
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
									<h3>Client Message</h3>
								</div>
								<div class="module-body">
									<form class="form-horizontal row-fluid" name="message" action="servlet/CheckIn" method="post">																		
										<div class="control-group">
											<label class="control-label" for="basicinput">Client Name</label>
											<div class="controls">
												<input type="text" name="name" id="basicinput" placeholder="name" class="span8">
											</div>
										</div>
										
										<div class="control-group">
											<label class="control-label">Sex</label>
											<div class="controls">
												<label class="radio">
													<input type="radio" name="sex" value="man" checked>Man
												</label> 
												<label class="radio">
													<input type="radio" name="sex" value="woman">Woman
												</label>
											</div>
										</div>
										
										<div class="control-group">
											<label class="control-label" for="basicinput">Birthday</label>
											<div class="controls">
												<input type="date" name="birth" class="span8">
											</div>
										</div>
										
										<div class="control-group">
											<label class="control-label" for="basicinput">ID Number</label>
											<div class="controls">
												<input type="text" name="id" id="basicinput" placeholder="ID Number" class="span8">
											</div>
										</div>
										
										<div class="control-group">
											<label class="control-label" for="basicinput">Telephone</label>
											<div class="controls">
												<input type="text" name="tel" id="basicinput" placeholder="Telephone" class="span8">
											</div>
										</div>
										
										<div class="control-group">
											<label class="control-label" for="basicinput">Check In Date</label>
											<div class="controls">
												<input type="date" name="indate" class="span8" value="<%=indate %>" readonly="readonly">
											</div>
										</div>
										
										<div class="control-group">
											<label class="control-label" for="basicinput">Check Out Date</label>
											<div class="controls">
												<input type="date" name="outdate" class="span8" value="<%=outdate %>" readonly="readonly">
											</div>
										</div>
										
										<div class="control-group">
											<label class="control-label" for="basicinput">Remark</label>
											<div class="controls">
												<textarea name="remark" placeholder="Remark" class="span8"></textarea>
											</div>
										</div>
										
										<div class="control-group">
											<label class="control-label" for="basicinput">Selected Room</label>
											<div class="controls">
												<table class="table">
													<tr>
													  <%for(int i=0;i<room.length;i++){%>
														<td><input type="text" value="<%=room[i] %>" style="width: 75px;" disabled></td>
													  <%if(i!=0 && i%4==0){%>
															</tr><tr>
														<%}
													}%>
													</tr>
												</table>
											</div>
										</div>	
										
										<div class="control-group">
												<div class="controls">
													<button type="button" class="btn" onclick="dealt()">Submit</button>
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
				name=document.message.name.value;
				birth=document.message.birth.value;
				id=document.message.id.value;
				tel=document.message.tel.value;
				
				if(name=="" || birth=="" || id=="" || tel==""){
					alert("Please improve the information.");
					return ;
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