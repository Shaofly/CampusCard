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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user/transferModal.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user/profileModal.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user/transactionModal.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/modalOverlay.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/verticalInputRow.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/horizontalInputRow.css"/>
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
            <a href="#" id="user-info-btn">个人信息</a>
            <a href="#">系统设置</a>
            <a href="${pageContext.request.contextPath}/LogoutServlet">退出登录</a>
        </div>
    </div>
</div>

<div class="main-content">
    <div class="card-row">
        <%
            // 判断头像地址是否为空
            String avatarPath = card.getAvatar();
            if (avatarPath == null || avatarPath.trim().isEmpty()) {
                avatarPath = "/img/userAvatar/default.png";
            }
        %>
        <div class="card profile-card">
            <img src='<%= request.getContextPath() + avatarPath %>' class="avatar" alt="未设置头像"
                 onerror="this.onerror=null;this.src='/img/userAvatar/default.png';">
            <div class="info">
                <h3 style="font-size: 20px">基本信息</h3>
                <p>姓名：<%= card.getName() %></p>
                <p>学号：<%= card.getPersonID() %></p>
                <p>电话：<%= card.getPhoneNumber() %></p>
                <button type="button" class="myTransaction-btn" onclick="showRecentTransactions()">查看流水</button>
            </div>
        </div>

        <div class="card balance-card">
            <h3>账户余额</h3>
            <p>¥<%= String.format("%.2f", card.getBalance()) %></p>
            <h4>待圈存金额</h4>
            <p>¥<%= String.format("%.2f", card.getPendingBalance()) %></p>
        </div>
    </div>

    <div class="card-row">
        <div class="card announcement-card">
            <h3>系统公告</h3>
            <ul>
                <li>6月10日系统维护</li>
                <li>6月16日系统维护</li>
            </ul>
        </div>

        <div class="card message-card">
            <h3>我的消息</h3>
            <ul>
                <%
                    String message = card.getMessage();
                    if (message == null || message.trim().isEmpty()) {
                %>
                <li>暂无消息</li>
                <%
                } else {
                %>
                <li><%= message %></li>
                <%
                    }
                %>
            </ul>
        </div>

        <div class="card transfer-card">
            <h3>转账功能</h3>
            <form>
                <input type="text" placeholder="请输入对方学号">
                <input type="number" placeholder="转账金额" min="0" step="5"
                       oninput="this.value = this.value < 0 ? '' : this.value;">
                <!-- 判断输入是否为负数 -->
                <input type="button" class="myTransaction-btn" value="转账"
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
        font-size: 16px;
        font-weight: 500;
        box-shadow: 0 2px 8px rgba(79,140,255,0.10);
        transition: background 0.2s;">
        🚀 管理页面
    </a>
</div>
<%
    }
%>

<!-- 遮罩层 + 转账弹窗 -->
<div id="transfer-modal" class="modal-overlay" style="display: none;">
    <div class="transfer-modal-card">
        <h3>转账验证</h3>
        <form id="modal-transfer-form" autocomplete="off">
            <div class="input-row-vertical">
                <label>被转账人学号</label>
                <input type="text" id="modal-personID" name="personID" required readonly>
            </div>
            <div class="input-row-vertical">
                <label>被转账人姓名</label>
                <input type="text" id="modal-name" name="name" required>
            </div>
            <div class="input-row-vertical">
                <label>转账金额</label>
                <input type="number" id="modal-amount" name="amount" required readonly>
            </div>
            <div class="input-row-vertical">
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

<!-- 遮罩层 + 个人信息编辑弹窗 -->
<div id="user-edit-modal" class="modal-overlay" style="display: none;">
    <div class="profile-modal-card">
        <h3 style="font-size: 24px">个人信息</h3>
        <form id="user-edit-form" autocomplete="off">
            <div class="profile-modal-form-grid">
                <!-- 姓名（只读） -->
                <div class="input-row-horizontal">
                    <label>姓名</label>
                    <input type="text" id="user-name" name="name" required readonly>
                </div>
                <!-- 性别（只读） -->
                <div class="input-row-horizontal">
                    <label>性别</label>
                    <input type="text" id="user-gender" name="gender" required readonly>
                </div>
                <!-- 学号（只读） -->
                <div class="input-row-horizontal">
                    <label>学号</label>
                    <input type="text" id="user-personID" name="personID" required readonly>
                </div>
                <!-- 学院（只读） -->
                <div class="input-row-horizontal">
                    <label>学院</label>
                    <input type="text" id="user-department" name="department" required readonly>
                </div>
                <!-- 专业（只读） -->
                <div class="input-row-horizontal">
                    <label>专业</label>
                    <input type="text" id="user-major" name="major" required readonly>
                </div>
                <!-- 手机号 -->
                <div class="input-row-horizontal">
                    <label>手机号</label>
                    <input type="text" id="user-phoneNumber" name="phoneNumber">
                </div>
                <!-- 单词消费限额 -->
                <div class="input-row-horizontal">
                    <label>单次消费限额</label>
                    <input type="text" id="user-maxLimit" name="maxLimit" required readonly>
                </div>
                <!-- 邮箱 -->
                <div class="input-row-horizontal">
                    <label>邮箱</label>
                    <input type="email" id="user-email" name="email">
                </div>
            </div>
            <div class="modal-btn-row">
                <button type="submit" class="modal-confirm-btn">保存</button>
                <button type="button" class="modal-cancel-btn" onclick="closeUserEditModal()">取消</button>
            </div>
        </form>
    </div>
