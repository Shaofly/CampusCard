package com.mag.servlet;

import com.mag.domain.CampusCard;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class UserHomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 校验是否已登录
        HttpSession session = request.getSession(false); // false 表示不新建 session
        CampusCard card = (session != null) ? (CampusCard) session.getAttribute("loginCard") : null;

        if (card == null) {
            // 没有登录，重定向到登录页面
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // 传递当前用户对象到 JSP，方便前端渲染，方便 index.jsp 显示按钮
        request.setAttribute("loginCard", card);

        // （预留）如果有消息/公告等，也可以在这里查出来并 setAttribute 传给 JSP

        // 跳转到 user/home.jsp
        request.getRequestDispatcher("/jsp/user/home.jsp").forward(request, response);
    }

    // get/post 都支持
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}