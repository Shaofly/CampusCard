<%--
  Created by IntelliJ IDEA.
  User: msf
  Date: 2025/6/6
  Time: 16:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="com.mag.domain.CampusCard" %>
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

<%
    double totalAmount = (request.getAttribute("totalAmount") != null) ? (double) request.getAttribute("totalAmount") : 0.0;
    int total = (request.getAttribute("total") != null) ? (int)request.getAttribute("total") : 0;
%>

<!-- index.jsp 管理员主页/统计视图 -->
<!DOCTYPE html>
<html lang="<%= locale.getLanguage() %>">
<head>
    <meta charset="UTF-8"/>
    <title>管理员主页-校园卡系统</title>
    <%--   引入css --%>
    <link rel="stylesheet" href=" <%=request.getContextPath()%>/css/admin/sidebar.css"/>
    <link rel="stylesheet" href=" <%=request.getContextPath()%>/css/admin/main.css"/>
</head>
<body>
<%-- 侧边导航栏 --%>
<aside class="admin-sidebar">
    <div class="admin-logo">
        <img src=" <%=request.getContextPath()%>/img/logo.png" alt="logo">
        <span>校园卡系统</span>
    </div>
    <nav class="admin-nav">
        <a href="${pageContext.request.contextPath}/AdminIndexServlet?currentPage=1&pageSize=5" class="nav-item active">统计视图</a>
        <a href="manageCard.jsp" class="nav-item">人员管理</a>
        <a href="approval.jsp" class="nav-item">审批处理</a>
    </nav>
    <div class="admin-sidebar-bottom">
        <a href="${pageContext.request.contextPath}/LogoutServlet" class="logout-link">退出登录</a>
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
                <div class="dashboard-value"><%= total %></div>
                <div class="dashboard-label">总卡片数</div>
            </div>
            <div class="dashboard-card">
                <div class="dashboard-value">¥<%= String.format("%,.2f", totalAmount) %></div>
                <div class="dashboard-label">校园卡累计金额</div>
            </div>
            <div class="dashboard-card abnormal">
                <div class="dashboard-value">2</div>
                <div class="dashboard-label">异常数据</div>
            </div>
        </div>
        <%-- 卡片表格 一页7行 --%>
        <div class="admin-table-card">
            <div class="table-header">卡片一览</div>
            <table class="admin-table">
                <thead>
                <tr>
                    <th>学号/工号</th>
                    <th>姓名</th>
                    <th>状态</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <%
                    List<CampusCard> cardList =
                            (List<CampusCard>) request.getAttribute("cardList");
                    if (cardList != null && !cardList.isEmpty()) {
                        for (CampusCard card : cardList) {
                %>
                <tr>
                    <td><%= card.getPersonID() %></td>
                    <td><%= card.getName() %></td>
                    <td><%= card.getStatus() %></td>
                    <td><button class="edit-btn">编辑</button></td>
                </tr>
                <%
                    }
                } else {
                %>
                <tr><td colspan="4">暂无数据</td></tr>
                <% } %>
                </tbody>
            </table>
            <%-- 分页控件 --%>
            <div class="pagination">
                <%
                    // 已在页面开头获取过total（总条数）
                    int currentPage = (request.getAttribute("currentPage") != null) ? (int)request.getAttribute("currentPage") : 1;
                    int pageSize = 5;
                    int pageCount = (int) Math.ceil((double) total / pageSize);
                    if (pageCount == 0) pageCount = 1;

                    // 分页按钮显示优化相关参数
                    int maxPageShow = 5; // 最多连续显示的页码数
                    // 计算连续显示的起始和终止页码
                    int startPage = Math.max(1, currentPage - 2);
                    int endPage = Math.min(pageCount, currentPage + 2);
                    // 如果显示的页数不够maxPageShow个，自动调整start和end，保证数量
                    if (endPage - startPage < maxPageShow - 1) {
                        if (startPage == 1) {
                            endPage = Math.min(pageCount, startPage + maxPageShow - 1);
                        } else if (endPage == pageCount) {
                            startPage = Math.max(1, endPage - maxPageShow + 1);
                        }
                    }
                %>
                <%-- 显示总条数 --%>
                <span>共 <%= total %> 条</span>

                <%-- “上一页”按钮，当前页为1时不显示 --%>
                <% if (currentPage > 1) { %>
                <a href="${pageContext.request.contextPath}/AdminIndexServlet?currentPage=<%= currentPage - 1 %>">&lt; 上一页</a>
                <% } %>

                <%-- 如果起始页大于1，显示首页按钮（并可能加省略号） --%>
                <% if (startPage > 1) { %>
                <a href="${pageContext.request.contextPath}/AdminIndexServlet?currentPage=1">1</a>
                <%-- 如果第一页和起始页之间超过1页，加省略号 --%>
                <% if (startPage > 2) { %>
                <span>...</span>
                <% } %>
                <% } %>

                <%-- 显示当前页及其附近的页码按钮（最多maxPageShow个） --%>
                <% for (int i = startPage; i <= endPage; i++) { %>
                <% if (i == currentPage) { %>
                <span style="font-weight:bold;"><%= i %></span> <%-- 当前页高亮显示 --%>
                <% } else { %>
                <a href="${pageContext.request.contextPath}/AdminIndexServlet?currentPage=<%= i %>"><%= i %></a>
                <% } %>
                <% } %>

                <%-- 如果终止页小于总页数，显示末页按钮（并可能加省略号） --%>
                <% if (endPage < pageCount) { %>
                <%-- 如果终止页和末页之间超过1页，加省略号 --%>
                <% if (endPage < pageCount - 1) { %>
                <span>...</span>
                <% } %>
                <a href="${pageContext.request.contextPath}/AdminIndexServlet?currentPage=<%= pageCount %>"><%= pageCount %></a>
                <% } %>

                <%-- “下一页”按钮，当前页为最后一页时不显示 --%>
                <% if (currentPage < pageCount) { %>
                <a href="${pageContext.request.contextPath}/AdminIndexServlet?currentPage=<%= currentPage + 1 %>">下一页 &gt;</a>
                <% } %>
            </div>
        </div>
    </div>
</main>
</body>
</html>