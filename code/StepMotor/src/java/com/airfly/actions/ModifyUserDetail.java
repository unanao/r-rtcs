package com.airfly.actions;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.airfly.model.User;
import com.airfly.util.DBAdmin;

public class ModifyUserDetail extends HttpServlet {

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
		User user = db.getUser(username[0]);
		if (password != null && checkpassword!=null&&password[0].equals(checkpassword[0])) {
			user.setPassword(password[0]);
			db.modifyUser(user);
			req.getSession().setAttribute("users", db.getUsers());
			resp.sendRedirect("/StepMotor/jsp/admin/set_users.jsp");
		} else {
			req.getSession().setAttribute("user", user);
			resp.sendRedirect("/StepMotor/jsp/admin/modify_user.jsp");
		}

	}

}
