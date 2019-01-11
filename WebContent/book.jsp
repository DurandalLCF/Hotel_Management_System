<%@page import="type.Datecompare"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="type.Desc"%>
<%@page import="database.RoomstatueDao"%>
<%@page import="database.DescDao"%>
<%@page import="type.Room"%>
<%@page import="java.util.ArrayList"%>
<%@page import="database.RoomDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Modify Room</title>
        <link type="text/css" href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link type="text/css" href="bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet">
        <link type="text/css" href="css/theme.css" rel="stylesheet">
        <link type="text/css" href="images/icons/css/font-awesome.css" rel="stylesheet">
        <link type="text/css" href='http://fonts.googleapis.com/css?family=Open+Sans:400italic,600italic,400,600'
            rel='stylesheet'>
    </head>
    <body>
    <script type="text/javascript">
    	function dealt(){
			check=document.getElementsByName("roomch");
		    value = new Array();
		    for(i = 0; i < check.length; i++){
				if(check[i].checked)
		     		value.push(check[i].value);
		    }
		    
		    if(value.length==0){
		    	alert("NOTHING SELECTED!");
		    	return;
		    }
		    
		    
		    message.submit();
    	}
    	function checkroom(){
    		indate=document.livedate.indate.value;
    		outdate=document.livedate.outdate.value;
    		
    		if(indate=="" || outdate==""){
    			alert("Please choose the date!");
    			return;
    		}
    		
    		livedate.submit();
    	}
    </script>
    <% 
    	String indate = request.getParameter("indate");
    	String outdate = request.getParameter("outdate");
    	ArrayList<Room> rooms = new ArrayList<Room>();
    	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
    	Calendar calendar = new GregorianCalendar();
    	
    	boolean flag;
    	if(indate==null || outdate==null){
    		Date date=new Date();//取时间
    		calendar.setTime(date);
    		indate = formatter.format(date);
    		calendar.add(calendar.DATE,1);//把日期往后增加一天.整数往后推,负数往前移动
    		date=calendar.getTime(); //这个时间就是日期往后推一天的结果 
    		outdate = formatter.format(date);
    	}
    	else{
    		Datecompare comp=new Datecompare();
    		Date date=new Date();//取时间
    		String today=formatter.format(date);
    		
    		if(comp.compare(indate, outdate)!=1){%>
    		<script type="text/javascript">
					alert("Check-in time must be earlier than check-out time!");
			</script>
    		<%
    			calendar.setTime(date);
	    		indate = formatter.format(date);
	    		calendar.add(calendar.DATE,1);//把日期往后增加一天.整数往后推,负数往前移动
	    		date=calendar.getTime(); //这个时间就是日期往后推一天的结果 
	    		outdate = formatter.format(date);
    		}
    		else if(comp.compare(today, indate)<0){%>
    		<script type="text/javascript">
					alert("Check-in time can not be earlier than today!");
			</script>
    		<%
    			indate = formatter.format(date);
    		}
    	}
    	
   		RoomstatueDao statueDao = new RoomstatueDao();
   		//out.print(indate+"    "+outdate+"<br>");
   		ArrayList<Integer> choose = statueDao.CheckByDate(indate, outdate);
   		/* for(int i=0;i<choose.size();i++)
   			out.print(choose.get(i)+"  "); */
   		
   		RoomDao roomDao = new RoomDao();
   		ArrayList<Room> tmprooms = roomDao.SelectAll();
   		rooms = new ArrayList<Room>();
   		
   		session.setAttribute("indate", indate);
   		session.setAttribute("outdate", outdate);
   		
   		for(int i=0;i<tmprooms.size();i++)
   			for(int j=0;j<choose.size();j++)
   				if(tmprooms.get(i).getRoomNo()==choose.get(j)){
   					rooms.add(tmprooms.get(i));
   				}
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
									<h3>Choose Date</h3>
								</div>
								<div class="module-body">
								<form action="book.jsp" name="livedate" class="form-horizontal row-fluid">
								<table>
									<tbody>
									<tr><td>
										<label class="control-label" for="basicinput">In Date</label>
										<div class="controls">
											<input type="date" name="indate" class="span12" value="<%=indate %>">
										</div></td><td>
										<label class="control-label" for="basicinput">Out Date</label>
										<div class="controls">
											<input type="date" name="outdate" class="span12" value="<%=outdate %>">
										</div></td></tr>
										</tbody>
								</table><br>
								    <div class="control-group">
											<div class="controls">
												<button type="button" class="btn" onclick="checkroom()">Check</button>
											</div>
									</div>
								</form>
								</div>
							
								<div class="module-head">
									<h3>Choose Room</h3>
								</div>
								<div class="module-body">
								<form action="Bill.jsp" name="message">
									<table class="table">
									  <thead>
										<tr>
										  <th>#</th>
										  <th>Choose</th>
										  <th>Type</th>
										  <th>Price</th>
										  <th>Name-one</th>
										  <th>ID-one</th>
										  <th>Name-two</th>
										  <th>ID-two</th>
										</tr>
									  </thead>
									  <tbody><% for(int i=0;i<rooms.size();i++){
									  				Room tmp=rooms.get(i);
									  				DescDao descDao = new DescDao();
									  				Desc desctmp = descDao.selectOne(""+tmp.getTypeNo());%>
										<tr><td><%=tmp.getRoomNo() %></td>
										  <td><input name="roomch" type="checkbox" value="<%=tmp.getRoomNo() %>"></td>
										  <td><%=desctmp.getTypename() %></td>
										  <td><%=desctmp.getPrice() %></td>
										  <td><div class="controls">
												<input type="text" name="nameone<%=tmp.getRoomNo() %>" placeholder="Name-one" style="width: 65px; ">
										  </div></td>
										  <td><div class="controls">
												<input type="text" name="idone<%=tmp.getRoomNo() %>" placeholder="ID-one" style="width: 65px; ">
										  </div></td>
										  <td><div class="controls">
												<input type="text" name="nametwo<%=tmp.getRoomNo() %>" placeholder="Name-two" style="width: 65px; ">
										  </div></td>
										  <td><div class="controls">
												<input type="text" name="idtwo<%=tmp.getRoomNo() %>" placeholder="ID-two" style="width: 65px; ">
										  </div></td>
										</tr><%} %>
									  </tbody>
									</table>
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

        <script src="scripts/jquery-1.9.1.min.js" type="text/javascript"></script>
        <script src="scripts/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>
        <script src="bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="scripts/flot/jquery.flot.js" type="text/javascript"></script>
        <script src="scripts/flot/jquery.flot.resize.js" type="text/javascript"></script>
        <script src="scripts/datatables/jquery.dataTables.js" type="text/javascript"></script>
        <script src="scripts/common.js" type="text/javascript"></script>
        </body>
</html>