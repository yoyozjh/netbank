package com.gdbocom.util;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;

/**
 *@author ken
 *@date 2014��12��8�� ����11:04:07
 */
public class ReqParamUtil {
	private static final String PARAM_INPUT_STRING_START="<input type=\"hidden\" name=\"";
	private static final String PARAM_INPUT_STRING_MID="\" value=\"";
	private static final String PARAM_INPUT_STRING_END="\"/>\n";
	private static final String DEF_PREFIX_STRING="aReq_";
	/**
	 * Ĭ�ϲ��������Ĳ�������
	 */
	private static final List DEF_IGNORE_PARAM_NAME=new ArrayList();
	static{
		DEF_IGNORE_PARAM_NAME.add("MBK_BOCOMACC_PASSWORD");
		DEF_IGNORE_PARAM_NAME.add("cssFileName");
		DEF_IGNORE_PARAM_NAME.add("sendPass");
		DEF_IGNORE_PARAM_NAME.add("loginType");
	}
	
	/**��request�����У���ò�����ֵ<br/>
	 * ���Parameter��û�У�������Attribute�����Ҷ������trim()������ �����õĲ���Ϊnull���ͷ��ء����հ��ַ���
	 * @param request �������
	 * @param paramName ��������
	 * @return
	 */
	public static String getParamAttr(HttpServletRequest request,String paramName){
		String val=reqParamTirm(request, paramName);
		if(StringUtils.isEmpty(val)){
			val=StringUtils.trimToEmpty((String)request.getAttribute(paramName));
		}
		
		return val;
	}
	
	/**��request�����У���ò�����ֵ�����Ҷ������trim()������ �����õĲ���Ϊnull���ͷ��ء����հ��ַ���
	 * @param request �������
	 * @param paramName ��������
	 * @return
	 */
	public static String reqParamTirm(HttpServletRequest request,String paramName){
		String paramValue=request.getParameter(paramName);
		String value=StringUtils.trimToEmpty(paramValue);
		
		return value;
	}
	
	/**��Request�е�ȫ����������input����HTML��ǩ����ʽ�����ע������ֵ���Ѿ���trim������
	 * @param request
	 * @return
	 */
	public static String reqParamToHtmlStr(HttpServletRequest request) {
		return reqParamToHtmlStr(request,null);
	}
	
	/**��Request�е�ȫ����������input����HTML��ǩ����ʽ�����ע������ֵ���Ѿ���trim������
	 * @param request
	 * @param ignores ����Դ����Ĳ�������
	 * @return
	 */
	public static String reqParamToHtmlStr(HttpServletRequest request,String[] ignores) {
		Map reqParamMap = trimParamVal(request,ignores);
		Iterator iter = reqParamMap.entrySet().iterator();

		StringBuffer sb = new StringBuffer();
		while (iter.hasNext()) {
			Map.Entry entry = (Map.Entry) iter.next();
			String key = (String) entry.getKey();
			
			if(DEF_IGNORE_PARAM_NAME.contains(key)){
				continue;
			}
			
			String[] vals = (String[]) entry.getValue();
			//���ֵ�����飬��ת��Ϊ��a;b;c����ʽ���ַ���
			if (vals.length > 1) {
				sb.append(PARAM_INPUT_STRING_START).append(key)
						.append(PARAM_INPUT_STRING_MID)
						.append(StringComUtils.arrayToString(vals))
						.append(PARAM_INPUT_STRING_END);
			} else {
				sb.append(PARAM_INPUT_STRING_START).append(key)
				.append(PARAM_INPUT_STRING_MID)
				.append(vals[0])
				.append(PARAM_INPUT_STRING_END);
			}
		}
		
		return sb.toString();
	}
	
