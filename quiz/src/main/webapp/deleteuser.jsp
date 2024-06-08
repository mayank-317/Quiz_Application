h<%@page import="java.sql.*" %> 


<% 
int id = Integer.parseInt(request.getParameter("id"));
        Connection con;
        PreparedStatement pst;
        ResultSet rs;
        
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/quizapp?useSSL=false","root","123");
        pst = con.prepareStatement("delete from users where id = ?");
         pst.setInt(1, id);
        pst.executeUpdate();  
        
        %>
        
        <script>
            
        alert("Record Deleted Successfully");
        window.location.href = "manageuser.jsp";
            
       </script>
