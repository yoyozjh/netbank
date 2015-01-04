<%@ page language="java" pageEncoding="gbk"%>
<%@ page import="com.bocom.midserv.gz.*"%>
<%@ page import="com.viatt.bean.*"%>
<%@ page import="com.viatt.util.*"%>

<%
			String dse_sessionId = MessManTool.changeChar(request
			.getParameter("dse_sessionId"));//获取dse_sessionId	
	GzLog log = new GzLog("c:/gzLog");
		String loginType = request.getParameter("loginType");//传送登陆类别 0－注册用户(手机版) 1－证书用户 2－大众用户
	String biz_id = MessManTool.changeChar(request
			.getParameter("biz_id"));
	if (biz_id.equals("")) {
		System.out.println("传入参数不正确");
	}
	String tmp = "";
	String cdno = MessManTool
			.changeChar(request.getParameter("cardNo"));
	String content = "biz_id," + biz_id + "|i_biz_step_id,4|CDNO,"
			+ cdno + "|";
	MidServer midServer = new MidServer();
	BwResult bwResult = midServer.sendMessage(content);
	if (bwResult == null || bwResult.getCode() == null
			|| !bwResult.getCode().equals("000")) {
			System.out.println("查询信息失败");
			AppParam.setParam(dse_sessionId+"midErr1","失败");
			AppParam.setParam(dse_sessionId+"midErr2",bwResult.getContext());
%>
<script type="text/javascript">
	window.location="/personbank/HttpProxy?URL=/midserv/midservError.jsp&dse_sessionId=<%=dse_sessionId%>";
</script>
<%
	return;	
	}
	tmp = bwResult.getContext();
	MessManTool messManTool = new MessManTool();
	messManTool.getValueByName(tmp,"IDNo");
%>

<!-------------------------------------------------------------------
                          标准JavaScript库引用
--------------------------------------------------------------------->
<script language="JavaScript"
	src="/personbank/HttpProxy?URL=/midserv/js/public.js&dse_sessionId=<%=dse_sessionId%>"></script>
<script language="JavaScript"
	src="/personbank/HttpProxy?URL=/midserv/js/common.js&dse_sessionId=<%=dse_sessionId%>"></script>
<script language="JavaScript"
	src="/personbank/HttpProxy?URL=/midserv/js/date.js&dse_sessionId=<%=dse_sessionId%>"></script>
<!--------------------------------------------------------------------
   当前页面JavaScript函数部分，包括提交验证，页面动作，具体目标等代码
---------------------------------------------------------------------->

<!--------------------------------------------------------------------
                          页面HTML表现部分    
---------------------------------------------------------------------->

