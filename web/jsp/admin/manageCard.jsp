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
    //取出 card
    CampusCard loginCard = (CampusCard) request.getAttribute("loginCard");
%>

<!-- index.jsp 管理员主页/统计视图 -->
<!DOCTYPE html>
<html lang="<%= locale.getLanguage() %>">
<head>
    <meta charset="UTF-8"/>
    <title>管理员主页-校园卡系统</title>
    <%--   引入css --%>
    <link rel="stylesheet" href=" <%=request.getContextPath()%>/css/admin/sidebar.css"/>
    <link rel="stylesheet" href=" <%=request.getContextPath()%>/css/admin/manageCard.css"/>
    <link rel="stylesheet" href=" <%=request.getContextPath()%>/css/admin/editModal.css"/>
    <link rel="stylesheet" href=" <%=request.getContextPath()%>/css/admin/choiceModal.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/modalOverlay.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/horizontalInputRow.css"/>
</head>
<body>
<%-- 侧边导航栏 --%>
<aside class="admin-sidebar">
    <div class="admin-logo">
        <img src=" <%=request.getContextPath()%>/img/logo.png" alt="logo">
        <span>校园卡系统</span>
    </div>
    <nav class="admin-nav">
        <a href="${pageContext.request.contextPath}/AdminIndexServlet?currentPage=1&pageSize=5" class="nav-item">统计视图</a>
        <a href="${pageContext.request.contextPath}/CardManageServlet?currentPage=1&pageSize=10" class="nav-item active">人员管理</a>
        <a href="${pageContext.request.contextPath}/jsp/admin/approval.jsp" class="nav-item">审批处理</a>
    </nav>
    <div class="admin-home">
        <a href="${pageContext.request.contextPath}/UserHomeServlet" class="admin-home-item">
            🏠 我的主页
        </a>
    </div>
    <div class="admin-sidebar-bottom">
        <a href="${pageContext.request.contextPath}/LogoutServlet" class="logout-link">退出登录</a>
    </div>
</aside>

