<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">

	function goBack(){
		window.self.location="system.jsp";
	}
</script>
		<title>基于龙芯的远程实时安全控制系统</title>
</head>
<body bgcolor="lightblue">

	<h1>新密码为空或确认密码与新密码不匹配</h1>
	<hr>
	<form action="../../addUser.do" method="post">
		<ul>
		<li>用户名：<input type="text" name="username"/></li>
		<li>新密码：<input type="password" name="newPassword" id="newPassword"></li>
		<li>确认密码:<input type="password" name="checkPassword" id="checkPassword"></li>
		<li><input type="submit" value="修改">
			<input type="button" value="返回" onclick="goBack()">
		</li>	
		</ul>
		
	</form>
</body>
</html>