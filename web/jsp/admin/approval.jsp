<%--
  Created by IntelliJ IDEA.
  User: msf
  Date: 2025/6/7
  Time: 02:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>审批处理 - 校园卡系统</title>
    <style>
        body {
            background: #f6f8fa;
            margin: 0;
            padding: 0;
            font-family: '微软雅黑', 'Arial', sans-serif;
            color: #1e2436;
        }
        .center-box {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 85vh;
        }
        .icon-box {
            font-size: 62px;
            color: #b6c7e1;
            margin-bottom: 18px;
            user-select: none;
        }
        .msg-title {
            font-size: 26px;
            font-weight: bold;
            margin-bottom: 14px;
            letter-spacing: 2px;
        }
        .msg-tip {
            color: #8391a5;
            font-size: 17px;
        }
        .back-btn {
            margin-top: 38px;
            padding: 9px 30px;
            background: #4f8cff;
            color: #fff;
            border: none;
            border-radius: 11px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.2s;
        }
        .back-btn:hover {
            background: #1e90ff;
        }
    </style>
</head>
<body>
<div class="center-box">
    <div class="icon-box">🚧</div>
    <div class="msg-title">该功能暂不支持</div>
    <div class="msg-tip">请耐心等待后续开发，或返回主页面。</div>
    <button class="back-btn" onclick="window.history.back()">返回上一页</button>
</div>
</body>
</html>
