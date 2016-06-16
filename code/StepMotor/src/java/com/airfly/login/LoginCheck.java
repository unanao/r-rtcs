package com.airfly.login;

import com.airfly.model.User;
import com.airfly.util.DBAdmin;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginCheck extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        doPost(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
System.out.println("herere..............");
        // TODO Auto-generated method stub
        ServletContext application = getServletContext();
        if (application.getAttribute("xmode") == null) {
            Integer xmode = new Integer("1");
            application.setAttribute("xmode", xmode);
        }
        if (application.getAttribute("ymode") == null) {
            Integer ymode = new Integer("1");
            application.setAttribute("ymode", ymode);
        }
        if (application.getAttribute("zmode") == null) {
            Integer zmode = new Integer("1");
            application.setAttribute("zmode", zmode);
        }
        if (application.getAttribute("usernum") == null) {
            Integer usernum = new Integer("0");
            application.setAttribute("usernum", usernum);
        }
        Integer usernum = (Integer) application.getAttribute("usernum");
        System.out.println(usernum.intValue());
        if (usernum.intValue() == 1) {
            resp.sendRedirect("/StepMotor/index.jsp");
            return;
        }

        String[] username = req.getParameterValues("username");
        String[] password = req.getParameterValues("password");
        if (username == null) {
            resp.sendRedirect("/StepMotor/jsp/share/no_user.jsp");
        }
        if (password == null) {
            resp.sendRedirect("/StepMotor/jsp/share/error_pwd.jsp");
        }
        DBAdmin admin = new DBAdmin();
        User user = admin.getUser(username[0]);

        if (user != null) {
            System.out.println(user.getUsername()+"*********"+user.getPassword()+"***"+password[0]+"***********");
            if (!user.getPassword().equals(password[0])) {
                resp.sendRedirect("/StepMotor/jsp/share/error_pwd.jsp");
            } else {
                application.setAttribute("usernum", new Integer(1));
                req.getSession().setAttribute("username", username[0]);
                Boolean login = new Boolean(true);
                req.getSession().setAttribute(username[0], login);
                System.out.println(user.getRole());
                if (user.getRole().equals("A")) {
                    System.out.println("hello");
                    resp.sendRedirect("/jsp/admin/admin_index.jsp");//'/' means http://localhost:8084/StepMotor
                } else {
                    resp.sendRedirect("/jsp/user/user_index.jsp");
                }
            }
        } else {

            resp.sendRedirect("/StepMotor/jsp/share/no_user.jsp");
        }
    }
}

