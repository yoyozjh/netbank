<%@ page language="java" contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*" %>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.bocom.midserv.gz.*"%>
<%@ page import="com.gdbocom.Transactions.WelLot" %>
<%@include file="/includeFiles/common.jsp" %>
<!-------------------------------------------------------------------
                          标准JavaScript库引用
--------------------------------------------------------------------->
<script language="JavaScript" src="/personbank/HttpProxy?URL=/midserv/js/public.js&dse_sessionId=<%=dse_sessionId%>"></script>
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
        <input type="hidden" name="URL" value="/midserv/Wel_Bus_Red.jsp"/>
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
					<OPTION value='<%=WelLot.ADDREG%>' selected="selected">用户注册</OPTION>
					<OPTION value='<%=WelLot.UPDREG%>'>更改用户注册</OPTION>
					<OPTION value='<%=WelLot.DOUBLEBUY%>'>双色球实时投注</OPTION>
					<OPTION value='<%=WelLot.DOUBLEFIXBUY%>'>双色球定投</OPTION>
					<OPTION value='<%=WelLot.TENBUY%>'>快乐十分实时投注</OPTION>
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