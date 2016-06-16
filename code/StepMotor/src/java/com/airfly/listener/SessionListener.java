package com.airfly.listener;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

public class SessionListener implements HttpSessionListener {

	public void sessionCreated(HttpSessionEvent event) {

	}

	public void sessionDestroyed(HttpSessionEvent event) {
		
		ServletContext application = event.getSession().getServletContext();
		Integer usernum = (Integer) application.getAttribute("usernum");
		usernum = new Integer(usernum.intValue() - 1);
		application.setAttribute("usernum", usernum);
	}

}
