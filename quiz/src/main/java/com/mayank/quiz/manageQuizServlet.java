package com.mayank.quiz;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// Servlet implementation class ManageQuizServlet
 
@WebServlet("/manageQuizServlet")
public class manageQuizServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String category = request.getParameter("quizCategory");
		String name = request.getParameter("quizName");
		RequestDispatcher dispatcher = null;
		Connection con = null;
		if(category == null || category.equals("")) {
			request.setAttribute("status", "invalidCategory");
			dispatcher = request.getRequestDispatcher("managequiz.jsp");
			dispatcher.forward(request,response);
		}
		if(name == null || name.equals("")) {
			request.setAttribute("status", "invalidName");
			dispatcher = request.getRequestDispatcher("managequiz.jsp");
			dispatcher.forward(request,response);
		}
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/quizapp?useSSL=false","root","123");
			PreparedStatement pst = con.prepareStatement("insert into quizzes(category_name, quiz_name) values(?,?)");
			pst.setString(1, category);
			pst.setString(2, name);
			int rowCount = pst.executeUpdate();
			dispatcher = request.getRequestDispatcher("managequiz.jsp");
			if(rowCount>0)
				request.setAttribute("status", "success");
			else
				request.setAttribute("status", "failed");
			dispatcher.include(request, response);
		}
		catch(Exception e){
			e.printStackTrace();
		}finally {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

}
