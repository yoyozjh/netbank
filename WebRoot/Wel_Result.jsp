<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page language="java" contentType="text/html;charset=GBK"%>
<%@ page import="java.net.*" %>
<%@ page import="com.bocom.midserv.gz.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="com.gdbocom.Transactions.WelLot" %>
<%@ page import="com.gdbocom.util.format.*" %>
<%@include file="/includeFiles/common.jsp" %>
<%
	//设置显示的值的顺序
	String[] keyOrder = {};

	//设置非循环体需要显示的值和名称,
	Map sequenceShowKey = new HashMap();

	//设置循环体需要显示的值和名称,
	Map showKey = new HashMap();

	//设置需要显示的值的类型
	Map keyType = new HashMap();
	//获取bus字段,判断交易类型
	String busStr=ReqParamUtil.reqParamTirm(request,"Bus");
	//String busStr = (String)pageContext.getAttribute("Bus", PageContext.SESSION_SCOPE);
	//获取服务端调用结果集
	Map responseVal=(Map)request.getAttribute("responseVal");
	
	int bus =Integer.parseInt(busStr);
	String title = "";
	String remark = "";
	if(bus==WelLot.ADDREG){
		title = "福彩用户注册成功";
	}else if(bus==WelLot.UPDREG){
		title = "福彩用户注册信息更改成功";
	}else if(bus==WelLot.DOUBLE_SEL){//双色球自选
		title = "双色球实时投注购买成功";
		keyOrder = new String[]{"BetLin", "BetAmt", "TLogNo"};
		showKey.put("DrawId", "投注期号");
		showKey.put("BetLin", "投注号码");
		showKey.put("BetAmt", "投注金额");
		showKey.put("TLogNo", "投注流水号");
		showKey.put("TckNo", "会计流水号");
		keyType.put("BetLin", WelFormatter.getSingleton(WelFormatter.BETNUM));
		keyType.put("BetAmt", WelFormatter.getSingleton(WelFormatter.CURRENCY));
	}else if(bus==WelLot.DOUBLE_BETSQRY){//双色球投注查询
		title = "福彩用户注册信息更改成功";
	}else if(bus==WelLot.DOUBLE_WINQRY){//双色球中奖查询
		title = "福彩用户注册信息更改成功";
	}else if(bus==WelLot.DOUBLE_FIX_BUY){//双色球定投购买
		title = "双色球定投购买成功";

		keyOrder = new String[]{"BetLin", "BetPer"};

		/*showKey.put("TLogNo", "购彩流水号");*/
		showKey.put("BetLin", "投注号码");
		showKey.put("BetPer", "套餐类型");
		
		keyType.put("BetLin", WelFormatter.getSingleton(WelFormatter.BETNUM));
		keyType.put("BetPer", WelFormatter.getSingleton(WelFormatter.PACKAGE));

	}else if(bus==WelLot.DOUBLE_FIX_CANCEL){//双色球中奖查询
		title = "双色球定投取消成功";

	}else{
		throw new IllegalArgumentException("错误的bus值");
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
		     	<%=title%>
		    </td>
		  </tr>
		  <tr></tr>
		 <tr class="tab_tr">
		  <td colspan="50">
			<%
				for(int keyIndex=0; keyIndex<keyOrder.length; keyIndex++){
					//英文值，类似"DrawId"
					String key = keyOrder[keyIndex];
					//显示的中文名字，类似"投注期号"
					String showName = (String)showKey.get(key);
					//使用的格式化对象，类似 WelFormatter.getSingleton(WelFormatter.BETNUM)
					FormatterInterface type = (FormatterInterface)keyType.get(key);
					//为格式化的值
					String originValue = (String)responseVal.get(key);
					if(StringUtils.isEmpty(originValue)){
						originValue=ReqParamUtil.getParamAttr(request,key);
					}
					if(null==originValue){
						out.println("<label>"+showName+":null</label><br/>");
					}else if(null==type){
						out.println("<label>"+showName+":"+originValue+"</label><br/>");
					}else{
						//格式化后的值
						String formattedValue = type.getFormattedValue(StringUtils.trim(originValue));
						out.println("<label>"+showName+":"+formattedValue+"</label><br/>");
					}
				}
			%>
			</td>
	     </tr>
	     <tr class="tab_tr"> 
	        <td align="center" colspan="50">
	            <%=remark%>
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
   	</div>
    </body>
</html>
<%!
	public String getFormattedValue(String value, String type){
		if("BigDecimal".equals(type)){
			return new DecimalFormat("#,###.00").format(Double.parseDouble(value)/100.0);
		}else{
			return value;
		}

	}
	
%>