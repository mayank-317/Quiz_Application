package com.mayank.quiz;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ManageQuestionServlet
 */
@WebServlet("/manageQuestionServlet")
public class manageQuestionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String quizName = request.getParameter("quizName");
		String question = request.getParameter("QuestionName");
		String option1 = request.getParameter("OptionOne");
		String option2 = request.getParameter("OptionTwo");
		String option3 = request.getParameter("OptionThree");
		String option4 = request.getParameter("OptionFour");
		String correctOption = request.getParameter("CorrectOption");
		RequestDispatcher dispatcher = null;
		Connection con = null;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/quizapp?useSSL=false","root","123");
			PreparedStatement pst_quizId = con.prepareStatement("select quiz_id from quizzes where quiz_name = ?");
			pst_quizId.setString(1, quizName);
			ResultSet rs_quizId = pst_quizId.executeQuery();
			int quizId = -1;
			if (rs_quizId.next()) {
			    quizId = rs_quizId.getInt("quiz_id");
			}
			PreparedStatement pst = con.prepareStatement("insert into questions(quiz_id,question_text, option1, option2, option3, option4, correct_option) VALUES (?,?,?,?,?,?,?)");
			pst.setInt(1, quizId);
			pst.setString(2, question);
			pst.setString(3, option1);
			pst.setString(4, option2);
			pst.setString(5, option3);
			pst.setString(6, option4);
			pst.setString(7, correctOption);
			int rowCount = pst.executeUpdate();

			dispatcher = request.getRequestDispatcher("managequestion.jsp");
			if (rowCount > 0)
				request.setAttribute("status", "success");
			else
				request.setAttribute("status", "failed");
			dispatcher.include(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (con != null) {
					con.close();
				}
					
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

	}
}
