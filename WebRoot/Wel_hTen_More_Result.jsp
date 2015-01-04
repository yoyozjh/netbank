<%@page import="com.gdbocom.util.HpTenBallCreater.HpTenParam"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page language="java" contentType="text/html;charset=GBK"%>
<%@ page import="com.bocom.midserv.gz.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="com.gdbocom.util.format.*" %>
<%@ page import="com.gdbocom.Transactions.WelLot" %>
<%@include file="/includeFiles/common.jsp" %>
<%
	//设置显示的值的顺序
	String[] keyOrder = {};

	//设置非循环体需要显示的值和名称,
	Map sequenceShowKey = new HashMap();

	//设置循环体需要显示的值和名称,
	Map loopShowKey = new HashMap();
	
	//获取服务端调用结果集
	Map responseVal=(Map)request.getAttribute("responseVal");
	
	//设置需要显示的值的类型
	Map keyType = new HashMap();

	int bus = Integer.parseInt(ReqParamUtil.reqParamTirm(request,"Bus"));
	String title = "";
	String remark = "";
	if(bus==WelLot.HP_TEN_QRY){//双色球投注查询
		title = "";
		keyOrder = new String[]{"DrawId","KenoId","BetLin", "BetAmt","PlayId","TLogNo"};
		
		loopShowKey.put("DrawId", "投注期号");
		loopShowKey.put("KenoId", "小期号");
		loopShowKey.put("PlayId", "投注种类");
		loopShowKey.put("BetLin", "投注号码");
		loopShowKey.put("BetAmt", "投注金额");
		loopShowKey.put("TLogNo", "投注流水号");
		
		keyType.put("BetLin", WelFormatter.getSingleton(WelFormatter.BETNUM_HPTEN));
		keyType.put("BetAmt", WelFormatter.getSingleton(WelFormatter.CURRENCY));

	}else if(bus==WelLot.HP_TEN_WINQRY){//双色球中奖查询
		title = "";
		keyOrder = new String[]{"DrawId","KenoId","BetLin", "PrzAmt","PlayId", "TLogNo"};
		
		loopShowKey.put("DrawId", "中奖期号");
		loopShowKey.put("KenoId", "小期号");
		loopShowKey.put("PlayId", "投注种类");
		loopShowKey.put("BetLin", "中奖号码");
		loopShowKey.put("PrzAmt", "中奖金额");
		loopShowKey.put("TLogNo", "投注流水号");
		
		keyType.put("BetLin", WelFormatter.getSingleton(WelFormatter.BETNUM_HPTEN));
		keyType.put("PrzAmt", WelFormatter.getSingleton(WelFormatter.CURRENCY));

	}else{
		title = "";
	}
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
        <input type="hidden" name="URL" value="/midserv/Wel_Bus_Sel.jsp"/>
        <input type="hidden" name="dse_sessionId" value="<%=dse_sessionId%>"/>
        <table width="90%" align="center" cellpadding="1" cellspacing="1"  class="tab">
		  <tr align="center" class="tab_title">
		    <td align="left" colspan="2">
		      投注结果:
		    </td>
		  </tr>
		  <tr></tr>
		 <tr class="tab_tr">
	        <td align="left">
	            <%
	String loopCntStr=responseVal.get("LoopCnt").toString();
	int loopCnt =Integer.parseInt(loopCntStr);
	if(0==loopCnt){
		out.println("<label>无记录</label><br/>");
	}else{
		List loopBody = (List)responseVal.get("LoopBody");
		//解拆循环字段
		for(int recordIndex=0; recordIndex<loopBody.size(); recordIndex++){
			Map oneRecord = (Map)loopBody.get(recordIndex);
			for(int keyIndex=0; keyIndex<keyOrder.length; keyIndex++){
				//英文值，类似"DrawId"
				String key = keyOrder[keyIndex];
				//显示的中文名字，类似"投注期号"
				String showName = (String)loopShowKey.get(key);
				//使用的格式化对象，类似 WelFormatter.getSingleton(WelFormatter.BETNUM)
				FormatterInterface type = (FormatterInterface)keyType.get(key);
				//为格式化的值
				String originValue = StringUtils.trimToEmpty((String)oneRecord.get(key));
				
				if("PlayId".equals(key)){
					HpTenParam param=new HpTenBallCreater(originValue).getParam();
					out.println("<label>"+showName+":"+param.name+"</label><br/>");
				}else if(null==originValue){
					out.println("<label>"+showName+":null</label><br/>");
				}else if(null==type){
					out.println("<label>"+showName+":"+originValue+"</label><br/>");
				}else{
					//格式化后的值
					String formattedValue = type.getFormattedValue(originValue);
					out.println("<label>"+showName+":"+formattedValue+"</label><br/>");

				}

			}
			out.println("<label>***********************</label><br/>");

		}
	}
%>
	        </td>
	     </tr>
	     <tr class="tab_tr"> 
	        <td align="left">
	             备注:
	        </td>
	        <td align="left"> 
				<%=remark%>
	        </td>
	     </tr>
	     <tr class="tab_result"> 
	        <td align="center" colspan="2">
	            <input type="submit" class="button_bg" value="确定" style="cursor:hand;"/>
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