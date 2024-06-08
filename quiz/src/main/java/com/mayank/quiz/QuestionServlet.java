package com.mayank.quiz;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/QuestionServlet")
public class QuestionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher dispatcher = null;
		Connection con = null;
		HttpSession session = request.getSession();
		int numberOfQuestions = Integer.parseInt(request.getParameter("questionNumber"));
		int quizId = (int) session.getAttribute("quizId");
		try {
			int score = 0;
			for (int i = 1; i < numberOfQuestions; i++) {
				String selectedOption = request.getParameter("answer" + i);
				Class.forName("com.mysql.cj.jdbc.Driver");
				con = DriverManager.getConnection("jdbc:mysql://localhost:3306/quizapp?useSSL=false", "root", "123");
				PreparedStatement pst = con.prepareStatement("select correct_option from questions where quiz_id=?");
				pst.setInt(1, quizId);
				ResultSet rs = pst.executeQuery();
				while (rs.next()) {
					String correctOption = rs.getString("correct_otion");
					if (selectedOption != null && selectedOption.equals(correctOption)) {
						score++;
					}
				}
			}
			PreparedStatement pst_attempt = con.prepareStatement("insert into quiz_attempts (user_id, quiz_id, score) VALUES (?, ?, ?)");
			pst_attempt.setInt(1, quizId);
			pst_attempt.setInt(2, quizId);
			pst_attempt.setInt(3, score);
			pst_attempt.executeUpdate();
			dispatcher = request.getRequestDispatcher("usershowscore.jsp");
			dispatcher.forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}