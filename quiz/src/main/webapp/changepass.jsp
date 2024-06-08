
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>

<%

    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
	int userId = (int) request.getSession().getAttribute("id");

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/quizapp?useSSL=false", "root", "123");
        String query = "SELECT upwd FROM users WHERE id = ?";
        pstmt = con.prepareStatement(query);
        pstmt.setInt(1, userId);
        rs = pstmt.executeQuery();
        String oldPassword = "";
        if (rs.next()) {
            oldPassword = rs.getString("upwd");
        }

        String enteredOldPassword = request.getParameter("oldPassword");
        if (!oldPassword.equals(enteredOldPassword)) {
            out.println("Old password does not match.");
        } else {
            String newPassword = request.getParameter("newPassword");
            String confirmNewPassword = request.getParameter("confirmNewPassword");
            if (!newPassword.equals(confirmNewPassword)) {
                out.println("New password and confirm password do not match.");
            } else {
                query = "UPDATE users SET upwd = ? WHERE id = ?";
                pstmt = con.prepareStatement(query);
                pstmt.setString(1, newPassword);
                pstmt.setInt(2, userId);
                int rowsAffected = pstmt.executeUpdate();
                if (rowsAffected > 0) {
                	%>
                	<script>
            
        alert("Password Updated Successfully");
        window.location.href = "changepass.jsp";
            
       </script>
       <% 
                } else {
                	%>
                	<script>
                	 alert("Failed to Update Password");
        window.location.href = "changepass.jsp";
        </script>
        <% 
              
                }
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>


<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1, shrink-to-fit=no"
    />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Quiz App</title>
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
    <script
      src="https://use.fontawesome.com/releases/v5.15.4/js/all.js"
      crossorigin="anonymous"
    ></script>
    <link
      href="https://fonts.googleapis.com/css?family=Montserrat:400,700"
      rel="stylesheet"
      type="text/css"
    />
    <link
      href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic"
      rel="stylesheet"
      type="text/css"
    />
    <link
      href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link href="css/index-styles.css" rel="stylesheet" />
  </head>

  <body id="page-top" class="d-flex flex-column min-vh-100">
    <!-- Add d-flex and flex-column classes to make the body a flex container and set its flex-direction to column -->
    <!-- Navigation-->
    <nav
      class="navbar navbar-expand-lg bg-secondary text-uppercase fixed-top"
      id="mainNav"
    >
      <div class="container">
        <a class="navbar-brand" href="#page-top">Quiz App</a>
        <button
          class="navbar-toggler text-uppercase font-weight-bold bg-primary text-white rounded"
          type="button"
          data-bs-toggle="collapse"
          data-bs-target="#navbarResponsive"
          aria-controls="navbarResponsive"
          aria-expanded="false"
          aria-label="Toggle navigation"
        >
          Menu <i class="fas fa-bars"></i>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
          <ul class="navbar-nav ms-auto">
            <li class="nav-item mx-0 mx-lg-1">
              <a class="nav-link py-3 px-0 px-lg-3 rounded" href="./index.jsp"
                >Home</a
              >
            </li>
            <li class="nav-item mx-0 mx-lg-1">
              <a
                class="nav-link py-3 px-0 px-lg-3 rounded"
                href="./manageuser.jsp"
                >Manage User</a
              >
            </li>
            <!-- Replace this list item with the dropdown submenu -->
            <li class="nav-item dropdown nav-item mx-0 mx-lg-1">
              <a
                class="nav-link dropdown-toggle nav-link py-3 px-0 px-lg-3"
                href="#"
                id="navbarDropdownDashboard"
                role="button"
                data-toggle="dropdown"
                aria-haspopup="true"
                aria-expanded="false"
              >
                Dashboard
              </a>
              <div
                class="dropdown-menu"
                aria-labelledby="navbarDropdownDashboard"
              >
                <a
                  class="dropdown-item font-weight-bold"
                  href="./managequiz.jsp"
                  >Manage Quiz</a
                >
                <a
                  class="dropdown-item font-weight-bold"
                  href="./managequestion.jsp"
                  >Manage Question</a
                >
                <a class="dropdown-item font-weight-bold" href="./showscore.jsp"
                  >Show Score</a
                >
              </div>
            </li>
            <!-- End of dropdown submenu -->
            <li class="nav-item mx-0 mx-lg-1">
              <a
                class="nav-link py-3 px-0 px-lg-3 rounded"
                href="./changepass.jsp"
                >Change Password</a
              >
            </li>
            <li class="nav-item mx-0 mx-lg-1">
              <a class="nav-link py-3 px-0 px-lg-3 rounded" href="Logout"
                >Logout</a
              >
            </li>
          </ul>
        </div>
      </div>
    </nav>
    <br>
    <br>
    <br>
    <br>
    <br>
    <div class=pl-5>
    <h2>Password Change</h2>
    <form method="post" action="userchangepass.jsp">
        <label for="oldPassword">Old Password:</label>
        <input type="password" id="oldPassword" name="oldPassword" required><br><br>
        <label for="newPassword">New Password:</label>
        <input type="password" id="newPassword" name="newPassword" required><br><br>
        <label for="confirmNewPassword">Confirm New Password:</label>
        <input type="password" id="confirmNewPassword" name="confirmNewPassword" required><br><br>
        <input type="hidden" name="userId" value="<%= userId %>">
        <input type="submit" value="Change Password" class="btn btn-primary btn-sm">
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
              Andheri West <br />
              Mumbai, 400058
            </p>
          </div>
          <!-- Footer Social Icons-->
          <div class="col-lg-4 mb-5 mb-lg-0">
            <h4 class="text-uppercase mb-4">Around the Web</h4>
            <a class="btn btn-outline-light btn-social mx-1" href="#!"
              ><i class="fab fa-fw fa-facebook-f"></i
            ></a>
            <a class="btn btn-outline-light btn-social mx-1" href="#!"
              ><i class="fab fa-fw fa-twitter"></i
            ></a>
            <a class="btn btn-outline-light btn-social mx-1" href="#!"
              ><i class="fab fa-fw fa-linkedin-in"></i
            ></a>
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
      $(document).ready(function () {
        $(".dropdown-toggle").dropdown();
      });
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
    <script src="js/scripts.js"></script>
    <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
  </body>
</html>
