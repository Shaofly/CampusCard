package com.mag.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Locale;

public class ChangeLanguageServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 获取用户选择的语言
        String language = request.getParameter("language");

        // 根据选择创建 Locale 对象
        Locale locale;
        if ("zh".equals(language)) {
            locale = new Locale("zh", "CN");
        } else {
            locale = new Locale("en","US");
        }

        // 将 Locale 保存到 Session 中
        HttpSession session = request.getSession();
        session.setAttribute("locale", locale);

        // 重定向回原页面
        String referer = request.getHeader("Referer");
        if (referer != null) {
            response.sendRedirect(referer);
        } else {
            response.sendRedirect("./login.jsp");
        }
    }
}