<%-- 视图主要内容 --%>
<main class="admin-main">
    <%--  视图头部  --%>
    <div class="admin-header">
        <span class="admin-title">人员管理</span>
        <%-- 这里可以加管理员信息 --%>
        <span class="admin-user-info">欢迎，管理员<strong><%= loginCard.getName() %></strong></span>
    </div>
    <%-- 工具栏：搜索和新增卡片 --%>
    <div class="admin-table-toolbar">
        <form method="get" action="${pageContext.request.contextPath}/CardSearchServlet" style="display: flex; width: 100%;">
            <input type="text" name="keyword" value="<%= request.getAttribute("keyword") != null ? request.getAttribute("keyword") : "" %>"
                   class="admin-search-input"
                   placeholder="输入卡号/学号/姓名搜索…" autocomplete="off">
            <button type="submit" class="search-btn">搜索</button>
        </form>
        <button class="add-card-btn" type="button" onclick="openAddCardTypeModal()">新增卡片</button>
    </div>
    <%-- 卡片表格 一页10行 --%>
    <div class="admin-table-card">
        <div class="table-header">管理卡片</div>
        <div class="table-content">
            <table class="admin-table">
                <thead>
                <tr>
                    <th>卡号</th> <!-- 新增 -->
                    <th>学号/工号</th>
                    <th>姓名</th>
                    <th>状态</th>
                    <th>编辑</th>
                    <th>注销</th> <!-- 新增 -->
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
                    <td><%= card.getCardID() %></td>   <!-- 新增：卡号 -->
                    <td><%= card.getPersonID() %></td>
                    <td><%= card.getName() %></td>
                    <td><%= card.getStatus() %></td>
                    <td>
                        <button class="edit-btn"
                                onclick='openAdminEditModal({
                                        cardID: "<%= card.getCardID() %>",
                                        name: "<%= card.getName() %>",
                                        personID: "<%= card.getPersonID() %>",
                                        gender: "<%= card.getGender() %>",
                                        department: "<%= card.getDepartment() %>",
                                        major: "<%= card.getMajor() %>",
                                        status: "<%= card.getStatus() %>",
                                        cardType: "<%= card.getCardType() %>",
                                        campusLocation: "<%= card.getCampusLocation() %>",
                                        role: "<%= card.getRole() %>",
                                        registerDate: "<%= card.getRegisterDateString() %>",
                                        IDNumber: "<%= card.getIDNumber() %>",
                                        password: "<%= card.getPassword() == null ? "" : card.getPassword() %>",
                                        passwordPay: "<%= card.getPasswordPay() == null ? "" : card.getPasswordPay() %>",
                                        phoneNumber: "<%= card.getPhoneNumber() %>",
                                        email: "<%= card.getEmail() %>",
                                        maxLimit: "<%= card.getMaxLimit() %>"
                                        })'>编辑</button>
                    </td>
                    <td>
                        <button class="cancel-btn"
                                onclick="confirmCancelCard('<%= card.getCardID() %>')">
                            注销
                        </button>
                    </td>  <!-- 新增：删除 -->
                </tr>
                <%
                    }
                } else {
                %>
                <tr><td colspan="6">暂无数据</td></tr>
                <% } %>
                </tbody>
            </table>
        </div>
        <%-- 分页控件 --%>
        <div class="pagination">
            <%
                // 当前页、每页条数、总条数等从 request 取出
                int currentPage = (request.getAttribute("currentPage") != null) ? (int)request.getAttribute("currentPage") : 1;
                int pageSize = (request.getAttribute("pageSize") != null) ? (int)request.getAttribute("pageSize") : 10;
                int total = (request.getAttribute("total") != null) ? (int)request.getAttribute("total") : 0;
                String keyword = request.getParameter("keyword") == null ? "" : request.getParameter("keyword");

                int pageCount = (int) Math.ceil((double) total / pageSize);
                if (pageCount == 0) pageCount = 1; // 保证至少1页

                // 最多显示的连续页码数
                int maxPageShow = 5;
                int startPage = Math.max(1, currentPage - 2);
                int endPage = Math.min(pageCount, currentPage + 2);
                // 如果页数不够 maxPageShow 个，自动调整
                if (endPage - startPage < maxPageShow - 1) {
                    if (startPage == 1) {
                        endPage = Math.min(pageCount, startPage + maxPageShow - 1);
                    } else if (endPage == pageCount) {
                        startPage = Math.max(1, endPage - maxPageShow + 1);
                    }
                }
            %>
            <%-- 总条数 --%>
            <span>共 <%= total %> 条</span>

            <%-- 上一页按钮，只有在当前页大于1时显示 --%>
            <% if (currentPage > 1) { %>
            <a href="${pageContext.request.contextPath}/CardSearchServlet?keyword=<%= keyword %>&currentPage=<%= currentPage - 1 %>&pageSize=<%= pageSize %>">&lt; 上一页</a>
            <% } %>

            <%-- 如果起始页大于1，显示首页和省略号 --%>
            <% if (startPage > 1) { %>
            <a href="${pageContext.request.contextPath}/CardSearchServlet?keyword=<%= keyword %>&currentPage=1&pageSize=<%= pageSize %>">1</a>
            <% if (startPage > 2) { %>
            <span>...</span>
            <% } %>
            <% } %>

            <%-- 主体页码按钮 --%>
            <% for (int i = startPage; i <= endPage; i++) {
                if (i == currentPage) { %>
            <span style="font-weight:bold;"><%= i %></span>
            <% } else { %>
            <a href="${pageContext.request.contextPath}/CardSearchServlet?keyword=<%= keyword %>&currentPage=<%= i %>&pageSize=<%= pageSize %>"><%= i %></a>
            <% }
            } %>

            <%-- 如果终止页小于总页数，显示省略号和尾页 --%>
            <% if (endPage < pageCount) { %>
            <% if (endPage < pageCount - 1) { %>
            <span>...</span>
            <% } %>
            <a href="${pageContext.request.contextPath}/CardSearchServlet?keyword=<%= keyword %>&currentPage=<%= pageCount %>&pageSize=<%= pageSize %>"><%= pageCount %></a>
            <% } %>

            <%-- 下一页按钮，只有在当前页小于总页数时显示 --%>
            <% if (currentPage < pageCount) { %>
            <a href="${pageContext.request.contextPath}/CardSearchServlet?keyword=<%= keyword %>&currentPage=<%= currentPage + 1 %>&pageSize=<%= pageSize %>">下一页 &gt;</a>
            <% } %>
        </div>
    </div>
