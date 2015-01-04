package com.bocom.midserv.web;

/**
 * 此处插入类型描述。
 * 创建日期：(2003-5-30 13:40:08)
 * @author：Administrator
 */
import java.sql.*;
import java.util.*;
import com.bocom.midserv.base.*;

public class MidObjectStepView extends MidObject {
    private int biz_id; //*商户代码
    private int biz_step_id; //* 步骤代码
    private int serino; //* 序列号
    private String input_lable; //* INPUT前面的文字
    private String input_type;
    private String input_name;
    private String input_size;
    private String input_value;
    private String input_memo; //简要说明

   


/**
 * MidObjectStep1View 构造子注解。
 */
public MidObjectStepView() {
	super();
}
/**
 * 此处插入方法描述。
 * 创建日期：(2003-5-30 13:46:32)
 * @return int
 */
public int get_biz_id() {
	return biz_id;
}
/**
 * 此处插入方法描述。
 * 创建日期：(2003-5-30 13:46:51)
 * @return int
 */
public int get_biz_step_id() {
	return biz_step_id;
}
/**
 * 此处插入方法描述。
 * 创建日期：(2003-5-30 13:47:31)
 * @return java.lang.String
 */
public String get_input_lable() {
	return input_lable;
}
/**
 * 此处插入方法描述。
 * 创建日期：(2003-5-30 13:49:17)
 * @return java.lang.String
 */
public String get_input_memo() {
	return input_memo;
}
/**
 * 此处插入方法描述。
 * 创建日期：(2003-5-30 13:48:15)
 * @return java.lang.String
 */
public String get_input_name() {
	return input_name;
}
/**
 * 此处插入方法描述。
 * 创建日期：(2003-5-30 13:48:36)
 * @return java.lang.String
 */
public String get_input_size() {
	return input_size;
}
/**
 * 此处插入方法描述。
 * 创建日期：(2003-5-30 13:47:53)
 * @return java.lang.String
 */
public String get_input_type() {
	return input_size;
}
/**
 * 此处插入方法描述。
 * 创建日期：(2003-5-30 13:48:57)
 * @return java.lang.String
 */
public String get_input_value() {
	return input_value;
}
/**
 * 此处插入方法描述。
 * 创建日期：(2003-5-30 13:47:12)
 * @return int
 */
public int get_serino() {
	return serino;
}




/**
 * 此处插入方法描述。
 * 创建日期：(2003-5-30 13:53:18)
 * @param i_biz_id int
 * @param i_step_id int
 * @param i_serino int
 */
public void getInputViewByBizIdAndStepIdAndSerino(
    int i_biz_id,
    int i_step_id,
    int i_serino)
    throws EBException {
    Statement st=null;
    try {
        // beginLog();
        getDBConnection();
        String sqlstr =
            "select * from TRANS_VIEW_DEF where biz_id="
                + i_biz_id
                + " and step_id="
                + i_step_id
                + " and serino="
                + i_serino;
        st = _con.createStatement();
        ResultSet rs = st.executeQuery(sqlstr);

        set_biz_id(biz_id);
        set_biz_step_id(rs.getInt("biz_step_id"));
        set_input_lable(rs.getString("input_lable"));
        set_input_memo(rs.getString("input_memo"));
        set_input_name(rs.getString("input_name"));
        set_input_size(rs.getString("input_size"));
        set_input_type(rs.getString("input_type"));
        set_input_value(rs.getString("input_value"));
        set_serino(rs.getInt("serino"));
        releaseDBConnection();
    } catch (SQLException e) {
        e.printStackTrace();
    } 
}
/**
 * 此处插入方法描述。
 * 创建日期：(2003-06-03 09:24:21)
 * @return int
 * @param biz_id int
 */
public int getMaxStepId(int i_biz_id) throws EBException {
	Statement st =null;
    try {
        // beginLog();
        getDBConnection();
        String sqlstr =
            "select max(biz_step_id) from TRANS_VIEW_DEF where biz_id=" + i_biz_id;
        st = _con.createStatement();
        ResultSet rs = st.executeQuery(sqlstr);
        int i_max_step_id;
        if(rs.next())
            i_max_step_id = rs.getInt(1);
        else
           //* there are no rows for select 
            i_max_step_id = -1;
        //rs.close();
        //st.close();
        releaseDBConnection();
        return i_max_step_id;
    } catch (SQLException e) {
        e.printStackTrace();
        return -1;
    }
  
}
/**
 * 此处插入方法描述。
 * 创建日期：(2003-06-03 09:24:21)
 * @return int
 * @param biz_id int
 */
public int getMaxbiz_id() throws EBException {
    Statement st =null;
    try {
        // beginLog();
        getDBConnection();
        String sqlstr =
            "select max(biz_id) from TRANS_DEF";
        st = _con.createStatement();
        ResultSet rs = st.executeQuery(sqlstr);
        int i_max_biz_id;
        if(rs.next())
            i_max_biz_id = rs.getInt(1);
        else
            //* there are no rows for select 
            i_max_biz_id = -1;
        //rs.close();
        //st.close();
        releaseDBConnection();
        return i_max_biz_id;
    } catch (SQLException e) {
        e.printStackTrace();
        return -1;
    }
}
/**
 * 此处插入方法描述。
 * 创建日期：(2003-06-03 09:24:21)
 * @return int
 * @param biz_id int
 */
public int getMaxserino(int i_biz_id, int i_step_id) throws EBException  {
    Statement st=null;
    try {
        // beginLog();
        getDBConnection();
        String sqlstr =
            "select max(serino) from TRANS_VIEW_DEF where biz_id="
                + i_biz_id
                + " and biz_step_id="
                + i_step_id
                + "";
        st = _con.createStatement();
        ResultSet rs = st.executeQuery(sqlstr);
        int i_max_serino;
        if(rs.next())
            i_max_serino = rs.getInt(1);
        else
         //* there are no rows for select 
            i_max_serino = -1;
        //rs.close();
        //st.close();
        releaseDBConnection();
        return i_max_serino;
    } catch (SQLException e) {
        e.printStackTrace();
        return -1;
    }
}
/**
 * 此处插入方法描述。
 * 创建日期：(2003-5-30 13:53:18)
 * @param biz_id int
 * @param step_id int
 */
public ResultSet getStepViewHidByBizIdAndStepId(int i_biz_id, int i_step_id)
    throws EBException {
    Statement st=null;
    try {
        // beginLog();
        getDBConnection();
        String sqlstr =
            "select * from TRANS_VIEW_DEF where biz_id="
                + i_biz_id
                + " and biz_step_id="
                + i_step_id
                + " and view_mod=-1";
        st = _con.createStatement();
        ResultSet rs = st.executeQuery(sqlstr);

        return rs;

    } catch (SQLException e) {
        e.printStackTrace();
        return null;
    }
 
}
/**
 * 此处插入方法描述。
 * 创建日期：(2003-5-30 13:53:18)
 * @param biz_id int
 * @param step_id int
 */
public ResultSet getStepView(int i_biz_id, int i_step_id)
    throws EBException {
	Statement st=null;
    try {
        // beginLog();
        getDBConnection();
        String sqlstr =
            "select * from TRANS_VIEW_DEF where biz_id="
                + i_biz_id
                + " and biz_step_id="
                + i_step_id
                + "";
        st = _con.createStatement();
        ResultSet rs = st.executeQuery(sqlstr);

        return rs;

    } catch (SQLException e) {
        e.printStackTrace();
        return null;
    }
    
}
/**
 * 此处插入方法描述。
 * 创建日期：(2003-5-30 13:53:18)
 * @param biz_id int
 * @param step_id int
 */
public ResultSet getStepViewNotHidByBizIdAndStepId(int i_biz_id, int i_step_id)
    throws EBException {
    Statement st =null;
    try {
        // beginLog();
        getDBConnection();
        String sqlstr =
            "select * from TRANS_VIEW_DEF where biz_id="
                + i_biz_id
                + " and biz_step_id="
                + i_step_id
                + " and view_mod=1";
        ;
        st = _con.createStatement();
        ResultSet rs = st.executeQuery(sqlstr);
        return rs;

    } catch (SQLException e) {
        e.printStackTrace();
        return null;
    }
 
 
}
/**
 * 此处插入方法描述。
 * 创建日期：(2003-5-30 11:34:03)
 * @param args java.lang.String[]
 */
public static void main(String[] args) {

    MidObjectStepView myMidObjectStepView = new MidObjectStepView();

    //* test 1 : top list
    //try {

    //System.out.print("begin\n");
    //ResultSet myrs = myMidObjectStepView.getMidBizIdAndBizNameList();
    //String str_biz_no;
    //String str_biz_memo;
    //while (myrs.next()) {
    //str_biz_no = myrs.getString("biz_no");
    //str_biz_memo = myrs.getString("biz_memo");

    //System.out.print(str_biz_no + "--" + str_biz_memo + "\n");
    //}
    //myrs.close();
    //System.out.print("end\n");
    //} catch (Exception e) {
    //e.printStackTrace();
    //}

    //* test 2 : stepview list
    try {

    System.out.print("begin\n");
    ResultSet myrs = myMidObjectStepView.getStepViewNotHidByBizIdAndStepId(4, 2);
    String str_input_lable;
    String str_input_size;
    while (myrs.next()) {
    str_input_lable = myrs.getString("input_lable");
    str_input_size = myrs.getString("input_size");

    System.out.print(
    str_input_lable + "--" + str_input_size + "\n");
    }
    myrs.close();
    myMidObjectStepView.releaseDBConnection();
    System.out.print("end\n");
    } catch (Exception e) {
    e.printStackTrace();
    }

    ////* test 3
    //try {
        //int iii = myMidObjectStepView.getMaxStepId(1);
        //System.out.print(iii);
    //} catch (Exception e) {
        //e.printStackTrace();
    //}
}
/**
 * 生成页面检查的javascript语句
 * 创建日期：(2003-5-31 12:55:10)
 * @param rs java.sql.ResultSet
 */
public void makePreSubmitCheck(ResultSet rs) {

    //* 可以在这里根据input的size来进行判断，并提供函数

}
/**
 * 此处插入方法描述。
 * 创建日期：(2003-5-30 14:33:46)
 * @param i_biz_id int
 */
public void set_biz_id(int i_biz_id) {
	biz_id=i_biz_id;}
/**
 * 此处插入方法描述。
 * 创建日期：(2003-5-30 14:34:28)
 * @param i_biz_step_id int
 */
public void set_biz_step_id(int i_biz_step_id) {
    biz_step_id = i_biz_step_id;
}
/**
 * 此处插入方法描述。
 * 创建日期：(2003-5-30 14:35:27)
 * @param s_input_lable java.lang.String
 */
public void set_input_lable(String s_input_lable) {
    input_lable = s_input_lable;
}
/**
 * 此处插入方法描述。
 * 创建日期：(2003-5-30 14:38:31)
 * @param s_input_memo java.lang.String
 */
public void set_input_memo(String s_input_memo) {
    input_memo = s_input_memo;
}
/**
 * 此处插入方法描述。
 * 创建日期：(2003-5-30 14:36:51)
 * @param s_input_type java.lang.String
 */
public void set_input_name(String s_input_name) {
    input_name = s_input_name;
}
/**
 * 此处插入方法描述。
 * 创建日期：(2003-5-30 14:37:19)
 * @param s_input_size java.lang.String
 */
public void set_input_size(String s_input_size) {
	input_size=s_input_size;}
/**
 * 此处插入方法描述。
 * 创建日期：(2003-5-30 14:36:28)
 * @param s_input_type java.lang.String
 */
public void set_input_type(String s_input_type) {
    input_type = s_input_type;
}
/**
 * 此处插入方法描述。
 * 创建日期：(2003-5-30 14:37:41)
 * @param s_input_value java.lang.String
 */
public void set_input_value(String s_input_value) {
    input_value = s_input_value;
}
/**
 * 此处插入方法描述。
 * 创建日期：(2003-5-30 14:34:56)
 * @param i_serino int
 */
public void set_serino(int i_serino) {
    serino = i_serino;
}
}
