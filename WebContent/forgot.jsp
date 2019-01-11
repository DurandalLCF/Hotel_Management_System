<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="no-js">
	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>Forgot Password</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="Free HTML5 Template by FreeHTML5.co" />
	<meta name="keywords" content="free html5, free template, free bootstrap, html5, css3, mobile first, responsive" />
	
	<link rel="stylesheet" href="css/bootstrap.min.css">
	<link rel="stylesheet" href="css/animate.css">
	<link rel="stylesheet" href="css/style.css">

	<script src="js/modernizr-2.6.2.min.js"></script>
	<script type="text/javascript">
		function dealt(){
			name=document.message.name.value;
			num=document.message.number.value;
			id=document.message.ID.value;
			pass=document.message.pass
			
			if(name==""){
				alert("Please input your Name.");
				return ;
			}
			if(num==""){
				alert("Please input your Employee-Number.");
				return ;
			}
			if(id==""){
				alert("Please input your ID-Card-No.");
				return ;
			}
			if(pass==""){
				alert("Please input your New Password.")
			}
			message.submit();
		}
	</script>
	</head>
	<body>
		<div class="container">
			<div class="row">
				<div class="col-md-4 col-md-offset-4">
					<!-- Start Sign In Form -->
					<br><br><br>
					<form action="Load_Forget.jsp" name="message" class="fh5co-form animate-box" data-animate-effect="fadeIn">
						<h2>Forgot Password</h2>
						<br>
						<div class="form-group">
							<input type="text" class="form-control" name="username" placeholder="Name" autocomplete="off">
						</div>
						<div class="form-group">
							<input type="text" class="form-control" name="number" placeholder="Employee Number" autocomplete="off">
						</div>
						<div class="form-group">
							<input type="text" class="form-control" name="ID" placeholder="ID Card No" autocomplete="off">
						</div>
						<div class="form-group">
							<input type="text" class="form-control" name="password" placeholder="New Password" autocomplete="off">
						</div>
						<div class="form-group">
							<p><a href="load.jsp">Sign In</a></p>
						</div>
						<div class="form-group">
							<input type="button" value="Submit" onclick="dealt()" class="btn btn-primary">
						</div>
					</form>
				</div>
			</div>
		</div>
	
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/jquery.placeholder.min.js"></script>
	<script src="js/jquery.waypoints.min.js"></script>
	<script src="js/main.js"></script>

	</body>
</html>

