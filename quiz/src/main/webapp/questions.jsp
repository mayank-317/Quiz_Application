<%@page import="java.sql.*"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.logging.*"%>
<%
// Establish connection
Logger logger = Logger.getLogger("QuizLogger");
Connection con;
PreparedStatement pst;
ResultSet rs;
Class.forName("com.mysql.cj.jdbc.Driver");
con = DriverManager.getConnection("jdbc:mysql://localhost:3306/quizapp?useSSL=false", "root", "123");

String quizName = request.getParameter("quizName");
String action = request.getParameter("action");

// Get quiz ID
PreparedStatement pst_quizId = con.prepareStatement("select quiz_id from quizzes where quiz_name = ?");
pst_quizId.setString(1, quizName);
ResultSet rs_quizId = pst_quizId.executeQuery();
int quiz_id = -1;
if (rs_quizId.next()) {
	quiz_id = rs_quizId.getInt("quiz_id");
}

if ("submit".equals(action)) {
	// If form is submitted, calculate the score
	int questionCount = Integer.parseInt(request.getParameter("question_count"));
	int score = 0;

	// Retrieve correct answers from the database
	pst = con.prepareStatement("SELECT question_id, correct_option FROM questions WHERE quiz_id=?");
	pst.setInt(1, quiz_id);
	rs = pst.executeQuery();
	Map<Integer, String> correctOptions = new HashMap<>();
	while (rs.next()) {
		int questionId = rs.getInt("question_id");
		String correctOption = rs.getString("correct_option");
		correctOptions.put(questionId, correctOption);
	}

	// Compare selected answers with correct answers
	for (int i = 1; i <= questionCount; i++) {
		String selectedOption = request.getParameter("hiddenAnswer" + i);
		logger.info("selectedOption for Question " + i + ": " + selectedOption);
		String correctOption = correctOptions.get(i);
		logger.info("Correct Option for Question " + i + ": " + correctOption);

		if (selectedOption != null && selectedOption.equals(correctOption)) {
	score++;
		}
	}

	int userId = (int) request.getSession().getAttribute("id");
	pst = con.prepareStatement("INSERT INTO quiz_attempts (user_id, quiz_id, score) VALUES (?, ?, ?)");
	pst.setInt(1, userId);
	pst.setInt(2, quiz_id);
	pst.setInt(3, score);
	pst.executeUpdate();

	// Display the score
%>
<br>
<br>
<br>
<br>
<br>
<br>
<h2>Your Quiz Score</h2>
<p>
	Total Questions:
	<%=questionCount%></p>
<p>
	Correct Answers:
	<%=score%></p>
<p>
	Incorrect Answers:
	<%=questionCount - score%></p>
<%
} else {
// If form is not submitted, display the quiz
pst = con.prepareStatement("select * from questions where quiz_id = ?");
pst.setInt(1, quiz_id);
rs = pst.executeQuery();
int questionNumber = 1;
%>
<br>
<br>
<br>
<br>
<br>
<br>
<form method="POST" action="questions.jsp">
	<input type="hidden" name="quizName" value="<%=quizName%>"> <input
		type="hidden" name="action" value="submit">
	<%
	while (rs.next()) {
	%>
	<div id="question<%=questionNumber%>" class="question">
		<h3>
			Question
			<%=questionNumber%></h3>
		<p><%=rs.getString("question_text")%></p>
		<input type="radio" name="answer<%=questionNumber%>" value="1"
			onclick="saveAnswer(<%=questionNumber%>, 1)">
		<%=rs.getString("option1")%><br> <input type="radio"
			name="answer<%=questionNumber%>" value="2"
			onclick="saveAnswer(<%=questionNumber%>, 2)">
		<%=rs.getString("option2")%><br> <input type="radio"
			name="answer<%=questionNumber%>" value="3"
			onclick="saveAnswer(<%=questionNumber%>, 3)">
		<%=rs.getString("option3")%><br> <input type="radio"
			name="answer<%=questionNumber%>" value="4"
			onclick="saveAnswer(<%=questionNumber%>, 4)">
		<%=rs.getString("option4")%><br> <input type="hidden"
			id="hiddenAnswer<%=questionNumber%>"
			name="hiddenAnswer<%=questionNumber%>">
	</div>
	<%
	questionNumber++;
	}
	%>
	<input type="hidden" name="question_count"
		value="<%=questionNumber - 1%>">
	<button type="button" id="prevBtn" onclick="prevQuestion()"
		class="btn btn-secondary btn-sm">Previous</button>
	<button type="button" id="nextBtn" onclick="nextQuestion()"
		class="btn btn-primary btn-sm">Next</button>
	<button type="submit" id="submitBtn" style="display: none;"
		class="btn btn-info btn-sm">Submit</button>
</form>

<script>
            var currentQuestion = 1;
            showQuestion(currentQuestion);

            function showQuestion(n) {
                var questions = document.getElementsByClassName("question");
                if (n < 1) { currentQuestion = 1; }
                if (n > questions.length) { currentQuestion = questions.length; }
                for (var i = 0; i < questions.length; i++) {
                    questions[i].style.display = "none";
                }
                questions[currentQuestion - 1].style.display = "block";
                if (currentQuestion === 1) {
                    document.getElementById("prevBtn").style.display = "none";
                } else {
                    document.getElementById("prevBtn").style.display = "inline";
                }
                if (currentQuestion === questions.length) {
                    document.getElementById("nextBtn").style.display = "none";
                    document.getElementById("submitBtn").style.display = "inline";
                } else {
                    document.getElementById("nextBtn").style.display = "inline";
                    document.getElementById("submitBtn").style.display = "none";
                }
            }

            function prevQuestion() {
                showQuestion(currentQuestion -= 1);
            }

            function nextQuestion() {
                showQuestion(currentQuestion += 1);
            }

            function saveAnswer(questionNumber, selectedOption) {
                document.getElementById("hiddenAnswer" + questionNumber).value = selectedOption;
            }
        </script>
<%
}
%>

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
</body>
</html>
