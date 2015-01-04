<!-------------------------------------------------------------------
                          标准页面服务对象引用
-------------------------------------------------------------------->
<%@ page language="java" contentType="text/html;charset=GBK" %>

<%@ page import="java.util.Date" %>
<%@ page import="com.viatt.bean.*"%>
<%@ page import="com.viatt.util.*" %>
<%@ page import="com.bocom.midserv.base.*" %>
<%@ page import="com.bocom.midserv.web.*" %>
<%@ page import="com.bocom.midserv.gz.*"%>
<%
	GzLog log = new GzLog("c:/gzLog");
	log.Write("###########客户签约的查询以及输入参数回显########yiDongCharge3.jsp######begins");
	String loginType = request.getParameter("loginType");//传送登陆类别 0－注册用户(手机版) 1－证书用户 2－大众用户
	String dse_sessionId = MessManTool.changeChar(request.getParameter("dse_sessionId"));//获取dse_sessionId
	String cdno = MessManTool.changeChar(request.getParameter("cardNo"));
	String step_id = MessManTool.changeChar(request.getParameter("step_id"));
	String biz_id = MessManTool.changeChar(request.getParameter("biz_id"));
	
	String IdTyp = MessManTool.changeChar(request.getParameter("IdTyp"));//证件类型
	String IdNo = MessManTool.changeChar(request.getParameter("IdNo"));//证件号码
	String ActNam = MessManTool.changeChar(request.getParameter("ActNam"));//证件姓名
	String mainNo = MessManTool.changeChar(request.getParameter("mainNo"));//签约主号码	
	String signNo = "";
	String optType = MessManTool.changeChar(request.getParameter("optType"));//reg--签约 deReg--解约
	
	String signType = MessManTool.changeChar(request.getParameter("signType"));  //1-主号签约 2-副号签约
	String signFlg = MessManTool.changeChar(request.getParameter("signFlg"));      //签约标记 主号0  副号1
	
	String IdTypeName = MessManTool.changeChar(request.getParameter("IdTypeName"));//证件类型
	
	
	String dynamicCode="";
	String dynamicCodeSeq="";
	String sendPass = "";
	
	if(loginType.equals("0")){
	//动态密码方面
		sendPass=MessManTool.changeChar(request.getParameter("sendPass"));//1--需要 0--不需要;
		if(sendPass.equals("1")||sendPass.equals("2")){
			dynamicCode=request.getParameter("dynamicCode");
			dynamicCodeSeq=request.getParameter("dynamicCodeSeq");
		}
		
	}
	
	if(signType.equals("1")){
		signNo=mainNo;
	}
	else if(signType.equals("2")){
		signNo=MessManTool.changeChar(request.getParameter("signNo"));//签约副号码	
	}
	
	log.Write("loginType="+loginType+"|signType="+signType+"|signFlg="+signFlg+"|dynamicCode="+dynamicCode+"|dynamicCodeSeq="+dynamicCodeSeq);
	
	
	
    String cssFileName = request.getParameter("cssFileName");//获取客户当前使用的CSS样式
	if(cssFileName ==null){
		cssFileName = "skin.css";
	}		
		
%>

<!-------------------------------------------------------------------
                          标准JavaScript库引用
--------------------------------------------------------------------->
<script language="JavaScript" src="/personbank/HttpProxy?URL=/midserv/js/public.js&dse_sessionId=<%=dse_sessionId%>"></script>
<script language="JavaScript" src="/personbank/HttpProxy?URL=/midserv/js/public_card.js&dse_sessionId=<%=dse_sessionId%>"></script>

<!--------------------------------------------------------------------
   当前页面JavaScript函数部分，包括提交验证，页面动作，具体目标等代码
---------------------------------------------------------------------->

<!--------------------------------------------------------------------
                          页面HTML表现部分    
---------------------------------------------------------------------->

