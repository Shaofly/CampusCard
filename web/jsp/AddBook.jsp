<%@ page language="java" import="java.util.*,com.mag.domain.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>新增图书</title>

	<style type="text/css" media="screen">
                .center{
                       
                       margin:8%;
                       text-align:center; 
                }
     </style>
     <SCRIPT language="javascript" type="text/javascript" src="${pageContext.request.contextPath}/js/checkadd.js"></SCRIPT>
    <SCRIPT language="javascript" type="text/javascript">
	function load()
	{
		document.getElementById("bookID").focus();
	}
	</SCRIPT>
     
  </head>

<!--  ?type=ADD-->
  <body onload="load()">
    <div class="center">
    <form action="${pageContext.request.contextPath}/AddCl" onsubmit="return validate_form(this)" method="post">
<!--    -->

    <table border="0" style="MARGIN-RIGHT: auto; MARGIN-LEFT: auto; width:600px;font-size: 22px;">
    <tr align="center"><td colspan=2><h1>新增图书</h1></td></tr>
       <%
   Books book=(Books)request.getAttribute("updateBook");
   %>
 <% String message = "Warning Info ..."; out.println("<SCRIPT LANGUAGE='JavaScript'>"); out.println("<!--"); out.println("alert('"+message+"')"); out.println("//-->"); out.println("</SCRIPT>"); %>    <tr align="center"><td>图书编号：</td><td><input type="text" name="bookID" style="width: 400px;height: 30px;font-size: 22px;" value="<%= book==null? "":book.getBookID() %>" /></td></tr>
    <tr align="center"><td>图书名称：</td><td><input type="text" name="bookName" style="width: 400px;height: 30px;font-size: 22px;" value="<%= book==null? "":book.getBookName() %>" /></td></tr>
    <tr align="center"><td>图书类别：</td><td><input type="text" name="bCategory" style="width: 400px;height: 30px;font-size: 22px;" value="<%= book==null? "":book.getCategory() %>" /></td></tr>
      <tr align="center"><td>出版时间：</td><td><input type="text" name="bTime" style="width: 400px;height: 30px;font-size: 22px;" value="<%= book==null? "":book.getDateString() %>" /></td></tr>
     <tr align="center"><td>作         者：</td><td><input type="text" name="bAuthor" style="width: 400px;height: 30px;font-size: 22px;" value="<%= book==null? "":book.getAuthor() %>" /></td></tr>
     <tr align="center"><td>价格：</td><td><input type="text" name="bPrice" style="width: 400px;height: 30px;font-size: 22px;" value="<%= book==null? "":book.getPrice()+"" %>" /></td></tr>
      <tr align="center"><td>促销价格：</td><td><input type="text" name="bPPrice" style="width: 400px;height: 30px;font-size: 22px;" value="<%= book==null? "":book.getPricepromotion()+"" %>" /></td></tr>
      <tr align="center"><td>库存：</td><td><input type="text" name="bStock" style="width: 400px;height: 30px;font-size: 22px;" value="<%= book==null? "":book.getStock()+"" %>" /></td></tr>
      <tr align="center"><td>图书简介：</td><td><input type="text" name="bDescription" style="width: 400px;height: 120px;font-size: 22px;" value="<%= book==null? "":book.getDescription() %>" /></td></tr>
      <tr><td><br></td></tr>
       <%
    if(request.getAttribute("ExpAddError")!=null)
    {
     %>
     <tr align="center"><td colspan=2><font color="red"><%=request.getAttribute("ExpAddError") %></font></td></tr>
     <tr><td><br></td></tr>
     <%
     }
      %>
      
    <tr align="center"><td colspan=2><input type="submit" style="width:70px;height:30px ; font-size:20px;" value="新增" />
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="${pageContext.request.contextPath}/index.jsp">返回</a></td></tr>
     </table>    
    </form>
    </div>
  </body>
</html>
