<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
    <meta charset="UTF-8" />
    <title><%= bundle.getString("home.title") %></title>
    <link rel="stylesheet" href="../../css/home.css" />
    <meta charset="UTF-8" />
    <title>我的主页</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: "Segoe UI", "Helvetica Neue", Arial, "Microsoft YaHei", "PingFang SC", sans-serif;
            background-color: #f5f7fa;
            background-image: url('../../img/heart.jpg');
            background-size: cover;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-left: 30px;
            padding-right: 30px;
            height: 60px;
            background: rgba(255, 255, 255, 0.7);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            z-index: 1000;
        }

        .header-left {
            display: flex;
            align-items: center;
            gap: 10px;
            font-weight: 600;
            font-size: 18px;
            color: #2c3e50;
        }

        .header-left img {
            height: 36px;
        }

        .header-right {
            margin-right: 40px;
            box-sizing: border-box;
            height: 100%;
            width: 100px;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            font-size: 16px;
            cursor: pointer;
        }

        .header-right:hover {
            color: #0071e3;
            /* Apple蓝色 */
            background: rgba(245, 245, 245, 0.7);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);

        }

        .dropdown-content {
            display: none;
            position: absolute;
            font-size: 14px;
            right: 0;
            width: 100px;
            top: 100%;
            background: rgba(255, 255, 255, 0.7);
            border-radius: 8px;
            backdrop-filter: blur(8px);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            border: 1px solid rgba(200, 200, 200, 0.2);
        }

        .header-right:hover .dropdown-content {
            display: block;
        }

        .dropdown-content a {
            display: block;
            padding: 10px 20px;
            text-decoration: none;
            /* 去掉下划线 */
            color: rgba(29, 29, 31, 1);
        }

        .dropdown-content a:hover {
            background: rgba(240, 240, 240, 0.85);
            color: #0071e3;
            /* Apple蓝色 */
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            transform: translateY(-2px);
        }

        .main-content {
            margin-top: 80px;
            padding: 30px;
            display: flex;
            flex-direction: column;
            justify-content: space-around;
            align-items: center;
            gap: 24px;
        }

        .card-row {
            display: flex;
            gap: 20px;
            padding:20px;
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border-radius: 12px;
            box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
            flex-wrap: wrap;
            justify-content: space-around;
            width: 100%;
            min-width: 350px;
            max-width: 1200px;
            background: rgba(255, 255, 255, 0.2);
        }

        .card {
            display: block;
            background: rgba(255, 255, 255, 0.5);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            flex:1;
            min-width: 300px;
            max-width: 100%;
        }

        .card:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.15);
            border: 1px solid rgba(255, 255, 255, 0.3);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .card h3 {
            margin-top: 0;
            font-size: 18px;
            color: #2c3e50;
        }

        .profile-card {
            display: flex;
            gap: 16px;
            flex:2;
        }

        .avatar {
            height: 100%;
            aspect-ratio: 1 / 1;
            border-radius: 20%;
            background-color: #ccc;
            object-fit: cover;
        }

        .info p {
            margin: 4px 0;
            font-size: 14px;
            color: #555;
        }

        .announcement-card ul,
        .message-card ul {
            padding: 0;
            margin: 0;
            list-style: none;
        }

        .announcement-card li,
        .message-card li {
            font-size: 13px;
            margin-bottom: 6px;
        }

        .transfer-card input {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 6px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }

        .transfer-card input[type="submit"] {
            background-color: #1e90ff;
            color: white;
            border: none;
            cursor: pointer;
        }
    </style>
</head>

<body>
<div class="page-header">
    <div class="header-left">
        <img src="#" alt="logo">
        校园卡系统
    </div>
    <div class="header-right">
        张三
        <div class="dropdown-content">
            <a href="#">个人信息</a>
            <a href="#">系统设置</a>
            <a href="#">退出登录</a>
        </div>
    </div>
</div>

<div class="main-content">
    <div class="card-row">
        <div class="card profile-card">
            <img src="#" class="avatar" alt="头像">
            <div class="info">
                <p>姓名：张三</p>
                <p>学号：2023111234</p>
                <p>电话：13800001111</p>
                <a href="#">查看流水</a>
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
                <li>新版UI上线</li>
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
            <form>
                <input type="text" placeholder="请输入对方学号">
                <input type="number" placeholder="转账金额" min="0" step="5"
                       oninput="this.value = this.value < 0 ? '' : this.value;">
                <!-- 判断输入是否为负数 -->
                <input type="submit" value="转账">
            </form>
        </div>
    </div>
</div>
</body>

</html>