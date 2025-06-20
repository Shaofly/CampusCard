package com.mag.servlet;

import com.mag.domain.CampusCard;
import com.mag.service.CardService;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;

public class AddCardServlet extends HttpServlet {
    private final CardService cardService = new CardService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // 1. 使用你的静态工厂方法，自动生成卡号和开卡时间
            CampusCard card = CampusCard.createWithAutoFields();

            // 2. 设置其他字段（请求参数）
            card.setPersonID(request.getParameter("personID"));
            card.setName(request.getParameter("name"));
            card.setGender(request.getParameter("gender"));
            card.setDepartment(request.getParameter("department"));
            card.setMajor(request.getParameter("major"));
            card.setGrade(request.getParameter("grade"));
            card.setClassName(request.getParameter("className"));
            card.setBalance(Double.parseDouble(request.getParameter("balance")));
            card.setPendingBalance(Double.parseDouble(request.getParameter("pendingBalance")));
            card.setMaxLimit(Integer.parseInt(request.getParameter("maxLimit")));
            card.setPassword(request.getParameter("password"));
            card.setPasswordPay(request.getParameter("passwordPay"));
            card.setOnlineTransfer(Boolean.parseBoolean(request.getParameter("isOnlineTransfer")));
            card.setCardType(request.getParameter("cardType"));
            card.setRole(request.getParameter("role"));
            card.setCampusLocation(request.getParameter("campusLocation"));
            card.setPhoneNumber(request.getParameter("phoneNumber"));
            card.setIDNumber(request.getParameter("IDNumber"));
            card.setEmail(request.getParameter("email"));
            card.setAdmin(Boolean.parseBoolean(request.getParameter("isAdmin")));
            // message/status等按实际业务处理

            // 3. 新增卡片（自动处理老卡注销）
            boolean success = cardService.addCard(card);

            // 4. 响应
            if (success) {
                String registerDateStr = new SimpleDateFormat("yyyy-MM-dd").format(card.getRegisterDate());
                out.print("{\"success\":true," +
                        "\"cardID\":\"" + card.getCardID() + "\"," +
                        "\"registerDate\":\"" + registerDateStr + "\"}");
            } else {
                out.print("{\"success\":false,\"msg\":\"新增卡片失败\"}");
            }
        } catch (Exception e) {
            out.print("{\"success\":false,\"msg\":\"服务器异常: " + e.getMessage() + "\"}");
        } finally {
            out.close();
        }
    }
}