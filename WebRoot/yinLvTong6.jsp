<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@ page import="com.bocom.midserv.gz.*,com.bocom.eb.des.*"%>
<%@ page import="com.viatt.bean.*"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%
	GzLog log = new GzLog("c:/gzLog");
	String loginType = request.getParameter("loginType");//传送登陆类别 0－注册用户(手机版) 1－证书用户 2－大众用户
	String dse_sessionId = MessManTool.changeChar(request.getParameter("dse_sessionId"));//获取dse_sessionId
	String cdno = MessManTool.changeChar(request.getParameter("cardNo"));
	String step_id = MessManTool.changeChar(request.getParameter("step_id"));
	String password = MessManTool.changeChar(request.getParameter("password"));//加密密码
	if(password.equals("")){
		System.out.println("交易密码为空");
			AppParam.setParam(dse_sessionId+"midErr1","参数错误");
			AppParam.setParam(dse_sessionId+"midErr2","交易密码为空");
%>
<script type="text/javascript">
	window.location="/personbank/HttpProxy?URL=/midserv/midservError.jsp&dse_sessionId=<%=dse_sessionId%>";
</script>
<%
		return;
	}
//	if(password != null)
//	{
//		password = EBDES.decryptoDES(password, dse_sessionId);//解密后密码
//	}
	String biz_id = MessManTool.changeChar(request.getParameter("biz_id"));
	if (biz_id.equals("")) {
		System.out.println("传入参数不正确");
	}
	if(loginType.equals("0")){
		String dynamicCode1=AppParam.getParam(dse_sessionId);
		String dynamicCode=MessManTool.changeChar(request.getParameter("dynamicCode"));
		if(!dynamicCode.equals(dynamicCode1)){
			System.out.println("动态密码不对");
			AppParam.setParam(dse_sessionId+"midErr1","参数错误");
			AppParam.setParam(dse_sessionId+"midErr2","动态密码不对");
%>
<script type="text/javascript">
	window.location="/personbank/HttpProxy?URL=/midserv/midservError.jsp&dse_sessionId=<%=dse_sessionId%>";
</script>
<%
		return;
		}
	}
	String content = "bocom_mid|biz_id,21|biz_step_id,5"+
	"|Product_Code,"+MessManTool.changeChar(request.getParameter("ticketCode"))+//门票代码
	"|Retail_Price1,"+MessManTool.changeChar(request.getParameter("mpj"))+//门市价
	"|E_Discount_Price1,"+MessManTool.changeChar(request.getParameter("dzyhj"))+//电子优惠价
	"|Reserve_Amoun,"+MessManTool.changeChar(request.getParameter("gmzs"))+//购买张数
	"|Mobile_Phone_Number,"+MessManTool.changeChar(request.getParameter("sjhm1"))+//手机号
	"|Begin_Date,"+MessManTool.changeChar(request.getParameter("mprq"))+//门票日期
	"|Message_Type,"+MessManTool.changeChar(request.getParameter("sjlx"))+//手机类型
	"|Amount1,"+MessManTool.changeChar(request.getParameter("zjr"))+//总金额
	"|CDNO,"+cdno+//卡号
	"|PSWD,"+password+//交易密码
	"|Scence_Code,"+MessManTool.changeChar(request.getParameter("sightCode"))+//景区代码
	"|Scence_Name,"+MessManTool.changeChar(request.getParameter("sightName"))+//景区名称
	"|Product_Name,"+MessManTool.changeChar(request.getParameter("mpms"))+//门票名称
	"|Remark1,"+MessManTool.changeChar(request.getParameter("bz"))+//备注
	"|Valid_Days,"+MessManTool.changeChar(request.getParameter("yxrq"))+"|TXNSRC,WE441|";//有效日期
	
	System.out.println("wy:"+content);
	MidServer midServer = new MidServer();
	BwResult bwResult = midServer.sendMessage(content);
	
	if (bwResult == null || bwResult.getCode() == null
			|| !bwResult.getCode().equals("000")) {
			System.out.println("交易结果不对");
			AppParam.setParam(dse_sessionId+"midErr1","失败");
			AppParam.setParam(dse_sessionId+"midErr2",bwResult.getContext());
%>
<script type="text/javascript">
	window.location="/personbank/HttpProxy?URL=/midserv/midservError.jsp&dse_sessionId=<%=dse_sessionId%>";
</script>
<%
	return;
	}
	String tmp = bwResult.getContext();
	String info=MessManTool.getValueByName(tmp,"MGID");
	if(info==null||info.equals("")||!info.equals("000000")){
		System.out.println("交易不成功");
			AppParam.setParam(dse_sessionId+"midErr1","失败");
			AppParam.setParam(dse_sessionId+"midErr2","交易不成功！");
%>
<script type="text/javascript">
	window.location="/personbank/HttpProxy?URL=/midserv/midservError.jsp&dse_sessionId=<%=dse_sessionId%>";
</script>
<%
	return;
	}
%>

<!-------------------------------------------------------------------
                          标准JavaScript库引用
--------------------------------------------------------------------->
<script language="JavaScript" src="/personbank/HttpProxy?URL=/midserv/js/public.js&dse_sessionId=<%=dse_sessionId%>"></script>
<script language="JavaScript" src="/personbank/HttpProxy?URL=/midserv/js/common.js&dse_sessionId=<%=dse_sessionId%>"></script>

