<%@ page pageEncoding="GBK"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<% request.setCharacterEncoding("GBK");%>

<%@ page import="com.bocom.midserv.gz.*"%>
<%@ page import="com.viatt.bean.*"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.util.*"%>
<%

	String uri = request.getRequestURI();
	/* 获取总行全局参数 */
	//获取客户当前使用的CSS样式
	String cssFileName = request.getParameter("cssFileName");
	//获取dse_sessionId
	String dse_sessionId = request.getParameter("dse_sessionId");
	//获取卡号
	String cardNo = request.getParameter("cardNo");
	//获取卡号
	String custName = request.getParameter("custName");
	
	//创建日志实例
	GzLog log = new GzLog("c:/gzLog");
	log.Write(cardNo+"进入["+uri+"]");


%>

<html>
    <head>
        <title>交通银行网上服务</title>
        <link rel="stylesheet" type="text/css" href="/personbank/css/<%=cssFileName%>">
    </head>


    <body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  oncontextmenu=self.event.returnValue=false onselectstart="return false" >
    <div class="indent">
    <form action="/personbank/HttpProxy" method=post name="form1">
		<table width="90%" align="center" cellpadding="1" cellspacing="1" class="tab">
		  <tr align="center" class="tab_title"> 
		    <td>
		    我行已受理您的签约申请。
		    </td>
		  </tr>
		  <tr class="tab_tr">
		    <td align="left">
		    各委托项目的自动代缴费业务功能自首次扣款成功之日起开通，请确保您的签约银行卡帐户余额充足，并留意签约银行卡扣款短信通知。感谢您对交行的支持!
		    </td>
		  </tr>
		</table>
    </form>
    </div>
    </body>
</html>