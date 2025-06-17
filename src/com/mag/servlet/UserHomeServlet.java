package com.mag.servlet;

import com.mag.domain.CampusCard;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class  UserHomeServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        CampusCard card = (CampusCard) session.getAttribute("loginCard");
        if (card == null) {
            response.sendRedirect("login.jsp");
            return;
        }
            }
}