</main>

<!-- 编辑校园卡信息弹窗（管理员专用） -->
<div id="admin-edit-modal" class="modal-overlay" style="display: none;">
    <div class="modal-card">
        <h3>编辑校园卡信息</h3>
        <form id="admin-edit-form" autocomplete="off">
            <div class="modal-form-grid">
                <!-- 卡号（只读） -->
                <div class="input-row-horizontal">
                    <label>卡号</label>
                    <input type="text" id="edit-cardID" name="cardID" required readonly>
                </div>
                <!-- 姓名 -->
                <div class="input-row-horizontal">
                    <label>姓名</label>
                    <input type="text" id="edit-name" name="name" required>
                </div>
                <!-- 学号 -->
                <div class="input-row-horizontal">
                    <label>学号</label>
                    <input type="text" id="edit-personID" name="personID" required readonly>
                </div>
                <!-- 性别 -->
                <div class="input-row-horizontal">
                    <label>性别</label>
                    <input type="text" id="edit-gender" name="gender" required>
                </div>
                <!-- 学院 -->
                <div class="input-row-horizontal">
                    <label>学院</label>
                    <input type="text" id="edit-department" name="department">
                </div>
                <!-- 专业 -->
                <div class="input-row-horizontal">
                    <label>专业</label>
                    <input type="text" id="edit-major" name="major">
                </div>
                <!-- 状态 -->
                <div class="input-row-horizontal">
                    <label>状态</label>
                    <select id="edit-status" name="status" required>
                        <option value="正常">正常</option>
                        <option value="挂失">挂失</option>
                        <option value="冻结">冻结</option>
                        <option value="注销">注销</option>
                    </select>
                </div>
                <!-- 类型 -->
                <div class="input-row-horizontal">
                    <label>类型</label>
                    <select id="edit-cardType" name="cardType" required>
                        <option value="正式">正式</option>
                        <option value="临时">临时</option>
                    </select>
                </div>
                <!-- 校区 -->
                <div class="input-row-horizontal">
                    <label>校区</label>
                    <select id="edit-campusLocation" name="campusLocation" required>
                        <option value="合肥校区">合肥校区</option>
                        <option value="宣城校区">宣城校区</option>
                    </select>
                </div>
                <!-- 身份 -->
                <div class="input-row-horizontal">
                    <label>身份</label>
                    <input type="text" id="edit-role" name="role" required>
                </div>
                <!-- 开卡日期（只读） -->
                <div class="input-row-horizontal">
                    <label>开卡日期</label>
                    <input type="text" id="edit-registerDate" name="registerDate" readonly>
                </div>
                <!-- 身份证号 -->
                <div class="input-row-horizontal">
                    <label>身份证号</label>
                    <input type="text" id="edit-IDNumber" name="IDNumber">
                </div>
                <!-- 只读：手机号、邮箱 -->
                <div class="input-row-horizontal">
                    <label>手机号</label>
                    <input type="text" id="edit-phoneNumber" name="phoneNumber" readonly>
                </div>
                <div class="input-row-horizontal">
                    <label>邮箱</label>
                    <input type="text" id="edit-email" name="email" readonly>
                </div>
                <!-- 登录密码 -->
                <div class="input-row-horizontal">
                    <label>登录密码</label>
                    <input type="password" id="edit-password" name="password">
                    <button type="button" class="password-toggle-btn" onclick="togglePassword('edit-password', this)">显示</button>
                </div>
                <!-- 支付密码 -->
                <div class="input-row-horizontal">
                    <label>支付密码</label>
                    <input type="password" id="edit-passwordPay" name="passwordPay">
                    <button type="button" class="password-toggle-btn" onclick="togglePassword('edit-passwordPay', this)">显示</button>
                </div>
                <!-- 单次限额 -->
                <div class="input-row-horizontal">
                    <label>单次限额</label>
                    <input type="number" id="edit-maxLimit" name="maxLimit">
                </div>
            </div>
            <div class="modal-btn-row">
                <button type="submit" class="modal-confirm-btn">保存</button>
                <button type="button" class="modal-cancel-btn" onclick="closeAdminEditModal()">取消</button>
            </div>
        </form>
    </div>
