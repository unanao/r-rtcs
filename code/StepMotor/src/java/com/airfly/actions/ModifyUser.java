package com.airfly.actions;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.airfly.util.DBAdmin;

public class ModifyUser extends HttpServlet {

	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req, resp);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String[] username= req.getParameterValues("username");
		DBAdmin db = new DBAdmin();
		if(username!=null){
			req.getSession().setAttribute("user", db.getUser(username[0]));
		}
		resp.sendRedirect("/StepMotor/jsp/admin/modify_user.jsp");
	}

}
