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

<!DOCTYPE html>
<html lang="<%= locale.getLanguage() %>">
<head>
    <meta charset="UTF-8"/>
    <link rel="stylesheet" href="../../css/user/home.css"/>
    <title>我的主页</title>
</head>

<body>
<div class="page-header">
    <div class="header-left">
        <img src="../../img/logo.png" alt="logo">
        我的主页
    </div>
    <div class="header-right">
        张三
        <div class="dropdown-content">
            <a href="#">个人信息</a>
            <a href="#">系统设置</a>
            <a href="${pageContext.request.contextPath}/LogoutServlet">退出登录</a>
        </div>
    </div>
</div>

<div class="main-content">
    <div class="card-row">
        <div class="card profile-card">
            <img src="#" class="avatar" alt="头像">
            <div class="info">
                <h3 style="font-size: 20px">基本信息</h3>
                <p>姓名：张三</p>
                <p>学号：2023111234</p>
                <p>电话：13800001111</p>
                <a href="${pageContext.request.contextPath}/jsp/user/myTransactions.jsp"
                   class="myTransaction-btn">查看流水</a>
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
                <input type="button" value="转账"
                       onclick="openModal(document.querySelector('.transfer-card input[type=text]').value)">
            </form>
        </div>
    </div>
</div>

<div style="text-align: center; margin-top: 20px;">
    <a href="${pageContext.request.contextPath}/jsp/admin/index.jsp" style="
        display: inline-block;
        padding: 8px 16px;
        background-color: #ccc;
        color: #000;
        text-decoration: none;
        border-radius: 6px;
        font-size: 13px;">
        🚀 管理员界面
    </a>
</div>

<!-- 遮罩层+弹窗 -->
<div id="transfer-modal" class="modal-overlay" style="display: none;">
    <div class="modal-card">
        <h3>转账验证</h3>
        <form id="modal-transfer-form">
            <div class="input-row">
                <label>对方学号</label>
                <input type="text" id="modal-personID" name="personID" required readonly>
            </div>
            <div class="input-row">
                <label>对方姓名</label>
                <input type="text" id="modal-name" name="name" required>
            </div>
            <div class="input-row">
                <label>支付密码</label>
                <input type="password" id="modal-passwordPay" name="passwordPay" required>
            </div>
            <div class="modal-btn-row">
                <button type="submit" class="modal-confirm-btn">确认转账</button>
                <button type="button" class="modal-cancel-btn" onclick="closeModal()">取消</button>
            </div>
        </form>
    </div>
</div>

<script>
    function openModal(personID) {
        document.getElementById('transfer-modal').style.display = 'flex';
        document.getElementById('modal-personID').value = personID || ''; // 支持自动填
        document.getElementById('modal-name').value = '';
        document.getElementById('modal-passwordPay').value = '';
    }

    // 关闭弹窗
    function closeModal() {
        document.getElementById('transfer-modal').style.display = 'none';
    }

    // 拦截表单默认提交行为，做自己的校验/处理
    document.getElementById('modal-transfer-form').onsubmit = function (e) {
        e.preventDefault();
        // 这里可以做ajax请求或者前端校验
        alert('验证通过！准备发起后端转账请求（这里你可以补充AJAX代码）');
        closeModal();
    };
</script>
</body>

</html>