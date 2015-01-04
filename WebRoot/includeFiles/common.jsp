<%@ page import="com.gdbocom.util.*"%>
<%
	request.setCharacterEncoding("GBK");
	/* 获取总行全局参数 */
	//获取客户当前使用的CSS样式
	String cssFileName = request.getParameter("cssFileName");
	//获取dse_sessionId
	String dse_sessionId = request.getParameter("dse_sessionId");
	
	//PrintTheReqeustHeaderUtils.printParam(request);   
	//PrintTheReqeustHeaderUtils.printAttr(request);   
%>