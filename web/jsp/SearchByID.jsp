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
		document.getElementById("bID").focus();
	}
	function validate_form()
	{
		var txt=document.getElementById("bID");
		if(txt.value==null||txt.value=="")
		{
			alert("请填写编号！");
			txt.focus();
			return false;
		}
		else {return true;}
	}
	</SCRIPT>
  </head>

	<body onload="load()">
		<div class="center">
		
		<form  action="${pageContext.request.contextPath}/SearchBook?type=ByID" name="formid" recordID="formid" onsubmit="return validate_form()" method="post">
			<h1 align="center">
				图书查询
			</h1>
			<table border="0"
				style="MARGIN-RIGHT: auto; MARGIN-LEFT: auto; width: 350px; font-size: 22px;">
				<tr align="center">
					<td>图书编号：</td>
					<td>
						<input type="text" recordID="bID" name="bID" onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9]+/,'');}).call(this)"
							style="width: 200px; height: 30px; font-size: 22px;" />
					</td>
				</tr>
				<tr>
					<td><br></td>
				</tr>

				<tr align="center"><td colspan=2><input type="submit" style="width:70px;height:30px ; font-size:20px;" value="查询" />　　
    <a href="${pageContext.request.contextPath}/index.jsp">返回</a></td></tr>
			</table>
			</form>
		</div>
	</body>
</html>
