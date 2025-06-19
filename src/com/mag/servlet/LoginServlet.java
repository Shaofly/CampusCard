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

        //校验非空
        if (personID == null || password == null || personID.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("error", "账号或密码不能为空！");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // 账户不存在或者密码错误判断
        CampusCard card = loginService.getCard(personID);
        // 判断用户不存在
        if (card == null) {
            // 用户不存在
            request.setAttribute("error", "不存在该用户！");
            request.setAttribute("personID", ""); // 清空账户框
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
        // 判断密码错误
        if (!card.getPassword().equals(password)) {
            // 密码错误
            request.setAttribute("error", "密码错误！");
            request.setAttribute("personID", personID); // 保留账户输入
            // XSS安全提醒，可能被跨站脚本攻击
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        boolean loginSuccess = loginService.login(personID, password);

        if (loginSuccess) {
            HttpSession session = request.getSession();
            session.setAttribute("loginCard", card);

            // 判断是否管理员，重定向不同页面
            if (loginService.isAdmin(personID)) {
                response.sendRedirect(request.getContextPath() + "/AdminIndexServlet?currentPage=1&pageSize=5");
            } else {
                response.sendRedirect(request.getContextPath() + "/UserHomeServlet");
            }
        }
    }

    // get请求转发到index.jsp
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }
}