<html>
	<head>
		<title>交通银行网上服务</title>
		<link rel="stylesheet"
			href="/personbank/HttpProxy?URL=/midserv/css/personbank.css&dse_sessionId=<%=dse_sessionId%>">
		<link rel="stylesheet"
			href="/personbank/HttpProxy?URL=/midserv/css/midserv.css&dse_sessionId=<%=dse_sessionId%>">
		<link href="/personbank/css/csspt.css" rel="stylesheet"
			type="text/css">
		<link href="/personbank/css/content.css" rel="stylesheet"
			type="text/css">
		<script type="text/javascript">
			var clickBoolean=true;
			function tj1(){
				if(clickBoolean){
						var input=document.forms[0].getElementsByTagName("input");
						var bn=true;
						for(var i=0;i<input.length;i++){
							var type=input[i].getAttribute("type");
							if(type=='text'||type=='password'){
								if(input[i].value==''||input[i].value==null){
											bn=false;
											break;
								}
							} 
						}
						if(bn){
							var tmp1=document.getElementById("mobile_no").value;
							var tmp3=document.getElementById("card1").value;
							if(!tmp1.isMobile()){
								alert("手机号码格式不对！");
								return;
							}
							if(tmp3.length < 8){
								alert("羊城通卡号长度最少是8位！");
								return;
							}
							clickBoolean=false;
							tj();
						}else{
							alert("输入项不能为空!");
							return;
						}
						var tmp = confirm("1、兹申明以上资料完全属实，本人确认无误，如资料填写有误所造成的损失由本人自行承担。\n2、不论申请批准与否，本人同意以上资料由羊城通有限公司和银行保留。\n3、本人已经清楚了解并同意遵守该自动充值签约交易已申明的所有事项，对因违反规定所造成的损失和后果，本人愿意承担一切法律责任。\n4、本人同意并授权交通银行从自动充值签约交易所指定的银行帐户上划扣羊城通自动充值款");
						if(tmp)
						{
							
						}
						else{
							window.location="/personbank/HttpProxy?dse_sessionId=<%=dse_sessionId %>&URL=/midserv/midSelect.jsp";
						}
					}
			}
		</script>
	</head>

	<body leftmargin="0" topmargin="0"
		oncontextmenu=self.event.returnValue=false
		onselectstart="return false">
		<center>
			<DIV align=center>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td
							background="/personbank/HttpProxy?URL=/midserv/images/pageTitle.gif&dse_sessionId=<%=dse_sessionId%>"
							class="pageTitle">
							&nbsp;&nbsp;请输入相应签约信息
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
				<FORM action="/personbank/HttpProxy" method=post>
					<input type="hidden" name="dse_sessionId"
						value="<%=dse_sessionId%>">
					<input type="hidden" name="URL"
						value="/midserv/kongZhongChongZhi4.jsp">
					<input type="hidden" name=biz_id value="<%=biz_id%>">
					<input type="hidden" name=step_id value="3">
					<input type="hidden" name=acc_type value="0">
					<input type="hidden" name=IDTyp value="<%=messManTool.getValueByName(tmp,"IDTyp") %>">
					<input type="hidden" name="sendPass" value="<%=loginType.endsWith("0")?"1":"0" %>">
					<table border="0" cellspacing="2" cellpadding="0" align="center"
						width="78%">
						<tr>
							<td width="50%" align="right" height="22" class="InputTip">
								用户姓名:
							</td>
							<td width="50%" align="left" height="22" class="InputTip">
								<input type="text" name="cust_name" value="<%=messManTool.getValueByName(tmp,"ActNam")%>" readonly="readonly">
							</td>
						</tr>
						<tr>
							<td width="50%" align="right" height="22" class="InputTip">
								用户身份证:
							</td>
							<td width="50%" align="left" height="22" class="InputTip">
								<input type="text" name="paper_no" value="<%=messManTool.getValueByName(tmp,"IDNo")%>"  readonly="readonly">
							</td>
						</tr>
						<tr>
							<td width="50%" align="right" height="22" class="InputTip">
								性别:
							</td>
							<td width="50%" align="left" height="22" class="InputTip">
								<select name="sex_code">
									<option value="0">
										男
									</option>
									<option value="1">
										女
									</option>
								</select>
							</td>
						</tr>
						<tr>
							<td width="50%" align="right" height="22" class="InputTip">
								手机号码:
							</td>
							<td width="50%" align="left" height="22" class="InputTip">
								<input type="text" name="mobile_no" value="" onkeypress="onlyMunNoPointer();" maxlength="11"><span class="span1"></span>
							</td>
						</tr>
						<tr>
							<td width="50%" align="right" height="22" class="InputTip">
								羊城通卡号:
							</td>
							<td width="50%" align="left" height="22" class="InputTip">
								<input type="text" name="card1" onkeypress="onlyMunNoPointer();" maxlength="10" value=""><span class="span1"></span>
							</td>
						</tr>
					</table>
				</FORM>
				<table>
					<tr>
						<td>
							<input type="button" onclick="tj1();" value="下一步"
								class="button_bg">
							<input type="button" onclick="window.history.back();" value="返 回"
								class="button_bg">
							
						</td>
					</tr>
				</table>
				<table width="80%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
							<b>注意：</b>
						</td>
					</tr>
					<tr>
						<td>
							<br>
							1、每个银行账户最多可以绑定四张羊城通卡，每张羊城通卡只能对应一个银行帐号。
							<br>
							2、用户必须在提交本签约交易第二日起七个工作日内，到羊城通自动充值终端对绑定的每一张羊城通卡分别进行激活，激活后方可使用自动充值服务；如羊城通卡未在规定时间内激活，则本表中该羊城通卡与制定银行账户的绑定自动解除。
							<br>
							3、充值频度、充值额度采用自动充值系统设定的统一值，用户根据需要可在羊城通自动充值终端上进行个性化选择,默认设置为充值频度为每天一次,额度为50元。
							<br>
							4、《羊城通自动充值服务协议》、《羊城通自动充值服务章程》、《羊城通自动充值服务业务规则》为本签约交易的有效组成部分，在申请人办理以上业务时，广州羊城通有限公司即视申请人已经清楚了解并同意按照以上文件行使和履行相关权力和义务。
							<br>
							5、自动充值服务有变更的，以广州羊城通有限公司最新公告为准。

						</td>
					</tr>
				</table>
			</DIV>
		</center>
	</body>
</html>
