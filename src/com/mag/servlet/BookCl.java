package com.mag.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class BookCl extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		BookService bs=new BookService();
		String type=request.getParameter("type");
		
		//跳转到修改信息页面
		if("goUpdate".equals(type))
		{
			String id=request.getParameter("id");
			Books book=bs.GetBookById(id);
			request.getSession().setAttribute("updateBook", book);
			response.sendRedirect("/CampusCard/jsp/update.jsp");
		}
		//修改信息
		else if("Update".equals(type))
		{
			Books book=new Books();
			book.setBoookID(Integer.parseInt(request.getParameter("id")));
			book.setBookName(request.getParameter("bookName"));
			book.setCategory(request.getParameter("bCategory"));
			book.setPublishTime(request.getParameter("bTime"));
			book.setAuthor(request.getParameter("bAuthor"));
			book.setPrice(Double.parseDouble(request.getParameter("bPrice")));
			book.setPricepromotion(Double.parseDouble(request.getParameter("bPPrice")));
			book.setStock(Integer.parseInt(request.getParameter("bStock")));
			book.setDescription(request.getParameter("bDescription"));

			if(bs.UpdateBook(book))
			{
				response.sendRedirect("/CampusCard/BookCl?type=goUpdate&id="+book.getBookID()+"");
			}
		}
		//删除用户
		else if("delete".equals(type))
		{
			String bookID=request.getParameter("id");
			if(bs.DelBook(bookID))
			{
				//ArrayList<Books> al=new ArrayList<Books>();
				//al=bs.GetAllBooks();
				//request.getSession().setAttribute("type", "allbook");
				//request.getSession().setAttribute("UserList", al);
				response.sendRedirect("/CampusCard/SearchBook?type=allbook");
			}//"
		}
		else if("goDetail".equals(type))
		{
			String id=request.getParameter("id");
			Books book=bs.GetBookById(id);
			request.getSession().setAttribute("detailBook", book);
			response.sendRedirect("/CampusCard/jsp/details.jsp");
			
		}
	}


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		this.doGet(request, response);
	}


}
