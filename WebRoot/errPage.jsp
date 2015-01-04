<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page language="java" contentType="text/html;charset=GBK"%>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.gdbocom.util.*" %>
<%@include file="/includeFiles/common.jsp" %>
<%
	//设置需要显示的值和名称,
	String showKey = "RspCod,错误码|RspMsg,错误信息";	
	
	String errorCode=ReqParamUtil.getParamAttr(request,"errorCode");
	String errorStr=ReqParamUtil.getParamAttr(request,"errorStr");
	//获取服务端调用结果集
	String rspCod="";
	String rspMsg="";
	Map resVal=(Map)request.getAttribute("responseVal");
	if(resVal!=null){
		rspCod=(String)resVal.get("RspCod");
		rspMsg=(String)resVal.get("RspMsg");
	}else{
		rspCod=ReqParamUtil.getParamAttr(request,"RspCod");
		rspMsg=ReqParamUtil.getParamAttr(request,"RspMsg");
	}
%>
<html>
    <head>
        <title>交通银行网上服务</title>
        <link rel="stylesheet" type="text/css" href="/personbank/css/<%=cssFileName%>"></link>
        <script type="text/javascript" src="/personbank/HttpProxy?URL=/midserv/js/jquery-1.11.1.min.js&dse_sessionId=<%=dse_sessionId%>"></script>
        <script type="text/javascript"  charset="UTF-8" src="/personbank/HttpProxy?URL=/midserv/js/formValidator.js&dse_sessionId=<%=dse_sessionId%>"></script>
        <script type="text/javascript"  charset="UTF-8" src="/personbank/HttpProxy?URL=/midserv/js/formValidatorRegex.js&dse_sessionId=<%=dse_sessionId%>"></script>
        <script type="text/javascript">
	    	jQuery(document).ready(function(){
	    		jQuery("#btn_back").click(function(){
	    			jQuery("#form1").submit();
	    		});
	    	});
        </script>
    </head>
    <body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  oncontextmenu="self.event.returnValue=false" onselectstart="return false">
    <div class="indent">
    	<table width="90%" align="center" cellpadding="1" cellspacing="1"  class="tab">
		  <tr align="center" class="tab_title">
		    <td align="left" colspan="2">
		     	交易失败:
		    </td>
		  </tr>
		  <tr></tr>
		 <tr class="tab_tr"> 
	        <td align="right">
	        	错误码:
	        </td>
	        <td align="left"> 
				<%=StringUtils.trimToEmpty(rspMsg)%><%=StringUtils.trimToEmpty(errorCode)%>
	        </td>
	     </tr>
	     <tr class="tab_tr"> 
	        <td align="right">
	        	错误信息:
	        </td>
	        <td align="left"> 
				<%=StringUtils.trimToEmpty(rspMsg)%><%=StringUtils.trimToEmpty(errorStr)%>
	        </td>
	     </tr>
	     <tr class="tab_result"> 
	        <td align="center" colspan="2">
	            <input type="button" class="button_bg" value="返回" id="btn_back" style="cursor:hand;"/>
	        </td>
	     </tr>
	    </table>
	   	<form action="/personbank/HttpProxy" method="post" id="form1">
        	<input type="hidden" name="URL" value="/midserv/Wel_Bus_Sel.jsp"/>
        	<input type="hidden" name="dse_sessionId" value="<%=dse_sessionId%>"/>
	    </form>
   	</div>
    </body>
</html>
