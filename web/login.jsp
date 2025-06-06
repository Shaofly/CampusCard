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
<html>
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
            font-family: "Helvetica Neue", Arial, sans-serif;
        }

        .login-box {
            width: 360px;
            margin: 100px auto;
            padding: 40px;
            background-color: rgba(255,255,255,0.9);
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            text-align: center;
        }

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
        }

        .login-box .options {
            text-align: right;
            font-size: 12px;
            margin-top: -5px;
            margin-bottom: 10px;
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
<div class="login-box">
    <%-- 登录标题 --%>
    <h1><%= bundle.getString("login.title") %></h1>

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

<script>
    // 当前语言由后端JSP输出，始终与session同步，不会错
    const currentLang = "<%= locale.getLanguage() %>";

    function changeLanguage() {
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
