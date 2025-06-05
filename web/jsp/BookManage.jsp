<%@ page language="java" import="java.util.*,com.mag.domain.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>图书管理</title>
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
	<SCRIPT language="javascript" type="text/javascript" src="/CampusCard/js/SearchBook.js"></SCRIPT>
 </head>
  
  <body>
  <form name="form2" recordID="form2" action="" method="post" >
  <div class="center">
 	<div class="column-layout-container">
		<div class="column-left"><h1>图书管理</h1></div>
		<div class="column-right"><input type="button"  align="left" style="width:70px;height:30px ; font-size:20px;" value="返回" onclick=who_submit(); />
			<input type="hidden" recordID="vhidden" value="<%= request.getSession().getAttribute("ison") %>"/>
		</div>
	</div>
	<div class="center">
   <table recordID="mainT" cellpadding="0" cellspacing="0">
    <tr><th>编号</th><th>书名</th><th>类别</th><th>出版时间</th><th>作者</th><th>价格</th><th>促销价</th><th>库存</th><th>简介</th><th>修改</th><th>删除</th></tr>
  <%
   ArrayList<Books> al=new ArrayList<Books>();
   al=(ArrayList<Books>)request.getSession().getAttribute("BookList");
   for(Books book:al)
   {
   %>
   <tr>
   <td><%=book.getBookID() %></td><td><%=book.getBookName()%></td><td><%=book.getCategory() %></td>
   <td><%=book.getPublishTime() %></td><td><%=book.getAuthor()%></td><td><%=book.getPrice() %></td>
   <td><%=book.getPricepromotion() %></td><td><%=book.getStock()%></td><td><%=book.getDescription() %></td>
   <td><a href="${pageContext.request.contextPath}/BookCl?type=goDetail&recordID=<%=book.getBookID() %>">详情</a></td>
   <td><a href="${pageContext.request.contextPath}/BookCl?type=goUpdate&recordID=<%=book.getBookID() %>">修改</a></td>
   <td><a href="${pageContext.request.contextPath}/BookCl?type=delete&recordID=<%=book.getBookID() %>">删除</a></td>
   </tr>
   <% } %>
  </table>
  </div>
  </div>
  </form>
  </body>
</html>
