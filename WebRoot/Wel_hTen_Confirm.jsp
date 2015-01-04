<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page language="java" contentType="text/html;charset=GBK"%>
<%@ page import="java.net.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.bocom.midserv.gz.*"%>
<%@ page import="com.gdbocom.util.communication.*" %>
<%@ page import="com.gdbocom.Transactions.WelLot" %>
<%@include file="/includeFiles/common.jsp" %>
<%
String loginType =ReqParamUtil.reqParamTirm(request,"loginType");//传送登陆类别 0－注册用户(手机版) 1－证书用户 2－大众用户
String cdno = ReqParamUtil.getParamAttr(request,"cardNo");
//设置正常情况需要跳转的页面
String forwardPage = "Wel_Confirm.jsp";
//设置出错情况需要跳转的页面
String errPage = "errPage.jsp";
//计算相关业务数据，并放入request的Attribute中
HpTenBallCreater.processData(request,response);
String showNum=ReqParamUtil.getParamAttr(request,"showNum");
String BetAmtShow=ReqParamUtil.getParamAttr(request,"BetAmtShow");
%>
<html>
    <head>
        <title>交通银行网上服务</title>
        <link rel="stylesheet" type="text/css" href="/personbank/css/<%=cssFileName%>"></link>
    </head>
    <body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  oncontextmenu="self.event.returnValue=false" onselectstart="return false">
    <div class="indent">
    <form action="/personbank/HttpProxy" method="post" name="form1">
        <!-- 总行定义字段 -->
        <input type="hidden" name="URL" value="/midserv/Wel_hTen_pwd.jsp"/>
        <input type="hidden" name="dse_sessionId" value="<%=dse_sessionId%>"/>
        <input type="hidden" name="sendPass" value="<%=loginType.endsWith("0")?"1":"0" %>">
        <table width="90%" align="center" cellpadding="1" cellspacing="1"  class="tab">
		  <tr align="center" class="tab_title">
		    <td align="left" colspan="2">
		       确认投注信息:
		    </td>
		  </tr>
		  <tr></tr>
		 <tr class="tab_tr"> 
	        <td align="right">
	             银行卡号:
	        </td>
	        <td align="left"> 
	        	<label><%=cdno%></label>
	        </td>
	     </tr>
	     <tr class="tab_tr"> 
	        <td align="right">
	             投注号码:
	        </td>
	        <td align="left"> 
	        	<label><%=showNum%></label>
	        </td>
	     </tr>
	     <tr class="tab_tr"> 
	        <td align="right">
	             交易金额:
	        </td>
	        <td align="left"> 
	        	<label><%=BetAmtShow%>元</label>
	        </td>
	     </tr>
	     <tr class="tab_result"> 
	        <td align="center" colspan="2">
	            <input type="submit" class="button_bg" value="确定" style="cursor:hand;"/>
	            <input type="button" class="button_bg" name="Submit3" value="返回" onclick="javascript:history.back()" />
	        </td>
	     </tr>
	     </table>
	     <%=
			ReqParamUtil.reqParamAttrToHtmlStr(request)
		 %>
		</form>
	</div>
	</body>
</html>