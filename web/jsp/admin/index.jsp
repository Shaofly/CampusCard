<%--
  Created by IntelliJ IDEA.
  User: msf
  Date: 2025/6/6
  Time: 16:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%
    Locale locale = (Locale) session.getAttribute("locale");
    if (locale == null) {
        locale = request.getLocale();
    }
    ResourceBundle bundle = ResourceBundle.getBundle("messages", locale);
%>

<%-- 登录拦截 --%>
<%
    if (session.getAttribute("loginCard") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<!-- index.jsp 管理员主页/统计视图 -->
<!DOCTYPE html>
<html lang="<%= locale.getLanguage() %>">
<head>
    <meta charset="UTF-8"/>
    <title>管理员主页-校园卡系统</title>
    <link rel="stylesheet" href="../../css/admin/sidebar.css"/>
    <link rel="stylesheet" href="../../css/admin/main.css"/>
    <%-- 可引入你已有的common.css --%>
</head>
<body>
<aside class="admin-sidebar">
    <div class="admin-logo">
        <img src="../../img/logo.png" alt="logo">
        <span>校园卡系统</span>
    </div>
    <nav class="admin-nav">
        <a href="index.jsp" class="nav-item active">统计视图</a>
        <a href="manageCard.jsp" class="nav-item">人员管理</a>
        <a href="approval.jsp" class="nav-item">审批处理</a>
    </nav>
    <div class="admin-sidebar-bottom">
        <a href="../../login.jsp" class="logout-link">退出登录</a>
    </div>
</aside>
<main class="admin-main">
    <div class="admin-header">
        <span class="admin-title">统计视图</span>
        <%-- 这里可以加管理员信息 --%>
        <span class="admin-user-info">欢迎，管理员张三</span>
    </div>
    <div class="admin-dashboard">
        <!-- 统计卡片区域 -->
        <div class="dashboard-row">
            <div class="dashboard-card">
                <div class="dashboard-value">3920</div>
                <div class="dashboard-label">总卡片数</div>
            </div>
            <div class="dashboard-card">
                <div class="dashboard-value">¥12,847,233.40</div>
                <div class="dashboard-label">校园卡累计金额</div>
            </div>
            <div class="dashboard-card abnormal">
                <div class="dashboard-value">2</div>
                <div class="dashboard-label">异常数据</div>
            </div>
        </div>
        <!-- 这里你可以加更多统计图表、趋势曲线等 -->
    </div>
</main>
</body>
</html>