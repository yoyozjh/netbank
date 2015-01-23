package com.gdbocom.util;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.PageContext;

import com.viatt.util.MessManTool;

public class PreAction {

	/**
	 * ����preSaveKey�������ϱ��������ݵ�session
	 * @param pageContext
	 * @param request
	 * @param preSaveKey
	 */
	public static void savePreFormValue(PageContext pageContext, HttpServletRequest request, String preSaveKey){
		String[] preSaveKeys = preSaveKey.split("\\,");
		for(int i=0; i<preSaveKeys.length; i++){
			String param=request.getParameter(preSaveKeys[i]);
			param=param.trim();
			if(param!=null&&param.length()>=1){
				pageContext.setAttribute(preSaveKeys[i],param, PageContext.SESSION_SCOPE);
			}
		}
		
	}

	/**
	 * ��ȡpageContext�������е�session�ֶ�
	 * @param pageContext
	 * @return
	 */
	public static String strOfPageContext(PageContext pageContext){
		StringBuffer sb = new StringBuffer();
		sb.append("PageContext������ֶ����£�\n");
		String key;
		for (Enumeration e = pageContext.getSession().getAttributeNames(); e.hasMoreElements();){
			key = (String)e.nextElement();
			sb.append(key+":"+pageContext.getAttribute(key, PageContext.SESSION_SCOPE)+"\n");
		}
		
		return sb.toString();
	}

	/**
	 * �������ط��ص�����
	 * @param pageContext
	 * @param responseContext
	 * @param saveKey
	 */
	public static void saveMidServerValue(PageContext pageContext, String responseContext, String saveKey){
		String[] saveKeys = saveKey.split("\\,");
		for(int i=0; i<saveKeys.length; i++){
			pageContext.setAttribute(saveKeys[i], MessManTool.getValueByName(responseContext, saveKeys[i]), PageContext.SESSION_SCOPE);
		}
	}

}