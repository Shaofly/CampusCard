<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
			System.out.println("path="+path+",basePath="+basePath);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>图书信息管理系统</title>
<style type="text/css" media="screen">
                .center{
                       
                       margin:8%;
                       text-align:center; 
                }
     </style>
		<SCRIPT language="javascript" type="text/javascript" src="${pageContext.request.contextPath}/js/main.js"></SCRIPT>
<script language="javascript">
// 这个脚本是 ie6和ie7 通用的脚本
function custom_close(){
if
(confirm("您确定要关闭本页吗？")){
window.opener=null;
window.open('','_self');
window.close();
}
else{}
}
</script>
	</head>

	<body>
		<div class="center">
			<form name="form1" recordID="form1" action=""  method="post"  >
				<table border="0"
					style="MARGIN-RIGHT: auto; MARGIN-LEFT: auto; width: 400px; font-size: 22px;">
					<tr align="center">
						<td colspan=2>
							<h1>
								图书信息管理系统
							</h1>
						</td>
					</tr>
				</table>
				<table border="0"
					style="MARGIN-RIGHT: auto; MARGIN-LEFT: auto; width: 600px; font-size: 22px;">
					<tr align="center">
						<td>
							<input type="button" recordID="querrybyall" style="width:130px;height:30px ; font-size:20px;" value="显示所有书" onclick="is_submit(1)"/>

						</td>
						<td>
							<input type="button" recordID="querrybyid" style="width:80px;height:30px ; font-size:20px;" value="ID查询"
								onclick=is_submit(2); />
						</td>
						<td>
							<input type="button" recordID="querrybyname" style="width:100px;height:30px ; font-size:20px;" value="书名查询"
								onclick=is_submit(3); />
						</td>
						<td>
							<input type="button" recordID="AddBook" style="width:100px;height:30px ; font-size:20px;" value="增加图书"
								onclick=is_submit(4); />
						</td>
						<td><input type="button" name="close" value="退出" style="width:70px;height:30px ; font-size:20px;" onclick="custom_close()" /></td>
					</tr>
				</table>
				<br/>
				<img src="${pageContext.request.contextPath}/img/index.jpg">

			</form>
		</div>
	</body>
</html>
