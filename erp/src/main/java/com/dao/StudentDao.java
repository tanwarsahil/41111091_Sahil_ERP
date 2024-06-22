package com.dao;

import java.sql.*;
import java.util.*;

import com.bean.Student;

public class StudentDao {
	public static List<Student>getAllRecords(){
		List<Student> list=new ArrayList<Student>();
	try{
		Class.forName("com.mysql.jdbc.Driver");
		Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/student","root","");
		
		PreparedStatement ps= con.prepareStatement("select * from results");
		ResultSet rs = ps.executeQuery();	
		
		while (rs.next())
	
		  {
			Student s = new Student();
            s.setId(rs.getInt("id"));
            s.setStudentId(rs.getInt("student_id"));
            s.setSubject(rs.getString("subject"));
            s.setMaximumMarks(rs.getInt("maximum_marks"));
            s.setObtainedMarks(rs.getInt("obtained_marks"));
            list.add(s);
		   }
		}  
	catch(Exception e){
		System.out.println(e);}
		return list;
	
	}
}
