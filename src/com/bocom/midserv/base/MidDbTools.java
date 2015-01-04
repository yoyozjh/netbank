package com.bocom.midserv.base;

import java.net.*;
import java.sql.*;
import java.lang.*;
import java.io.*;
import java.util.*;
public class MidDbTools
{
 	Connection dbConn=null; //数据库连接
 
public MidDbTools() {
    try {
        Class.forName("com.sybase.jdbc2.jdbc.SybDriver");
    } catch (java.lang.ClassNotFoundException e) {
        System.out.println("mydb():" + e.getMessage());
    }
}
public ResultSet callStore(String sql) {
    ResultSet rSet = null;
    try {
        CallableStatement sqlStmt = dbConn.prepareCall(sql);
        rSet = sqlStmt.executeQuery();
    } catch (SQLException ex) {
        System.out.println("db.callStore:" + ex.getMessage());
    }
    return rSet;
}
public Connection connect(
    String ip,
    String port,
    String user,
    String passwd) //数据库连接
{
    String theUrl = "jdbc:sybase:Tds:" + ip + ":" + port;
    System.out.println(theUrl);
    try {
        dbConn = DriverManager.getConnection("jdbc:sybase:Tds:182.53.15.211:6600/pbbranchdb?CHARSET=cp936&amp;amp;LANGUAGE=en_US", "miduser", "miduser");
        return dbConn;
    } catch (SQLException ex) {
        System.out.println("db.connect:" + ex.getMessage());
        return null;

    }
}
public void disconnect() //断开数据库
{
    try {
        dbConn.close();
    } catch (SQLException ex) {
        System.out.println("db.closeconn:" + ex.getMessage());
    }
}
public ResultSet executeQuery(String sql) //数据库查询
{
    ResultSet rSet = null;
    try {
        Statement sqlStmt = dbConn.createStatement();
        rSet = sqlStmt.executeQuery(sql);
    } catch (SQLException ex) {
        System.out.println("db.excuteQuery:" + ex.getMessage());
    }
    return rSet;
}
public boolean executeUpdate(String sql) {
    boolean bupdate = false;
    ResultSet rSet = null;
    try {
        Statement sqlStmt = dbConn.createStatement();
        int rowCount = sqlStmt.executeUpdate(sql);
        if (rowCount != 0)
            bupdate = true;
    } catch (SQLException ex) {
        System.out.println("db.executeUpdate:" + ex.getMessage());
    }
    return bupdate;
}
}
