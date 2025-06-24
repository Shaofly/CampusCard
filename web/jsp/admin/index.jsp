<%--
  Created by IntelliJ IDEA.
  User: msf
  Date: 2025/6/6
  Time: 16:23
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

<%-- 取参数 --%>
<%
    //取出 totalAmount 和 total
    double totalAmount = (request.getAttribute("totalAmount") != null) ? (double) request.getAttribute("totalAmount") : 0.0;
    int total = (request.getAttribute("total") != null) ? (int)request.getAttribute("total") : 0;

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
    <link rel="stylesheet" href=" <%=request.getContextPath()%>/css/admin/main.css"/>
    <link rel="stylesheet" href=" <%=request.getContextPath()%>/css/admin/editModal.css"/>
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
        <a href="${pageContext.request.contextPath}/AdminIndexServlet?currentPage=1&pageSize=5" class="nav-item active">统计视图</a>
        <a href="${pageContext.request.contextPath}/CardManageServlet?currentPage=1&pageSize=10" class="nav-item">人员管理</a>
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
    <%-- 视图头 --%>
    <div class="admin-header">
        <span class="admin-title">统计视图</span>
        <%-- 这里可以加管理员信息 --%>
        <span class="admin-user-info">欢迎，管理员<strong><%= loginCard.getName() %></strong></span>
    </div>
    <%-- 仪表盘 --%>
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
        <%-- 卡片表格 一页5行 --%>
        <div class="admin-table-card">
            <div class="table-header">卡片一览</div>
            <div class="table-content">
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
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr><td colspan="4">暂无数据</td></tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
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
                    <input type="text" id="edit-name" name="name" pattern="^[\u4e00-\u9fa5]{1,12}$" title="姓名必须为1-12位汉字" required>
                </div>
                <!-- 学号 -->
                <div class="input-row-horizontal">
                    <label>学号</label>
                    <input type="text" id="edit-personID" name="personID" pattern="\d{10}" title="学号/工号必须为10位数字" required readonly>
                </div>
                <!-- 性别 -->
                <div class="input-row-horizontal">
                    <label>性别</label>
                    <select id="edit-gender" name="gender" required>
                        <option value="男">男</option>
                        <option value="女">女</option>
                    </select>
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
                    <select id="edit-role" name="role" required>
                        <option value="">请选择身份</option>
                        <option value="学生">学生</option>
                        <option value="教师">教师</option>
                        <option value="后勤">后勤</option>
                        <option value="附属中小学生">附属中小学生</option>
                    </select>
                </div>
                <!-- 开卡日期（只读） -->
                <div class="input-row-horizontal">
                    <label>开卡日期</label>
                    <input type="text" id="edit-registerDate" name="registerDate" required readonly>
                </div>
                <!-- 身份证号 -->
                <div class="input-row-horizontal">
                    <label>身份证号</label>
                    <input type="text" id="edit-IDNumber" name="IDNumber" pattern="^\d{17}[\dXx]$" title="请输入18位身份证号" required>
                </div>
                <!-- 只读：手机号、邮箱 -->
                <div class="input-row-horizontal">
                    <label>手机号</label>
                    <input type="text" id="edit-phoneNumber" name="phoneNumber" pattern="^1[3-9]\d{9}$" title="请输入以1开头的11位有效手机号" required readonly>
                </div>
                <div class="input-row-horizontal">
                    <label>邮箱</label>
                    <input type="text" id="edit-email" name="email" title="请输入有效邮箱" readonly>
                </div>
                <!-- 登录密码 -->
                <div class="input-row-horizontal">
                    <label>登录密码</label>
                    <input type="password" id="edit-password" name="password" pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d_.]{8,20}$" title="密码需8-20位，必须包含大小写字母和数字，可含_和.">
                    <button type="button" class="password-toggle-btn" onclick="togglePassword('edit-password', this)">显示</button>
                </div>
                <!-- 支付密码 -->
                <div class="input-row-horizontal">
                    <label>支付密码</label>
                    <input type="password" id="edit-passwordPay" name="passwordPay" pattern="^\d{6}$" title="支付密码必须为6位数字" required>
                    <button type="button" class="password-toggle-btn" onclick="togglePassword('edit-passwordPay', this)">显示</button>
                </div>
                <!-- 单次限额 -->
                <div class="input-row-horizontal">
                    <label>单次限额</label>
                    <input type="number" id="edit-maxLimit" name="maxLimit" required>
                </div>
            </div>
            <div class="modal-btn-row">
                <button type="submit" class="modal-confirm-btn">保存</button>
                <button type="button" class="modal-cancel-btn" onclick="closeAdminEditModal()">取消</button>
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
        //TODO：这里记录一个当时修的bug
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
</script>
</body>
</html>