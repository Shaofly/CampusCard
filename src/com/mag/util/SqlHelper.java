package com.mag.util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.util.Properties;



public class SqlHelper {
	
	public static Connection getCt() {
		return ct;
	}
	public static PreparedStatement getPs() {
		return ps;
	}
	public static ResultSet getRs() {
		return rs;
	}
	private static Connection ct=null;
	private static PreparedStatement ps=null;
	private static ResultSet rs=null;
	
	private static String driver="";
	private static String url="";
	private static String username="";
	private static String password="";
	
	private static Properties pp=null;
	private static InputStream fis=null;
	//加载驱动，只需一次，所以放在静态块中。
	static{
		
		try {
			//javaweb项目读取文件要用类加载器
			pp=new Properties();
			fis=SqlHelper.class.getClassLoader().getResourceAsStream("dbinfo.properties");
			pp.load(fis);
			driver=pp.getProperty("driver");
			url=pp.getProperty("url");
			username=pp.getProperty("username");
			password=pp.getProperty("password");
			Class.forName(driver);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally
		{
			if(fis!=null)
			{
				try {
					fis.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			fis=null;
		}
	}
	//得到链接
	public static Connection getConnection()
	{
		try {
			ct=DriverManager.getConnection(url,username,password);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return ct;
	}
	//关闭资源函数
	public static void close(Connection ct,PreparedStatement ps,ResultSet rs)
		{
			try {
				//为了程序健壮、
				if(rs!=null)
				{
					rs.close();
				}
				rs=null;
				if(ps!=null)
				{
					ps.close();
				}
				ps=null;
				if(ct!=null)
				{
					ct.close();
				}
				ct=null;
			
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	//Update函数(单条delete/update/insert语句)
	public static void executeUpdate(String sql,String []parameters)
	{
		
		try {
			ct=getConnection();
			ps=ct.prepareStatement(sql);
			if(parameters!=null)
			{
				for(int i=0;i<parameters.length;i++)
				{
					ps.setObject(i+1, parameters[i]);//.setString(i+1, parameters[i]);
				}
			}
			//执行
			ps.executeUpdate();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw new RuntimeException(e.getMessage());
		}finally{
			close(ct,ps,rs); 
		}
	}
	//Update函数(多条delete/update/insert语句)事务处理（回滚）
	public static void executeUpdate2(String []sql,String [][]parameters)
	{
		try {
			ct=getConnection();
			ct.setAutoCommit(false);
			if(sql!=null)
			{
				for(int i=0;i<sql.length;i++)
				{
					ps=ct.prepareStatement(sql[i]);
					if(parameters[i]!=null)
					{
						for(int j=0;j<parameters[i].length;j++)
						{
							ps.setObject(j+1, parameters[i][j]);
						}
						ps.executeUpdate();
					}
				}
			}
			ct.commit();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			//回滚
			try {
				ct.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			throw new RuntimeException(e.getMessage());
		}finally{
			
			close(ct,ps,rs);
		}
	}
	//select语句
	public static ResultSet executeQuery(String sql,String []parameters)
	{
		try {
			ct=getConnection();
			ps=ct.prepareStatement(sql);
			if(parameters!=null&&!parameters.equals(""))
			{
			  for(int i=0;i<parameters.length;i++)
			  {
				  ps.setObject(i+1, parameters[i]);
			  }
			}
			rs=ps.executeQuery();
			return rs;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			throw new RuntimeException(e.getMessage());
		}finally{

            //因为要返回结果集rs，所以要手动关闭资源。
		}
	}

	// 新增方法：返回受影响的行数
	public static int executeUpdateReturnCount(String sql, String[] parameters) {
		Connection ct = null;
		PreparedStatement ps = null;
		try {
			ct = getConnection();
			ps = ct.prepareStatement(sql);
			if (parameters != null) {
				for (int i = 0; i < parameters.length; i++) {
					ps.setObject(i + 1, parameters[i]);
				}
			}
			// 执行并返回受影响行数
			return ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e.getMessage());
		} finally {
			close(ct, ps, null);
		}
	}
}