	/**
	 * ��Request�е�ȫ����������input����HTML��ǩ����ʽ��������ɺ��name���ḽ��ָ����ǰ׺������
	 * request�а�������name:zhang����ô���ɵ�input��ǩ��name��ΪaReq_name<br/>
	 * ��Request�����к���ָ��ǰ׺�ģ������ٸ���ǰ׺��<br/>
	 * <br/>��ע������ֵ���Ѿ���trim������
	 * @param request �������
	 * @param prefixStr ǰ���ַ�
	 */
	public static String reqParamToHtmlStrWithPF(HttpServletRequest request,String prefixStr){
		return reqParamToHtmlStrWithPF(request, prefixStr,null);
	}
		
	
	/**
	 * ��Request�е�ȫ����������input����HTML��ǩ����ʽ��������ɺ��name���ḽ��ָ����ǰ׺������
	 * request�а�������name:zhang����ô���ɵ�input��ǩ��name��ΪaReq_name<br/>
	 * ��Request�����к���ָ��ǰ׺�ģ������ٸ���ǰ׺��<br/>
	 * <br/>��ע������ֵ���Ѿ���trim������
	 * @param request �������
	 * @param prefixStr ǰ���ַ�
	 * @param ignores ����Դ����Ĳ�������
	 */
	public static String reqParamToHtmlStrWithPF(HttpServletRequest request,String prefixStr,String[] ignores){
		String pfStr=null;
		//���Ϊ�գ���ʹ��Ĭ��
		if(StringUtils.isEmpty(prefixStr)){
			pfStr=DEF_PREFIX_STRING;
		}else{
			pfStr=prefixStr;
		}
		
		Map reqParamMap = trimParamVal(request,ignores);
		Iterator iter = reqParamMap.entrySet().iterator();
		
		String pfKey=null;//����ǰ׺��key
		StringBuffer sb = new StringBuffer();
		while (iter.hasNext()) {
			Map.Entry entry = (Map.Entry) iter.next();
			String key = (String) entry.getKey();
			String[] vals = (String[]) entry.getValue();
			
			//�������ָ��ǰ׺��ʼ�������ٸ���ǰ׺���������
			if(!key.startsWith(pfStr)){
				pfKey=pfStr+key;
			}else{
				pfKey=key;
			}
			
			//���ֵ�����飬��ת��Ϊ��a;b;c����ʽ���ַ���
			if (vals.length > 1) {
				sb.append(PARAM_INPUT_STRING_START).append(pfKey)
						.append(PARAM_INPUT_STRING_MID)
						.append(StringComUtils.arrayToString(vals))
						.append(PARAM_INPUT_STRING_END);
			} else {
				sb.append(PARAM_INPUT_STRING_START).append(pfKey)
				.append(PARAM_INPUT_STRING_MID)
				.append(vals[0])
				.append(PARAM_INPUT_STRING_END);
			}
		}
		
		return sb.toString();
	}
	
	/**
	 * ��Request�е�ȫ����������input����HTML��ǩ����ʽ��������ɺ��name���ḽ��ָ����ǰ׺������
	 * request�а�������name:zhang����ô���ɵ�input��ǩ��name��ΪaReq_name(Ĭ��ǰ׺)<br/>
	 * ��Request�����к���ָ��ǰ׺�ģ������ٸ���ǰ׺��<br/>
	 * <br/>��ע������ֵ���Ѿ���trim������
	 * @param request �������
	 * @param prefixStr ǰ���ַ�
	 */
	public static String reqParamToHtmlStrWithPF(HttpServletRequest request){
		return reqParamToHtmlStrWithPF(request,null);
	}
	
	public static String reqAttrToHtmlStr(HttpServletRequest request){
		Enumeration e=request.getAttributeNames();
		StringBuffer sb = new StringBuffer();
		String key;
		String val;
		while (e.hasMoreElements()) {
			key = (String) e.nextElement();
            val=request.getAttribute(key).toString();
			sb.append(PARAM_INPUT_STRING_START).append(key)
			.append(PARAM_INPUT_STRING_MID)
			.append(val)
			.append(PARAM_INPUT_STRING_END);
		}
		return sb.toString();
	}
	
