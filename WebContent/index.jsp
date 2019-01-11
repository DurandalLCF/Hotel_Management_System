<%@page import="database.RoomstatueDao"%>
<%@page import="type.Room"%>
<%@page import="database.RoomDao"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="database.DescDao"%>
<%@page import="type.Desc"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Index</title>
        <link type="text/css" href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link type="text/css" href="bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet">
        <link type="text/css" href="css/theme.css" rel="stylesheet">
        <link type="text/css" href="images/icons/css/font-awesome.css" rel="stylesheet">
        <link type="text/css" href='http://fonts.googleapis.com/css?family=Open+Sans:400italic,600italic,400,600'
            rel='stylesheet'>
    </head>
    <body>
    <%
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
		Date date=new Date();//取时间
		Calendar calendar = new GregorianCalendar();
		calendar.setTime(date);
		String today = formatter.format(date);
		calendar.add(calendar.DATE,1);//把日期往后增加一天.整数往后推,负数往前移动
		date=calendar.getTime(); //这个时间就是日期往后推一天的结果 
		String tomorrow = formatter.format(date);
		
		RoomDao roomDao = new RoomDao();
		ArrayList<Room> rooms = roomDao.SelectAll();
		
		RoomstatueDao statueDao = new RoomstatueDao();
		ArrayList<Integer> tmp = statueDao.CheckByDate(today, tomorrow);
		int num1=0,num2=0,num3=0;
		for(int i=0;i<tmp.size();i++)
			for(int j=0;j<rooms.size();j++){
				if(tmp.get(i)==rooms.get(j).getRoomNo()){
					if(rooms.get(j).getTypeNo()==0)
						num1++;
					else if(rooms.get(j).getTypeNo()==1)
						num2++;
					else
						num3++;
				}
			}
		
    	DescDao descDao = new DescDao();
    	ArrayList<Desc> descs = descDao.SelectAll();
    	float pre0=(num1*1.0f)/descs.get(0).getGross()*100;
    	float pre1=(num2*1.0f)/descs.get(1).getGross()*100;
    	float pre2=(num3*1.0f)/descs.get(2).getGross()*100;
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
                            <div class="btn-controls">
                                <div class="btn-box-row row-fluid">
                                    <a href="morroomtype.jsp?No=0" class="btn-box big span4"><i class="icon-user"></i><b>
                                    <%=descs.get(0).getPrice() %></b>
                                        <p class="text-muted">Single Room</p>
                                    </a><a href="morroomtype.jsp?No=1" class="btn-box big span4"><i class="icon-exchange"></i><b>
									<%=descs.get(1).getPrice() %></b>
                                        <p class="text-muted">Twin Beds Room</p>
                                    </a><a href="morroomtype.jsp?No=2" class="btn-box big span4"><i class="icon-group"></i><b>
                                    <%=descs.get(2).getPrice() %></b>
                                        <p class="text-muted">Double Room</p>
                                    </a>
                                </div>
                                <div class="btn-box-row row-fluid">
                                	<span class="btn-box big span4"><b>
									<%=num1 %></b>
                                        <p><strong>Single Room</strong>
                                        </p><div class="progress tight">
                                            <div class="bar" style="width: <%=pre0 %>%;"></div>
                                        </div>
                                    </span><span class="btn-box big span4"><b>
                                    <%=num2 %></b>
                                        <p><strong>Twin Beds Room</strong>
                                        </p><div class="progress tight">
                                            <div class="bar bar-success" style="width: <%=pre1 %>%;"></div>
                                        </div>
                                    </span><span class="btn-box big span4"><b>
                                    <%=num3 %></b>
                                        <p><strong>Double Room</strong>
                                        </p><div class="progress tight">
                                            <div class="bar bar-warning" style="width: <%=pre2 %>%;"></div>
                                        </div>
                                    </span>
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