package com.mag.servlet;

import com.mag.service.CardService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

public class CancelCardServlet extends HttpServlet {
    private CardService cardService = new CardService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String cardID = request.getParameter("cardID");
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        if (cardID == null || cardID.trim().isEmpty()) {
            out.write("{\"success\":false,\"msg\":\"卡号不能为空\"}");
            return;
        }

        try {
            boolean result = cardService.cancelCard(cardID);

            if (result) {
                out.write("{\"success\":true}");
            } else {
                out.write("{\"success\":false,\"msg\":\"注销失败，卡号不存在或状态已是注销。\"}");
            }
        } catch (Exception e) {
            out.write("{\"success\":false,\"msg\":\"服务器异常：" + e.getMessage() + "\"}");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}