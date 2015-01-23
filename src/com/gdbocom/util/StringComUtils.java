package com.gdbocom.util;

import org.apache.commons.lang.StringEscapeUtils;

/**
 * @version <1.0>
 * @author ken
 */
public class StringComUtils {
	/**�����������ת��Ϊ"a;b;c"�������ַ���
	 * @param tringArray
	 * @return
	 */
	public static final String arrayToString(String[] vals){
		StringBuffer sb=new StringBuffer();
		
		for(int i=0;i<vals.length;i++){
			sb.append(";"+StringEscapeUtils.escapeSql(vals[i]));
		}
		
		String result=sb.toString().replaceFirst(";","");
		
		return result;
	}
}