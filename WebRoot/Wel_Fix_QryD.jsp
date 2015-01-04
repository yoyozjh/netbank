<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page language="java" contentType="text/html;charset=GBK"%>
<%@ page import="com.bocom.midserv.gz.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="com.gdbocom.util.format.*" %>
<%@ page import="com.gdbocom.Transactions.WelLot" %>
<%@include file="/includeFiles/common.jsp" %>
<%
	String CrdNo = ReqParamUtil.reqParamTirm(request,"cardNo");

	//获取服务端调用结果集
	Map resVal=(Map)request.getAttribute("responseVal");
	
	//设置显示的值的顺序
	String[] keyOrder = null;

	//设置非循环体需要显示的值和名称,
	Map sequenceShowKey = new HashMap();

	//设置循环体需要显示的值和名称,
	Map loopShowKey = new HashMap();

	//设置需要显示的值的类型
	Map keyType = new HashMap();

	int bus = Integer.parseInt(ReqParamUtil.reqParamTirm(request,"Bus"));
	String title = "";
	String remark = "";
	if(bus==WelLot.DOUBLE_FIX_QRY){//双色球投注查询
		title = "";
		//sequenceShowKey.put("CrdNo", "签约手机号");
		keyOrder = new String[]{"PlanNo", "BetPer", "BetLin", "BetAmt", "DoPer", "LevPer"};
		
		loopShowKey.put("BetPer", "套餐类型");
		loopShowKey.put("BetLin", "投注号码");
		loopShowKey.put("BetAmt", "投注金额");
		loopShowKey.put("DoPer", "已投注期数");
		loopShowKey.put("LevPer", "剩余投注期数");
		
		keyType.put("BetLin", WelFormatter.getSingleton(WelFormatter.BETNUM));
		keyType.put("BetAmt", WelFormatter.getSingleton(WelFormatter.CURRENCY));

	}else{
		title = "";
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
	    			jQuery("#backForm").submit();
	    		});
	    	});
        </script>
    </head>
    <body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  oncontextmenu="self.event.returnValue=false" onselectstart="return false">
    <div class="indent">
    <form action="/personbank/HttpProxy" method="post" name="form1">
        <!-- 总行定义字段 -->
        <input type="hidden" name="URL" value="/midserv/Wel_Fix_DCnf.jsp"/>
        <table width="90%" align="center" cellpadding="1" cellspacing="1"  class="tab">
		  <tr align="center" class="tab_title">
		   <td align="left" colspan="2">
		      <%=title%>
		    </td>
		  </tr>
		  <tr></tr>
		 <tr class="tab_tr"> 
	        <td align="right">
	                 签约卡号：
	        </td>
	        <td align="left"> 
				<%=CrdNo%>
	        </td>
	     </tr>
	     <tr class="tab_tr"> 
	        <td align="" colspan="5">
		<%
			String loopCntStr=resVal.get("LoopCnt").toString();
			int loopCnt = Integer.parseInt(loopCntStr);
			if(0==loopCnt){
				out.println("<label>无记录</label><br/>");
			}else{
				//解拆循环字段
				List loopBody = (List)resVal.get("LoopBody");
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
						String originValue = (String)oneRecord.get(key);
			
						if(null==originValue){
							out.println("<label>"+showName+":null</label><br/>");
						}else if("PlanNo".equals(key)){
							out.println("<input type='radio' name='"+key+"' value='"+originValue+"' />");
						}else if(null==type){
							out.println("<label>"+showName+":"+originValue+"</label><br/>");
						}else{
							//格式化后的值
							String formattedValue = type.getFormattedValue(StringUtils.trimToEmpty(originValue));
							
							out.println("<label>"+showName+":"+formattedValue+"</label><br/>");
		
						}
			
					}
					out.println("<label>***********************</label><br/>");
			
				}
			}
		%>
		</td>
		</tr>
		  <tr class="tab_result"> 
	        <td align="center" colspan="2">
	            <input type="submit" class="button_bg" value="撤销" style="cursor:hand;"/>
	            <input type="button" class="button_bg" value="返回" id="btn_back" style="cursor:hand;"/>
	        </td>
	     </tr>
	     <tr class="tab_result"> 
	        <td align="center" colspan="2">
	            <label><%=remark%></label>
	        </td>
	     </tr>
	     </table>
	    <%=
			ReqParamUtil.reqParamAttrToHtmlStr(request)
		 %>
	</form>
	<form action="/personbank/HttpProxy" method="post" id="backForm">
       	<input type="hidden" name="URL" value="/midserv/Wel_Fix_Sel.jsp"/>
       	<input type="hidden" name="dse_sessionId" value="<%=dse_sessionId%>"/>
    </form>
	</div>
	</body>
</html>
