package com.mag.servlet;

import com.mag.domain.CampusCard;
import com.mag.service.CardService;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;

public class FindOldUserServlet extends HttpServlet {
    private final CardService cardService = new CardService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            String personID = request.getParameter("personID");
            if (personID == null || personID.trim().isEmpty()) {
                out.print("{\"success\":false, \"msg\":\"学号/工号不能为空\"}");
                return;
            }

            CampusCard card = cardService.findCardByPersonID(personID);

            if (card != null) {
                StringBuilder sb = new StringBuilder();
                sb.append("{\"success\":true,\"cardInfo\":{");
                sb.append("\"cardID\":\"").append(escape(card.getCardID())).append("\",");
                sb.append("\"personID\":\"").append(escape(card.getPersonID())).append("\",");
                sb.append("\"name\":\"").append(escape(card.getName())).append("\",");
                sb.append("\"gender\":\"").append(escape(card.getGender())).append("\",");
                sb.append("\"avatar\":\"").append(escape(card.getAvatar())).append("\",");
                sb.append("\"department\":\"").append(escape(card.getDepartment())).append("\",");
                sb.append("\"major\":\"").append(escape(card.getMajor())).append("\",");
                sb.append("\"grade\":\"").append(escape(card.getGrade())).append("\",");
                sb.append("\"className\":\"").append(escape(card.getClassName())).append("\",");
                sb.append("\"balance\":").append(card.getBalance()).append(",");
                sb.append("\"pendingBalance\":").append(card.getPendingBalance()).append(",");
                sb.append("\"maxLimit\":").append(card.getMaxLimit()).append(",");
                sb.append("\"password\":\"").append(escape(card.getPassword())).append("\",");
                sb.append("\"passwordPay\":\"").append(escape(card.getPasswordPay())).append("\",");
                sb.append("\"isOnlineTransfer\":").append(card.isOnlineTransfer()).append(",");
                sb.append("\"status\":\"").append(escape(card.getStatus())).append("\",");
                sb.append("\"cardType\":\"").append(escape(card.getCardType())).append("\",");
                sb.append("\"role\":\"").append(escape(card.getRole())).append("\",");
                sb.append("\"campusLocation\":\"").append(escape(card.getCampusLocation())).append("\",");

                // registerDate输出为yyyy-MM-dd
                String registerDateStr = card.getRegisterDate() == null ? "" :
                        new SimpleDateFormat("yyyy-MM-dd").format(card.getRegisterDate());
                sb.append("\"registerDate\":\"").append(registerDateStr).append("\",");

                sb.append("\"phoneNumber\":\"").append(escape(card.getPhoneNumber())).append("\",");
                sb.append("\"IDNumber\":\"").append(escape(card.getIDNumber())).append("\",");
                sb.append("\"email\":\"").append(escape(card.getEmail())).append("\",");
                sb.append("\"isAdmin\":").append(card.isAdmin());
                sb.append("}}");

                out.print(sb.toString());
            } else {
                out.print("{\"success\":false, \"msg\":\"未找到该学号/工号用户\"}");
            }
        } catch (Exception e) {
            out.print("{\"success\":false, \"msg\":\"服务器异常: " + e.getMessage() + "\"}");
        } finally {
            out.close();
        }
    }

    private String escape(String s) {
        return s == null ? "" : s.replace("\"", "\\\"").replace("\n", "").replace("\r", "");
    }
}