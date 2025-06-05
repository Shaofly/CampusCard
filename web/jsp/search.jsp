<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  // 数据库连接信息，根据实际情况修改
  String url = "jdbc:mysql://localhost:3306/web_demo?useSSL=false&serverTimezone=UTC";
  String dbUser = "root";
  String dbPwd = "123456";

  Connection conn = null;
  Statement stmt = null;
  ResultSet rs = null;

  String username = request.getParameter("username");
  String gender = request.getParameter("gender");
  String ageStart = request.getParameter("ageStart");
  String ageEnd = request.getParameter("ageEnd");

  // 拼接 SQL 查询语句
  String sql = "SELECT * FROM user_table WHERE 1=1 ";
  if (username != null && !username.trim().equals("")) {
    sql += " AND username LIKE '%" + username + "%' ";
  }
  if (gender != null && !gender.trim().equals("")) {
    sql += " AND gender = '" + gender + "' ";
  }
  if (ageStart != null && !ageStart.trim().equals("")) {
    sql += " AND age >= " + ageStart + " ";
  }
  if (ageEnd != null && !ageEnd.trim().equals("")) {
    sql += " AND age <= " + ageEnd + " ";
  }

  try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(url, dbUser, dbPwd);
    stmt = conn.createStatement();
    rs = stmt.executeQuery(sql);

    while (rs.next()) {
      out.println("<tr>");
      out.println("<td>" + rs.getInt("id") + "</td>");
      out.println("<td>" + rs.getString("username") + "</td>");
      out.println("<td>" + rs.getInt("age") + "</td>");
      out.println("<td>" + rs.getString("gender") + "</td>");
      out.println("<td>" + rs.getString("email") + "</td>");
      out.println("</tr>");
    }
  } catch (Exception e) {
    e.printStackTrace();
    out.println("查询出错：" + e.getMessage());
  } finally {
    // 关闭资源
    if (rs != null) try { rs.close(); } catch (SQLException e) {}
    if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
    if (conn != null) try { conn.close(); } catch (SQLException e) {}
  }
%>
