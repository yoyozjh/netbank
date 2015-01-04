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
	String TxnAmt = MessManTool.changeChar(request.getParameter("TxnAmt"));
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
	String cardNo=MessManTool.changeChar(request.getParameter("cardNo"));
	String BusNam=MessManTool.changeChar(request.getParameter("BusNam"));
	String currDate = DateUtils.FormatDate(new Date(), "yyyyMMdd");
	String content = "biz_id," + biz_id
			+ "|i_biz_step_id,2|TxnDat," + currDate + "|BusNam,"
			+ BusNam + "|TxnAmt," + TxnAmt + "|CDNO," + cardNo
			+ "|PSWD," + password + "|";//有效日期
	MidServer midServer = new MidServer();
	BwResult bwResult = midServer.sendMessage(content);
	if (bwResult == null || bwResult.getCode() == null
			|| !bwResult.getCode().equals("000")) {
			System.out.println("");
			AppParam.setParam(dse_sessionId+"midErr1","失败");
			AppParam.setParam(dse_sessionId+"midErr2",bwResult.getContext());
%>
<script type="text/javascript">
	window.location="/personbank/HttpProxy?URL=/midserv/midservError.jsp&dse_sessionId=<%=dse_sessionId%>";
</script>
<%
	return;
	}
	String result = bwResult.getContext();
	String info=MessManTool.getValueByName(result,"MGID");
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
	double tmpAmt = Double.parseDouble(TxnAmt.trim());
	tmpAmt = tmpAmt / 100;
	String strAmt = MoneyUtils.FormatMoney(tmpAmt, "#,##0.00元");
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
							&nbsp;&nbsp;预 订 成 功 ：
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
								你的购买面值为:
							</td>
							<td align="left" height="22" class="InputTip">
								<%=strAmt%>
							</td>
						</tr>
						<tr>
							<td align="right" height="22" class="InputTip">
								充值密码:
							</td>
							<td align="left" height="22" class="InputTip">
								<%=MessManTool.getValueByName(result, "TcusNm")%>
							</td>
						</tr>
						<tr>
							<td align="right" height="22" class="InputTip">
								有效日期:
							</td>
							<td align="left" height="22" class="InputTip">
								<%=MessManTool.getValueByName(result, "YXDate")%>
							</td>
						</tr>
					</table>
				</FORM>
				<table>
					<tr>
						<td>
							<input onchange="" type="button" onclick="tj();" value="确定" class="button_bg">
						</td>
					</tr>
				</table>
			</DIV>
		</center>
	</body>
</html>