</div>

<%--选择办卡类型弹窗--%>
<div class="modal-overlay" id="add-card-overlay" style="display:none;">
    <div class="add-card-modal">
        <h3>请选择办卡方式</h3>
        <div>
            <!-- 保持和JS一致 -->
            <button class="choice-btn" onclick="chooseOldUser()">老用户新办</button>
            <button class="choice-btn" onclick="chooseNewUser()">新用户</button>
        </div>
    </div>
</div>

<%--老用户输入学号弹窗--%>
<div class="modal-overlay" id="old-user-overlay" style="display:none;">
    <div class="old-user-modal">
        <h3>请输入原学号/工号</h3>
            <div class="input-row-horizontal">
                <label>学号/工号</label>
                <input type="text" id="old-user-personid" placeholder="学号/工号" autocomplete="off" />
            </div>
            <button class="confirm-btn" onclick="confirmOldUser()">确认</button>
            <button class="cancel-btn" onclick="closeOldUserModal()">取消</button>
        </div>
    </div>
</div>

<!-- 新增校园卡信息弹窗 -->
<div id="add-card-modal" class="modal-overlay" style="display: none;">
    <div class="add-card-modal-card">
        <h3>填写校园卡信息</h3>
        <form id="add-card-form" autocomplete="off">
            <div class="add-card-form-grid">
                <!-- 卡号（只读） -->
                <div class="input-row-horizontal">
                    <label>卡号</label>
                    <input type="text" id="add-cardID" name="cardID" required readonly>
                </div>
                <!-- 开卡日期（只读） -->
                <div class="input-row-horizontal">
                    <label>开卡日期</label>
                    <input type="text" id="add-registerDate" name="registerDate" required readonly>
                </div>
                <!-- 学号/工号（只读/或可编辑, 视业务而定）干脆做成可读了 -->
                <div class="input-row-horizontal">
                    <label>学号/工号</label>
                    <input type="text" id="add-personID" name="personID" required>
                </div>
                <!-- 姓名 -->
                <div class="input-row-horizontal">
                    <label>姓名</label>
                    <input type="text" id="add-name" name="name" required>
                </div>
                <!-- 性别 -->
                <div class="input-row-horizontal">
                    <label>性别</label>
                    <input type="text" id="add-gender" name="gender" required>
                </div>
                <!-- 学院 -->
                <div class="input-row-horizontal">
                    <label>学院</label>
                    <input type="text" id="add-department" name="department">
                </div>
                <!-- 专业 -->
                <div class="input-row-horizontal">
                    <label>专业</label>
                    <input type="text" id="add-major" name="major">
                </div>
                <!-- 年级 -->
                <div class="input-row-horizontal">
                    <label>年级</label>
                    <input type="text" id="add-grade" name="grade">
                </div>
                <!-- 班级 -->
                <div class="input-row-horizontal">
                    <label>班级</label>
                    <input type="text" id="add-className" name="className">
                </div>
                <!-- 余额 -->
                <div class="input-row-horizontal">
                    <label>余额</label>
                    <input type="number" step="0.01" id="add-balance" name="balance" required>
                </div>
                <!-- 待圈存余额 -->
                <div class="input-row-horizontal">
                    <label>待圈存余额</label>
                    <input type="number" step="0.01" id="add-pendingBalance" name="pendingBalance">
                </div>
                <!-- 单次消费限额 -->
                <div class="input-row-horizontal">
                    <label>单次限额</label>
                    <input type="number" id="add-maxLimit" name="maxLimit">
                </div>
                <!-- 登录密码 -->
                <div class="input-row-horizontal">
                    <label>登录密码</label>
                    <input type="password" id="add-password" name="password" required>
                    <button type="button" class="password-toggle-btn" onclick="togglePassword('add-password', this)">显示</button>
                </div>
                <!-- 支付密码 -->
                <div class="input-row-horizontal">
                    <label>支付密码</label>
                    <input type="password" id="add-passwordPay" name="passwordPay" required>
                    <button type="button" class="password-toggle-btn" onclick="togglePassword('add-passwordPay', this)">显示</button>
                </div>
                <!-- 是否支持在线转账 -->
                <div class="input-row-horizontal">
                    <label>在线转账</label>
                    <select id="add-isOnlineTransfer" name="isOnlineTransfer">
                        <option value="true">支持</option>
                        <option value="false">不支持</option>
                    </select>
                </div>
                <!-- 卡状态 -->
                <div class="input-row-horizontal">
                    <label>卡状态</label>
                    <select id="add-status" name="status" required>
                        <option value="正常">正常</option>
                        <option value="挂失">挂失</option>
                        <option value="冻结">冻结</option>
                        <option value="注销">注销</option>
                    </select>
                </div>
                <!-- 卡类型 -->
                <div class="input-row-horizontal">
                    <label>卡类型</label>
                    <select id="add-cardType" name="cardType" required>
                        <option value="正式">正式</option>
                        <option value="临时">临时</option>
                    </select>
                </div>
                <!-- 身份 -->
                <div class="input-row-horizontal">
                    <label>身份</label>
                    <input type="text" id="add-role" name="role" required>
                </div>
                <!-- 校区 -->
                <div class="input-row-horizontal">
                    <label>校区</label>
                    <select id="add-campusLocation" name="campusLocation" required>
                        <option value="合肥校区">合肥校区</option>
                        <option value="宣城校区">宣城校区</option>
                    </select>
                </div>
                <!-- 手机号 -->
                <div class="input-row-horizontal">
                    <label>手机号</label>
                    <input type="text" id="add-phoneNumber" name="phoneNumber" required>
                </div>
                <!-- 身份证号 -->
                <div class="input-row-horizontal">
                    <label>身份证号</label>
                    <input type="text" id="add-IDNumber" name="IDNumber" required>
                </div>
                <!-- 邮箱 -->
                <div class="input-row-horizontal">
                    <label>邮箱</label>
                    <input type="email" id="add-email" name="email" required>
                </div>
                <!-- 是否管理员 -->
                <div class="input-row-horizontal">
                    <label>管理员</label>
                    <select id="add-isAdmin" name="isAdmin">
                        <option value="false">否</option>
                        <option value="true">是</option>
                    </select>
                </div>
            </div>
            <div class="add-card-btn-row">
                <button type="submit" class="add-card-confirm-btn">确认信息</button>
                <button type="button" class="add-card-cancel-btn" onclick="closeAddCardModal()">取消</button>
            </div>
        </form>
    </div>
