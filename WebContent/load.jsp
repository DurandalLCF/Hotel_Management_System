<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html> 
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Loading</title>

	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="Free HTML5 Template by FreeHTML5.co" />
	<meta name="keywords" content="free html5, free template, free bootstrap, html5, css3, mobile first, responsive" />
	
	<link rel="shortcut icon" href="favicon.ico">
	<link href='https://fonts.googleapis.com/css?family=Open+Sans:400,700,300' rel='stylesheet' type='text/css'>
	<link rel="stylesheet" href="css/bootstrap.min.css">
	<link rel="stylesheet" href="css/animate.css">
	<link rel="stylesheet" href="css/style.css">

	<script type="text/javascript">
		function dealt(){
			number=document.message.number.value;
			pass=document.message.password.value;
			
			if(number==""){
				alert("Please input your Empnumber.");
				return ;
			}
			if(pass==""){
				alert("Please input your password.");
				return ;
			}
			message.submit();
		}
	</script>
	</head>
	<body>
		<div class="container">
			<div class="row">
				<div class="col-md-4 col-md-offset-4">
					<br><br><br>
					<form action="Load_Forget.jsp" name="message" class="fh5co-form animate-box" data-animate-effect="fadeIn">
						<h2>Sign In</h2>
						<br>
						<div class="form-group">
							<input type="text" class="form-control" name="number" placeholder="Employee Number" autocomplete="off">
						</div>
						<div class="form-group">
							<input type="password" class="form-control" name="password" placeholder="Password" autocomplete="off">
						</div>
						<div class="form-group">
							<p><a href="forgot.jsp">Forgot Password?</a></p>
						</div>
						<div class="form-group">
							<input type="button" value="Sign In" onclick="dealt()" class="btn btn-primary">
						</div>
					</form>
				</div>
			</div>
		</div>
	
	<!-- jQuery -->
	<script src="js/jquery.min.js"></script>
	<!-- Bootstrap -->
	<script src="js/bootstrap.min.js"></script>
	<!-- Placeholder -->
	<script src="js/jquery.placeholder.min.js"></script>
	<!-- Waypoints -->
	<script src="js/jquery.waypoints.min.js"></script>
	<!-- Main JS -->
	<script src="js/main.js"></script>
	<script src="js/modernizr-2.6.2.min.js"></script>
	</body>
</html>