	/**��Request�е�Attribute��������input����HTML��ǩ����ʽ�������������ų���Parameter������ͬ����ֵ
	 * @param request
	 * @return
	 */
	public static String reqAttrToHtmlStrExcParam(HttpServletRequest request){
		//��ȡParameter����
		Map reqParamMap=request.getParameterMap();
		
		Enumeration e=request.getAttributeNames();
		StringBuffer sb = new StringBuffer();
		String key;
		String val;
		while (e.hasMoreElements()) {
			key = (String) e.nextElement();
			//���Parameter�������Ѿ�������ͬ��KEY����������
			if(reqParamMap.containsKey(key)){
				continue;
			}
			
			if(DEF_IGNORE_PARAM_NAME.contains(key)){
				continue;
			}
			
            val=request.getAttribute(key).toString();
			sb.append(PARAM_INPUT_STRING_START).append(key)
			.append(PARAM_INPUT_STRING_MID)
			.append(val)
			.append(PARAM_INPUT_STRING_END);
		}
		return sb.toString();
	}
	
	/**Request�е�ȫ������(Parameter��Attribute)��ȫ����input����HTML��ǩ����ʽ�����
	 * �����Attribute��Parameter������ͬ��KEY����ֻ���Parameter��
	 * @param request
	 * @return
	 */
	public static String reqParamAttrToHtmlStr(HttpServletRequest request){
		return reqParamToHtmlStr(request)+reqAttrToHtmlStrExcParam(request);
	}
	
	
	/**�Բ���Map����trim����
	 * @param request
	 * @return
	 */
	private static Map trimParamVal(HttpServletRequest request,String[] ignores){
		Map requestParamMap=request.getParameterMap();
		Set paramEntrySet=requestParamMap.entrySet();
		
		//��Ҫ���Դ����Ĳ������ƣ�������
		List iParamName=new ArrayList();
		//Ĭ�Ϻ��Ե�
		iParamName.addAll(DEF_IGNORE_PARAM_NAME);
		//���봫�ݽ����ĺ�������
		if(ignores!=null&&ignores.length>0){
			List params=Arrays.asList(ignores);
			iParamName.addAll(params);
		}
		
		Map resultMap=new HashMap();
		Iterator iter=paramEntrySet.iterator();
		while(iter.hasNext()){
			Map.Entry entry=(Map.Entry) iter.next();	
			String key=(String)entry.getKey();
			//����������ư������ڣ�������
			if(iParamName.contains(key)){
				continue;
			}
			String[] vals=(String[]) entry.getValue();
			if(vals!=null||vals.length>0){
				String[] trimValArray=new String[vals.length];
				for(int i=0;i<vals.length;i++){
					trimValArray[i]=StringUtils.trimToEmpty(vals[i]);
				}
				resultMap.put(StringUtils.trim(key),trimValArray);
			}
		}
		
		return resultMap;
	}
	
	/**��ȡattribute��parameter��ȫ������
	 * @param request
	 * @return
	 */
	public static Map getParamAttr(HttpServletRequest request){
		Map rsMap=new HashMap();
		int id=1;
		
		//����ParameterMap
		Map reqParamMap=request.getParameterMap();
		Set paramEntrySet=reqParamMap.entrySet();
		Iterator iter=paramEntrySet.iterator();
		while(iter.hasNext()){
			Map.Entry entry=(Map.Entry) iter.next();	
			String key=(String)entry.getKey();
			String[] vals=(String[]) entry.getValue();
			
			if(vals!=null||vals.length>0){
				String[] trimValArray=new String[vals.length];
				for(int i=0;i<vals.length;i++){
					trimValArray[i]=StringUtils.trimToEmpty(vals[i]);
				}
				//����ת��Ϊ�ַ������
				rsMap.put(StringUtils.trim(key),StringComUtils.arrayToString(trimValArray));
				DebugUtils.log(request,"getP"+(id++)+" "+StringUtils.trim(key)+":"+StringComUtils.arrayToString(trimValArray));
			}else{
				rsMap.put(StringUtils.trim(key),"");
				DebugUtils.log(request,"getP"+(id++)+" "+StringUtils.trim(key)+":"+"");
			}
		}
		
		//����Attribute
		Enumeration attrNames=request.getAttributeNames();
		while(attrNames.hasMoreElements()){
			String key=attrNames.nextElement().toString();
			String val=request.getAttribute(key).toString();
			rsMap.put(StringUtils.trim(key),StringUtils.trim(val));
			DebugUtils.log(request,"getA"+(id++)+" "+StringUtils.trim(key)+":"+StringUtils.trim(val));
		}
		
		return rsMap;
	}
}