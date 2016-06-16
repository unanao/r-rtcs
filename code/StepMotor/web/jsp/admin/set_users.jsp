<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.airfly.model.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>基于龙芯的远程实时安全控制系统</title>
	</head>
	<body bgcolor="lightblue">
	<form action="../../findUser.do" method="post">
		<table border="1" cellspacing="2" cellpadding="4" bgcolor="lightgreen"
			align="center">
			<caption>
				用户名:
				<input type="text" size="10" name="username">
				<input type="submit" value="查询">
                                <br />&nbsp;
                                <br />
			</caption>
			<tr>
				<td>用户名
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</td>
				<td>密码
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</td>
				<td><a href="add_user.jsp">添加</a></td>
			</tr>
			
				<c:forEach items="${users }" var="user">
					<tr>
						<td>${user.username }</td>
						<td>${user.password }</td>
						<td>
							<a href="../../modifyUser.do?username=${user.username }">修改</a>|
							<a href="../../deleteUser.do?username=${user.username }">删除</a>
						</td>
					</tr>
				</c:forEach>
		</table>
		</form>
	</body>
</html>