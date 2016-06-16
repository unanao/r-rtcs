package com.airfly.stepmotor;

import org.jfree.*;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class TurnControl extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // TODO Auto-generated method stub
        doPost(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // TODO Auto-generated method stub
        String which = new String((req.getParameterValues("which"))[0]);
        System.out.println(which);
        String turn = new String((req.getParameterValues("turn"))[0]);
        System.out.println(turn);
        String whichturn = new String(which + "turn");
        ServletContext application = this.getServletContext();
        if (turn.equals("s")) {
            application.setAttribute(whichturn, "0");
        } else {
            application.setAttribute(whichturn, "1");
        }
        FileOutputStream fos = new FileOutputStream("/tmp/" + which + "fifo");
        fos.write(turn.getBytes());
        resp.sendRedirect("/StepMotor/jsp/stepmotor/" + which + "turn.jsp");


    }
}
