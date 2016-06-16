<%@ page language="java" import="java.util.*" pageEncoding="GB18030" contentType="image/jpeg" import="java.awt.*,
java.awt.image.*,java.util.*,javax.imageio.*" %>

<%@ page import="java.io.*" %>
<%
        File f = null ;
        BufferedImage image = null ;

    // 在内存中创建图象

            f = new File("../webapps/StepMotor/image/xspeed.jpg") ;
            image = ImageIO.read(f) ;
            
// 输出图象到页面

ImageIO.write(image, "JPEG",response.getOutputStream());


//  后面的释放工作也非常的重要
response.flushBuffer() ;
out.clear() ;
out = pageContext.pushBody() ;

%>
