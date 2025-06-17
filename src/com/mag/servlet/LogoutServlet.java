package com.mag.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class LogoutServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(true); // 不自动创建一个session
        if (session != null) {
            session.invalidate(); // 彻底清除所有Session数据
        }
        response.sendRedirect("/login.jsp"); // 跳回登录页
    }
}
