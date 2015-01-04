<%@ page language="java" contentType="text/html;charset=GBK"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.bocom.midserv.gz.*"%>
<%@ page import="java.math.BigInteger" %>
<%@ page import="com.gdbocom.util.format.*" %>
<%@ page import="com.gdbocom.action.wel.*" %>
<%@include file="/includeFiles/common.jsp" %>
<%
	//String cdno = request.getHeader("MBK_ACCOUNT");
	String cdno = ReqParamUtil.reqParamTirm(request,"cardNo");
	
	String loginType =ReqParamUtil.reqParamTirm(request,"loginType");//传送登陆类别 0－注册用户(手机版) 1－证书用户 2－大众用户
	//设置正常情况需要跳转的页面
	String forwardPage = "Wel_Confirm.jsp";
	//设置出错情况需要跳转的页面
	String errPage = "errPage.jsp";

	String BetMod="";
	String BetLin="";
	String forepart="";
	String rear="";
	int forepart_cnt=0;
	int rear_cnt=0;

	//遍历前区
	for(int i=1;i<=33;i++){
		if(request.getParameter("forepart"+i)!=null){
			forepart+=request.getParameter("forepart"+i);
			forepart_cnt++;
		}
	}
	//遍历后区
	for(int i=1;i<=16;i++){
		if(request.getParameter("rear"+i)!=null){
			rear+=request.getParameter("rear"+i);
			rear_cnt++;
		}
	}
	//拼接投注号码字段
	BetLin = this.formatnumber(forepart_cnt)+forepart+this.formatnumber(rear_cnt)+rear;
	String ShowNum = WelFormatter.getSingleton(WelFormatter.BETNUM)
			.getFormattedValue(BetLin);
	//pageContext.setAttribute("BetLin", BetLin, PageContext.SESSION_SCOPE);
	request.setAttribute("BetLin", BetLin);
	
	if(forepart_cnt>=6&&forepart_cnt<=16&&rear_cnt>=1){//合法的号码个数

		if(forepart_cnt==6&&rear_cnt==1){//单式
			BetMod="1";
		}else{//复式
			BetMod="12";
		}
		//pageContext.setAttribute("BetMod", BetMod, PageContext.SESSION_SCOPE);
		request.setAttribute("BetMod", BetMod);
	}else{//非法的号码个数
		String RspCod = "Wel999";
		String RspMsg = "非法号码数"; 
		DebugUtils.log(request,"MGID不正确");

		StringBuffer forwardString = new StringBuffer();
		forwardString.append(errPage).append("?");
		forwardString.append("RspCod").append("=").append(RspCod);
		forwardString.append("&");
		forwardString.append("RspMsg").append("=").append(RspMsg);
        pageContext.forward(forwardString.toString());
	}

	//复式
	int betMode = BetMoney.betMode_Multiple;//单复式
	int multiple = Integer.parseInt((String)ReqParamUtil.reqParamTirm(request,"BetMul"));//投注倍数
	double price = 2;//单注投注金额
	int section = 0;//单式投注注数,复式无意义
	int betRedNum = 6;//单注红球号码个数
	int redTailNum = forepart_cnt;//选择红球号码个数
	int betBlueNum = 1;//单注蓝球号码个数
	int blueNum = rear_cnt;//选择蓝球号码个数
	int redBaseNum = 0;//实际投注红球胆号码个数，复式无意义
	double BetAmt = new BetMoney().CalculateBMoney(betMode, multiple,
		    		price, section, betRedNum,
		    		betBlueNum, redBaseNum, redTailNum, blueNum);
	/*
	pageContext.setAttribute("BetAmt",
			String.valueOf((int)BetAmt*100),
			PageContext.SESSION_SCOPE);
	pageContext.setAttribute("BetNum", String.valueOf(forepart_cnt+rear_cnt), PageContext.SESSION_SCOPE);
	pageContext.setAttribute("ShowNum", ShowNum, PageContext.SESSION_SCOPE);
	*/
	request.setAttribute("BetAmt", String.valueOf((int)BetAmt*100));
	request.setAttribute("BetNum", String.valueOf(forepart_cnt+rear_cnt));
	request.setAttribute("ShowNum", ShowNum);
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
        <input type="hidden" name="URL" value="/midserv/Wel_Confirm.jsp"/>
        <input type="hidden" name="dse_sessionId" value="<%=dse_sessionId%>"/>
        <input type="hidden" name="sendPass" value="<%=loginType.endsWith("0")?"1":"0" %>">
        <table width="90%" align="center" cellpadding="1" cellspacing="1"  class="tab">
		  <tr align="center" class="tab_title">
		    <td align="left" colspan="2">
		       确认投注信息:
		    </td>
		  </tr>
		  <tr></tr>
		 <tr class="tab_tr"> 
	        <td align="right">
	             银行卡号:
	        </td>
	        <td align="left"> 
	        	<label><%=cdno%></label>
	        </td>
	     </tr>
	     <tr class="tab_tr"> 
	        <td align="right">
	             投注号码:
	        </td>
	        <td align="left"> 
	        	<label><%=ShowNum%></label>
	        </td>
	     </tr>
	     <tr class="tab_tr"> 
	        <td align="right">
	             交易金额:
	        </td>
	        <td align="left"> 
	        	<label><%=BetAmt%>元</label>
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
<%!
	public String formatnumber(int inputstr){
		String outputstr;
		if(inputstr<=9){
			outputstr="0"+String.valueOf(inputstr);
		}else{
			outputstr = String.valueOf(inputstr);
		}
		return outputstr;
	}

%>