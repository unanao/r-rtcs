<%@ page language="java" import="java.util.*" pageEncoding="GB18030" contentType="image/jpeg" import="java.awt.*,
java.awt.image.*,java.util.*,javax.imageio.*" %>

<%@ page import="java.io.*" %>
<%
        File f = null ;
        BufferedImage image = null ;

    // ���ڴ��д���ͼ��

            f = new File("../webapps/StepMotor/image/xspeed.jpg") ;
            image = ImageIO.read(f) ;
            
// ���ͼ��ҳ��

ImageIO.write(image, "JPEG",response.getOutputStream());


//  ������ͷŹ���Ҳ�ǳ�����Ҫ
response.flushBuffer() ;
out.clear() ;
out = pageContext.pushBody() ;

%>
