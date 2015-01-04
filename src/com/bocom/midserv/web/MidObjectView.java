package com.bocom.midserv.web;

/**
 * 此处插入类型描述。
 * 创建日期：(2003-5-29 16:34:22)
 * @author：Administrator
 */
import java.sql.*;
import java.util.*;
import com.bocom.midserv.base.*;

public class MidObjectView extends MidObject {
    private int biz_id;
    private String biz_no;
    private String biz_memo;
    private String biz_detail;
    private String ico_name;
/**
 * MidObjectCtl 构造子注解。
 */ 
public MidObjectView() {
	super();
}
    /**
     * 此处插入方法描述。
     * 创建日期：(2003-5-30 13:48:57)
     * @return java.lang.String
     */
    public String get_biz_detail() {
        return biz_detail;
    }
/**
* 此处插入方法描述。
* 创建日期：(2003-5-30 13:48:57)
* @return java.lang.int
*/
public int get_biz_id() {
    return biz_id;
}
    /**
     * 此处插入方法描述。
     * 创建日期：(2003-5-30 13:48:57)
     * @return java.lang.String
     */
    public String get_biz_memo() {
        return biz_memo;
    }
    /**
     * 此处插入方法描述。
     * 创建日期：(2003-5-30 13:48:57)
     * @return java.lang.String
     */
    public String get_biz_no() {
        return biz_no;
    }
    /**
     * 此处插入方法描述。
     * 创建日期：(2003-5-30 13:48:57)
     * @return java.lang.String
     */
    public String get_ico_name() {
        return ico_name;
    }
/**
 * 客户提交请求，罗列分行当前的中间代理业务品种
 * 创建日期：(2003-5-29 17:07:43)
 */
public boolean getMidObjectView(int i_biz_id) throws Exception {

    // beginLog();
System.out.print(" debug!调试a00.01 MidObjectView.java getMidObjectView getDBConnection()\n");
    getDBConnection();
System.out.print(" debug!调试a00.02 MidObjectView.java getMidObjectView getDBConnection()\n");
    String sqlstr = "select * from TRANS_DEF where biz_id=" + i_biz_id;
System.out.println("debug 调试  MidObjectView.java getMidObjectView 111.03 sqlstr="+sqlstr);
    Statement st = _con.createStatement();
    ResultSet rs = st.executeQuery(sqlstr);
	boolean ret_flag;
    if (rs.next()) {
        set_biz_id(rs.getInt("biz_id"));
        set_biz_no(rs.getString("biz_no"));
        set_biz_memo(rs.getString("biz_memo"));
        set_biz_detail(rs.getString("biz_detail"));
        set_ico_name(rs.getString("ico_name"));
        
        ret_flag = true;
    } else {
      
    	ret_flag = false;
    }
    rs.close();
    st.close();
System.out.print(" debug!调试a01.01 MidObjectView.java getMidObjectView releaseDBConnection()\n");
    releaseDBConnection();   
System.out.print(" debug!调试a01.02 MidObjectView.java getMidObjectView releaseDBConnection()\n");
 
    return ret_flag;
    	

}
/**
 * 客户提交请求，罗列分行当前的中间代理业务品种
 * 创建日期：(2003-5-29 17:07:43)
 * @return java.sql.ResultSet
 */
public ResultSet getMidViewList() throws Exception {
	Statement st = null;
	try
	{
    // beginLog();
    getDBConnection();
    String sqlstr = "select * from TRANS_DEF where state='1'";
    st = _con.createStatement();
    ResultSet rs = st.executeQuery(sqlstr);
    return rs;
    } catch (SQLException e) {
        e.printStackTrace();
        return null;
    }
    
}


public ResultSet getMidViewList(String up_biz_id) throws Exception {
	Statement st = null;
	try
	{
    // beginLog();
    getDBConnection();
    String sqlstr = "select b.biz_id,b.biz_memo,b.biz_no,a.branch,a.web_url "
    	+" from TRANS_MENU_DEF a, TRANS_DEF  b"
    	+" where a.biz_id=b.biz_id and b.state='1' and a.up_biz_id="+up_biz_id
    	+" order by web_order";
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

    MidObjectView myMidObjectView = new MidObjectView();

    try {
    System.out.print("begin\n");
    ResultSet myrs = myMidObjectView.getMidViewList();
    String str_biz_no;
    String str_biz_memo;
    while (myrs.next()) {
    myMidObjectView.set_biz_id(myrs.getInt("biz_id"));
    str_biz_no = myrs.getString("biz_no");
    str_biz_memo = myrs.getString("biz_memo");
    System.out.print(str_biz_no + "--" + str_biz_memo + "\n");
    }
    myrs.close();
    myMidObjectView.releaseDBConnection();
    System.out.print("end\n");
    } catch (Exception e) {
    e.printStackTrace();
    }
    
    ////* test 2 : objectview list
    //try {

    //System.out.print("begin\n");
    //myMidObjectView.getMidObjectView(1);
    //System.out.print(
    //myMidObjectView.get_biz_id()
    //+ myMidObjectView.get_biz_no()
    //+ myMidObjectView.get_biz_memo()
    //+ myMidObjectView.get_biz_detail()
    //+ myMidObjectView.get_ico_name()
    //+ "\n");
    //System.out.print("end\n");
    //} catch (Exception e) {
    //e.printStackTrace();
    //}

}
public void set_biz_detail(String s_biz_detail) {
    biz_detail = s_biz_detail;
}
public void set_biz_id(int i_biz_id) {
    biz_id = i_biz_id;
}
public void set_biz_memo(String s_biz_memo) {
    biz_memo = s_biz_memo;
}
public void set_biz_no(String s_biz_no) {
    biz_no = s_biz_no;
}
public void set_ico_name(String s_ico_name) {
    ico_name = s_ico_name;
}

/**
 * 客户提交请求，罗列分行当前的中间代理业务品种
 * 创建日期：(2003-5-29 17:07:43)
 */
public MidObjectView getMidObjectInstance(int i_biz_id) throws Exception {

    // beginLog();
    MidObjectView midObjectView = new MidObjectView();

    midObjectView.getDBConnection();

    String sqlstr = "select * from TRANS_DEF where biz_id=" + i_biz_id;
    Statement st = _con.createStatement();
    ResultSet rs = st.executeQuery(sqlstr);

    if (rs.next()) {
        set_biz_id(rs.getInt("biz_id"));
        set_biz_no(rs.getString("biz_no"));
        set_biz_memo(rs.getString("biz_memo"));
        set_biz_detail(rs.getString("biz_detail"));
        set_ico_name(rs.getString("ico_name"));

		rs.close();
 		midObjectView.releaseDBConnection();
        return midObjectView;
    } else {
		rs.close();
    midObjectView.releaseDBConnection();
        return null;
    }

}

/**
 * 客户提交请求，罗列分行当前的中间代理业务品种
 * 创建日期：(2003-5-29 17:07:43)
 * @return java.lang.String
 */
public String writeMidViewListJspPage() throws Exception {

    // beginLog();
    getDBConnection();
    String sqlstr = "select biz_no,biz_memo from TRANS_DEF";
    Statement st = _con.createStatement();
    ResultSet rs = st.executeQuery(sqlstr);

    String jsp_page_buff = null;
    while (rs.next()) {
        jsp_page_buff =
            jsp_page_buff
                + "<a href=./midServStep1.jsp?biz_id="
                + rs.getInt("biz_id")
                + ">"
                + rs.getString("biz_label")
                + "</a>";
    }
    /* 返回形如
    	<input href=/midserv/midServStep1.jsp?biz_id=1>移动电话交费</a>
    	<input href=/midserv/midServStep1.jsp?biz_id=2>电信电话交费</a>
    	<input href=/midserv/midServStep1.jsp?biz_id=2>联通电话交费</a>
    */
		//rs.close();
        releaseDBConnection();
    return jsp_page_buff;
}
/**
 * 客户提交请求，罗列分行当前的中间代理业务品种
 * 创建日期：(2003-5-29 17:07:43)
 * @return java.lang.String
 */
public String writeCondition(int i_biz_id, int i_step_id) throws Exception {

    // beginLog();
    getDBConnection();
    String sqlstr = "select * from TRANS_VIEW_DEF where biz_id="+i_biz_id+" and biz_step_id="+i_step_id+" and view_mod=1";
    //System.out.println("调试 debug! sqlstr="+sqlstr);
    Statement st = _con.createStatement();
    ResultSet rs = st.executeQuery(sqlstr);
    String txing="输入不能为空！";
    String null_check = null;
    while (rs.next()) {
    	if(rs.getInt("word_type")!=3){
        null_check =
            null_check
                + "\n" + "if (this.document.form1."
                + rs.getString("input_name").trim()
                + ".value==" + "\"" + "\"" + "||this.document.form1."
                + rs.getString("input_name").trim()
                + ".value==null)"
		+ "{" + "\n"
		+ "alert(" + "\"" + " 输入不能为空！" + "\"" + ");" + "\n"
		+ "return false;" + "\n"
  		+ "}";
    	}
    }
    String sql_word="select * from TRANS_VIEW_DEF where biz_id="+i_biz_id+" and biz_step_id="+i_step_id+" and view_mod=1 and word_type=2";
    ResultSet rs_word = st.executeQuery(sql_word);
    String word_check=null;
    while (rs_word.next()){
        word_check =
            word_check
            + "\n" + "length1 = this.document.form1." 
            + rs_word.getString("input_name").trim()
            + ".value.length;" + "\n"
            + "for (i = 0 ; i < length1 ; i++)" + "{" + "\n"
            + "if(isNaN(parseInt(this.document.form1."
            + rs_word.getString("input_name").trim()
            + ".value.charAt(i),10))){" + "\n"
            + "alert(" + "\"" + "请输入数字！" + "\"" + ");" + "\n"
            + "return false;" + "\n"
            + "}" + "\n"
            + "}";
    }
    
    String sql_word2="select * from TRANS_VIEW_DEF where biz_id="+i_biz_id+" and biz_step_id="+i_step_id+" and view_mod=1 and word_type=3";
    ResultSet rs_word2 = st.executeQuery(sql_word2);
    String word_check2 = null;
    while (rs_word2.next()){
        word_check2 =
             word_check2
             + "\n" + "length1 = this.document.form1."
             + rs_word2.getString("input_name").trim()
             + ".value.length;" + "\n"
             + "if (this.document.form1."
             + rs_word2.getString("input_name").trim()
             + ".value.charAt(0)==" + "\"" + "0" + "\"" + ")" + "\n"
             + "{if (length1 == 1){" + "\n"
             + "alert(" +"\"" + "金额不能为0！" + "\"" + ");" + "\n"
             + "return false;" + "\n"
             + "}" + "\n"
             + "else{" + "\n"
             + "if (!(this.document.form1."
             + rs_word2.getString("input_name").trim()
             + ".charAt(1)==" + "\"" + "." + "\"" + ")){" + "\n"
             + "alert(" + "\"" + "金额首位为0！" + "\"" + ");" + "\n"
             + "return false;" + "\n"
             + "}" + "\n"
             + "}" + "\n"
             + "}" + "\n"
             + "j=0;" + "\n"
             + "for (i = 0 ; i < length1 ; i++) " + "\n"
             + "{" + "\n"
             + "if(isNaN(parseInt(this.document.form1."
             + rs_word2.getString("input_name").trim()
             + ".value.charAt(i),10)))" + "\n"
             + "{" + "\n"
             + "if(this.document.form1."
             + rs_word2.getString("input_name").trim()
             + ".value.charAt(i) != " + "\"" + "." + "\"" + ")" + "\n"
             + "{" + "\n"
             + "alert(" + "\"" + "字符类型不对！" + "\"" + ");" + "\n"
             + "return false;" + "\n"
             + "}" + "\n"
             + "else{" + "\n" 
             + "j++;" + "\n"
             + "if(length1 - i > 3 ){" + "\n"
             + "alert(" + "\"" + "小数点后只能有两位数！" + "\"" + ");" + "\n"
             + "return false;" + "\n"
             + "}" + "\n"
             + "}" + "\n"
             + "}" + "\n"
             + "}" + "\n"
             + "if(j > 1) {" + "\n"
             + "alert(" + "\"" + "只能有一个小数点！" + "\"" + ");" + "\n"
              + "return false;" + "\n"
             + "}" + "\n";
             
    }
    
    String sql_length="select * from TRANS_VIEW_DEF where biz_id="+i_biz_id+" and biz_step_id="+i_step_id+" and view_mod=1 and check_sign=1";
    ResultSet rs_length = st.executeQuery(sql_length);
    String length_check=null;
    while (rs_length.next()){
        length_check=
            length_check
                + "\n" + "if (this.document.form1."
                + rs_length.getString("input_name").trim()
                + ".value.length!=" + rs_length.getInt("input_size")
                + "&&this.document.form1." 
                + rs_length.getString("input_name").trim()
                 + ".value.length!=16)"
                + "{" + "\n"
                + "alert(" + "\"" + " 长度不正确" + "\"" + ");" + "\n"
                + "return false;" + "\n"
                + "}";
    }
    
    String condition=null;
    condition="<SCRIPT LANGUAGE=javascript>" + "\n"
        +"function condition()" + "\n" + "{" + "\n"
	+ "var length1 , i,j ;" + "\n"
	+ null_check + "\n" + word_check + "\n" + word_check2 + "\n" + length_check + "\n" + "return true;" + "\n" 
	+"}" +"\n" 
	+"</script>";
//System.out.println("调试 debug! condition="+condition);
        rs.close();
        rs_length.close();
        rs_word.close();
        rs_word2.close();
    	releaseDBConnection();

    return condition;
}
/**
 * 客户提交请求，罗列分行当前的中间代理业务品种
 * 创建日期：(2003-6-26 17:07:43)
 */
public boolean insertData(String sqltr) throws Exception {
    boolean bupdate = false;
    // beginLog();
    getDBConnection();
    Statement st=null;
    try {
    st = _con.createStatement();
    st.executeQuery(sqltr);
    bupdate = true;
    } catch (SQLException ex) {
        System.out.println("db.executeUpdate:" + ex.getMessage());
    }
 
      finally {
    	  //st.close();
         releaseDBConnection();
 
    }
 
    return bupdate;
}
}

    