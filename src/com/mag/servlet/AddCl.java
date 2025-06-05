package com.mag.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class AddCl extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		BookService bs = new BookService();
		int bookID = Integer.parseInt(request.getParameter("bookID"));
		String bookName = request.getParameter("bookName");
		String category = request.getParameter("bCategory");
		String publishTime = request.getParameter("bTime");
		String author = request.getParameter("bAuthor");
		double Price = Double.parseDouble(request.getParameter("bPrice"));
		double Pricepromotion = Double.parseDouble(request
				.getParameter("bPPrice"));
		int Stock = Integer.parseInt(request.getParameter("bStock"));
		String Description = request.getParameter("bDescription");
		Books book = new Books();
		book.setBoookID(bookID);
		book.setBookName(bookName);
		book.setCategory(category);
		book.setPublishTime(publishTime);
		book.setAuthor(author);
		book.setPrice(Price);
		book.setPricepromotion(Pricepromotion);
		book.setStock(Stock);
		book.setDescription(Description);

		int count = bs.GetCountOfBookByID(bookID);
		if (count == 0) {
			// 添加书
			bs.AddBook(book);

			// 得到刚刚添加的新书
			book = bs.CheckBook(book);

			request.getSession().setAttribute("updateBook", book);
			response.sendRedirect("/CampusCard/jsp/update.jsp");
		} else {
			request.setAttribute("ExpAddError", "图书:'"+bookID+"'已存在，请重新输入！");
			request.setAttribute("updateBook", book);
			request.getRequestDispatcher("/jsp/AddBook.jsp").forward(request,
					response);
		}
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		this.doGet(request, response);
	}

}
