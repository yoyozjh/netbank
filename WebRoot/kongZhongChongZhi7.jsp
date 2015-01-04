<!-------------------------------------------------------------------
                          标准页面服务对象引用
--------------------------------------------------------------------->
<%@ page language="java" contentType="text/html;charset=GBK"%>
<%@ page import="com.bocom.midserv.gz.*"%>
<%@ page import="com.viatt.util.*" %>
<%
	GzLog log = new GzLog("c:/gzLog");
	String dse_sessionId = MessManTool.changeChar(request.getParameter("dse_sessionId"));//获取dse_sessionId
	String biz_id=MessManTool.changeChar(request.getParameter("biz_id"));
	String step_id = MessManTool.changeChar(request.getParameter("step_id"));
%>

<!-------------------------------------------------------------------
                          标准JavaScript库引用
--------------------------------------------------------------------->
<script language="JavaScript" src="/personbank/HttpProxy?URL=/midserv/js/public.js&dse_sessionId=<%=dse_sessionId%>"></script>

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
	</head>

	<body leftmargin="0" topmargin="0" oncontextmenu=self.event.returnValue=false onselectstart="return false">
		<center>
			<DIV align=center>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td
							background="/personbank/HttpProxy?URL=/midserv/images/pageTitle.gif&dse_sessionId=<%=dse_sessionId%>"
							class="pageTitle">
							&nbsp;&nbsp;请 选 择 对 应 的 子 功 能
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
					<input type="hidden" name="URL" value="/midserv/kongZhongChongZhi1.jsp">
					<input type="hidden" name=biz_id value="<%=biz_id %>">
					<input type="hidden" name=step_id value="2">
					<table border="0" cellspacing="2" cellpadding="0" align="center"
						width="50%">
						<tr>
							<td width="50%" align="center" height="22" class="InputTip">
								<A
									onClick="
     this.document.f1.URL.value='/midserv/kongZhongChongZhi1.jsp';
     this.document.f1.biz_id.value=<%=biz_id %>;
     this.document.f1.submit();
     return false;
     "
									HREF=""><font color="blue">签约管理
								</font>
								</A>
							</td>
						</tr>
						<tr>
							<td width="50%" align="center" height="22" class="InputTip">
								<A
									onClick="
	 this.document.f1.URL.value='/midserv/kongZhongChongZhi8.jsp';
     this.document.f1.biz_id.value=<%=biz_id %>;
     this.document.f1.submit();
     return false;
     "
									HREF=""><font color="blue">充值记录查询</font>
								</A>
							</td>
						</tr>
					</table>
				</FORM>
			</DIV>
		</center>
	</body>
</html>
