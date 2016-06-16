<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>基于龙芯的远程实时安全控制系统</title>

</head>
	<frameset id="parentFrame"  rows="93,*,36" cols="*" framespacing="0"
		frameborder="no">
		<frame src="../share/top.jsp" name="topFrame" scrolling="NO" noresize="noresize">
			
		<frameset id="middle"  rows="*" cols="150,*"
			framespacing="0" frameborder="no">
			<frame src="admin_left.jsp" scrolling="no"
				noresize="noresize">
			<frame src="../stepmotor/control.jsp" name="mainFrame">
		</frameset>

		<frame src="../share/bottom.jsp" name="bottomFrame" scrolling="NO" noresize="noresize">
	</frameset>

</html>

