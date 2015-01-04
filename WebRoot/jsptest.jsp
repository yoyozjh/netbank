<%
/****************************************
 *程序名称：jsptest.jsp                 *
 *程序目的：测试页面                    *
 *                                      *
 *                                      *
 ****************************************/
%>
<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.*" %>
<%@ page import ="java.text.*" %>
<%@ page import="java.lang.*"%>
<%@ page import ="com.sybase.jdbc2.jdbc.*" %>
<%
  String sql="select * from TRANS_DEF  ";
/**
  Connection con;
  Statement stmt;
  DBConnectionPool pool = DBConnectionPool.getInstance();
  con =pool.getConnection();
  stmt = con.createStatement();
  ResultSet rs;

  rs=stmt.executeQuery(sql);
  if(!rs.next()){
  out.print("连接成功");
  }else{
  out.print("失败");
  }
  pool.freeConnection(con);
*/


Class.forName("com.sybase.jdbc2.jdbc.SybDriver").newInstance();

Connection con;

con=DriverManager.getConnection("jdbc:sybase:Tds:182.53.4.118:6006","miduser","miduser");

Statement stmt=con.createStatement();

ResultSet rs=stmt.executeQuery(sql);
rs.next();
out.print(rs.getString(1));
out.print(rs.getString(2));
out.print(rs.getString(3));

rs.close();

con.close();

//out.print("haha");
%>