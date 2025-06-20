package com.mag.servlet;

import com.mag.domain.CampusCard;
import com.mag.service.CardService;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

public class UpdateCardServlet extends HttpServlet {
    private final CardService cardService = new CardService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 1. 基本配置
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession(false);

        // 2. 权限判断，获取当前登录用户和角色
        CampusCard currentUser = (session != null) ? (CampusCard) session.getAttribute("loginCard") : null;
        boolean isAdmin = currentUser != null && currentUser.isAdmin();

        // 3. 取出要修改的卡片ID
        String personID = request.getParameter("personID");
        if (personID == null || personID.trim().isEmpty()) {
            out.write("{\"success\":false,\"msg\":\"缺少学号/工号！\"}");
            return;
        }
        // 只允许用户编辑自己的，管理员可以编辑任何人的
        if (!isAdmin && !personID.equals(currentUser.getPersonID())) {
            out.write("{\"success\":false,\"msg\":\"无权修改他人信息！\"}");
            return;
        }

        CampusCard card = cardService.findCardByPersonID(personID);
        if (card == null) {
            out.write("{\"success\":false,\"msg\":\"卡片不存在或已失效！\"}");
            return;
        }

        // 4. 普通用户可改字段
        if (!isAdmin) {
            String phoneNumber = request.getParameter("phoneNumber");
            String email = request.getParameter("email");
            if (phoneNumber != null) card.setPhoneNumber(phoneNumber.trim());
            if (email != null) card.setEmail(email.trim());
        }

        // 5. 管理员可改所有字段（除了卡号、开卡日期）
        if (isAdmin) {
            // 管理员专属
            String name = request.getParameter("name");
            String gender = request.getParameter("gender");
            String department = request.getParameter("department");
            String major = request.getParameter("major");
            String grade = request.getParameter("grade");
            String className = request.getParameter("className");
            String status = request.getParameter("status");
            String cardType = request.getParameter("cardType");
            String campusLocation = request.getParameter("campusLocation");
            String role = request.getParameter("role");
            String maxLimit = request.getParameter("maxLimit");
            String IDNumber = request.getParameter("IDNumber");
            String password = request.getParameter("password");
            String passwordPay = request.getParameter("passwordPay");
            // 普通字段
            if (name != null) card.setName(name.trim());
            if (gender != null) card.setGender(gender.trim());
            if (department != null) card.setDepartment(department.trim());
            if (major != null) card.setMajor(major.trim());
            if (grade != null) card.setGrade(grade.trim());
            if (className != null) card.setClassName(className.trim());
            if (status != null) card.setStatus(status.trim());
            if (cardType != null) card.setCardType(cardType.trim());
            if (campusLocation != null) card.setCampusLocation(campusLocation.trim());
            if (role != null) card.setRole(role.trim());
            if (maxLimit != null) {
                try { card.setMaxLimit(Integer.parseInt(maxLimit.trim())); } catch (Exception ignored) {}
            }
            if (IDNumber != null) card.setIDNumber(IDNumber.trim());
            if (password != null) card.setPassword(password.trim());
            if (passwordPay != null) card.setPasswordPay(passwordPay.trim());
        }

        // 6. 更新数据库
        boolean ok = cardService.updateCard(card);

        if (ok) {
            // 如果是本人修改，顺便更新 session 的 loginCard 信息
            if (!isAdmin && personID.equals(currentUser.getPersonID())) {
                session.setAttribute("loginCard", card);
            }
            out.write("{\"success\":true,\"msg\":\"修改成功！\"}");
        } else {
            out.write("{\"success\":false,\"msg\":\"保存失败，请重试！\"}");
        }
    }
}