package com.airfly.actions;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ChangePassword extends HttpServlet {

	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req, resp);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String url = "jdbc:mysql://localhost/user?user=root&password=airfly";
		Connection con;
		Statement stmt = null;
		ResultSet rs;
		String pwd = null;
		String oldPassword = (req.getParameterValues("oldPassword"))[0];
		String newPassword = (req.getParameterValues("newPassword"))[0];
		String checkPassword = (req.getParameterValues("checkPassword"))[0];
		String username = (String) req.getSession().getAttribute("username");
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		try {
			con = DriverManager.getConnection(url);
			stmt = con.createStatement();

			rs = stmt.executeQuery("select * from user where username=" + "'"
					+ username + "'");
			if (rs.next()) {
				pwd = rs.getString(2);
			}
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		if (!pwd.equals(oldPassword)) {System.out.println("1");
			resp.sendRedirect("/jsp/share/change_pwd_error_old.jsp");
			return;
		}
		if (newPassword == null || newPassword.equals("")
				|| !newPassword.equals(checkPassword)) {System.out.println("2");
			resp.sendRedirect("/jsp/share/change_pwd_error_check.jsp");
			return;
		}
		try {
			stmt.executeUpdate("update user set password=" + "'" + newPassword
					+ "'" + "where username=" + "'" + username + "'");
		} catch (SQLException ex) {
			ex.printStackTrace();
		}System.out.println("3");
		resp.sendRedirect("/StepMotor/jsp/share/change_pwd_successful.jsp");
	}

}
