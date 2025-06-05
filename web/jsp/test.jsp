<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>My JSP 'test.jsp' starting page</title>
		<style>
				.center{
                       
                       margin:1%;
                       text-align:center; 
                }
        #mainT{width:1200px; text-align: center;font-size: 16px;line-height: 26px;border: 2px solid #6e6e6e;}
        #mainT caption{text-align: center;font-size: 30px;font-weight: bolder;}
        #mainT th{text-align: center;font-size: 20px;font-weight: bolder;line-height: 36px;border: 1px solid #6e6e6e;}
        #mainT td{width: 100px;border: 1px solid #6e6e6e;font-size: 18px;}
        

	.column-layout-container { width: 1200px; padding: 10px; background-color: lightblue;}
    .column-layout { width: 25%; height: 90px; margin: 10px;background-color: green;}
    .column-layout-container { overflow: hidden; }
    .column-layout { float: left; }
  	.column-left{width: 300px; height: 60px; margin: 20px; text-align:right;background-color: ;display:inline-block; }
   	.column-right{width: 300px; height: 30px; margin: 20px; text-align:left;background-color: ; display:inline-block;overflow:auto; vertical-align: middle;}
	<!--  vertical-align: middle;-->
</style>
	</head>

	<body>
 <form>
<div class="center">
<div class="column-layout-container">
    <div class="column-left"><h1>图书管理</h1></div>
    <div class="column-right"><input type="button"  align="left" style="width:70px;height:30px ; font-size:20px;" value="返回" onclick=who_submit(); />
    <input type="hidden" recordID="vhidden" value="<%= request.getSession().getAttribute("ison") %>"/>
    </div>
</div>
	<br>
	<div>
	   <table recordID="mainT" cellpadding="0" cellspacing="0">
    <tr><th>编号</th><th>书名</th><th>类别</th><th>出版时间</th><th>作者</th><th>价格</th><th>促销价</th><th>库存</th><th>详情</th><th>修改</th><th>删除</th></tr>
	   <tr>
   <td>1</td><td>信息管理学</td><td>管理</td>
   <td>2015-09-12</td><td>李兴国</td><td>36.58</td>
   <td>30.90</td><td>1000</td><td>企业信息资源管理属于微观层次的信息资源管理的范畴,指企业为达到预定的目标运用现代的管理方法</td>
   <td><a href="${pageContext.request.contextPath}/BookCl?type=goUpdate&recordID=1">修改</a></td>
   <td><a href="${pageContext.request.contextPath}/BookCl?type=delete&recordID=1">删除</a></td>
   </tr>
	</table>
	<br/>
	<input name="time" onkeypress="datestring="2006-12-25 09:12:35";var re=/^(\d{4}-\d{1,2}-\d{1,2})(\s?\d{2}:\d{2}:\d{2})?$/ alert(re.test(datestring));" />
	<!-- 
	/^(?:(?!0000)[0-9]{4}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)-02-29)$/
	 -->
	</div>
	</div>
</form>
  </body>
</html>
