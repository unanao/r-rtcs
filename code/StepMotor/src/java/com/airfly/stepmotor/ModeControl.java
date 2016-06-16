package com.airfly.stepmotor;

import java.io.FileOutputStream;
import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ModeControl extends HttpServlet {

	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
			doPost(req, resp);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String which = new String((req.getParameterValues("which"))[0]);
		String mode = new String((req.getParameterValues("mode"))[0]);
		String whichmode = new String(which+"mode");
		ServletContext application = this.getServletContext();
		application.setAttribute(whichmode, mode);
                FileOutputStream fos = new FileOutputStream("/tmp/" + which + "fifomode");
		fos.write(mode.getBytes());
		resp.sendRedirect("/StepMotor/jsp/stepmotor/"+which+"mode.jsp");
		
	}
	
}
