<%@ page pageEncoding="GBK"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<% request.setCharacterEncoding("GBK");%>

<%@ page import="com.bocom.midserv.gz.*"%>
<%@ page import="com.viatt.bean.*"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.util.*"%>
<%

    String cssFileName = request.getParameter("cssFileName");//获取客户当前使用的CSS样式

    //String biz_step_id="1";  

    GzLog log = new GzLog("c:/gzLog");
    String cardNo = request.getParameter("cardNo");
    String uri = request.getRequestURI();
    log.Write(cardNo+"进入["+uri+"]");

    String dse_sessionId = MessManTool.changeChar(request
            .getParameter("dse_sessionId"));//获取dse_sessionId

%>

<html>
    <head>
        <title>交通银行网上服务</title>
        <link rel="stylesheet" type="text/css" href="/personbank/css/<%=cssFileName%>">
    </head>


    <body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  oncontextmenu=self.event.returnValue=false onselectstart="return false">
    <div class="indent">
		<table width="90%" align="center" cellpadding="1" cellspacing="1" class="tab">
        <tr class="tab_tr">
            <td align="left">
                <p><font style="color:red;">温馨提示：</font>暂不支持电费的电子渠道委托签约，您可直接通过我行交博汇网上商城，手机银行或自助通终端进行自助缴费，或携带身份证、任一期缴费发票到交通银行网点办理签约手续。</p>
            </td>
        </tr>
		<tr class="tab_result">
		    <td align="center">
		        <input type="button" class="button_bg" name="Submit3" value="返回" onclick="javascript:history.back()" />      
		    </td>      
		</tr>
		</table>
    </div>
    </body>
</html>