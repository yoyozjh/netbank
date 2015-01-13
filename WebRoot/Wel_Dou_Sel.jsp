<%@ page language="java" contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*" %>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.bocom.midserv.gz.*"%>
<%@ page import="com.gdbocom.Transactions.WelLot" %>
<%@include file="/includeFiles/common.jsp" %>
<html>
    <head>
        <title>交通银行网上服务</title>
               <!-- 总行样式表，定义总体色调与表格等格式 -->
        <link rel="stylesheet" type="text/css" href="/personbank/css/<%=cssFileName%>">
        <!-- 分行样式表，定义段落、超链接格式 -->
        <link rel="stylesheet" type="text/css"
            href="/personbank/HttpProxy?URL=/midserv/css/css.css&dse_sessionId=<%=dse_sessionId%>">
    </head>
    <body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  oncontextmenu="self.event.returnValue=false" onselectstart="return false">
    <div class="indent">
    <form action="/personbank/HttpProxy" method="post" name="form1">
        <!-- 总行定义字段 -->
        <input type="hidden" name="URL" value="/midserv/Wel_Dou_Red.jsp"/>
        <input type="hidden" name="dse_sessionId" value="<%=dse_sessionId%>"/>
        <table width="90%" align="center" cellpadding="1" cellspacing="1"  class="tab">
		  <tr align="center" class="tab_title">
		    <td align="left" colspan="2">
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
					<option value='<%=WelLot.DOUBLE_SEL%>' selected="selected">自选</option>
					<option value='<%=WelLot.DOUBLE_BETSQRY%>'>投注查询</option>
					<option value='<%=WelLot.DOUBLE_WINQRY%>'>中奖查询</option>
				</SELECT>
	        </td>
	     </tr>
	     <tr class="tab_tr"> 
	        <td align="center" colspan="3">
	        	<div style="color: red;">定投单购买是开奖日12:00前投注当期，12:00后下的定投单在下一期投注</div>
	        </td>
	     </tr>
	     <tr class="tab_result"> 
	        <td align="center" colspan="2">
	            <input type="submit" class="button_bg" value="确定" style="cursor:hand;"/>
	            <input type="button" class="button_bg" name="Submit3" value="返回" onclick="javascript:history.back()" />
	        </td>
	     </tr>
	     </table>
		</form>
	</div>
	</body>
</html>