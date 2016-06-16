package com.airfly.actions;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.airfly.util.DBAdmin;

public class DeleteUser extends HttpServlet {

	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req, resp);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		DBAdmin db = new DBAdmin();
		String[] username = req.getParameterValues("username");
		if(username!=null){
			db.deleteUser(username[0]);
		}
		req.getSession().setAttribute("users", db.getUsers());
		resp.sendRedirect("/StepMotor/jsp/admin/set_users.jsp");
	}

}
