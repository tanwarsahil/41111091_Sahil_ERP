<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Details</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            padding: 20px;
        }
        table {
            margin: 0 auto;
            border-collapse: collapse;
            width: 50%;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
    </style>
</head>
<body>
    <h2>Student Details</h2>

    <%
        String registerNumber = (String) session.getAttribute("registerNumber");
        if (registerNumber == null) {
            out.println("<p>No student selected. Please login again.</p>");
        } else {
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/student", "root", "");
                String sql = "SELECT * FROM students WHERE register_number = ?";
                ps = con.prepareStatement(sql);
                ps.setString(1, registerNumber);
                rs = ps.executeQuery();

                if (rs.next()) {
                    %>
                    <table>
                        <tr>
                            <th>Register Number</th>
                            <td><%= rs.getString("register_number") %></td>
                        </tr>
                        <tr>
                            <th>Name</th>
                            <td><%= rs.getString("name") %></td>
                        </tr>
                        <tr>
                            <th>Email</th>
                            <td><%= rs.getString("email") %></td>
                        </tr>
                        <tr>
                            <th>Contact Number</th>
                            <td><%= rs.getString("contact_number") %></td>
                        </tr>
                    </table>
                    <%
                } else {
                    out.println("<p>Student details not found.</p>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>An error occurred. Please try again later.</p>");
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (ps != null) ps.close();
                    if (con != null) con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    %>

</body>
</html>
