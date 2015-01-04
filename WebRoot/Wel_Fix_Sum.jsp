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
    <form action="/personbank/HttpProxy" method="post" name="form1">
        <!-- 总行定义字段 -->
        <input type="hidden" name="URL" value="/midserv/Wel_Fix_Sel.jsp"/>
        <input type="hidden" name="dse_sessionId" value="<%=dse_sessionId%>"/>
        <table width="90%" align="center" cellpadding="1" cellspacing="1"  class="tab">
		  <tr align="center" class="tab_title">
		    <td align="left" colspan="2">
		     定投业务简介:
		    </td>
		  </tr>
		  <tr></tr>
		 <tr class="tab_tr"> 
	        <td align="right">
	             简介:
	        </td>
	        <td align="left"> 
				<label>双色球是由中国福利彩票发行管理中心发行的一款彩票玩法，双色球彩票投注区分为红色球号码区和蓝色球号码区。双色球每注投注号码由6个红色球号码和1个蓝色球号码组成。红色球号码从1-33中选择，蓝色球号码从1-16中选择，顺序不限，每注2元，每周二、四、日晚20:50开奖。客户办理定投业务后，福彩中心将每期自动按照客户提交的号码、套餐类型等信息为客户进行自动购买。目前可在我行办理双色球306定投套餐306元（共153期）和152元（共76期）。若客户中奖，单注奖金小于等于1万元时，奖金自动转入客户银行卡账户；单注奖金大于1万元，将由福彩中心客服人员人工通知客户携带本恩身份证前往福彩中心领取。</label>
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
