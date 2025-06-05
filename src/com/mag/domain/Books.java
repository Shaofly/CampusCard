package com.mag.domain;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Books {
	private int bookID;
	private String bookName;
	private String category;
	private Date publishTime;
	private String author;
	private double Price;
	private double Pricepromotion;
	private int Stock;
	private String Description;
	public int getBookID() {
		return bookID;
	}
	public void setBoookID(int bookID) {
		this.bookID = bookID;
	}
	public String getBookName() {
		return bookName;
	}
	public void setBookName(String bookName) {
		this.bookName =bookName;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getDateString() {
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		return sdf.format(publishTime);
	}

	public Date getPublishTime() {
		return publishTime;
	}
	public void setPublishTime(Date publishTime) {
		this.publishTime=publishTime;
	}
	public void setPublishTime(String publishTime) {
		try  
		{  
		    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");  
		    this.publishTime = sdf.parse(publishTime);  
		}  
		catch (ParseException e)  
		{  
		    System.out.println(e.getMessage());  
		}  

	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public double getPrice() {
		return Price;
	}
	public void setPrice(double Price) {
		this.Price = Price;
	}
	public double getPricepromotion() {
		return Pricepromotion;
	}
	public void setPricepromotion(double Pricepromotion) {
		this.Pricepromotion = Pricepromotion;
	}
	public int getStock() {
		return Stock;
	}
	public void setStock(int Stock) {
		this.Stock = Stock;
	}
	public String getDescription() {
		return Description;
	}
	public void setDescription(String Description) {
		this.Description = Description;
	}

}
