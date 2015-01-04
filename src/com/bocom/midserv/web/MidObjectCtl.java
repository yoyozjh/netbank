package com.bocom.midserv.web;

/**
 * 此处插入类型描述。
 * 创建日期：(2003-5-30 16:56:00)
 * @author：Administrator
 * xml_send_buff的定义如下：
 * <mid_bocom>
 * <biz_id>%biz_id</biz_id>
 * <biz_step_id>%biz_step_id</biz_step_id>
 * <%input_name>%input_value</%input_name>
 * </mid_bocom>
 * xml_recv_buff的定义如下：
 * <mid_bocom>
 * <biz_id>%biz_id</biz_id>
 * <biz_step_id>%biz_step_id</biz_step_id>
 * <display_zone>%display_buff</display_zone>
 * <%input_name>%input_value</%input_name>
 * </mid_bocom>
 */
import java.io.*;
import java.util.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
//import javax.servlet.jsp.tagext.*;
import com.bocom.midserv.base.*;
import com.bocom.eb.des.EBDES;
import com.bocom.midserv.gz.*;


public class MidObjectCtl extends com.bocom.midserv.base.MidObject {

    private int biz_id;
    private int biz_step_id;
    private String send_buff = null;
    private String recv_buff = null;
    private String display_buff = null;
    private String hidden_input_buff = null;
    private String xml_send_buff = null; //* 向主机发送
    private String xml_recv_buff = null; //* 从主机得到
        


/**
 * MidObjectCtl 构造子注解。
 */
public MidObjectCtl() {
	super();
}
public int get_biz_id() {
    return biz_id;
}
public int get_biz_step_id() {
    return biz_step_id;
}
    public String get_display_buff() {
        return display_buff;
    }
    public String get_hidden_input_buff() {
        return hidden_input_buff;
    }
    public String get_recv_buff() {
        return recv_buff;
    }
    public String get_send_buff() {
    	//System.out.println("debug 3002 get_send_buff调试2 OK");
    	//System.out.println("debug 3002.1 get_send_buff调试2 send_buff="+send_buff);
        return send_buff;
    }
public String get_xml_recv_buff() {
    return xml_recv_buff;
}
public String get_xml_send_buff() {
    return xml_send_buff;
}



/**
 * 此处插入方法描述。
 * 创建日期：(2003-5-30 11:34:03)
 * @param args java.lang.String[]
 */
public static void main(String[] args) {

    MidObjectCtl myMidObjectCtl = new MidObjectCtl();

    //String in_str = null;
    //String out_str = null;

    //in_str = "2970                      000001      1314";

    //try {
    //System.out.print("start\n");
    //out_str = myMidObjectCtl.invokeConnect();
    //System.out.print(out_str);
    //System.out.print("end\n");
    //} catch (Exception e) {
    //e.printStackTrace();
    //}

    //myMidObjectCtl.preInvokeNotXML(1, 1);
    //myMidObjectCtl.invokeConnectNotXML();
    try {
    myMidObjectCtl.preInvokeNotXML(1, 1);

    myMidObjectCtl.set_send_buff(
        "|bocom_mid|biz_id,1|biz_step_id,1|mobile_no,13983887121|");

    myMidObjectCtl.invokeConnectNotXML("182.59.6.254", 3555);
    //for test,and 221 is working manchine

    System.out.print("myMidObjectCtl.get_recv_buff()="+myMidObjectCtl.get_recv_buff());

    //myMidObjectCtl.set_recv_buff(
    // "|mid_bocom|biz_id,1|biz_no,00001|biz_step_id,1|display_zone,aaa|pay_amt,123.11|");
    myMidObjectCtl.postInvokeNotXML();

    System.out.print("myMidObjectCtl.get_hidden_input_buff()="+myMidObjectCtl.get_hidden_input_buff());

	myMidObjectCtl.releaseDBConnection();
	} catch (Exception e) {
    e.printStackTrace();
    }

}
/**
 * 将前置机返回的xml报文分解，然后不同处理
 * 创建日期：(2003-5-31 11:23:11)
 * xml_recv_buff的定义如下：
 * |mid_bocom|biz_id,%biz_id|biz_no,%biz_no|biz_step_id,%biz_step_id|display_zone,%display_buff|%input_name,%input_value
 */

public void postInvokeNotXML() {

    try {
        String s_recv_buff = get_recv_buff(); 
System.out.println("postInvokeNotXML begin ========================== ");
System.out.println("s_recv_buff=["+s_recv_buff+"]");
GzLog gl = new GzLog("c:/gzLog");
gl.Write("===> recv_buff=["+s_recv_buff+"]");

        MidObjectStepView midObjectStepView = new MidObjectStepView();

        int index_biz_id = s_recv_buff.indexOf("biz_id");
        int index_biz_no = s_recv_buff.indexOf("biz_no");
        int index_biz_step_id = s_recv_buff.indexOf("biz_step_id");
        int index_display_zone = s_recv_buff.indexOf("display_zone");

        ////* 处理标准参数
        String s_biz_id = s_recv_buff.substring(index_biz_id + 7, index_biz_no - 1);
System.out.println("s_biz_id=["+s_biz_id+"]");        
        String s_biz_no = s_recv_buff.substring(index_biz_no + 7, index_biz_step_id - 1);
System.out.println("s_biz_no=["+s_biz_no+"]");        
        String s_biz_step_id = s_recv_buff.substring(index_biz_step_id + 12, index_display_zone - 1);
System.out.println("s_biz_step_id=["+s_biz_step_id+"]");        

        //* 得到biz_id,biz_step_id
        set_biz_id(Integer.parseInt(s_biz_id));
        set_biz_step_id(Integer.parseInt(s_biz_step_id));

        String tmp_s_recv_buff = s_recv_buff.substring(index_display_zone);

        ////* 处理显示域
        String s_display_zone =
            tmp_s_recv_buff.substring(13, tmp_s_recv_buff.indexOf("|"));
        set_display_buff(s_display_zone);

        String s_input_name = null;
        String s_input_value = null;
        String s_hidden_input_buff = null;
        String tmp_ss_recv_buff = null;
        int index_input_name; 

System.out.println("biz_step_id=["+biz_step_id+"] and MaxStepId=["+midObjectStepView.getMaxStepId(biz_id)+"]");
        if (biz_step_id  < midObjectStepView.getMaxStepId(biz_id)) {
            //*如果定义的步骤还没有到最后，否则只做显示域的显示操作
System.out.println("biz_step_id=["+biz_step_id+"]");
            ResultSet rs1 =
                midObjectStepView.getStepViewHidByBizIdAndStepId(biz_id, biz_step_id + 1);                
            while (rs1.next()) {
             	s_input_name = rs1.getString("input_name").trim();   
System.out.println("s_input_name=["+s_input_name+"]----------------------------------"); 
//System.out.println("tmp_s_recv_buff=["+tmp_s_recv_buff+"]"); 
	            if (tmp_s_recv_buff.indexOf(s_input_name) < 0)
                	continue;
             	tmp_ss_recv_buff = tmp_s_recv_buff.substring(tmp_s_recv_buff.indexOf(s_input_name));             
                	
                s_input_value =
                    tmp_ss_recv_buff.substring(s_input_name.length() + 1,
                        tmp_ss_recv_buff.indexOf("|"));
System.out.println("s_input_value=["+s_input_value+"]");
                s_hidden_input_buff =
                    "<input type=hidden name=" + s_input_name + " value=\"" + s_input_value + "\">";
                set_hidden_input_buff(s_hidden_input_buff);
System.out.println("s_hidden_input_buff=["+s_hidden_input_buff+"]");                       
            }
            rs1.close();
            
        }
        midObjectStepView.releaseDBConnection();

    } catch (Exception e) {
        e.printStackTrace();
    }

}
/**
 * 将前置机返回的xml报文分解，然后不同处理
 * 创建日期：(2003-5-31 11:23:11)
 * xml_recv_buff的定义如下：
 * |mid_bocom|biz_id,%biz_id|biz_no,%biz_no|biz_step_id,%biz_step_id|display_zone,%display_buff|%input_name,%input_value
 */

public void postInvokeNotXML(String s_recv_buff) {

    try {

        MidObjectStepView midObjectStepView = new MidObjectStepView();

        int index_biz_id = s_recv_buff.indexOf("biz_id");
        int index_biz_no = s_recv_buff.indexOf("biz_no");
        int index_biz_step_id = s_recv_buff.indexOf("biz_step_id");
        int index_display_zone = s_recv_buff.indexOf("display_zone");

        ////* 处理标准参数
        String s_biz_id = s_recv_buff.substring(index_biz_id + 7, index_biz_no - 1);
        String s_biz_no =
            s_recv_buff.substring(index_biz_no + 7, index_biz_step_id - 1);
        String s_biz_step_id =
            s_recv_buff.substring(index_biz_step_id + 12, index_display_zone - 1);

        //* 得到biz_id,biz_step_id
        set_biz_id(Integer.parseInt(s_biz_id));
        set_biz_step_id(Integer.parseInt(s_biz_step_id));

        String tmp_s_recv_buff = s_recv_buff.substring(index_display_zone);

        ////* 处理显示域
        String s_display_zone =
            tmp_s_recv_buff.substring(1, tmp_s_recv_buff.indexOf("|"));
        set_display_buff(s_display_zone);

        String s_input_name = null;
        String s_input_value = null;
        String s_hidden_input_buff = null;
        int index_input_name;

        if (biz_step_id  < midObjectStepView.getMaxStepId(biz_id)) {
            //*如果定义的步骤还没有到最后，否则只做显示域的显示操作

            ResultSet rs1 =
                midObjectStepView.getStepViewHidByBizIdAndStepId(biz_id, biz_step_id + 1);
            while (rs1.next()) {
                tmp_s_recv_buff = tmp_s_recv_buff.substring(tmp_s_recv_buff.indexOf("|") + 1);
                s_input_name = rs1.getString("input_name").trim();
                s_input_value =
                    tmp_s_recv_buff.substring(
                        tmp_s_recv_buff.indexOf(s_input_name) + s_input_name.length() + 1,
                        tmp_s_recv_buff.indexOf("|"));

                s_hidden_input_buff =
                    "<input type=hidden name=" + s_input_name + " value=" + s_input_value + ">";
                
                set_hidden_input_buff(s_hidden_input_buff);
            }
            if (rs1 != null)
                rs1.close();
        }

    midObjectStepView.releaseDBConnection();
    } catch (Exception e) {
        e.printStackTrace();
    }

}
/**
 * 在进行通讯调用前进行的报文缓冲区的有关处理
 * 创建日期：(2003-5-31 11:10:56)
 */
public void preInvokeNotXML(int page_biz_id, int page_step_id) {

    try {
        MidObjectStepView midObjectStepView = new MidObjectStepView();
        String tmp_send_buff = null;

        ResultSet rs =
            midObjectStepView.getStepViewNotHidByBizIdAndStepId(page_biz_id, page_step_id);

        //* 从数据库从获得input的列表，并且从request对象中获得值域，然后组合成为缓存区
        //* rs代表需要客户直接输入的
        while (rs.next()) {
            //addElement(rs.getString("input_name").trim(), "1");
            if (tmp_send_buff == null)
                tmp_send_buff = rs.getString("input_name").trim() + "," + "1";
            else
                tmp_send_buff = tmp_send_buff + rs.getString("input_name").trim() + "," + "1";
        }
        rs.close();

        //* rs1代表不需要客户直接输入，由系统填写或者前次带回
        ResultSet rs1 =
            midObjectStepView.getStepViewHidByBizIdAndStepId(page_biz_id, page_step_id);

        while (rs1.next()) {
            //addElement(rs1.getString("input_name").trim(), "2");
            if (tmp_send_buff == null)
                tmp_send_buff = rs1.getString("input_name").trim() + "," + "1" + "|";
            else
                tmp_send_buff =
                    tmp_send_buff + rs1.getString("input_name").trim() + "," + "2" + "|";
        }
        rs1.close();

        String s_card_no = "aaaa";

        String s_password = "bbbb";

        //*将缓存区组合成为xml报文,条件成熟后可以采取XML来格式化

        //*如果不使用xml报文，还可以采取其他的形式
        String temp_send_buff =
            "|bocom_mid"
                + "|biz_id,"
                + page_biz_id
                + "|biz_step_id,"
                + page_step_id
                + "|"
                + tmp_send_buff
                + "|CDNO,"
                + s_card_no
                + "|PSWD,"
                + s_password
                + "|";

        send_buff = temp_send_buff;
        midObjectStepView.releaseDBConnection();
    } catch (Exception e) {
        e.printStackTrace();
    }

}
/**
 * 判断返回字符串中VALUE为HIDDEN的要素
 * 创建日期：(2003-7-9 18:26:12)
 * @return boolean
 * @param s_input_name java.lang.String
 * @exception java.lang.Exception 异常说明。
 */
public boolean checkHidden(String s_input_name) throws java.lang.Exception {

    try {
        String s_recv_buff = get_recv_buff();
//System.out.println("checkHidden - recv_buff=["+s_recv_buff+"]");
        int index_input_name = s_recv_buff.indexOf(s_input_name);
        if ( index_input_name < 0 )
        	return false ;
        	
        String tmp_s_recv_buff = s_recv_buff.substring(index_input_name);
        int index_jiange = tmp_s_recv_buff.indexOf("|");

        ////* 处理标准参数
        String value_input_name =
            tmp_s_recv_buff.substring(s_input_name.length()+1, index_jiange);

        if (value_input_name.equals("hidden"))
            return true;
        else
            return false;
    } catch (Exception e) {
        e.printStackTrace();
        return false;
    }

}
/**
 * 在进行通讯调用前进行的报文缓冲区的有关处理
 * 创建日期：(2003-5-31 11:10:56)
 */
public void preInvokeNotXML(
    ServletRequest request,
    int page_biz_id,
    int page_step_id) {

    try {
        MidObjectStepView midObjectStepView = new MidObjectStepView();
        String tmp_send_buff = null;
        String s_input_name = null;
//System.out.print(" debug!!调试400.01 ****** MidObjectCtl.java preInvokeNotXML \n");
        ResultSet rs =
            midObjectStepView.getStepViewNotHidByBizIdAndStepId(page_biz_id, page_step_id);
//System.out.print(" debug!!调试400.01.5 ****** \n");
        //* 从数据库从获得input的列表，并且从request对象中获得值域，然后组合成为缓存区
        //* rs代表需要客户直接输入的
GzLog gl = new GzLog("c:/gzLog");        
        while (rs.next()) {
            //addElement(rs.getString("input_name").trim(), "1");

            s_input_name = rs.getString("input_name").trim();
System.out.print("s_input_name=[" + s_input_name + "]\n");
System.out.print("request.s_input_name=[" + request.getParameter(s_input_name) + "]\n");            
            if (tmp_send_buff == null)
                tmp_send_buff =
                    rs.getString("input_name").trim()
                        + ","
                        + new String(request.getParameter(s_input_name).getBytes("ISO8859_1"), "gb2312")
                        + "|";
                       
            else
                tmp_send_buff =
                    tmp_send_buff
                        + rs.getString("input_name").trim()
                        + ","
                        + new String(request.getParameter(s_input_name).getBytes("ISO8859_1"), "gb2312")
                        + "|";

        }
        rs.close();
        midObjectStepView.releaseDBConnection();
//System.out.print(" debug!!调试400.01.6 ****** \n");
//System.out.print(" debug!!调试400.02 MidObjectCtl.java preInvokeNotXML \n");
        //* rs1代表不需要客户直接输入，由系统填写或者前次带回
        ResultSet rs1 =
            midObjectStepView.getStepViewHidByBizIdAndStepId(page_biz_id, page_step_id);
        while (rs1.next()) {
            //addElement(rs1.getString("input_name").trim(), "2");
            s_input_name = rs1.getString("input_name").trim();
System.out.print("s_input_name=[" + s_input_name + "]\n");
System.out.print("request.s_input_name=[" + request.getParameter(s_input_name) + "]\n");

            if (tmp_send_buff == null)
                tmp_send_buff =
                    rs1.getString("input_name").trim()
                        + ","
                        + new String(request.getParameter(s_input_name).getBytes("ISO8859_1"), "gb2312")
                        + "|";
            else
                tmp_send_buff =
                    tmp_send_buff
                        + rs1.getString("input_name").trim()
                        + ","
                        + new String(request.getParameter(s_input_name).getBytes("ISO8859_1"), "gb2312")
                        + "|";
        }
System.out.print("tmp_send_buff=["+tmp_send_buff+"]\n");        
        rs1.close();
//System.out.print("closed!!\n");
        midObjectStepView.releaseDBConnection();

//System.out.print(" debug!!调试400.03 MidObjectCtl.java preInvokeNotXML 开始\n");
        String s_card_no = new String(request.getParameter("cardNo").getBytes("ISO8859_1"), "gb2312");
System.out.print(" debug!!接收卡号成功["+s_card_no+"]\n");

        String dse_sessionId = request.getParameter("dse_sessionId");//获取dse_sessionId
System.out.print(" debug!!接收dse_sessionId成功["+dse_sessionId+"]\n");       
        String passwd = request.getParameter("bocomPwd");//加密密码
System.out.print(" debug!!接收bocomPwd成功["+passwd+"]\n");  
gl.Write("PinDat["+passwd+"]");
String s_password = "";
if( passwd != null ) 
{
    System.out.print(" debug!!接收sessionId成功["+dse_sessionId+"]\n");
//    s_password= request.getParameter("bocomPwd");//加密密码
     //  s_password = new String(EBDES.decryptoDES(passwd,dse_sessionId).getBytes("ISO8859_1"), "gb2312");
//System.out.print(" debug!!解密成功s_password=["+s_password+"]\n"); 
//gl.Write(" debug!!解密成功s_password=["+s_password+"]"); 
}
else
	s_password ="******";        
        //String s_card_no ="60142890780063001";
        //String s_password ="******";
//System.out.print(" debug!!接收passWord成功["+passwd+"]["+s_password+"] \n");          }else{
//s_password ="******"; }
//System.out.print(" debug!!接收密码成功 \n");
//System.out.print(" debug!!调试400.03 MidObjectCtl.java preInvokeNotXML 结束\n");            


        //*将缓存区组合成为xml报文,条件成熟后可以采取XML来格式化

        //*如果不使用xml报文，还可以采取其他的形式
        // s_password.substring(0,6) is for maybe there is a byte not usable
        String temp_send_buff =
            "|bocom_mid"
                + "|biz_id,"
                + page_biz_id
                + "|biz_step_id,"
                + page_step_id
                + "|TXNSRC,WE441|CDNO,"
                + s_card_no
                + "|PSWD,"
                + passwd
                //+ s_password.substring(0, 6)
                + "|"
                + tmp_send_buff;
        send_buff = temp_send_buff;
System.out.print("===> send_buff=["+send_buff+"]\n");

gl.Write("===> send_buff=["+send_buff+"]");
    } catch (Exception e) {
        e.printStackTrace();
    }
}


public void set_biz_id(int i_biz_id) {
    biz_id = i_biz_id;
}
public void set_biz_step_id(int i_biz_step_id) {
    biz_step_id = i_biz_step_id;
}
    public void set_display_buff(String s_display_buff) {
        display_buff = s_display_buff;
    }
public void set_hidden_input_buff(String s_hidden_input_buff) {
    if (get_hidden_input_buff() == null)
        hidden_input_buff = s_hidden_input_buff;
    else
        hidden_input_buff = get_hidden_input_buff() + s_hidden_input_buff;
}
    public void set_recv_buff(String s_recv_buff) {
        recv_buff = s_recv_buff;
    }
    public void set_send_buff(String s_send_buff) {
    	send_buff = s_send_buff;
    }
public void set_xml_recv_buff(String s_xml_recv_buff) {
    xml_recv_buff = s_xml_recv_buff;
}
public void set_xml_send_buff(String s_xml_send_buff) {
    xml_send_buff = s_xml_send_buff;
}

/**
 * 判断交易是否成功，根据MGID
 * 创建日期：(2003-07-11 16:11:54)
 * @return java.lang.String
 */
public String get_mgid_value() {
    if (recv_buff.equals(null))
        return null;

    String s_recv_buff = get_recv_buff();

    //这里的MGID字段注意与前置机上传来的结字段名定义一致
    int index_MGID = s_recv_buff.indexOf("MGID");
    if (index_MGID < 0)
        return null;

    String tmp_s_recv_buff = s_recv_buff.substring(index_MGID);
    int index_jiange = tmp_s_recv_buff.indexOf("|");

    ////* 处理标准参数
    //* MGID的字符长度为4，如果将来有变化，请在这里进行修改
    String value_MGID = tmp_s_recv_buff.substring(4 + 1, index_jiange);

    return value_MGID;
}

/**
 * 此处插入方法描述。
 * 创建日期：(2003-5-30 16:32:04)
 * @param send_buf java.lang.String
 * @param recv_buf java.lang.String
 */
public void invokeConnect(String s_host_ip, int i_host_port) {

    set_xml_recv_buff(
        invokeTcpConnect(get_xml_send_buff(), s_host_ip, i_host_port));

}

/**
 * 此处插入方法描述。
 * 创建日期：(2003-5-30 16:32:04)
 * @param send_buf java.lang.String
 * @param recv_buf java.lang.String
 */
public void invokeConnectNotXML(String s_host_ip, int i_host_port) {

    set_recv_buff(invokeTcpConnect(get_send_buff(), s_host_ip, i_host_port));

}

/**
 * 判断交易是否成功，根据PSWD
 * 创建日期：(2008-01-16 16:11:54)
 * @return java.lang.String
 */
public String get_pswd_value() {
    if (recv_buff.equals(null))
        return null;

    String s_recv_buff = get_recv_buff();

    //这里的PSWD字段注意与前置机上传来的结字段名定义一致
    int index_PSWD = s_recv_buff.indexOf("bocomPwd");
    if (index_PSWD < 0)
        return null;

    String tmp_s_recv_buff = s_recv_buff.substring(index_PSWD);
    int index_jiange = tmp_s_recv_buff.indexOf("|");

    ////* 处理标准参数
    //* passWord的字符长度为8，如果将来有变化，请在这里进行修改
    String value_PSWD = tmp_s_recv_buff.substring(8 + 1, index_jiange);

    return value_PSWD;
}

/**
 * 判断交易是否成功，根据AMT1
 * 创建日期：(2008-01-17 16:11:54)
 * @return java.lang.String
 */
public String get_amt1_value() {
    if (recv_buff.equals(null))
        return null;

    String s_recv_buff = get_recv_buff();

    //这里的AMT1字段注意与前置机上传来的结字段名定义一致
    int index_AMT1 = s_recv_buff.indexOf("AMT1");
    if (index_AMT1 < 0)
        return null;

    String tmp_s_recv_buff = s_recv_buff.substring(index_AMT1);
    int index_jiange = tmp_s_recv_buff.indexOf("|");

    ////* 处理标准参数
    //* AMT1的字符长度为4，如果将来有变化，请在这里进行修改
    String value_AMT1 = tmp_s_recv_buff.substring(4 + 1, index_jiange);

    return value_AMT1;
}

}