</div>

<div id="transaction-modal" class="modal-overlay" style="display:none;">
    <div class="transaction-modal-card">
        <h3>最近10条交易流水</h3>
        <div id="transaction-table-wrapper">
            <!-- 数据动态填充 -->
            <table>
                <thead>
                <tr>
                    <th>编号</th>
                    <th>类型</th>
                    <th>时间</th>
                    <th>地点</th>
                </tr>
                </thead>
                <tbody id="transaction-tbody"></tbody>
            </table>
        </div>
        <div style="text-align:right;padding-top:12px;">
            <button onclick="closeTransactionModal()">关闭</button>
        </div>
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
        const modalCard = modalOverlay.querySelector('.transfer-modal-card');
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


    // 打开个人信息弹窗，并填充当前用户信息（card是CampusCard对象）
    function openUserEditModal(card) {
        document.getElementById('user-edit-modal').style.display = 'flex';
        document.getElementById('user-name').value = card.name || '';
        document.getElementById('user-gender').value = card.gender || '';
        document.getElementById('user-personID').value = card.personID || '';
        document.getElementById('user-department').value = card.department || '';
        document.getElementById('user-major').value = card.major || '';
        document.getElementById('user-phoneNumber').value = card.phoneNumber || '';
        document.getElementById('user-email').value = card.email || '';
        document.getElementById('user-maxLimit').value = card.maxLimit || '';
    }

    // 关闭弹窗动画
    function closeUserEditModal() {
        const modal = document.getElementById('user-edit-modal');
        modal.classList.add('closing');
        setTimeout(() => {
            modal.style.display = 'none';
            modal.classList.remove('closing');
        }, 350);
    }

    // 个人信息表单提交（走 UpdateCardServlet）
    document.getElementById('user-edit-form').onsubmit = function (e) {
        e.preventDefault();
        const formData = new FormData(this);
        const xhr = new XMLHttpRequest();
        xhr.open("POST", "<%= request.getContextPath() %>/UpdateCardServlet", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                closeUserEditModal();
                try {
                    const res = JSON.parse(xhr.responseText);
                    if (xhr.status === 200 && res.success) {
                        alert("保存成功！");
                        location.reload();
                    } else {
                        alert("保存失败：" + (res.msg || "未知错误"));
                    }
                } catch (err) {
                    alert("服务器异常：" + xhr.responseText);
                }
            }
        };
        xhr.send(new URLSearchParams(formData).toString());
    };

    document.getElementById('user-info-btn').onclick = function(e) {
        e.preventDefault(); // 防止跳转
        openUserEditModal({
            name: "<%= card.getName() %>",
            gender: "<%= card.getGender() %>",
            personID: "<%= card.getPersonID() %>",
            department: "<%= card.getDepartment() %>",
            major: "<%= card.getMajor() %>",
            phoneNumber: "<%= card.getPhoneNumber() %>",
            email: "<%= card.getEmail() %>",
            maxLimit: <%= card.getMaxLimit() %>
        });
    };

    // 查询最近流水记录
    function showRecentTransactions() {
        // 假设页面上有全局personID变量，如果没有可直接拼接JSP：
        var personID = '<%= card.getPersonID() %>';
        fetch('<%=request.getContextPath()%>/RecentTransactionServlet?personID=' + encodeURIComponent(personID))
            .then(res => res.json())
            .then(data => {
                if (!data.success) {
                    alert(data.msg || '查询失败');
                    return;
                }
                var tbody = document.getElementById('transaction-tbody');
                tbody.innerHTML = "";
                if (!data.data || data.data.length === 0) {
                    tbody.innerHTML = '<tr><td colspan="4">暂无数据</td></tr>';
                } else {
                    data.data.forEach(item => {
                        var tr = document.createElement('tr');
                        tr.innerHTML = '<td>' + item.recordID + '</td>' +
                            '<td>' + item.type + '</td>' +
                            '<td>' + item.transactionTime + '</td>' +
                            '<td>' + item.location + '</td>';
                        tbody.appendChild(tr);
                    });
                }
                document.getElementById('transaction-modal').style.display = 'flex';
            }).catch(() => {
            alert("服务器异常");
        });
    }

    function closeTransactionModal() {
        document.getElementById('transaction-modal').style.display = 'none';
    }
</script>
</body>

</html>