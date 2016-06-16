/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.airfly.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.airfly.model.User;

/**
 *
 * @author unanao
 */
public class Test {

    public static void main(String args[]){
        String url = "jdbc:mysql://localhost/airfly?user=root&password=airfly";
	Connection con;
	Statement stmt = null;
	ResultSet rs;
	String username = null;
	String password = null;
	String role = null;

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

    }
}