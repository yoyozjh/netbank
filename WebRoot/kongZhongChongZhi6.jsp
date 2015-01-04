<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@page pageEncoding="utf-8"%>
<%request.setCharacterEncoding("utf-8");%>
<%@ page import="java.util.*" %>
<%@ page import="com.gdbocom.util.*"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.bocom.midserv.gz.*"%>
<%@ page import="com.gdbocom.Transactions.WelLot" %>
<%
	String uri = request.getRequestURI();
	/* 获取总行全局参数 */
	//获取客户当前使用的CSS样式
	String cssFileName = request.getParameter("cssFileName");
	//获取dse_sessionId
	String dse_sessionId = request.getParameter("dse_sessionId");
	//获取卡号
	String CrdNo = request.getParameter("cardNo");
	//获取卡号
	//创建日志实例
    GzLog log = new GzLog();
	log.Write(CrdNo+"进入["+uri+"]");
%>
<html>
    <head>
        <title>交通银行网上服务</title>
        <link rel="stylesheet" type="text/css" href="/personbank/css/<%=cssFileName%>"></link>
    </head>

    <body leftmargin="10" topmargin="0" marginwidth="0" marginheight="0"  oncontextmenu="self.event.returnValue=false" onselectstart="return false">
    <div class="indent">
    <form action="/personbank/HttpProxy" method="post" name="form1">
        <!-- 总行定义字段 -->
        <input type="hidden" name="URL" value="Wel_Bus_Red.jsp"/>
        <input type="hidden" name="dse_sessionId" value="<%=dse_sessionId%>"/>
        <input type='hidden' name='preSaveKey' value='Bus' />
        
    	<table width="90%" align="center" cellpadding="1" cellspacing="1"  class="tab">
		  <tr align="center" class="tab_title">
		    <td colspan="2">
		     请选择业务类别:
		    </td>
		  </tr>
		  <tr></tr>
		 <tr class="tab_tr"> 
	        <td align="right">
	             业务类别:
	        </td>
	        <td align="left"> 
	        	<SELECT name="Bus"> 
					<OPTION value='<%=WelLot.ADDREG%>' selected="selected">用户注册</OPTION>
					<OPTION value='<%=WelLot.UPDREG%>'>更改用户注册</OPTION>
					<OPTION value='<%=WelLot.DOUBLEBUY%>'>双色球实时投注</OPTION>
					<OPTION value='<%=WelLot.DOUBLEFIXBUY%>'>双色球定投</OPTION>
				</SELECT>
	        </td>
	      </tr>
	     <tr class="tab_result"> 
	        <td align="center" colspan="2">
	            <input type="submit" class="button_bg" value="确定" style="cursor:hand;"/>
	        </td>
	     </tr>
	     </table>
		</form>
    </div>
    </body>
</html>