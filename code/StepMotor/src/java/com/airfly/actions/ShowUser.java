package com.airfly.actions;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.airfly.util.DBAdmin;

public class ShowUser extends HttpServlet {

	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req, resp);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		DBAdmin db = new DBAdmin();
		req.getSession().setAttribute("users", db.getUsers());
		resp.sendRedirect("/jsp/admin/set_users.jsp");
	}

}
