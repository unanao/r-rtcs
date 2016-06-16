package com.airfly.login;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginFilter extends HttpServlet implements Filter {
	protected FilterConfig config;

	public void init(FilterConfig filterConfig) throws ServletException {
		this.config = filterConfig;
	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		
		HttpServletRequest httpServRequest = (HttpServletRequest) request;
		Object username =  httpServRequest.getSession().getAttribute("username");
		System.out.println(username);
		Object obj =  null;
		if(username!=null){
			obj=httpServRequest.getSession().getAttribute((String)username);
			System.out.println(obj);
		}else{
			request.getRequestDispatcher("jsp/share/relogin.jsp").forward(request , response);
			return;
		}
		Boolean login = null;
		if(obj==null){
			request.getRequestDispatcher("jsp/share/relogin.jsp").forward(request , response);
			return;
		}else{
			login = (Boolean) obj;
			System.out.println(login);
		}
		if (login == null || login.booleanValue() == false) {
			request.getRequestDispatcher("jsp/share/relogin.jsp").forward(request , response);
		} else {
			chain.doFilter(request, response);
		}
	}
	public void destroy() {

	}
}
