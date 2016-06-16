<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.airfly.model.*"%>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>基于龙芯的远程实时安全控制系统</title>
<script type="text/javascript">
	function goBack(){
			window.self.location="../../showUser.do";
		}
</script>
</head>
<body bgcolor="lightblue">
	<form action="../../modifyUserDetail.do?username=${user.username }" method="post"> 
		用户名&nbsp;&nbsp;&nbsp;&nbsp;${user.username }<br>
		
		新密码&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="password" value="${user.password }"><br>
		确认密码<input type="text" name="checkpassword" value="${user.password }"><br>
		<input type="submit" value="提交">
		<input type="button" value="返回" onClick="goBack()">
	</form>
</body>
</html>