<!--------------------------------------------------------------------
   当前页面JavaScript函数部分，包括提交验证，页面动作，具体目标等代码
---------------------------------------------------------------------->

<!--------------------------------------------------------------------
                          页面HTML表现部分    
---------------------------------------------------------------------->

<html>
	<title>交通银行网上服务</title>
	<head>
		<link rel="stylesheet"
			href="/personbank/HttpProxy?URL=/midserv/css/personbank.css&dse_sessionId=<%=dse_sessionId%>">
		<link rel="stylesheet"
			href="/personbank/HttpProxy?URL=/midserv/css/midserv.css&dse_sessionId=<%=dse_sessionId%>">
		<link href="/personbank/css/csspt.css" rel="stylesheet"
			type="text/css">
		<link href="/personbank/css/content.css" rel="stylesheet" type="text/css">
	</head>

	<body leftmargin="0" topmargin="0" oncontextmenu=self.event.returnValue=false onselectstart="return false">
		<center>
			<DIV align=center>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td
							background="/personbank/HttpProxy?URL=/midserv/images/pageTitle.gif&dse_sessionId=<%=dse_sessionId%>"
							class="pageTitle">
							&nbsp;&nbsp;预 订 成 功 ，门 票 信 息 如 下：
						</td>
						<td rowspan="2" align="right" valign="top">
							&nbsp;
						</td>
					</tr>
					<tr>
						<td>
							<img
								src="/personbank/HttpProxy?URL=/midserv/images/xianb.gif&dse_sessionId=<%=dse_sessionId%>"
								width="100" height="20">
						</td>
					</tr>
				</table>
				<FORM action="/personbank/HttpProxy" method=post name="f1">
					<input type="hidden" name="dse_sessionId"
						value="<%=dse_sessionId%>">
					<input type="hidden" name="URL" value="/midserv/midSelect.jsp">
					<table border="0" cellspacing="2" cellpadding="0" align="center"
						width="86%">
						<tr>
							<td align="right" height="22" class="InputTip">
								景区各称:
							</td>
							<td align="left" height="22" class="InputTip">
								<%=MessManTool.changeChar(request.getParameter("sightName")) %>
							</td>
						</tr>
						<tr>
							<td align="right" height="22" class="InputTip">
								门票名称:
							</td>
							<td align="left" height="22" class="InputTip">
								<%=MessManTool.changeChar(request.getParameter("mpms")) %>
							</td>
						</tr>
						<tr>
							<td align="right" height="22" class="InputTip">
								订单号码:
							</td>
							<td align="left" height="22" class="InputTip">
								<%=MessManTool.getValueByName(tmp, "TCUSNM") %>
							</td>
						</tr>
						<tr>
							<td align="right" height="22" class="InputTip">
								会计流水号:
							</td>
							<td align="left" height="22" class="InputTip">
								<%=MessManTool.getValueByName(tmp, "TckNo") %>
							</td>
						</tr>
						<tr>
							<td align="right" height="22" class="InputTip">
								客户手机号码:
							</td>
							<td align="left" height="22" class="InputTip">
								<%=MessManTool.changeChar(request.getParameter("sjhm1")) %>
							</td>
						</tr>
						<tr>
							<td align="right" height="22" class="InputTip">
								电子优惠价格:
							</td>
							<td align="left" height="22" class="InputTip">
								<%=MessManTool.changeChar(request.getParameter("dzyhj")) %>
							</td>
						</tr>
						<tr>
							<td align="right" height="22" class="InputTip">
								门票数量:
							</td>
							<td align="left" height="22" class="InputTip">
								<%=MessManTool.changeChar(request.getParameter("gmzs")) %>
							</td>
						</tr>
						<tr>
							<td align="right" height="22" class="InputTip">
								本次支付金额:
							</td>
							<td align="left" height="22" class="InputTip">
								<%=MessManTool.changeChar(request.getParameter("zjr")) %>
							</td>
						</tr>
						<tr>
							<td align="right" height="22" class="InputTip">
								使用日期:
							</td>
							<td align="left" height="22" class="InputTip">
								<%=MessManTool.changeChar(request.getParameter("mprq")) %>
							</td>
						</tr>
						<tr>
							<td align="right" height="22" class="InputTip">
								门票有效天数:
							</td>
							<td align="left" height="22" class="InputTip">
								<%=MessManTool.changeChar(request.getParameter("yxrq")) %>
							</td>
						</tr>
						<tr>
							<td align="right" height="22" class="InputTip">
								备注:
							</td>
							<td align="left" height="22" class="InputTip">
								<%=MessManTool.changeChar(request.getParameter("bz")) %>
							</td>
						</tr>
					</table>
					<table width="80%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
							<b>温馨提示：</b>
						</td>
					</tr>
					<tr>
						<td>
								请在使用日期之后的有效天数内使用，以免过期！在景区售票处出示购票银行卡或收到手机二维码短信取票，银旅通客户服务热线4008-960-168
						</td>
					</tr>
				</table>
				</FORM>
				<table>
					<tr>
						<td>
							<input onchange="" type="button" onclick="tj();" value="返 回" class="button_bg">
						</td>
					</tr>
				</table>
			</DIV>
		</center>
	</body>
</html>
