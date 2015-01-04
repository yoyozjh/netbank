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
	
  String cssFileName = request.getParameter("cssFileName");//获取客户当前使用的CSS样式
	if(cssFileName ==null){
		cssFileName = "skin.css";
	}		
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
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>交通银行网上服务</title>
		<link rel="stylesheet" type="text/css" href="/personbank/css/<%=cssFileName%>">
	</head>
	
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
		<center>
			<div class="indent">
				<table width="100%" align="center" cellpadding="1" cellspacing="1" class="tab">
					<tr align="left"> 
						<td class="tab_title">请 选 择 签 约 类 型</td>
					</tr>
		
					
					
					<form action="/personbank/HttpProxy" method=post name="f1">
					<input type="hidden"   name="dse_sessionId"	value="<%=dse_sessionId%>">
					<input type="hidden"   name="URL"           value="/midserv/yiDongCharge2.jsp">
					<input type="hidden"   name=biz_id          value="<%=biz_id %>">
					<input type="hidden"   name=step_id 		value="2">
					
					
					<tr class="tab_tr">
							<td width="40%" align="right" height="22" class="InputTip">
								签约类型:   
							</td>
							<td width="60%" align="left" height="22" class="InputTip">
									<select name="signType">
										<option value="1">主号签约</option>
										<option value="2">副号签约</option>
									</select>
							</td>
					</tr>
						
						
				
					
					<tr class="tab_result">
						<td align="center" colspan="2">
							<input type="button" onclick="submit();" value="下一步" class="button_bg">
							<input type="button" onclick="window.history.back();" value="返 回"	class="button_bg">
						</td>
					</tr>
					</table>
					
				</form>
				
			</DIV>
		</center>
	</body>
</html>
