	package com.mayank.quiz;
	
	import java.io.IOException;
	import java.sql.Connection;
	import java.sql.DriverManager;
	import java.sql.PreparedStatement;
	import java.sql.ResultSet;
	import java.sql.SQLException;
	
	import javax.servlet.RequestDispatcher;
	import javax.servlet.ServletException;
	import javax.servlet.annotation.WebServlet;
	import javax.servlet.http.HttpServlet;
	import javax.servlet.http.HttpServletRequest;
	import javax.servlet.http.HttpServletResponse;
	import javax.servlet.http.HttpSession;
	
	/**
	 * Servlet implementation class loginServlet
	 */
	@WebServlet("/Login")
	public class loginServlet extends HttpServlet {
		private static final long serialVersionUID = 1L;
	
		protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			String uemail = request.getParameter("username");
			String upwd = request.getParameter("password");
			HttpSession session = request.getSession();
			RequestDispatcher dispatcher = null;
			Connection con = null;
			if(uemail == null || uemail.equals("")) {
				request.setAttribute("status", "invalidEmail");
				dispatcher = request.getRequestDispatcher("login.jsp");
				dispatcher.forward(request,response);
			}
			if(upwd == null || upwd.equals("")) {
				request.setAttribute("status", "invalidPwd");
				dispatcher = request.getRequestDispatcher("login.jsp");
				dispatcher.forward(request,response);
			}
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				con = DriverManager.getConnection("jdbc:mysql://localhost:3306/quizapp?useSSL=false","root","123");
				PreparedStatement pst = con.prepareStatement("select id from users where uemail=? and upwd=?");
				pst.setString(1, uemail);
				pst.setString(2, upwd);
				ResultSet rs = pst.executeQuery(); 
				int userId = -1;
				if(rs.next()) {
					 userId = rs.getInt("id");
					 request.getSession().setAttribute("id", userId);
					 if (uemail.equals("admin@gmail.com")) {
	                     dispatcher = request.getRequestDispatcher("index.jsp");
	                 } else {
	                     dispatcher = request.getRequestDispatcher("user.jsp");
	                 }
				}
				else {
					/* request.setAttribute("status", "failed"); */
					dispatcher = request.getRequestDispatcher("login.jsp");
				}
				dispatcher.forward(request,response);
			}catch(Exception e) {
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
