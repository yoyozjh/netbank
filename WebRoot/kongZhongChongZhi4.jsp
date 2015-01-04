<%@ page language="java"  pageEncoding="gbk"%>
<%@ page import="com.bocom.midserv.gz.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="com.viatt.bean.*"%>
<%@ page import="com.viatt.util.*" %>
<%
	GzLog log = new GzLog("c:/gzLog");
	String loginType = request.getParameter("loginType");//传送登陆类别 0－注册用户(手机版) 1－证书用户 2－大众用户
	String dse_sessionId = MessManTool.changeChar(request.getParameter("dse_sessionId"));//获取dse_sessionId
	String cdno = MessManTool.changeChar(request.getParameter("cardNo"));
	String step_id = MessManTool.changeChar(request.getParameter("step_id"));
	String biz_id = MessManTool.changeChar(request.getParameter("biz_id"));
	String frequence=MessManTool.changeChar(request.getParameter("frequence1"))+"00"+MessManTool.changeChar(request.getParameter("frequence2"));
	String dynamicCode = MessManTool.changeChar(request.getParameter("dynamicCode"));
	AppParam.setParam(dse_sessionId,dynamicCode);
	
	MessManTool messManTool = new MessManTool();
%>

<!-------------------------------------------------------------------
                          标准JavaScript库引用
--------------------------------------------------------------------->
<script language="JavaScript" src="/personbank/HttpProxy?URL=/midserv/js/common.js&dse_sessionId=<%=dse_sessionId%>">
<!--------------------------------------------------------------------
   当前页面JavaScript函数部分，包括提交验证，页面动作，具体目标等代码
---------------------------------------------------------------------->

<!--------------------------------------------------------------------
                          页面HTML表现部分    
---------------------------------------------------------------------->

<html>
	<head>
		<link rel="stylesheet" type="text/css" href="css/csspt.css">   
		<link rel="stylesheet" type="text/css" href="css/public.css">
		<script language="JavaScript" src="/personbank/js/public.js"></script>
		<script language=JavaScript src="/personbank/js/writeActivxObject.js"></script>
		<link rel="stylesheet"
			href="/personbank/HttpProxy?URL=/midserv/css/personbank.css&dse_sessionId=<%=dse_sessionId%>">
		<link rel="stylesheet"
			href="/personbank/HttpProxy?URL=/midserv/css/midserv.css&dse_sessionId=<%=dse_sessionId%>">
		<link href="/personbank/css/csspt.css" rel="stylesheet"
			type="text/css">
		<link href="/personbank/css/public.css" rel="stylesheet"
			type="text/css">
		<link href="/personbank/css/content.css" rel="stylesheet" type="text/css">
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
					window.location="/personbank/HttpProxy?dse_sessionId=<%=dse_sessionId %>&URL=/midserv/midSelect.jsp";
				}
			}
			</script>
	</head>

	<body leftmargin="0" topmargin="0" >
	<SCRIPT language=JavaScript> writeCommitActivxObject('')</SCRIPT>
		<center>
			<DIV align=center>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td
							background="/personbank/HttpProxy?URL=/midserv/images/pageTitle.gif&dse_sessionId=<%=dse_sessionId%>"
							class="pageTitle">
							&nbsp;&nbsp;签 约 信 息 确 认
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
					<input type="hidden" name="URL" value="/midserv/kongZhongChongZhi5.jsp">
					<input type="hidden" name=biz_id value="<%=biz_id %>">
					<input type="hidden" name=step_id value="1">
					<input type="hidden" name="password"/>
					<input type="hidden" name=IDTyp value="<%=MessManTool.changeChar(request.getParameter("IDTyp")) %>">
					<table border="0" cellspacing="2" cellpadding="0" align="center"
						width="78%">
						<tr>
							<td width="50%" align="right" height="22" class="InputTip">
								用户姓名:
							</td>
							<td width="50%" align="left" height="22" class="InputTip">
								<input type="hidden" name=cust_name value="<%=MessManTool.changeChar(request.getParameter("cust_name")) %>">
								<%=MessManTool.changeChar(request.getParameter("cust_name"))%>
							</td>
						</tr>
						<tr>
							<td width="50%" align="right" height="22" class="InputTip">
								用户身份证:
							</td>
							<td width="50%" align="left" height="22" class="InputTip">
								<input type="hidden" name=paper_no value="<%=MessManTool.changeChar(request.getParameter("paper_no")) %>">
								<%=MessManTool.changeChar(request.getParameter("paper_no"))%>
							</td>
						</tr>
						<tr>
							<td width="50%" align="right" height="22" class="InputTip">
								性别:
							</td>
							<td width="50%" align="left" height="22" class="InputTip">
								<input type="hidden" name=sex_code value="<%=request.getParameter("sex_code") %>">
								<%
									String sex_code=MessManTool.changeChar(request.getParameter("sex_code"));
									String sex_code_name="";
									if(sex_code.equals("0")){
										sex_code_name="男";
									}else if(sex_code.equals("1")){
										sex_code_name="女";
									}
								%>
								<%=sex_code_name %>
							</td>
						</tr>
						<tr>
							<td width="50%" align="right" height="22" class="InputTip">
								手机号码:
							</td>
							<td width="50%" align="left" height="22" class="InputTip">
								<input type="hidden" name=mobile_no value="<%=request.getParameter("mobile_no") %>">
								<%=MessManTool.changeChar(request.getParameter("mobile_no")) %>
							</td>
						</tr>
						<tr>
							<td width="50%" align="right" height="22" class="InputTip">
								羊城通卡号:
							</td>
							<td width="50%" align="left" height="22" class="InputTip">
								<input type="hidden" name=card1 value="<%=request.getParameter("card1") %>">
								<%=MessManTool.changeChar(request.getParameter("card1")) %>
							</td>
						</tr>
						<tr>
							<td align="right" height="22" class="InputTip">
								交易密码:
							</td>
							<td align="left" height="22" class="InputTip">
<SCRIPT language=JavaScript> writePwdActivxObjectLenClass('safeInput1','safeInput1','','password',6,6,'20','153','/ZomnYmq1MnNjizoVo2E7bjgVAr2ePAWzY4s6FaNhO34UlGH/zfcB/2aJp2JqtTJWxCKiMnQswZhMfJzDfHD8w==')</SCRIPT>
							</td>
						</tr>
						<%if(loginType.equals("0")){ %>
						<tr>
							<td align="right" height="22" class="InputTip">
								动态密码:<%=dynamicCode%>
							</td>
							<td align="left" height="22" class="InputTip">
								<input type="text" name="dynamicCode" size="6" maxlength="6" onkeypress="onlyMunNoPointer();">
							</td>
						</tr>
						<%} %>
					</table>
				</FORM>
				<table>
					<tr>
						<td>
							<input type="button" onclick="tj1();" value="确 定" class="button_bg">
							<input type="button" onclick="window.history.back();" value="返 回"
								class="button_bg">
							<input type="button" onclick="tj2();" value="放弃" class="button_bg">
						</td>
					</tr>
				</table>
			</DIV>
		</center>
	</body>
</html>
