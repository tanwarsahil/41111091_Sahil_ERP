<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Student Action</title>
</head>
<body>
    <%
        String register_number = request.getParameter("register_number");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String contact_number = request.getParameter("contact_number");

        Connection con = null;
        PreparedStatement ps = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/student", "root", "");

            String sql = "INSERT INTO students (register_number, password, name, email, contact_number) VALUES (?, ?, ?, ?, ?)";
            ps = con.prepareStatement(sql);
            ps.setString(1, register_number);
            ps.setString(2, password);
            ps.setString(3, name);
            ps.setString(4, email);
            ps.setString(5, contact_number);

            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
    %>
                <h2>Student Added Successfully!</h2>
                <p>Register Number: <%= register_number %></p>
                <p>Name: <%= name %></p>
                <a href="home.jsp">Back to Home</a>
    <%
            } else {
    %>
                <h2>Error Adding Student</h2>
                <a href="addStudent.jsp">Try Again</a>
    <%
            }
        } catch (Exception e) {
            e.printStackTrace();
    %>
            <h2>Error</h2>
            <p><%= e.getMessage() %></p>
    <%
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>
</body>
</html>
