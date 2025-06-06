<%--
  Created by IntelliJ IDEA.
  User: msf
  Date: 2025/6/6
  Time: 01:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
    // 获取 session 中设置的语言，没有的话用浏览器默认
    Locale locale = (Locale) session.getAttribute("locale");
    if (locale == null) {
        locale = request.getLocale();
    }
    ResourceBundle bundle = ResourceBundle.getBundle("messages", locale);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= bundle.getString("setting.title") %></title>
</head>
<body>
<h2><%= bundle.getString("setting.language") %></h2>

<form action="ChangeLanguageServlet" method="post">
    <select name="lang">
        <option value="zh" <%= locale.getLanguage().equals("zh") ? "selected" : "" %>>中文</option>
        <option value="en" <%= locale.getLanguage().equals("en") ? "selected" : "" %>>English</option>
    </select>
    <input type="submit" value="<%= bundle.getString("setting.save") %>">
</form>

<hr>
<p><%= bundle.getString("setting.tip") %></p>
</body>
</html>