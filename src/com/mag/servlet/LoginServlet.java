package com.mag.servlet;

import com.mag.service.LoginService;
import com.mag.domain.CampusCard;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class LoginServlet extends HttpServlet {
    private final LoginService loginService = new LoginService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 设置编码
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String personID = request.getParameter("personID");
        String password = request.getParameter("password");

        if (personID == null || password == null || personID.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("error", "账号或密码不能为空！");
            request.getRequestDispatcher("index.jsp").forward(request, response);
            return;
        }

        boolean loginSuccess = loginService.login(personID, password);

        if (loginSuccess) {
            CampusCard card = loginService.getCard(personID);
            HttpSession session = request.getSession();
            session.setAttribute("loginCard", card);

            // 判断是否管理员，重定向不同页面
            if (card.isAdmin()) {
                response.sendRedirect("admin/main.jsp");
            } else {
                response.sendRedirect("user/main.jsp");
            }
        } else {
            request.setAttribute("error", "账号或密码错误！");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }

    // get请求转发到index.jsp
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("index.jsp");
    }
}