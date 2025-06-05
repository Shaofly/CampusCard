<%@ page language="java" import="java.util.*,com.mag.domain.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>更新图书信息</title>
<SCRIPT language="javascript" type="text/javascript" src="${pageContext.request.contextPath}/js/checkupdate.js"></SCRIPT>
	<style type="text/css" media="screen">
                .center{
                       
                       margin:8%;
                       text-align:center; 
                }

     </style>

  </head>
  
  <body>
  <div class="center">
    <form action="${pageContext.request.contextPath}/BookCl?type=Update&recordID=${ updateBook.bookID }" onsubmit="return validate_form(this)" method="post">
    <table border="0" style="MARGIN-RIGHT: auto; MARGIN-LEFT: auto; width:600px;font-size: 22px;">
    <tr align="center"><td colspan=2><h1>图书详情</h1></td></tr>
    <%
   Books book=new Books();
   book=(Books)request.getSession().getAttribute("detailBook");
   %>
    <tr align="center"><td>图书编号：</td><td>${ detailBook.bookID }</td></tr>
    <tr align="center"><td>图书名称：</td><td><input type="text" name="bookName" style="width: 400px;height: 30px;font-size: 22px;" value="<%=book.getBookName() %>"  readonly="readonly"/></td></tr>
    <tr align="center"><td>图书类别：</td><td><input type="text" name="bCategory" style="width: 400px;height: 30px;font-size: 22px;" value="<%=book.getCategory() %>"  readonly="readonly"/></td></tr>
      <tr align="center"><td>出版时间：</td><td><input type="text" name="bTime" style="width: 400px;height: 30px;font-size: 22px;" value="<%=book.getPublishTime() %>" readonly="readonly"/></td></tr>
     <tr align="center"><td>作&nbsp;&nbsp;&nbsp;&nbsp;者：</td><td><input type="text" name="bAuthor" style="width: 400px;height: 30px;font-size: 22px;" value="<%=book.getAuthor() %>" readonly="readonly"/></td></tr>
     <tr align="center"><td>价&nbsp;&nbsp;&nbsp;&nbsp;格：</td><td><input type="text" name="bPrice" style="width: 400px;height: 30px;font-size: 22px;" value="<%=book.getPrice() %>" readonly="readonly"/></td></tr>
      <tr align="center"><td>促销价格：</td><td><input type="text" name="bPPrice" style="width: 400px;height: 30px;font-size: 22px;" value="<%=book.getPricepromotion() %>" readonly="readonly"/></td></tr>
      <tr align="center"><td>库&nbsp;&nbsp;&nbsp;&nbsp;存：</td><td><input type="text" name="bStock" style="width: 400px;height: 30px;font-size: 22px;" value="<%=book.getStock() %>" readonly="readonly"/></td></tr>
      <tr align="center"><td>图书简介：</td><td><input type="text" name="bDescription" style="width: 400px;height: 120px;font-size: 22px;" value="<%=book.getDescription()%>" readonly="readonly"/></td></tr>
    <tr align="center"><td colspan=2><input type="submit" style="width:90px;height:30px ; font-size:22px;" recordID="saveInfo" value="提交" />
    &nbsp;&nbsp;&nbsp;&nbsp;<a href="${pageContext.request.contextPath}/SearchBook?type=allbook">返回</a></td></tr>
     
     </table>    
    </form>
    </div>
  </body>
</html>
