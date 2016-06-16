package com.airfly.login;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Test {
	public static void main(String args[]){
	String url = "jdbc:mysql://localhost/user?user=root&password=airfly";
	Connection con;
	Statement stmt = null;
	ResultSet rs = null;
	String pwd = null;
	String role = null;
	try {
		Class.forName("com.mysql.jdbc.Driver");
	} catch (ClassNotFoundException e) {
		e.printStackTrace();
	}

	try {
		con = DriverManager.getConnection(url);
		stmt = con.createStatement();

//		
//		rs = stmt.executeQuery("select * from user where username='airfly'");
//		rs.next();
//		pwd = rs.getString(2);
		stmt.executeUpdate("delete from user where username='hqyj'");
		System.out.println(pwd);
//		role = rs.getString(2);
		
	} catch (SQLException e) {
		e.printStackTrace();
	}
	}
}
