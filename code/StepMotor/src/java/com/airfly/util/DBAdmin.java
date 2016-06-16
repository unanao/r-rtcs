package com.airfly.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.airfly.model.User;

public class DBAdmin {

	String url = "jdbc:mysql://localhost/airfly?user=root&password=airfly";
	Connection con;
	Statement stmt = null;
	ResultSet rs;
	String username = null;
	String password = null;
	String role = null;

	public User getUser(String username) {
		User user = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(url);
			stmt = con.createStatement();

			rs = stmt.executeQuery("select * from StepMotor where username ="
					+ "'" + username + "'");
			if (rs.next()) {
				username = rs.getString(1);
				password = rs.getString(2);
				role = rs.getString(3);
//				if (role.equals("U")) {
					user = new User(username, password, role);
//				}
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return user;
	}

	public ArrayList findUser(String username) {
		ArrayList users = new ArrayList();
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(url);
			stmt = con.createStatement();
			rs = stmt.executeQuery("select * from StepMotor where username like"
					+ "'%" + username + "%'");
			while (rs.next()) {
				username = rs.getString(1);
				password = rs.getString(2);
				role = rs.getString(3);
				if (role.equals("U")) {
					User user = new User(username, password, "��ͨ�û�");
					users.add(user);
				}
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return users;
	}

	public void modifyUser(User user) {

		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(url);
			stmt = con.createStatement();

			stmt.executeUpdate("update StepMotor set password=" + "'"
					+ user.getPassword() + "'" + "where username=" + "'"
					+ user.getUsername() + "'");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
	}

        public void addUser(User user) {

		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(url);
			stmt = con.createStatement();

			stmt.executeUpdate("insert into StepMotor values('"
					+ user.getUsername() + "'," + "'"
					+ user.getPassword() + "',"+"'"
					+ user.getRole()+"')");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
	}
        
	public void deleteUser(String username) {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(url);
			stmt = con.createStatement();
			stmt.executeUpdate("delete from StepMotor where username=" + "'"
					+ username + "'");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
	}

	public ArrayList getUsers() {
		ArrayList users = new ArrayList();
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(url);
			stmt = con.createStatement();

			rs = stmt.executeQuery("select * from StepMotor");
			while (rs.next()) {
				username = rs.getString(1);
				password = rs.getString(2);
				role = rs.getString(3);
				if (role.equals("U")) {
					User user = new User(username, password, "��ͨ�û�");
					users.add(user);
				}
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return users;
	}
}
