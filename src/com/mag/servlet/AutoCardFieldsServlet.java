package com.mag.servlet;

import com.mag.domain.CampusCard;

import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;

public class AutoCardFieldsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            // 1. 自动生成卡号和开卡时间
            CampusCard card = CampusCard.createWithAutoFields();
            String registerDateStr = new SimpleDateFormat("yyyy-MM-dd").format(card.getRegisterDate());

            // 2. 输出JSON，新用户personID为空字符串
            out.print("{"
                    + "\"cardID\":\"" + card.getCardID() + "\","
                    + "\"registerDate\":\"" + registerDateStr + "\","
                    + "\"personID\":\"\""
                    + "}");
        } catch (Exception e) {
            out.print("{\"success\":false,\"msg\":\"服务器异常: " + e.getMessage() + "\"}");
        } finally {
            out.close();
        }
    }

    // 可以加上（不是必须）
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        doGet(request, response);
    }
}