<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String registerNumber = (String) session.getAttribute("registerNumber");

    if (registerNumber == null) {
        response.sendRedirect("studentLogin.jsp");
        return;
    }

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    int totalWorkingDays = 0;
    int daysPresent = 0;
    int daysAbsent = 0;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/student", "root", "");

        String sql = "SELECT * FROM attendance WHERE register_number = ?";
        ps = con.prepareStatement(sql);
        ps.setString(1, registerNumber);

        rs = ps.executeQuery();

        if (rs.next()) {
            totalWorkingDays = rs.getInt("total_working_days");
            daysPresent = rs.getInt("days_present");
            daysAbsent = rs.getInt("days_absent");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    double attendancePercentage = (double) daysPresent / totalWorkingDays * 100;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Attendance</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 800px;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }
        th {
            background-color: #4CAF50;
            color: #fff;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        .attendance {
            font-size: 18px;
            margin-top: 20px;
            color: #333;
        }
        .shortage {
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Attendance Details</h1>
        <table>
            <tr>
                <th>Register Number</th>
                <td><%= registerNumber %></td>
            </tr>
            <tr>
                <th>Total Working Days</th>
                <td><%= totalWorkingDays %></td>
            </tr>
            <tr>
                <th>Days Present</th>
                <td><%= daysPresent %></td>
            </tr>
            <tr>
                <th>Days Absent</th>
                <td><%= daysAbsent %></td>
            </tr>
            <tr>
                <th>Attendance Percentage</th>
                <td><%= String.format("%.2f", attendancePercentage) %> %</td>
            </tr>
        </table>
        <div class="attendance">
            <% if (attendancePercentage < 70) { %>
                <p class="shortage">Attendance Shortage</p>
            <% } %>
        </div>
    </div>
</body>
</html>
