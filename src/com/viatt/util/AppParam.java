package com.viatt.util;

import java.util.HashMap;

public class AppParam {
	public static HashMap dynamicCode=new HashMap();
	public static void setParam(String sessionid,String param){
		if(sessionid==null||param==null||sessionid.equals("")){
			return;
		}
		dynamicCode.put(sessionid, param);
	}
	public static String getParam(String sessionid){
		return (String) dynamicCode.get(sessionid);
	}
	public static void deleteParam(String sessionid){
		dynamicCode.remove("dynamicCode");
	}
}
