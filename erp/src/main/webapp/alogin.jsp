<%@ page import="java.sql.*"%>
<%
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/student", "root", "");
	Statement st = con.createStatement();
	
	ResultSet rs = st.executeQuery("select * from admin1 where username='" + username + "' and password='" + password + "'");
	
	if (rs.next()) {
	    session.setAttribute("registerNumber", username);
	    session.setAttribute("userName", rs.getString("name"));
	    response.sendRedirect("home.jsp");
	}
 
	else {
		out.println("Invalid password / username <a href='index.jsp'>try again</a>");
	}
	
%>