</div>

<script>
    // 打开编辑弹窗，card为当前行的卡片对象
    function openAdminEditModal(card) {
        document.getElementById('admin-edit-modal').style.display = 'flex';
        // 填充表单
        document.getElementById('edit-cardID').value = card.cardID;
        document.getElementById('edit-name').value = card.name;
        document.getElementById('edit-personID').value = card.personID;
        document.getElementById('edit-gender').value = card.gender;
        document.getElementById('edit-department').value = card.department;
        document.getElementById('edit-major').value = card.major;
        document.getElementById('edit-status').value = card.status;
        document.getElementById('edit-cardType').value = card.cardType;
        document.getElementById('edit-campusLocation').value = card.campusLocation;
        document.getElementById('edit-role').value = card.role;
        document.getElementById('edit-registerDate').value = card.registerDate; // yyyy-MM-dd
        document.getElementById('edit-IDNumber').value = card.IDNumber;
        document.getElementById('edit-password').value = card.password || '';
        document.getElementById('edit-passwordPay').value = card.passwordPay || '';
        document.getElementById('edit-phoneNumber').value = card.phoneNumber;
        document.getElementById('edit-email').value = card.email;
        document.getElementById('edit-maxLimit').value = card.maxLimit;
    }

    function closeAdminEditModal() {
        const modal = document.getElementById('admin-edit-modal');
        modal.classList.add('closing');
        setTimeout(() => {
            modal.style.display = 'none';
            modal.classList.remove('closing');
        }, 350);
    }

    // 提交表单
    document.getElementById('admin-edit-form').onsubmit = function (e) {
        e.preventDefault();
        const formData = new FormData(this);
        const xhr = new XMLHttpRequest();
        xhr.open("POST", "<%= request.getContextPath() %>/UpdateCardServlet", true);

        // 关键补丁：设置 Content-Type
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                closeAdminEditModal();
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

    // 显示密码按钮
    function togglePassword(inputId, btn) {
        const pwdInput = document.getElementById(inputId);
        if (pwdInput.type === 'password') {
            pwdInput.type = 'text';
            btn.textContent = '隐藏';
        } else {
            pwdInput.type = 'password';
            btn.textContent = '显示';
        }
    }

    // 注销卡片函数
    function confirmCancelCard(cardID) {
        if (!confirm("确认要注销该卡片吗？此操作不可恢复！")) return;
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "<%= request.getContextPath() %>/CancelCardServlet", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                try {
                    var res = JSON.parse(xhr.responseText);
                    if (xhr.status === 200 && res.success) {
                        alert("注销成功！");
                        location.reload();
                    } else {
                        alert("注销失败：" + (res.msg || "未知错误"));
                    }
                } catch (e) {
                    alert("服务器异常：" + xhr.responseText);
                }
            }
        };
        xhr.send("cardID=" + encodeURIComponent(cardID));
    }


    // 打开“选择办卡类型”弹窗
    function openAddCardTypeModal() {
        const overlay = document.getElementById('add-card-overlay');
        overlay.style.display = 'flex';
        overlay.classList.remove('closing');
        const card = overlay.querySelector('.add-card-modal');
        if (card) {
            card.classList.remove('closing');
            card.style.animation = 'popIn 0.35s cubic-bezier(0.4,0,0.2,1)';
            overlay.style.animation = 'overlayBlurIn 0.32s cubic-bezier(0.4,0,0.2,1)';
            setTimeout(() => {
                card.style.animation = '';
                overlay.style.animation = '';
            }, 370);
        }
    }
    // 关闭“选择办卡类型”弹窗
    function closeAddCardTypeModal() {
        const overlay = document.getElementById('add-card-overlay');
        const card = overlay.querySelector('.add-card-modal');
        if (card) card.classList.add('closing');
        overlay.classList.add('closing');
        setTimeout(() => {
            overlay.style.display = 'none';
            if (card) card.classList.remove('closing');
            overlay.classList.remove('closing');
        }, 350);
    }
    // 选择老用户/新用户流程
    function chooseOldUser() {
        closeAddCardTypeModal();
        openOldUserModal();
    }
    function chooseNewUser() {
        closeAddCardTypeModal();
        openAddCardInfoModal(); // 新用户弹新增卡片信息弹窗，默认字段自动生成
    }

    // 打开“老用户输入学号”弹窗
    function openOldUserModal() {
        const overlay = document.getElementById('old-user-overlay');
        overlay.style.display = 'flex';
        overlay.classList.remove('closing');
        const card = overlay.querySelector('.old-user-modal');
        if (card) {
            card.classList.remove('closing');
            card.style.animation = 'popIn 0.35s cubic-bezier(0.4,0,0.2,1)';
            overlay.style.animation = 'overlayBlurIn 0.32s cubic-bezier(0.4,0,0.2,1)';
            setTimeout(() => {
                card.style.animation = '';
                overlay.style.animation = '';
            }, 370);
        }
    }
    // 关闭“老用户输入学号”弹窗
    function closeOldUserModal() {
        const overlay = document.getElementById('old-user-overlay');
        const card = overlay.querySelector('.old-user-modal');
        if (card) card.classList.add('closing');
        overlay.classList.add('closing');
        setTimeout(() => {
            overlay.style.display = 'none';
            if (card) card.classList.remove('closing');
            overlay.classList.remove('closing');
            document.getElementById('old-user-personid').value = '';
        }, 350);
    }

    // 老用户输入学号后“确认”逻辑（AJAX查找并填充卡片表单）
    function confirmOldUser() {
        const personID = document.getElementById('old-user-personid').value.trim();
        if (!personID) {
            alert("请输入学号/工号！");
            return;
        }
        // 用AJAX查找老用户信息，然后填充卡片表单并弹出
        fetch('<%=request.getContextPath()%>/FindOldUserServlet?personID=' + encodeURIComponent(personID))
            .then(res => res.json())
            .then(data => {
                if (data.success) {
                    closeOldUserModal();
                    openAddCardInfoModal(data.cardInfo);
                } else {
                    alert(data.msg || "查找失败，用户不存在！");
                }
            }).catch(() => {
            alert("服务器异常！");
        });
    }

    // 打开“新增校园卡信息”弹窗，cardInfo可选，老用户自动带字段，新用户自动生成
    function openAddCardInfoModal(cardInfo) {
        const overlay = document.getElementById('add-card-modal');
        overlay.style.display = 'flex';
        overlay.classList.remove('closing');
        const card = overlay.querySelector('.add-card-modal-card');
        if (card) {
            card.classList.remove('closing');
            card.style.animation = 'popIn 0.35s cubic-bezier(0.4,0,0.2,1)';
            overlay.style.animation = 'overlayBlurIn 0.32s cubic-bezier(0.4,0,0.2,1)';
            setTimeout(() => {
                card.style.animation = '';
                overlay.style.animation = '';
            }, 370);
        }
        // 自动填充表单
        if (cardInfo) {
            fillAddCardForm(cardInfo);
        } else {
            // 新用户请求后端自动生成卡号、开卡日期等
            fetch('<%=request.getContextPath()%>/AutoCardFieldsServlet')
                .then(res => res.json())
                .then(data => fillAddCardForm(data));
        }
    }
    // 填充表单
    function fillAddCardForm(info) {
        const fields = [
            "cardID", "registerDate", "personID", "name", "gender",
            "department", "major", "grade", "className",
            "balance", "pendingBalance", "maxLimit",
            "password", "passwordPay", "isOnlineTransfer",
            "status", "cardType", "role", "campusLocation",
            "phoneNumber", "IDNumber", "email", "isAdmin"
        ];
        fields.forEach(field => {
            const el = document.getElementById('add-' + field);
            if (!el) return;
            let val = info && info[field] != null ? info[field] : (el.type === 'number' ? 0 : '');
            // select布尔字段
            if (el.tagName === "SELECT" && (field === 'isOnlineTransfer' || field === 'isAdmin')) {
                el.value = (val === true || val === 'true') ? 'true' : 'false';
            } else if (el.tagName === "SELECT") {
                el.value = val || el.options[0].value;
            } else if (el.type === "number") {
                el.value = val;
            } else {
                el.value = val;
            }
        });
    }
    // 关闭
    function closeAddCardModal() {
        const overlay = document.getElementById('add-card-modal');
        const card = overlay.querySelector('.add-card-modal-card');
        if (card) card.classList.add('closing');
        overlay.classList.add('closing');
        setTimeout(() => {
            overlay.style.display = 'none';
            if (card) card.classList.remove('closing');
            overlay.classList.remove('closing');
            fillAddCardForm({});
        }, 350);
    }
    // 表单提交
    document.getElementById('add-card-form').onsubmit = function (e) {
        e.preventDefault();
        const formData = new FormData(this);

        // 类型安全转换
        const data = {};
        formData.forEach((v, k) => {
            if (['balance', 'pendingBalance'].includes(k)) {
                data[k] = v === '' ? 0 : parseFloat(v);
            } else if (['maxLimit'].includes(k)) {
                data[k] = v === '' ? 0 : parseInt(v);
            } else if (['isOnlineTransfer', 'isAdmin'].includes(k)) {
                data[k] = v === 'true';
            } else {
                data[k] = v;
            }
        });

        const params = Object.entries(data)
            .map(([k, v]) => encodeURIComponent(k) + '=' + encodeURIComponent(v))
            .join('&');

        const xhr = new XMLHttpRequest();
        xhr.open("POST", "<%= request.getContextPath() %>/AddCardServlet", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4) {
                closeAddCardModal();
                try {
                    const res = JSON.parse(xhr.responseText);
                    if (xhr.status === 200 && res.success) {
                        alert("新增成功！卡号：" + res.cardID);
                        location.reload();
                    } else {
                        alert("新增失败：" + (res.msg || "未知错误"));
                    }
                } catch (err) {
                    alert("服务器异常：" + xhr.responseText);
                }
            }
        };
        xhr.send(params);
    };
</script>
</body>
</html>