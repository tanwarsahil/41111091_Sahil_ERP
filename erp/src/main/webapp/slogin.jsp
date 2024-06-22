<%@ page import="java.sql.*"%>
<%
	String register_number = request.getParameter("register_number");
	String password = request.getParameter("password");
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/student", "root", "");
	Statement st = con.createStatement();
	
	ResultSet rs = st.executeQuery("select * from students where register_number='" + register_number + "' and password='" + password + "'");
	
	if (rs.next()) {
	    session.setAttribute("registerNumber", register_number);
	    session.setAttribute("userName", rs.getString("name"));
	    response.sendRedirect("home.jsp");
	}
 
	else {
		out.println("Invalid password / username <a href='index.jsp'>try again</a>");
	}
	
%>
