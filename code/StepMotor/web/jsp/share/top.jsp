<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>基于龙芯的步进电机远程实时安全控制中心</title>

		<script language="javascript">
	function showweek() {
		now = new Date();
		if (now.getDay() == 0)
			return ("星期日");
		if (now.getDay() == 1)
			return ("星期一");
		if (now.getDay() == 2)
			return ("星期二");
		if (now.getDay() == 3)
			return ("星期三");
		if (now.getDay() == 4)
			return ("星期四");
		if (now.getDay() == 5)
			return ("星期五");
		if (now.getDay() == 6)
			return ("星期六");
	}
</script>
	</head>

	<body bgcolor="green" background="../../image/top.jpg">
		<TABLE align="right">
			<TR>
                            <td align="center"> <font size="18" color="lightblue"><b>步进电机远程实时安全控制中心</b></font></p></td>
				<TD width="322" align="right" valign="bottom">
					<table width="85%" border="0">
						<tr>
							<td>


								<script language="JavaScript">
	today = new Date();

	document.write(today.getFullYear(), "年", "", today.getMonth() + 1,

	"月", "",

	today.getDate(), "日 ");

	document.write(showweek());
</script>
							</td>
						</tr>
						<tr>
							<td>


								&nbsp;
							</td>
						</tr>
					</table>
					<table width="90%" border="0">
						<tr>
							<td height="20" nowrap="nowrap">
								<a href="../../logout.do" target="_top">【重新登录

									】</a>&nbsp;
								<a href="../../logout.do" target="_top">【退出系统

									】</a>&nbsp;
								<a href="help.jsp" target="mainFrame">【在线帮助】</a>&nbsp;
							</td>
						</tr>
					</table>
				</TD>
			</TR>
		</TABLE>
	</body>
</html>