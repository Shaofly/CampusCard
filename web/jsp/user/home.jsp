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

<%-- 取出card --%>
<%
    CampusCard card = (CampusCard) request.getAttribute("loginCard");
%>

<!DOCTYPE html>
<html lang="<%= locale.getLanguage() %>">
<head>
    <meta charset="UTF-8"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user/home.css"/>
    <title>我的主页</title>
</head>

<body>
<div class="page-header">
    <div class="header-left">
        <img src="${pageContext.request.contextPath}/img/logo.png" alt="logo">
        我的主页
    </div>
    <div class="header-right">
        <%-- 右上方姓名 --%>
        <%= card.getName() %>
        <%-- 悬浮菜单 --%>
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
            <img src="<%= card.getAvatar() %>" class="avatar" alt="头像">
            <div class="info">
                <h3 style="font-size: 20px">基本信息</h3>
                <p>姓名：<%= card.getName() %></p>
                <p>学号：<%= card.getPersonID() %></p>
                <p>电话：<%= card.getPhoneNumber() %></p>
                <a href="${pageContext.request.contextPath}/jsp/user/myTransactions.jsp"
                   class="myTransaction-btn">查看流水</a>
            </div>
        </div>

        <div class="card balance-card">
            <h3>账户余额</h3>
            <p>¥<%= card.getBalance() %></p>
            <h4>待圈存金额</h4>
            <p>¥<%= card.getPendingBalance() %></p>
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
                       onclick="openModal(
                           document.querySelector('.transfer-card input[type=text]').value,
                           document.querySelector('.transfer-card input[type=number]').value
                       )">
            </form>
        </div>
    </div>
</div>

<%-- 管理员页面进入按钮，仅管理员可见 --%>
<%
    boolean isAdmin = card.isAdmin();
    if (isAdmin) {
%>
<div style="text-align: center; margin-top: 20px;">
    <a href="${pageContext.request.contextPath}/AdminIndexServlet?currentPage=1&pageSize=5" style="
        display: inline-block;
        padding: 8px 16px;
        background-color: #ccc;
        color: #000;
        text-decoration: none;
        border-radius: 6px;
        font-size: 14px;
        font-weight: 500;
        box-shadow: 0 2px 8px rgba(79,140,255,0.10);
        transition: background 0.2s;">
        🚀 管理员界面
    </a>
</div>
<%
    }
%>

<!-- 遮罩层+弹窗 -->
<div id="transfer-modal" class="modal-overlay" style="display: none;">
    <div class="modal-card">
        <h3>转账验证</h3>
        <form id="modal-transfer-form" autocomplete="off">
            <div class="input-row">
                <label>被转账人学号</label>
                <input type="text" id="modal-personID" name="personID" required readonly>
            </div>
            <div class="input-row">
                <label>被转账人姓名</label>
                <input type="text" id="modal-name" name="name" required>
            </div>
            <div class="input-row">
                <label>转账金额</label>
                <input type="number" id="modal-amount" name="amount" required readonly>
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
    function openModal(personID,amount) {
        document.getElementById('transfer-modal').style.display = 'flex';
        document.getElementById('modal-personID').value = personID || '';
        document.getElementById('modal-name').value = '';
        document.getElementById('modal-amount').value = amount || '';
        document.getElementById('modal-passwordPay').value = '';
    }

    // 关闭弹窗（带动画）
    function closeModal() {
        const modalOverlay = document.getElementById('transfer-modal');
        const modalCard = modalOverlay.querySelector('.modal-card');
        modalOverlay.classList.add('closing');
        modalCard.classList.add('closing');
        setTimeout(() => {
            modalOverlay.style.display = 'none';
            modalOverlay.classList.remove('closing');
            modalCard.classList.remove('closing');
        }, 350);
    }

    // 拦截表单默认提交行为，做ajax转账请求
    document.getElementById('modal-transfer-form').onsubmit = function (e) {
        e.preventDefault();
        const personID = document.getElementById('modal-personID').value.trim();
        const name = document.getElementById('modal-name').value.trim();
        const amount = document.getElementById('modal-amount').value.trim();
        const passwordPay = document.getElementById('modal-passwordPay').value.trim();

        if (!personID || !amount || !passwordPay) {
            alert("请填写完整信息");
            return;
        }
        if (parseFloat(amount) <= 0) {
            alert("转账金额必须大于0");
            return;
        }
        // 发送ajax请求
        const xhr = new XMLHttpRequest();
        xhr.open("POST", "<%= request.getContextPath() %>/TransferServlet", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                closeModal();
                try {
                    const res = JSON.parse(xhr.responseText);
                    if (xhr.status === 200 && res.success) {
                        alert("转账成功！");
                        location.reload();
                    } else {
                        alert("转账失败：" + (res.msg || "未知错误"));
                    }
                } catch (err) {
                    alert("服务器异常：" + xhr.responseText);
                }
            }
        };
        xhr.send(
            "personID=" + encodeURIComponent(personID) +
            "&name=" + encodeURIComponent(name) +
            "&amount=" + encodeURIComponent(amount) +
            "&passwordPay=" + encodeURIComponent(passwordPay)
        );
    };
</script>
</body>

</html>