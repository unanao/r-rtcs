package com.airfly.actions;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.airfly.model.User;
import com.airfly.util.DBAdmin;

public class AddUser extends HttpServlet {

	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req, resp);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String[] username = req.getParameterValues("username");
		String[] password = req.getParameterValues("password");
		String[] checkpassword = req.getParameterValues("checkpassword");
		DBAdmin db = new DBAdmin();
		User user = null;
		System.out.println(username[0] + "**" + password[0] + "**"
				+ checkpassword[0] + "**");
		if (username != null && password != null && checkpassword != null
				&& !username[0].isEmpty() && !password[0].isEmpty()
				&& password[0].equals(checkpassword[0])) {
			user = new User(username[0], password[0], "U");
			;
			db.addUser(user);
			req.getSession().setAttribute("users", db.getUsers());
			resp.sendRedirect("/StepMotor/jsp/admin/add_user_successful.jsp");
		} else {
			resp.sendRedirect("/StepMotor/jsp/admin/add_user_error.jsp");
		}

	}
}
