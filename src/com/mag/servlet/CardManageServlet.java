package com.mag.servlet;

import com.mag.domain.CampusCard;
import com.mag.service.CardService;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class CardManageServlet extends HttpServlet {
    private final CardService cardService = new CardService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // 校验是否已登录
        HttpSession session = request.getSession(false); // false 表示不新建 session
        CampusCard card = (session != null) ? (CampusCard) session.getAttribute("loginCard") : null;

        if (card == null) {
            // 没有登录，重定向到登录页面
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // 1. 取参数
        String pageStr = request.getParameter("currentPage");
        String pageSizeStr = request.getParameter("pageSize");
        int currentPage = (pageStr == null) ? 1 : Integer.parseInt(pageStr);
        int pageSize = (pageSizeStr == null) ? 15 : Integer.parseInt(pageSizeStr); // 默认5条

        // 2. 查询数据和总数
        List<CampusCard> cardList = cardService.findCardsByPage(currentPage, pageSize);
        int total = cardService.countAllCards();

        double totalAmount = cardService.sumAllNormalBalance();

        // 3. 传给页面
        request.setAttribute("cardList", cardList);
        request.setAttribute("total", total);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("totalAmount", totalAmount);

        //传递 loginCard
        request.setAttribute("loginCard", card);

        // 4. 转发到 JSP（比如 admin/index.jsp ）
        request.getRequestDispatcher("/jsp/admin/manageCard.jsp").forward(request, response);
    }
}