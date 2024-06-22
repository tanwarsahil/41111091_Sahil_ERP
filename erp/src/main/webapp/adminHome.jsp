<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Home</title>
    <style>
        body, html {
            height: 100%;
            margin: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Roboto', sans-serif;
            background: #f5f7fa;
            color: #333;
        }
        .container {
            text-align: center;
            background-color: #ffffff;
            padding: 50px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .button {
            padding: 15px 30px;
            font-size: 18px;
            margin: 20px;
            cursor: pointer;
            background-color: #45a049;
            color: white;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            transition: background-color 0.3s, transform 0.3s;
        }
        .button:hover {
            background-color: #0056b3;
            transform: translateY(-2px);
        }
        h1 {
            margin-bottom: 30px;
            font-size: 36px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Admin Home</h1>
        <a href="viewUsers.jsp" class="button">View All Users</a>
        <a href="addStudent.jsp" class="button">Add Student</a>
    </div>
</body>
</html>
