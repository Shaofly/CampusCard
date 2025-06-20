package com.mag.servlet;

import com.mag.domain.CampusCard;
import com.mag.service.CardService;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class CardSearchServlet extends HttpServlet {
    private final CardService cardService = new CardService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 校验是否已登录
        HttpSession session = req.getSession(false);
        CampusCard loginCard = (session != null) ? (CampusCard) session.getAttribute("loginCard") : null;
        if (loginCard == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        // 1. 取参数
        String keyword = req.getParameter("keyword");
        if (keyword == null) keyword = "";
        int currentPage = 1, pageSize = 10;
        try { currentPage = Integer.parseInt(req.getParameter("currentPage")); } catch (Exception ignored) {}
        try { pageSize = Integer.parseInt(req.getParameter("pageSize")); } catch (Exception ignored) {}

        // 2. 查询数据和总数（注意调用带关键词的分页和统计方法）
        List<CampusCard> cardList = cardService.searchCards(keyword, currentPage, pageSize);
        int total = cardService.countCardsByKeyword(keyword);

        // 3. 放入request
        req.setAttribute("cardList", cardList);
        req.setAttribute("total", total);
        req.setAttribute("currentPage", currentPage);
        req.setAttribute("pageSize", pageSize);
        req.setAttribute("keyword", keyword);
        // 让页面能记住上一次搜索内容, XSS提醒
        req.setAttribute("loginCard", loginCard);

        // 4. 跳转
        req.getRequestDispatcher("/jsp/admin/manageCard.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}