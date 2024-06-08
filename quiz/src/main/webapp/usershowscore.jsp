
<%@page import="java.sql.*"%>
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
<script src="https://use.fontawesome.com/releases/v5.15.4/js/all.js"
	crossorigin="anonymous"></script>
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700"
	rel="stylesheet" type="text/css" />
<link
	href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic"
	rel="stylesheet" type="text/css" />
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet" />
<link href="css/index-styles.css" rel="stylesheet" />
<style>
.equal-width td {
	width: 50%;
}
</style>
</head>
<body id="page-top" class="d-flex flex-column min-vh-100">
	<!-- Add d-flex and flex-column classes to make the body a flex container and set its flex-direction to column -->
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
						class="nav-link py-3 px-0 px-lg-3 rounded" href="./user.jsp">Home</a></li>
					<li class="nav-item mx-0 mx-lg-1"><a
						class="nav-link py-3 px-0 px-lg-3 rounded" href="./givequiz.jsp">Give
							Quiz</a></li>
					<li class="nav-item mx-0 mx-lg-1"><a
						class="nav-link py-3 px-0 px-lg-3 rounded"
						href="./usershowscore.jsp">Show Score</a></li>
					<li class="nav-item mx-0 mx-lg-1"><a
						class="nav-link py-3 px-0 px-lg-3 rounded"
						href="./userchangepass.jsp">Change Password</a></li>
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
	<br>
	<div>
		<h2 class="text-center">Quiz History</h2>
		<!-- <div>
			<table id="tbl-student" class="table table-bordered text-center"> -->
		<div class="container">
			<table id="tbl-student"
				class="table table-bordered equal-width text-center">
				<thead>
					<tr>
						<th>Quiz Name</th>
						<th>Score(Out of 5)</th>
					</tr>
				</thead>
				<tbody>
					<%
					Connection con = null;
					PreparedStatement pst = null;
					ResultSet rs = null;
					ResultSet rs1 = null;
					int userId = (int) request.getSession().getAttribute("id");

					try {
						Class.forName("com.mysql.cj.jdbc.Driver");
						con = DriverManager.getConnection("jdbc:mysql://localhost:3306/quizapp?useSSL=false", "root", "123");

						pst = con.prepareStatement("SELECT score, quiz_id FROM quiz_attempts WHERE user_id = ?");
						pst.setInt(1, userId);
						rs = pst.executeQuery();

						while (rs.next()) {
							int quiz_id = rs.getInt("quiz_id");
							String score = rs.getString("score");

							PreparedStatement pst1 = con.prepareStatement("SELECT quiz_name FROM quizzes WHERE quiz_id = ?");
							pst1.setInt(1, quiz_id);
							rs1 = pst1.executeQuery();

							if (rs1.next()) {
						String quiz_name = rs1.getString("quiz_name");
					%>
					<tr>
						<td><%=quiz_name%></td>
						<td><%=score%></td>
					</tr>
					<%
					}
					rs1.close();
					pst1.close();
					}
					} catch (Exception e) {
					e.printStackTrace();
					} finally {
					if (rs != null)
					try {
					rs.close();
					} catch (SQLException e) {
					e.printStackTrace();
					}
					if (rs1 != null)
					try {
					rs1.close();
					} catch (SQLException e) {
					e.printStackTrace();
					}
					if (pst != null)
					try {
					pst.close();
					} catch (SQLException e) {
					e.printStackTrace();
					}
					if (con != null)
					try {
					con.close();
					} catch (SQLException e) {
					e.printStackTrace();
					}
					}
					%>
				</tbody>
			</table>
		</div>
	</div>

	<!-- Footer-->
	<div class="fixed-bottom">
		<footer class="footer mt-auto py-4 text-center text-white ">
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
					</div>
					<div class="col-lg-4">
						<h4 class="text-uppercase mb-4">About Quiz App</h4>
						<p class="lead mb-0">This is free to use.</p>
					</div>
				</div>
			</div>
		</footer>
		<div class="copyright py-4 text-center text-white">
			<small>Copyright &copy; Quiz App 2024</small>
		</div>
	</div>
	<script>
		$(document).ready(function() {
			$(".dropdown-toggle").dropdown();
		});
	</script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
	<script src="js/scripts.js"></script>
	<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>

