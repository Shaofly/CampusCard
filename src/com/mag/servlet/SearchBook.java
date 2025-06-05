package com.mag.servlet;

import com.mag.domain.Books;
import com.mag.service.BookService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

public class SearchBook extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		BookService bs = new BookService();
		String type = request.getParameter("type");

		if ("ByID".equals(type)) {
			ArrayList<Books> al = new ArrayList<Books>();
			String id = request.getParameter("bID");
			al.add(bs.GetBookById(id));
			request.getSession().setAttribute("BookList", al);
			request.getSession().setAttribute("ison", "ByID");
			response.sendRedirect("/CampusCard/jsp/BookManage.jsp");
		}//= =
		if ("ByName".equals(type)) {
			ArrayList<Books> al = new ArrayList<Books>();
			String bookName = request.getParameter("bName");
			al = bs.GetBooksByName(bookName);
			request.getSession().setAttribute("BookList", al);
			request.getSession().setAttribute("ison", "ByName");
			response.sendRedirect("/CampusCard/jsp/BookManage.jsp");
		}
		if("allbook".equals(type))
		{
			ArrayList<Books> al=new ArrayList<Books>();
			al=bs.GetAllBooks();
			request.getSession().setAttribute("BookList", al);
			request.getSession().setAttribute("ison", "allbook");
			response.sendRedirect("/CampusCard/jsp/BookManage.jsp");
		
		}

	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		this.doGet(request, response);
	}
}
