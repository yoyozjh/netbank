<!-------------------------------------------------------------------
                          标准页面服务对象引用
--------------------------------------------------------------------->
<%@ page language="java" contentType="text/html;charset=GBK"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.bocom.midserv.gz.*"%>
<%@ page import="com.bocom.midserv.web.*"%>
<%@ page import="com.viatt.util.*"%>

<%
	MidObjectView midObjectView = new MidObjectView();
	String up_biz_id = request.getParameter("up_biz_id")!=null?request.getParameter("up_biz_id"):"";
	if(up_biz_id.equals("")){
		up_biz_id="0";
	}
	MidSelectUtil midSelectUtil=new MidSelectUtil();
	ResultSet rs = midSelectUtil.getMidViewList(up_biz_id);

	GzLog log = new GzLog("c:/gzLog");
	String dse_sessionId = request.getParameter("dse_sessionId");//获取dse_sessionId
	
	String cdno = request.getParameter("cardNo");
	//System.out.println("卡号："+cdno);
	String loginType = request.getParameter("loginType");
	String remoteIp = request.getParameter("remoteIp");

	String s_step_id = request.getParameter("step_id");

	//测试时将canPass置0，则只有设定的测试卡(canPass==1)可以使用。
	int canPass = 1;
	log.Write("\n=================== begin ==============================");
	log.Write("select:	IP=[" + remoteIp + "] CDNO=[" + cdno
			+ "] loginType=[" + loginType + "] step_id=[" + s_step_id
			+ "]");
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
				<%
					if (loginType.equals("2")) {
						rs.close();
						midObjectView.releaseDBConnection();
						midSelectUtil.releaseDBConnection();
				%>
				普通用户不能使用此业务。
				<%
				} else if (canPass == 1) {
				%>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td
							background="/personbank/HttpProxy?URL=/midserv/images/pageTitle.gif&dse_sessionId=<%=dse_sessionId%>"
							class="pageTitle">
							&nbsp;&nbsp;请 选 择 代 理 业 务 种 类
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
					<input type="hidden" name="URL" value="">
					<input type="hidden" name=biz_id value="">
					<input type="hidden" name="up_biz_id" value="">
					<input type="hidden" name=step_id value="">
					<input type="hidden" name="biz_no" value="">
					
					<table border="0" cellspacing="2" cellpadding="0" align="center"
						width="50%">
						<%
							while (rs.next()) {
								String branch = rs.getString("branch");
								MidSelectUtil midSelectUtil1=new MidSelectUtil();
								int tmp=midSelectUtil1.isShow(cdno,branch);
								if(tmp!=0){
									continue;
								}
								int biz_id = rs.getInt("biz_id");
								String biz_no = rs.getString("biz_no");
								String web_url = rs.getString("web_url").trim();
								String biz_memo = rs.getString("biz_memo");
						%>
						<tr>
							<td width="50%" align="left" height="22" class="InputTip">
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     								&nbsp;&nbsp;&nbsp;
     								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     								&nbsp;&nbsp;&nbsp;&nbsp;
								<A
									onClick="
     this.document.f1.URL.value='<%=web_url %>';
     this.document.f1.biz_id.value='<%=biz_id %>';
     this.document.f1.up_biz_id.value='<%=biz_id %>';
     this.document.f1.step_id.value='1';
     this.document.f1.biz_no.value='<%=biz_no %>';
     this.document.f1.submit();
     return false;"  HREF="">
     							<font color="blue"><%=biz_memo.trim() %></font>
								</A>
							</td>
						</tr>
						<%
							}
							rs.close();
							midObjectView.releaseDBConnection();
							midSelectUtil.releaseDBConnection();
						%>
					</table>
					<br>
				</form>
				<%@ include file="bottom.jsp"%>
				<%
						} else {
						rs.close();
						midObjectView.releaseDBConnection();
						midSelectUtil.releaseDBConnection();
				%>
				系统维护中...
				<%
				}
				%>
			</DIV>
		</center>
	</body>
</html>
