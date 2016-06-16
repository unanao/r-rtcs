package com.airfly.login;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Logout extends HttpServlet {

	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doPost(req, resp);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String username = (String) req.getSession().getAttribute("username");
		if(username==null){
			resp.sendRedirect("/StepMotor/index.jsp");
		}
		req.getSession().setAttribute(username, null);
		ServletContext application = getServletContext();
		Integer usernum = new Integer(0);;
		application.setAttribute("usernum", usernum);
		resp.sendRedirect("/StepMotor/index.jsp");
	}
}