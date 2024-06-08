<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Quiz App</title>
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700"
	rel="stylesheet" type="text/css" />
<link
	href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic"
	rel="stylesheet" type="text/css" />
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<link href="css/index-styles.css" rel="stylesheet" />
</head>

<body id="page-top" class="d-flex flex-column min-vh-100" onLoad = showDialog()> <!-- Add d-flex and flex-column classes to make the body a flex container and set its flex-direction to column -->
	<input type="text" id="status" value="<%= request.getAttribute("status")%>">
	<!-- Navigation-->
	<nav
		class="navbar navbar-expand-lg bg-secondary text-uppercase fixed-top"
		id="mainNav">
		<div class="container">
			<a class="navbar-brand" href="#page-top">Quiz App</a>
			<button
				class="navbar-toggler text-uppercase font-weight-bold bg-primary text-white rounded"
				type="button" data-bs-toggle="collapse"
				data-bs-target="#navbarResponsive" aria-controls="navbarResponsive"
				aria-expanded="false" aria-label="Toggle navigation">
				Menu <i class="fas fa-bars"></i>
			</button>
			<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav ms-auto">
					<li class="nav-item mx-0 mx-lg-1"><a
						class="nav-link py-3 px-0 px-lg-3 rounded" href="./index.jsp">Home</a></li>
					<li class="nav-item mx-0 mx-lg-1"><a
						class="nav-link py-3 px-0 px-lg-3 rounded" href="./manageuser.jsp">Manage
							User</a></li>
					<!-- Replace this list item with the dropdown submenu -->
					<li class="nav-item dropdown nav-item mx-0 mx-lg-1"><a
						class="nav-link dropdown-toggle nav-link py-3 px-0 px-lg-3"
						href="#" id="navbarDropdownDashboard" role="button"
						data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							Dashboard </a>
						<div class="dropdown-menu"
							aria-labelledby="navbarDropdownDashboard">
							<a class="dropdown-item font-weight-bold" href="./managequiz.jsp">Manage Quiz</a>
							<a class="dropdown-item font-weight-bold" href="./managequestion.jsp">Manage
								Question</a> <a class="dropdown-item font-weight-bold" href="./showscore.jsp">Show
								Score</a>
						</div></li>
					<!-- End of dropdown submenu -->
					<li class="nav-item mx-0 mx-lg-1"><a
						class="nav-link py-3 px-0 px-lg-3 rounded" href="./changepass.jsp">Change
							Password</a></li>
					<li class="nav-item mx-0 mx-lg-1"><a
						class="nav-link py-3 px-0 px-lg-3 rounded" href="Logout">Logout</a></li>
				</ul>
			</div>

		</div>
	</nav>
	<br>
	<br>
	<br>
	<br>
	<br>
	
	<div class="p-3">
	
	 	<h2>Manage Quiz</h2>
   		 	<form method="post" action="manageQuizServlet" class="managequiz-form"
							id="managequiz-form">
				<div class="form-group">
					<label for="category"><i class="zmdi zmdi-account"></i>Quiz Category: </label> 
					<input type="text" name="quizCategory" id="quizCategory" placeholder="Quiz Category" required="required"/>
				</div>
				<div class="form-group">
					<label for="name"><i class="zmdi zmdi-account"></i>Quiz Name: </label> 
					<input type="text" name="quizName" id="quizName" placeholder="Quiz Name" required="required"/>
				</div>
        		<div class="form-group form-button">
					<input type="submit" class="form-submit bg-primary rounded" value="Submit" />
				</div>
			</form>
	</div>
    
    
	<!-- Footer-->
	<footer class="footer mt-auto py-4 text-center text-white">
		<div class="container">
			<div class="row">
				<!-- Footer Location-->
				<div class="col-lg-4 mb-5 mb-lg-0">
					<h4 class="text-uppercase mb-4">Location</h4>
					<p class="lead mb-0">
						Andheri West <br /> Mumbai, 400058
					</p>
				</div>
				<!-- Footer Social Icons-->
				<div class="col-lg-4 mb-5 mb-lg-0">
					<h4 class="text-uppercase mb-4">Around the Web</h4>
					<a class="btn btn-outline-light btn-social mx-1" href="#!"><i
						class="fab fa-fw fa-facebook-f"></i></a> <a
						class="btn btn-outline-light btn-social mx-1" href="#!"><i
						class="fab fa-fw fa-twitter"></i></a> <a
						class="btn btn-outline-light btn-social mx-1" href="#!"><i
						class="fab fa-fw fa-linkedin-in"></i></a>
					<!-- <a
						class="btn btn-outline-light btn-social mx-1" href="#!"><i
						class="fab fa-fw fa-dribbble"></i></a> -->
				</div>
				<!-- Footer About Text-->
				<div class="col-lg-4">
					<h4 class="text-uppercase mb-4">About Quiz App</h4>
					<p class="lead mb-0">This is free to use.</p>
				</div>
			</div>
		</div>
	</footer>
	<!-- Copyright Section-->
	<div class="copyright py-4 text-center text-white">
		<div class="container">
			<small>Copyright &copy; Quiz App 2024</small>
		</div>
	</div>
	<script type="text/javascript">
	function showDialog(){
		var status = document.getElementById("status").value;
		if(status=="success")
		{
			swal("Congratulation", "Data Added Successfully", "success");
		}
		if(status=="invalidCategory")
		{
			swal("Sorry", "Please Enter Quiz Category", "error");
		}
		if(status=="invalidName")
		{
			swal("Sorry", "Please Enter Quiz Name", "error");
		}
			$(document).ready(function() {
				$('.dropdown-toggle').dropdown();
			});
	}

	</script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<script src="https://use.fontawesome.com/releases/v5.15.4/js/all.js"
	crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
	<script src="js/scripts.js"></script>
	<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="js/main.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" href="alert/dist/sweetalert.css">
</body>
</html>
