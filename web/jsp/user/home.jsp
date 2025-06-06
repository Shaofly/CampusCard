<%--
  Created by IntelliJ IDEA.
  User: msf
  Date: 2025/6/6
  Time: 16:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
    Locale locale = (Locale) session.getAttribute("locale");
    if (locale == null) {
        locale = request.getLocale();
    }
    ResourceBundle bundle = ResourceBundle.getBundle("messages", locale);
%>
<!DOCTYPE html>
<html lang="<%= locale.getLanguage() %>">
<head>
    <meta charset="UTF-8">
    <title><%= bundle.getString("home.title") %></title>
    <link rel="stylesheet" href="../../css/user/home.css">
</head>
<body>
<div class="page-header">
    <div class="header-left">
        <img src="#" alt="logo" class="logo">
<%--        #表示logo的图片--%>
        <span class="school-name">校园卡管理系统</span>
    </div>
    <div class="header-right">
        <div class="user-name" onmouseover="toggleDropdown(true)" onmouseout="toggleDropdown(false)">
            张三
            <div id="userDropdown" class="dropdown-content">
                <a href="#" onclick="openProfileModal()"><%= bundle.getString("home.profile") %></a>
                <a href="settings.jsp"><%= bundle.getString("home.settings") %></a>
            </div>
        </div>
    </div>
</div>

<div class="main-content">
    <div class="card-row">
        <div class="card profile-card">
            <img src="#" class="avatar" alt="头像">
<%--            #表示头像的地址--%>
            <div class="info">
                <p>姓名：张三</p>
                <p>学号：20231234</p>
                <p>电话：13800001111</p>
                <a href="./myTransactions.jsp">查看流水</a>
            </div>
        </div>

        <div class="card balance-card">
            <h3>账户余额</h3>
            <p>¥123.45</p>
            <h4>待圈存金额</h4>
            <p>¥30.00</p>
        </div>
    </div>

    <div class="card-row">
        <div class="card announcement-card">
            <h3>系统公告</h3>
            <ul>
                <li>6月10日系统维护</li>
                <li>6月1日起启用新版布局</li>
            </ul>
        </div>

        <div class="card message-card">
            <h3>我的消息</h3>
            <ul>
                <li>你收到来自李四的转账 ¥20.00</li>
                <li>6月6日消费：¥15.80</li>
            </ul>
        </div>

        <div class="card transfer-card">
            <h3>转账功能</h3>
            <form action="${pageContext.request.contextPath}/TransferServlet" method="post">
                <input type="text" name="targetId" placeholder="请输入对方学号" required>
                <input type="number" step="0.01" name="amount" placeholder="转账金额" required>
                <input type="submit" value="转账">
            </form>
        </div>
    </div>
</div>

<!-- 个人信息弹窗 -->
<div id="profileModal" class="modal" style="display:none">
    <div class="modal-content">
        <span class="close" onclick="closeProfileModal()">&times;</span>
        <h2>个人信息</h2>
        <form>
            <label>姓名：</label><input type="text" value="张三" disabled><br>
            <label>学号：</label><input type="text" value="20231234" disabled><br>
            <label>电话：</label><input type="text" value="13800001111"><br>
            <input type="submit" value="保存">
        </form>
    </div>
</div>

<script>
    function toggleDropdown(show) {
        document.getElementById('userDropdown').style.display = show ? 'block' : 'none';
    }
    function openProfileModal() {
        document.getElementById('profileModal').style.display = 'block';
    }
    function closeProfileModal() {
        document.getElementById('profileModal').style.display = 'none';
    }
</script>
</body>
</html>
