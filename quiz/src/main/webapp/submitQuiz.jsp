<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quiz Result</title>
</head>
<body>
    <h2>Quiz Result</h2>
    <%
    // Retrieve the number of questions from the URL parameter
    int numQuestions = Integer.parseInt(request.getParameter("numQuestions"));
    String[] answers = new String[numQuestions]; // Initialize answers array

    // Retrieve answers submitted by the user
    for (int i = 1; i <= numQuestions; i++) {
        answers[i - 1] = request.getParameter("answer" + i);
    }

    // Connect to the database and process the quiz results
    Connection con = null;
    PreparedStatement pst = null;
    ResultSet rs = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/quizapp?useSSL=false", "root", "123");

        // Retrieve quizId based on the quizName parameter
        String quizName = request.getParameter("quizName");
        PreparedStatement pst_quizId = con.prepareStatement("SELECT quiz_id FROM quizzes WHERE quiz_name = ?");
        pst_quizId.setString(1, quizName);
        ResultSet rs_quizId = pst_quizId.executeQuery();
        int quizId = -1;
        if (rs_quizId.next()) {
            quizId = rs_quizId.getInt("quiz_id");
        }

        // Retrieve correct answers from the database
        pst = con.prepareStatement("SELECT correct_option FROM questions WHERE quiz_id = ?");
        pst.setInt(1, quizId);
        rs = pst.executeQuery();

        int correctAnswersCount = 0;
        int questionIndex = 0;
        while (rs.next() && questionIndex < numQuestions) {
            String correctAnswer = rs.getString("correct_option");
            if (correctAnswer.equals(answers[questionIndex])) {
                correctAnswersCount++;
            }
            questionIndex++;
        }

        // Calculate user's score
        double score = (double) correctAnswersCount / numQuestions * 100;

        // Display the score
        out.println("<p>Your Quiz Score: " + score + "%</p>");

    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace(); // Handle exceptions appropriately
    } finally {
        // Close database resources
        try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (pst != null) pst.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
    %>
</body>
</html>
