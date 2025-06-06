<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
    // 获取当前语言环境
    Locale locale = (Locale) session.getAttribute("locale");
    if (locale == null) {
        locale = request.getLocale(); // 浏览器默认
    }
    ResourceBundle bundle = ResourceBundle.getBundle("messages", locale);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= bundle.getString("login.title") %></title>
</head>
<body>
<h2><%= bundle.getString("login.header") %></h2>

<form action="LoginServlet" method="post">
    <label for="personID"><%= bundle.getString("login.account") %>:</label>
    <input type="text" id="personID" name="personID" required><br><br>

    <label for="password"><%= bundle.getString("login.password") %>:</label>
    <input type="password" id="password" name="password" required><br><br>

    <input type="submit" value="<%= bundle.getString("login.submit") %>">
</form>

<p><a href="settings.jsp"><%= bundle.getString("login.changeLanguage") %></a></p>
</body>
</html>