<html>
	<head>
		<title>交通银行网上服务</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		
		<script type="text/javascript">
			var clickBoolean=true;
			function tj1(){
				if(clickBoolean){
					document.safeInput1.commit("safeCommit1");
		    	document.safeCommit1.submit("f1"); 
		    	clickBoolean=false;
				}
					
			}
			function tj2(){
			if(clickBoolean){
				clickBoolean=false;
				Window.location="/personbank/HttpProxy?dse_sessionId=<%=dse_sessionId %>&URL=/midserv/midSelect.jsp";
			}
		}
		</script>
		<link rel="stylesheet" type="text/css" href="/personbank/css/<%=cssFileName%>">
		<script language="JavaScript"	src="/personbank/HttpProxy?URL=/midserv/js/common.js&dse_sessionId=<%=dse_sessionId%>"></script>
	</head>
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
		<center>
			<div class="indent">
				<script language=JavaScript src="/personbank/js/writeNewActivxObjectForProxy.js"></script>
				<table width="100%" align="center" cellpadding="1" cellspacing="1" class="tab">
					<tr align="left"> 
						<td class="tab_title">签 约 信 息 确 认</td>
					</tr>
				<script language=JavaScript> writeNewCommitActivxObject('/personbank')</script>	
				<FORM action="/personbank/HttpProxy" method=post name="f1">
					<input type="hidden" name="dse_sessionId"	value="<%=dse_sessionId%>">
					<input type="hidden" name="URL" value="/midserv/yiDongCharge4.jsp">
					<input type="hidden" name=biz_id value="<%=biz_id %>">
					<input type="hidden" name=step_id value="1">
					<input type="hidden" name="bocomPwd"/>
					<input type="hidden" name="signType"	value="<%=signType%>">
					<input type="hidden" name="signFlg"	value="<%=signFlg%>">
					<%if(loginType.equals("0")){ %>
					<input type="hidden" name="dynamicCode" value="<%=dynamicCode%>">
					<input type="hidden" name="dynamicCodeSeq" value="<%=dynamicCodeSeq%>">
					<%} %>
					
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
								证件类型:
							</td>
							<td width="50%" align="left" height="22" class="InputTip">
								<input type="hidden" name="IdTyp" value="<%=IdTyp%>"  readonly="readonly">
								<%=IdTypeName%>
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
								<input type="text" name="mainNo" value="<%=mainNo%>"  readonly="readonly">
							</td>
						</tr>
						<tr class="tab_tr">
							<td width="50%" align="right" height="22" class="InputTip">
								签约号码：
							</td>
							<td width="50%" align="left" height="22" class="InputTip">
								<input type="text" name="signNo" value="<%=signNo%>"  readonly="readonly">
						    </td>
						</tr>
				
						
						<tr class="tab_tr">
							<td align="right" height="22" class="InputTip">
								交易密码:
							</td>
							<!--td align="left" height="22" class="InputTip"><SCRIPT language=JavaScript> writePwdActivxObjectLenClass('safeInput1','safeInput1','','password',6,6,'20','153','/ZomnYmq1MnNjizoVo2E7bjgVAr2ePAWzY4s6FaNhO34UlGH/zfcB/2aJp2JqtTJWxCKiMnQswZhMfJzDfHD8w==')</SCRIPT-->
							<td class="InputTip"><SCRIPT language=JavaScript> writeNewPwdActivxObjectLenClass ('safeInput1','safeInput1','/personbank/','bocomPwd',20,6,'20','153','<%=dse_sessionId%>')</SCRIPT></td>  
							</td>
						</tr>
						
						<%if(loginType.equals("0")){ %>
						<tr class="tab_tr">
							<td align="right" height="22" class="InputTip">
								动态密码:
							</td>
							<td align="left" height="22" class="InputTip">
								<input type="text" name="dynamicCodeMan" size="6" maxlength="6" onkeypress="onlyMunNoPointer();">								
								<!--input type="text" name="dynamicCodeMan" value="<%=dynamicCode%>"-->								
							</td>
						</tr>
						<tr class="tab_tr">
							<td align="right" height="22" class="InputTip">
								密码序号:
							</td>
							<td align="left" height="22" class="InputTip">
								<input type="text" name="dynamicCodeSeqMan" value="<%=dynamicCodeSeq%>"  readonly="readonly">
							</td>
						</tr>
						
						<%} %>
					
					<tr class="tab_result">
						<td align="center" colspan="3">
							<input type="button" onclick="tj1();" value="确 定" class="button_bg">
							<input type="button" onclick="window.history.back();" value="返 回"	class="button_bg">
							<input type="button" onclick="tj2();" value="放弃" class="button_bg">
						</td>
					</tr>
				
					</table>
				</FORM>
				
			</DIV>
		</center>
	</body>
</html>
