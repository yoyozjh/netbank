<%@ page language="java" pageEncoding="gbk"%>
<%@ page import="com.bocom.midserv.gz.*"%>
<%@ page import="com.viatt.bean.*"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%
			String dse_sessionId = MessManTool.changeChar(request
			.getParameter("dse_sessionId"));//获取dse_sessionId
%>
<html>
	<script language="JavaScript"
		src="/personbank/HttpProxy?URL=/midserv/js/public.js&dse_sessionId=<%=dse_sessionId%>"></script>
	<script language="JavaScript"
		src="/personbank/HttpProxy?URL=/midserv/js/common.js&dse_sessionId=<%=dse_sessionId%>"></script>

	<head>
		<title>交通银行网上银行</title>
		<link href="/personbank/css/csspt.css" rel="stylesheet"
			type="text/css">
		<link href="/personbank/css/content.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="/personbank/js/public.js"></script>
	</head>

	<body onload="javascript:init()" bgcolor="#FFFFFF" text="#000000"
		leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" oncontextmenu=self.event.returnValue=false onselectstart="return false">
		<FORM action="/personbank/HttpProxy" method=post name="f1">
			<input type="hidden" name="dse_sessionId" value="<%=dse_sessionId%>">
			<input type="hidden" name="URL" value="/midserv/midSelect.jsp">
			<table width="561" border="0" cellspacing="0" cellpadding="0"
				align="center">
				<tr>
					<td width="561">
						<table width="100%" border="0" cellpadding="0" cellspacing="0"
							align="center">
							<tr>
								<td width="7%" align="right">
									<img src="/personbank/images/jiaoyi-fail.gif" width="42"
										height="40" hspace="4">
								</td>
								<td width="93%" height="36" valign="bottom" class="css">
									<strong><font color="#FF3300"> <%=AppParam.getParam(dse_sessionId + "midErr1")%>
									</font> </strong>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<table width="100%" align=center border=0 cellspacing=1
							cellpadding=2 class="bg_gray">
							<tr>
								<td colspan="2" class="table_title_td">
									交易提示
								</td>
							</tr>
							<tr>
								<td width="20%" class="bg_yellow">
									提示信息
								</td>
								<td class="input_content_td">
									<%=AppParam.getParam(dse_sessionId + "midErr2")%>
								</td>
							</tr>
							<tr>
								<td class="tab_result" align="center" colspan="2">
									<p align="center">
										<input type="button" onclick="tj();" value="确定"
											class="button_bg">
									</p>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
	</body>
</html>
<%
	AppParam.deleteParam(dse_sessionId + "midErr1");
	AppParam.deleteParam(dse_sessionId + "midErr2");
%>
