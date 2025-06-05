package com.mag.service;

import com.mag.domain.Books;
import com.mag.util.SqlHelper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class BookService {
	
	//检验书是否存在的函数
	public Books CheckBook(Books book)
	{
		String sql="select * from book where bookID=?";
		String parameters[]={book.getBookID()+""};
		ResultSet rs=SqlHelper.executeQuery(sql, parameters);
		try {
			if(rs.next())
			{
			book.setBoookID(rs.getInt(1));
			book.setBookName(rs.getString(2));
			book.setCategory(rs.getString(3));
			book.setPublishTime(rs.getDate(4));
			book.setAuthor(rs.getString(5));
			book.setPrice(rs.getDouble(6));
			book.setPricepromotion(rs.getDouble(7));
			book.setStock(rs.getInt(8));
			book.setDescription(rs.getString(9));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			//反向引用,关闭资源
			SqlHelper.close(SqlHelper.getCt(), SqlHelper.getPs(), SqlHelper.getRs());
			
		}

		return book;
	}
	
	//得到所有书
	public ArrayList<Books> GetAllBooks()
	{
		ArrayList<Books> al=new ArrayList<Books>();
		String sql="select * from book";
		String parameters[]={};
		ResultSet rs=SqlHelper.executeQuery(sql, parameters);
		try {
			while(rs.next())
			{
				Books book=new Books();
				book.setBoookID(rs.getInt(1));
				book.setBookName(rs.getString(2));
				book.setCategory(rs.getString(3));
				book.setPublishTime(rs.getDate(4));
				book.setAuthor(rs.getString(5));
				book.setPrice(rs.getDouble(6));
				book.setPricepromotion(rs.getDouble(7));
				book.setStock(rs.getInt(8));
				book.setDescription(rs.getString(9));
				al.add(book);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			
			SqlHelper.close(SqlHelper.getCt(), SqlHelper.getPs(), SqlHelper.getRs());
		}
			
		return al;
	}
	//根据ID号查询用户
	public Books GetBookById(String id)
	{
		Books book=new Books();
		String sql="select * from book where bookID=?";
		String parameters[]={id};
		ResultSet rs=SqlHelper.executeQuery(sql, parameters);
		try {
			if(rs.next())
			{
				book.setBoookID(rs.getInt(1));
				book.setBookName(rs.getString(2));
				book.setCategory(rs.getString(3));
				book.setPublishTime(rs.getDate(4));
				book.setAuthor(rs.getString(5));
				book.setPrice(rs.getDouble(6));
				book.setPricepromotion(rs.getDouble(7));
				book.setStock(rs.getInt(8));
				book.setDescription(rs.getString(9));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			//反向引用,关闭资源
			SqlHelper.close(SqlHelper.getCt(), SqlHelper.getPs(), SqlHelper.getRs());
			
		}

		return book;
	}
	
	//根据ID号查询用户
/*	public ArrayList<Books> GetBookById(String id)
	{
		ArrayList<Books> al=new ArrayList<Books>();
		String sql="select * from book where bookID=?";
		String parameters[]={id};
		ResultSet rs=SqlHelper.executeQuery(sql, parameters);
		try {
			while(rs.next())
			{
				Books book=new Books();
				book.setBoookID(rs.getInt(1));
				book.setBookName(rs.getString(2));
				book.setCategory(rs.getString(3));
				book.setPublishTime(rs.getDate(4));
				book.setAuthor(rs.getString(5));
				book.setPrice(rs.getDouble(6));
				book.setPricepromotion(rs.getDouble(7));
				book.setStock(rs.getInt(8));
				book.setDescription(rs.getString(9));
				al.add(book);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			//反向引用,关闭资源
			SqlHelper.close(SqlHelper.getCt(), SqlHelper.getPs(), SqlHelper.getRs());
			
		}

		return al;
	}
*/	
	//根据书名查询书,模糊查询
	public ArrayList<Books> GetBooksByName(String bookName)
	{
		ArrayList<Books> al=new ArrayList<Books>();
		String sql="select * from book where Name like ?";
		String parameters[]={"%"+bookName+"%"};
		ResultSet rs=SqlHelper.executeQuery(sql, parameters);
		try {
			while(rs.next())
			{
				Books book=new Books();
				book.setBoookID(rs.getInt(1));
				book.setBookName(rs.getString(2));
				book.setCategory(rs.getString(3));
				book.setPublishTime(rs.getDate(4));
				book.setAuthor(rs.getString(5));
				book.setPrice(rs.getDouble(6));
				book.setPricepromotion(rs.getDouble(7));
				book.setStock(rs.getInt(8));
				book.setDescription(rs.getString(9));
				al.add(book);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			
			SqlHelper.close(SqlHelper.getCt(), SqlHelper.getPs(), SqlHelper.getRs());
		}
			
		return al;
	}
	
	//根据书名查询书数量
	public int GetCountOfBookByID(int bookID)
	{
		
		int count=0;
		String sql="select COUNT(*) from book where bookID=?";
		String parameters[]={bookID+""};
		ResultSet rs=SqlHelper.executeQuery(sql, parameters);
		try {
			if(rs.next())
			{
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			//反向引用,关闭资源
			SqlHelper.close(SqlHelper.getCt(), SqlHelper.getPs(), SqlHelper.getRs());
			
		}

		return count;
	}

	//修改书信息函数
	public boolean UpdateBook(Books book)
	{
		boolean b=true;
		String sql="update book set Name=?,category=?,publishTime=?,author=?,Price=?,Pricepromotion=?,stock=?,description=? where bookID=?";
		String parameters[]={ book.getBookName(),book.getCategory(),book.getDateString(),
				book.getAuthor(),book.getPrice()+"",book.getPricepromotion()+"",book.getStock()+"",
				book.getDescription(),book.getBookID()+""};
		try {
			
			SqlHelper.executeUpdate(sql, parameters);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			b=false;
		}
	
		return b;
	}

	//删除记录函数
	public  boolean DelBook(String bookID)
	{
		boolean b=true;
		String sql="delete from book where bookID=?";
		String parameters[]={bookID};
		//捕获executeUpdate的运行异常
		try {
			SqlHelper.executeUpdate(sql, parameters);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			b=false;
		}
		return b;
	}

	//添加记录函数
	public boolean AddBook(Books book)
	{
		boolean b=true;
		String sql="insert into book(bookID,Name,category,publishTime,author,Price,Pricepromotion,stock,description) values(?,?,?,?,?,?,?,?,?)";//
		String parameters[]={book.getBookID()+"", book.getBookName(),book.getCategory(),book.getDateString(),
				book.getAuthor(),book.getPrice()+"",book.getPricepromotion()+"",book.getStock()+"",
				book.getDescription()};
		//String parameters[]={user.getUserName(),user.getSex(),user.getMobilePhone(),user.getGrade(),user.getPassword()};
		try {
			
			SqlHelper.executeUpdate(sql, parameters);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			b=false;
		}
	
		return b;
	}

}
