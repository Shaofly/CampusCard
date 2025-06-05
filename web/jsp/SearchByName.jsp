<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>图书查询</title>

		<style type="text/css" media="screen">
                .center{
                       
                       margin:8%;
                       text-align:center; 
                }
     </style>
	<SCRIPT language="javascript" type="text/javascript">
	function load()
	{
		document.getElementById("bName").focus();
	}
	</SCRIPT>

  </head>

	<body onload="load()">
		<div class="center">
		<form action="${pageContext.request.contextPath}/SearchBook?type=ByName" name="formid" recordID="formid" method="post">
			<h1 align="center">
				图书查询
			</h1>
			<table border="0"
				style="MARGIN-RIGHT: auto; MARGIN-LEFT: auto; width: 350px; font-size: 22px;">

				<tr align="center">
					<td>图书名称：</td>
					<td>
						<input type="text" name="bName" 
							style="width: 200px; height: 30px; font-size: 22px;" />
					</td>
				</tr>
				<tr>
					<td>	<br>	</td>
				</tr>
				<tr align="center"><td colspan=2><input type="submit" style="width:70px;height:30px ; font-size:20px;" value="查询"  />　　
    <a href="${pageContext.request.contextPath}/index.jsp">返回</a></td></tr>
			</table>
			</form>
		</div>
	</body>
</html>
