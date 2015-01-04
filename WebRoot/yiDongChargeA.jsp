<%@ page language="java" pageEncoding="gbk"%>
<%@ page import="com.bocom.midserv.gz.*"%>
<%@ page import="com.viatt.bean.*"%>
<%@ page import="com.viatt.util.*"%>

<%
	GzLog log = new GzLog("c:/gzLog");
	log.Write("###########解约的时候，用来查询并且显示客户的相关要素########yiDongChargeA.jsp######begins");
	String dse_sessionId = MessManTool.changeChar(request.getParameter("dse_sessionId"));//获取dse_sessionId	
	String loginType = request.getParameter("loginType");//传送登陆类别 0－注册用户(手机版) 1－证书用户 2－大众用户
	String biz_id = MessManTool.changeChar(request.getParameter("biz_id"));
	if (biz_id.equals("")) {
		System.out.println("传入参数不正确");
	}
	
	
	String optType = "deReg";//reg--签约 deReg--解约
	String cdno = MessManTool.changeChar(request.getParameter("cardNo"));
	String content = "biz_id,32|biz_step_id,3|TXNSRC,WE441|ActNo,"+cdno;
	log.Write(">>>>解约查询界面yiDongChargeA.jsp>>>>>>>>>>发出的content报文为：" +content);
			
    String cssFileName = request.getParameter("cssFileName");//获取客户当前使用的CSS样式
	if(cssFileName ==null){
		cssFileName = "skin.css";
	}		
	
	log.Write("======The cssFileName is :"+cssFileName);
	
				
	MidServer midServer = new MidServer();
	BwResult bwResult = midServer.sendMessage(content);
	
	
	
	if (bwResult == null || bwResult.getCode() == null|| !bwResult.getCode().equals("000")) {
		//返回为空或者有问题的时候
			log.Write("查询信息失败");			
			AppParam.setParam(dse_sessionId+"midErr1","失败");
			AppParam.setParam(dse_sessionId+"midErr2","查询失败");
%>
			<script type="text/javascript">
				window.location="/personbank/HttpProxy?URL=/midserv/midservError.jsp&dse_sessionId=<%=dse_sessionId%>";
			</script>
<%
				return;	
	}
	
	log.Write("<<<<<<<<<<<<<解约查询返回报文_bwResult:"+bwResult);

	log.Write("##########_Hello_####");
	String message="default";
	log.Write("##########_the Message is _######"+message);
	
	message = bwResult.getContext();
	log.Write("##########_bwResult.getContext==="+message);	
	

	MessManTool messManTool = new MessManTool();

	

	
	//获取查询回来去得到的值
	String IdTyp = messManTool.getValueByName(message, "IdTyp");
	String IdNo  = messManTool.getValueByName(message, "IdNo");
	String ActNam= messManTool.getValueByName(message, "ActNam");
	String ActSts= messManTool.getValueByName(message, "ActSts");
	
	String IdTypeName="";
	
	
	int idtype = Integer.parseInt(IdTyp.trim());
		
	switch(idtype)
	{
		case 15: IdTypeName="居民身份证"; break; 
		case 23: IdTypeName="户口簿"; break;
		case 19: IdTypeName="港澳通行证"; break;
		case 16: IdTypeName="临时身份证"; break;
		case 25: IdTypeName="外国人居留证"; break;
		case 18: IdTypeName="武警身份证"; break;
		case 17: IdTypeName="军人身份证"; break;
		case 21: IdTypeName="其他"; break;
		default : IdTypeName="其他身份证件";
		
	}
	
		
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
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>交通银行网上服务</title>
		<link rel="stylesheet" type="text/css" href="/personbank/css/<%=cssFileName%>">
		<script type="text/javascript">
			var clickBoolean=true;
			function tj1(){
				if(clickBoolean){
						var input=document.forms[0].getElementsByTagName("input");
						var bn=true;
						for(var i=0;i<input.length;i++){
							var type=input[i].getAttribute("type");
							if(type=='text'||type=='bocomPwd'){
								if(input[i].value==''||input[i].value==null){
											bn=false;
											break;
								}
							} 
						}
						if(bn){
							var tmp1=document.getElementById("mainNo").value;
							if(tmp1.length!=11){
								alert("手机位数输入有误！请重新输入");
								return;
							}
							clickBoolean=false;
							tj();
						}else{
							alert("输入项不能为空!");
							return;
						}
						var tmp = confirm("是否确定要继续进行解约操作？");
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

	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
		<center>
			<div class="indent">
				<table width="100%" align="center" cellpadding="1" cellspacing="1" class="tab">
					<tr align="left"> 
						<td class="tab_title">请输入相应解约信息</td>
					</tr>
					
				<FORM action="/personbank/HttpProxy" method=post name="f1">
					<input type="hidden" name="dse_sessionId"	value="<%=dse_sessionId%>">
					<input type="hidden" name="URL"	value="/midserv/yiDongChargeB.jsp">
					<input type="hidden" name=biz_id value="<%=biz_id%>">
					<input type="hidden" name=step_id value="3">
					<input type="hidden" name=acc_type value="0">
					<input type="hidden" name="sendPass" value="<%=loginType.endsWith("0")?"1":"0" %>">
					<input type="hidden" name="optType"	value="<%=optType%>">
					<input type="hidden" name="IdTyp"	value="<%=IdTyp%>">
					
						<tr class="tab_tr">
							<td width="50%" align="right" height="22" class="InputTip">
								用户姓名：
							</td>
							<td width="50%" align="left" height="22" class="InputTip">
								<input type="text" name="ActNam" value="<%=ActNam%>" readonly="readonly">
							</td>
						</tr>
						<tr class="tab_tr">
							<td width="50%" align="right" height="22" class="InputTip">
								证件类型：
							</td>
							<td width="50%" align="left" height="22" class="InputTip">
								<input type="text" name="IdTypeName" value="<%=IdTypeName%>" readonly="readonly">
							</td>
						</tr>
						<tr class="tab_tr">
							<td width="50%" align="right" height="22" class="InputTip">
								证件号码：
							</td>
							<td width="50%" align="left" height="22" class="InputTip">
								<input type="text" name="IdNo" value="<%=IdNo%>"  readonly="readonly">
							</td>
						</tr>
						<tr class="tab_tr">
							<td width="50%" align="right" height="22" class="InputTip">
								签约主号码：
							</td>
							<td width="50%" align="left" height="22" class="InputTip">
								<input type="text" name="mainNo" value="" onkeypress="onlyMunNoPointer();" maxlength="11"><span class="span1"></span>
							</td>
						</tr>
						<tr class="tab_result">
							<td align="center" colspan="2">
								<input type="button" onclick="tj1();" value="下一步" class="button_bg">
								<input type="button" onclick="window.history.back();" value="返 回"	class="button_bg">
							</td>
						</tr>
					</table>
					
				</FORM>
				
			</DIV>
		</center>
					 
	</body>
</html>
