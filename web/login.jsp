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
    <title><%= bundle.getString("login.title") %></title>
    <style>

        body {
            margin: 0;
            padding: 0;
            background-image: url('./img/loginBackground.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;

            font-family:
                /* 英文字体优先：现代清爽 */
                    "Segoe UI", "Helvetica Neue", "Arial",

                        /* 中文字体 fallback：覆盖 Windows、macOS 常用字体 */
                    "Microsoft YaHei", "PingFang SC", "Noto Sans CJK SC", "Heiti SC",

                        /* 兜底字体 */
                    sans-serif;
        }

        .page-header {
            position: fixed;
            top: 0;
            width: 100%;
            height: 60px;
            background: rgba(255, 255, 255, 0.7);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            display: flex;
            align-items: center;
            padding-left: 30px;
            font-size: 18px;
            font-weight: bold;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
            z-index: 1000;
        }

        .page-header .header-left {
            font-size: 20px;
            font-weight: 600;
            color: #2c3e50;
            text-shadow: 1px 1px 2px rgba(255, 255, 255, 0.3);
        }

        .login-box {
            width: 360px;
            margin: 160px auto;
            padding: 40px;
            background: rgba(255, 255, 255, 0.33); /* 半透明 */
            backdrop-filter: blur(12px); /* 模糊背景 */
            -webkit-backdrop-filter: blur(12px); /* 兼容 Safari */
            border-radius: 12px;
            box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
            text-align: center;
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        /*.login-box:hover{*/
        /*    transform: translateY(-2px);*/
        /*    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.15);*/
        /*    border: 1px solid rgba(255, 255, 255, 0.5);*/
        /*    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);*/
        /*}*/

        .login-box h1 {
            margin-bottom: 30px;
            font-size: 28px;
        }

        .login-box input[type="text"],
        .login-box input[type="password"] {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
            box-sizing: border-box;
        }

        .login-box .options {
            text-align: right;
            font-size: 12px;
            margin-top: -5px;
            margin-bottom: 10px;
            padding-right: 2px;
            box-sizing: border-box;
            width: 100%;  /* 确保和 input 对齐 */
        }

        .login-box .tip {
            text-align: left;
            font-size: 12px;
            color: #555;
            margin-top: 10px;
        }

        .login-box input[type="submit"] {
            width: 100%;
            padding: 12px;
            background-color: #1e90ff;
            border: none;
            color: white;
            border-radius: 6px;
            cursor: pointer;
            font-size: 15px;
        }

        .login-box .language-switch {
            margin-top: 20px;
            font-size: 12px;
            text-align: center;
            color: #333;
        }

        .login-box .language-switch a {
            color: #1e90ff;
            text-decoration: none;
            margin-left: 4px;
        }

        .login-box .language-switch a:hover {
            text-decoration: underline;
        }
    </style>

</head>

<body>
<%-- 系统标题 --%>
<div class="page-header">
    <div class="header-left">
        <%= bundle.getString("login.title") %>
    </div>
</div>

<div class="login-box">
    <%-- 登录标题 --%>
    <h1><%= bundle.getString("login.login") %></h1>

    <%--  --%>
    <form action="../LoginServlet" method="post">
        <input type="text" name="personID" placeholder="<%= bundle.getString("login.account") %>" required>
        <input type="password" name="password" placeholder="<%= bundle.getString("login.password") %>" required>

        <div class="options">
            <a href="#"><%= bundle.getString("login.forgotPassword") %></a>
        </div>

        <input type="submit" value="<%= bundle.getString("login.submit") %>">
    </form>

    <%-- 温馨提示 --%>
    <div class="tip">
        <%= bundle.getString("login.tip") %>
    </div>

    <%-- 切换语言 --%>
    <div class="language-switch">
        <form id="languageForm" action="${pageContext.request.contextPath}/ChangeLanguageServlet" method="post" style="display:none;">
            <input type="hidden" name="language" id="langInput">
        </form>
        <a href="javascript:void(0);" onclick="changeLanguage()">
            <%= bundle.getString("login.changeLanguage") %>
        </a>
    </div>
</div>

<div style="text-align: center; margin-top: 20px;">
    <a href="jsp/user/home.jsp" style="
        display: inline-block;
        padding: 8px 16px;
        background-color: #ccc;
        color: #000;
        text-decoration: none;
        border-radius: 6px;
        font-size: 13px;">
        🚀 测试跳转首页（开发用）
    </a>
</div>

<script>
    function changeLanguage() {
        // 当前语言由后端JSP输出，始终与session同步，不会错
        const currentLang = "<%= locale.getLanguage() %>";
        // 目标语言自动判断
        const newLanguage = currentLang === "zh" ? "en" : "zh";
        // 把目标语言写到隐藏表单
        document.getElementById('langInput').value = newLanguage;
        // 自动提交表单
        document.getElementById('languageForm').submit();
    }

</script>
</body>
</html>
