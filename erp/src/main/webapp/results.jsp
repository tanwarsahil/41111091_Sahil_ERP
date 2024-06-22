<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, java.util.ArrayList, java.util.List" %>
<%
    String registerNumber = (String) session.getAttribute("registerNumber");

    if (registerNumber == null) {
        response.sendRedirect("studentLogin.jsp");
        return;
    }

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    int totalObtainedMarks = 0;
    int totalMaximumMarks = 0;

    List<String> subjects = new ArrayList<String>();
    List<Integer> maximumMarksList = new ArrayList<Integer>();
    List<Integer> obtainedMarksList = new ArrayList<Integer>();

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/student", "root", "");

        String sql = "SELECT subject, maximum_marks, obtained_marks FROM results WHERE register_number = ?";
        ps = con.prepareStatement(sql);
        ps.setString(1, registerNumber);

        rs = ps.executeQuery();

        while (rs.next()) {
            subjects.add(rs.getString("subject"));
            int maxMarks = rs.getInt("maximum_marks");
            int obtMarks = rs.getInt("obtained_marks");

            maximumMarksList.add(maxMarks);
            obtainedMarksList.add(obtMarks);

            totalMaximumMarks += maxMarks;
            totalObtainedMarks += obtMarks;
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

    double overallPercentage = (double) totalObtainedMarks / totalMaximumMarks * 100;
    double cgpa = overallPercentage / 9.5;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Results</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #f2f2f2;
        }
        .pass {
            color: green;
        }
        .fail {
            color: red;
        }
    </style>
</head>
<body>
    <h1>Student Results</h1>
    <h2>Register Number: <%= registerNumber %></h2>
    <table>
        <tr>
            <th>Subject</th>
            <th>Maximum Marks</th>
            <th>Obtained Marks</th>
            <th>Percentage</th>
            <th>Status</th>
        </tr>
        <% 
            for (int i = 0; i < subjects.size(); i++) {
                String subject = subjects.get(i);
                int maximumMarks = maximumMarksList.get(i);
                int obtainedMarks = obtainedMarksList.get(i);
                double percentage = (double) obtainedMarks / maximumMarks * 100;
                String status = obtainedMarks >= maximumMarks * 0.5 ? "Pass" : "Fail";
                String statusClass = obtainedMarks >= maximumMarks * 0.5 ? "pass" : "fail";
        %>
        <tr>
            <td><%= subject %></td>
            <td><%= maximumMarks %></td>
            <td><%= obtainedMarks %></td>
            <td><%= String.format("%.2f", percentage) %> %</td>
            <td class="<%= statusClass %>"><%= status %></td>
        </tr>
        <% } %>
    </table>
    <h3>Overall Percentage: <%= String.format("%.2f", overallPercentage) %> %</h3>
    <h3>CGPA: <%= String.format("%.2f", cgpa) %></h3>
</body>
</html>
