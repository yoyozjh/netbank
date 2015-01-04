package com.viatt.util;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.bocom.midserv.base.MidObject;

public class MidSelectUtil extends MidObject{
	public int isShow(String cdno,String branch){
		if(cdno==null||"".equals(cdno)){
			return 1;
		}
		if(branch==null){
			return 1;
		}
		if(branch.indexOf("ALL")!=-1){
			return 0;
		}
		String addr="";
		if(cdno.length()==16){
			addr=cdno.substring(6,9);
		}else if(cdno.length()==17){
			if(cdno.substring(0,6).equals("405512") || cdno.substring(0,6).equals("601428")){
				addr=cdno.substring(7,10);	
			}else
				addr=cdno.substring(6,9);
		}else if(cdno.length()==19){
			addr=cdno.substring(6,9);
		}
		switch (Integer.parseInt(addr)){
			case 71:
				if(branch.indexOf("441999")!=-1){
					return 0;
				}
				break;
			case 75:
				if(branch.indexOf("484999")!=-1){
					return 0;
				}
				break;
			case 78:
				if(branch.indexOf("444999")!=-1){
					return 0;
				}
				break;
			case 371:
				if(branch.indexOf("446999")!=-1){
					return 0;
				}
				break;
			case 373:
				if(branch.indexOf("483999")!=-1){
					return 0;
				}
				break;
			case 74:
				if(branch.indexOf("485999")!=-1){
					return 0;
				}
				break;
			case 73:
				if(branch.indexOf("445999")!=-1){
					return 0;
				}
				break;
			case 491:
				if(branch.indexOf("491999")!=-1){
					return 0;
				}
				break;
		}
		return 1;
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
}
