<%@ page language="java" contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*" %>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.bocom.midserv.gz.*"%>
<%@ page import="com.gdbocom.Transactions.WelLot" %>
<%@include file="/includeFiles/common.jsp" %>
<html>
    <head>
        <title>交通银行网上服务</title>
        <link rel="stylesheet" type="text/css" href="/personbank/css/<%=cssFileName%>"></link>
    </head>
    <body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  oncontextmenu="self.event.returnValue=false" onselectstart="return false">
    <div class="indent">
    <form action="/personbank/HttpProxy" method="post" name="form1" id="form1">
        <!-- 总行定义字段 -->
        <input type="hidden" name="URL" value="/midserv/Wel_hTen_buyRed.jsp"/>
        <input type="hidden" name="dse_sessionId" value="<%=dse_sessionId%>"/>
        <table width="90%" align="center" cellpadding="1" cellspacing="1"  class="tab">
		  <tr align="center" class="tab_title">
		    <td align="left" colspan="2">
		     请选择投注方式:
		    </td>
		  </tr>
		  <tr></tr>
		 <tr class="tab_tr"> 
	        <td align="right">
	             投注方式:
	        </td>
	        <td align="left"> 
				<SELECT name="buyMode" id="buyMode">
					<option value='<%=WelLot.HpTenBuy.ONE%>' selected="selected">选一数投</option>
					<option value='<%=WelLot.HpTenBuy.ONE_RED%>' >选一红投</option>
					<option value='<%=WelLot.HpTenBuy.TWO%>' >任选二</option>
					<option value='<%=WelLot.HpTenBuy.TWO_LINE%>'>选二连直</option>
					<option value='<%=WelLot.HpTenBuy.TWO_GROUP%>'>选二连组</option>
					<option value='<%=WelLot.HpTenBuy.THREE%>'>任选三</option>
					<option value='<%=WelLot.HpTenBuy.THREE_LINE%>'>选三前直</option>
					<option value='<%=WelLot.HpTenBuy.THREE_GROUP%>'>选三前组</option>
					<option value='<%=WelLot.HpTenBuy.FOUR%>'>任选四</option>
					<option value='<%=WelLot.HpTenBuy.FIVE%>'>任选五</option> 
				</SELECT>
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
