package com.airfly.stepmotor;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jfree.chart.ChartUtilities;

import com.airfly.demo.SpeedChart;

public class SpeedControl extends HttpServlet {

	static int i=0;
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req, resp);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String which = new String((req.getParameterValues("which"))[0] );
		String speed = new String((req.getParameterValues("speed"))[0]);
		
		FileOutputStream fos = new FileOutputStream("/tmp/" + which + "fifospeed");
//		FileOutputStream fos = new FileOutputStream("F:\\"+which+"fifo");
		
		double f = 1000000.0f;
                int count=(int)(f/new Integer(speed).intValue());
                fos.write(new Integer(count).toString().getBytes());
                System.out.println(count);
		File file = new File("../webapps/StepMotor/image/"+which+"speed.jpg");
		System.out.println(file.getAbsolutePath());
		file.delete();
		FileOutputStream fo = new FileOutputStream(file);
		
		SpeedChart app = new SpeedChart("JFreeChart - Demo Dial 1", Float.valueOf(speed).floatValue());
		ChartUtilities.writeChartAsJPEG(fo, 1.0f, app.getFreeChart(), 200,
				200, null);
		fo.flush();
		resp.sendRedirect("/StepMotor/jsp/share/control.jsp");
	}
}