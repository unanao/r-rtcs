<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>基于龙芯的远程实时安全控制系统</title>
<script type="text/javascript">
	function goBack(){
			window.self.location="../share/system.jsp";
		}
</script>
</head>
<body bgcolor="lightblue">
<h1>输入有误，请重新输入</h1>
	<hr>
	<form action="../../addUser.do" method="post">
	
		用户名&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" width="18" name="username"/><br/>
		新密码&nbsp;&nbsp;&nbsp;&nbsp;<input type="password" width="20" name="password" /><br/>
		确认密码<input type="password"  width="20" name="checkpassword" /><br/><br/>
		<input type="submit" value="添加">
		<input type="button" value="返回" onClick="goBack()">
	</form>
</body>
</html>