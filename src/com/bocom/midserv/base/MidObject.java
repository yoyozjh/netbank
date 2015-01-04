package com.bocom.midserv.base;

/**
 * 此处插入类型描述。
 * 创建日期：(2003-5-29 17:12:36)
 * @author：Administrator
 */
import java.sql.*;
import java.util.*;
import java.io.*;
import javax.naming.*;

public class MidObject extends EBObject {
    public Connection _con = null;
    public Statement st = null;
    public ResultSet rs = null;
    
    //* 数据库变量定义
    //private String db_host = "182.39.161.221";
    //private String db_port = "6006";
    //private String db_user = "miduser";
    //private String db_passwd = "miduser";

    //* 通讯变量定义
    //private String host_ip = "182.39.161.221";
    //private int host_port = 3555;
/**
 * MidObject 构造子注解。
 */
public MidObject() {
	super();
}
/**
 * 获得数据库连接
 * 创建日期：(2003-5-30 10:50:10)
 * @exception com.bocom.midserv.base.EBException 异常说明。
 */
public void getDBConnection() throws EBException {

    //* single connection 
    MidDbTools myMidDbTools = new MidDbTools();
    //if (_con == null)
    	_con = myMidDbTools.connect("","","","");

    //* datasource connection viar weblogic def
	/*
    try {
        Context ctx = new InitialContext();
        javax.sql.DataSource ds = (javax.sql.DataSource) ctx.lookup("MidServPoolDs");
        _con = ds.getConnection();
        if(_con != null)
                System.out.print("getDBConnection获得数据库连接:[" + _con.toString() + "]\n");
        else
                System.out.print("getDBConnection获得数据库连接失败！");
    } catch (Exception e) {
    	System.out.print("getDBConnection获得数据库连接异常！");
        e.printStackTrace();
    }
    */

}


public void releaseDBConnection()
        throws SQLException
    {
    	try
        {
            if(rs != null)
            {
                System.out.print("releaseDBConnection数据库连接rs释放成功![" + rs.toString() + "]\n");
                rs.close();
            } else
            {
                System.out.print("releaseDBConnection数据库连接rs本来为空!\n");
            }
        }
        catch(Exception e)
        {
            System.out.print("releaseDBConnection数据库连接st释放失败!\n");
            e.printStackTrace();
        }
    	try
        {
            if(st != null)
            {
                System.out.print("releaseDBConnection数据库连接st释放成功![" + st.toString() + "]\n");
                st.close();
            } else
            {
                System.out.print("releaseDBConnection数据库连接st本来为空!\n");
            }
        }
        catch(Exception e)
        {
            System.out.print("releaseDBConnection数据库连接st释放失败!\n");
            e.printStackTrace();
        }
        /*
        try
        {
            if(_con != null)
            {
                System.out.print("releaseDBConnection数据库连接_con释放成功![" + _con.toString() + "]\n");
                _con.close();
            } else
            {
                System.out.print("releaseDBConnection数据库连接_con本来为空!\n");
            }
        }
        catch(Exception e)
        {
            System.out.print("releaseDBConnection数据库连接_con释放失败!\n");
            e.printStackTrace();
        }*/
    }



/**
 * 此处插入方法描述。
 * 创建日期：(2003-5-30 16:32:04)
 * @return String
 * @param send_buf java.lang.String
 * @param recv_buf java.lang.String
 */
public String invokeTcpConnect(
    String send_buf,
    String s_host_ip,
    int i_host_port) {
    String recv_buf = null;
    try {
        MidNetworkTools myMidNetworkTools = new MidNetworkTools();
        String str_len = String.valueOf(send_buf.length());
        while (str_len.length() < 4) {
            str_len = "0" + str_len;
        }
        myMidNetworkTools.set_buf_in(str_len + send_buf);
        recv_buf = myMidNetworkTools.tcpConnect(s_host_ip, i_host_port);
    } catch (IOException e) {
        e.printStackTrace();
    }
    return recv_buf;

}

}
