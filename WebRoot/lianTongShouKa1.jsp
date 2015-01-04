<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@ page import="com.bocom.midserv.gz.*"%>
<%@ page import="com.viatt.bean.*"%>
<%@ page import="com.viatt.util.*"%>
<%
	GzLog log = new GzLog("c:/gzLog");
	String loginType = MessManTool.changeChar(request.getParameter("loginType"));
	String dse_sessionId = MessManTool.changeChar(request.getParameter("dse_sessionId"));//获取dse_sessionId
	String biz_id = MessManTool.changeChar(request.getParameter("biz_id"));
	if (biz_id.equals("") ) {
		System.out.println("传入参数不正确");
	}
	List list = new ArrayList();
	String tmp="";
	String cdno = MessManTool.changeChar(request.getParameter("cardNo"));
	String content = "biz_id," + biz_id + "|i_biz_step_id,1|biz_no,00"+biz_id+"|";
	MidServer midServer = new MidServer();
	BwResult bwResult = midServer.sendMessage(content);
	if (bwResult == null || bwResult.getCode() == null
	|| !bwResult.getCode().equals("000")) {
			
	 }
	tmp = bwResult.getContext();
	MessManTool messManTool = new MessManTool();
	list = messManTool.lianTongShouKa1(tmp);
	int total = list.size();
	String currPage1 = request.getParameter("page") != null ? request
			.getParameter("page") : "1";
	int currPage = Integer.parseInt(currPage1);
	PageTools pageTools = new PageTools();
	pageTools.setPageSize(12);
	pageTools.setCurrPage(currPage);
	pageTools.setTotal(total);
	pageTools.setUrl("/personbank/HttpProxy?dse_sessionId="+dse_sessionId+"&URL=/midserv/yinLvTong2.jsp&biz_id="+biz_id);
	int pageSize = pageTools.getPageSize();
	String pagegetRoll = pageTools.pagegetRoll();
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
	<head>
		<title>交通银行网上服务</title>
		<link rel="stylesheet"
			href="/personbank/HttpProxy?URL=/midserv/css/personbank.css&dse_sessionId=<%=dse_sessionId%>">
		<link rel="stylesheet"
			href="/personbank/HttpProxy?URL=/midserv/css/midserv.css&dse_sessionId=<%=dse_sessionId%>">
		<link href="/personbank/css/csspt.css" rel="stylesheet"
			type="text/css">
		<link href="/personbank/css/content.css" rel="stylesheet" type="text/css">
		<script type="text/javascript">
			var clickBoolean=true;
			function tj1(){
				if(clickBoolean){
					var input=document.forms[0].getElementsByTagName("input");
					var bn=false;
					for(var i=0;i<input.length;i++){
						var type=input[i].getAttribute("type");
						var BusNam=input[i].getAttribute("BusNam");
						if(type=='radio'){
							bn=input[i].checked;
							if(bn){
								document.getElementById("BusNam").value=BusNam;
								break;
							}
						}
					}
					if(bn){
						clickBoolean=false;
						tj();
					}else{
						alert("请先选择需要购买的卡!");
					}
				}
			}
		</script>
	</head>
	

	<body leftmargin="0" topmargin="0" >
		<center>
			<DIV align=center>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td
							background="/personbank/HttpProxy?URL=/midserv/images/pageTitle.gif&dse_sessionId=<%=dse_sessionId%>"
							class="pageTitle">
							&nbsp;&nbsp;联 通 售 卡
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
					<input type="hidden" name="URL" value="/midserv/lianTongShouKa2.jsp">
					<input type="hidden" name=biz_id value="<%=biz_id %>">
					<input type="hidden" name=step_id value="1">
					<input type="hidden" name=BusNam value="">
					<input type="hidden" name="sendPass" value="<%=loginType.endsWith("0")?"1":"0" %>">
					<table border="0" cellspacing="2" cellpadding="0" align="center"
						width="65%">
						<tr onclick="selectrow(this);" style="cursor:hand;" >
							<td align="center" height="22"  class="TableRow2">
								选择
							</td>
							<td align="left" height="22"  class="TableRow2">
								卡类型
							</td>
						</tr>
						<%
						
						
						for (int i = 0; i < total; i++) {
							if ((i >= (currPage - 1) * pageSize)&& (i < currPage * pageSize)) {
								HashMap map = (HashMap) list.get(i);
						%>
						<tr onclick="selectrow(this);" style="cursor:hand;" >
							<td align="center" height="22"  class="<%=(i+1)%2==1?"TableRow1":"TableRow2" %>">
								<input type="radio" value="<%=map.get("param3") %>" 
									BusNam="<%=map.get("param2")%>" 
									name="TxnAmt" >
							</td>
							<td align="left" height="22"  class="<%=(i+1)%2==1?"TableRow1":"TableRow2" %>">
								<%=map.get("param2")%>
							</td>
						</tr>
						<%
								}
							}
						%>
						<tr>
							<td align="left" height="11" class="InputTip" colspan="6">
								&nbsp;
							</td>
						</tr>
						<tr>
							<td align="left" height="22" class="InputTip" colspan="6">
								<%=pagegetRoll %>
							</td>
						</tr>
					</table>
				</FORM>
				<table>
					<tr>
						<td>
							<input type="button" onclick="tj1();" value="确 定" class="button_bg">
						</td>
					</tr>
				</table>
			</DIV>
		</center>
	</body>
</html>
