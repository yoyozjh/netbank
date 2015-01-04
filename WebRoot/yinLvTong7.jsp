<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@ page import="com.bocom.midserv.gz.*"%>
<%@ page import="com.viatt.bean.*"%>
<%@ page import="com.viatt.util.*"%>
<%
	String sightName = MessManTool.changeChar(request.getParameter("sightName"));
	String sightCode=MessManTool.changeChar(request.getParameter("sightCode"));
	GzLog log = new GzLog("c:/gzLog");
	String cdno = MessManTool.changeChar(request.getParameter("cardNo"));
	String dse_sessionId = MessManTool.changeChar(request.getParameter("dse_sessionId"));//获取dse_sessionId
	String step_id = MessManTool.changeChar(request.getParameter("step_id"));
	String actionType = MessManTool.changeChar(request.getParameter("actionType"));
	String biz_id = MessManTool.changeChar(request.getParameter("biz_id"));
	if (biz_id.equals("")||sightCode.equals("")) {
		System.out.println("传入参数不正确");
	}
	List list = new ArrayList();
	String content = "bocom_mid|biz_id,21|biz_step_id,6|CDNO,"+cdno+"|";
	MidServer midServer = new MidServer();
	BwResult bwResult = midServer.sendMessage(content); 
	if (bwResult == null || bwResult.getCode() == null|| !bwResult.getCode().equals("000")) {
		
	}
	String tmp = bwResult.getContext();
	//System.out.println(tmp);
	MessManTool messManTool = new MessManTool();
	list = messManTool.yinLvTongGetResult3(tmp);
	int total = list.size();
	String currPage1 = request.getParameter("page") != null ? request
			.getParameter("page") : "1";
	int currPage = Integer.parseInt(currPage1);
	PageTools pageTools = new PageTools();
	pageTools.setPageSize(20);
	pageTools.setCurrPage(currPage);
	pageTools.setTotal(total);
	pageTools.setUrl("/personbank/HttpProxy?dse_sessionId="
			+ dse_sessionId + "&URL=/midserv/yinLvTong7.jsp&biz_id="
			+ biz_id);
	int pageSize = pageTools.getPageSize();
	String pagegetRoll = pageTools.pagegetRoll();
%>
<!-------------------------------------------------------------------
                          标准JavaScript库引用
--------------------------------------------------------------------->
<script language="JavaScript"
	src="/personbank/HttpProxy?URL=/midserv/js/public.js&dse_sessionId=<%=dse_sessionId%>"></script>
<script language="JavaScript"
	src="/personbank/HttpProxy?URL=/midserv/js/common.js&dse_sessionId=<%=dse_sessionId%>"></script>

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
	</head>

	<script type="text/javascript">
		function tj1(){
			var input=document.forms[0].getElementsByTagName("input");
			var bn=false;
			for(var i=0;i<input.length;i++){
				var type=input[i].getAttribute("type");
				var mpms=input[i].getAttribute("mpms");
				var dzyhj=input[i].getAttribute("dzyhj");
				var kcrq=input[i].getAttribute("kcrq");
				var jsrq=input[i].getAttribute("jsrq");
				var yxrq=input[i].getAttribute("yxrq");
				var bz=input[i].getAttribute("bz");
				var mpj=input[i].getAttribute("mpj");
				if(type=='radio'){
					bn=input[i].checked;
					if(bn){
						document.getElementById("mpms").value=mpms;
						document.getElementById("dzyhj").value=dzyhj;
						document.getElementById("kcrq").value=kcrq;
						document.getElementById("jsrq").value=jsrq;
						document.getElementById("yxrq").value=yxrq;
						document.getElementById("bz").value=bz;
						document.getElementById("mpj").value=mpj;
						break;
					}
				}
			}
			if(bn){
				document.forms[0].submit();
			}else{
				alert("请选择景区!");
			}
		}
		function showdiv(param){
			document.getElementById(param).style.display = "block";
		}
		function hiddendiv(param){
			document.getElementById(param).style.display = "none";
		}
	</script>


	<body leftmargin="0" topmargin="0" oncontextmenu=self.event.returnValue=false onselectstart="return false">
		<center>
			<DIV align=center>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td
							background="/personbank/HttpProxy?URL=/midserv/images/pageTitle.gif&dse_sessionId=<%=dse_sessionId%>"
							class="pageTitle">
							&nbsp;&nbsp;交 易 历 史 
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
						width="92%">
						<tr onclick="selectrow(this);" style="cursor:hand;">
							<td align="left" height="22" class="TableRow2">
								交易类型
							</td>
							<td align="left" height="22"  class="TableRow2">
								景区名称
							</td>
							<td align="left" height="22"  class="TableRow2">
								门票名称
							</td>
							<td align="left" height="22"  class="TableRow2">
								订单编号
							</td>
							<td align="left" height="22"  class="TableRow2">
								手机号码
							</td>
							<td align="left" height="22"  class="TableRow2">
								预订内容
							</td>
							<td align="left" height="22"  class="TableRow2">
								本次收费金额
							</td>
							<td align="left" height="22"  class="TableRow2">
								门票价格
							</td>
							<td align="left" height="22"  class="TableRow2">
								门票数量
							</td>
							<td align="left" height="22"  class="TableRow2">
								交易日期
							</td>
							<td align="left" height="22"  class="TableRow2">
								会计流水
							</td>
							<td align="left" height="22"  class="TableRow2">
								使用日期
							</td>
						</tr>
						<%
							//System.out.println("=1=2="+total);
							for (int i = 0; i < total; i++) {
								if ((i >= (currPage - 1) * pageSize) && (i < currPage * pageSize)) {
									HashMap map = (HashMap) list.get(i);
						%>
						<tr>
							<td align="left" height="22"  class="<%=(i + 1) % 2 == 1 ? "TableRow1" : "TableRow2"%>">
								<%
									String lx=(String)map.get("param2");
									String lxname="";
									if(lx!=null&&lx.trim().equals("090004")){
										lxname="电子门票";
									}else if(lx!=null&&lx.trim().equals("010004")){
										lxname="旅游激费";
									}
								%>
								<%=lxname %>
							</td>
							<td align="left" height="22"  class="<%=(i + 1) % 2 == 1 ? "TableRow1" : "TableRow2"%>">
								<%=map.get("param3")%>
							</td>
							<td align="left" height="22"  class="<%=(i + 1) % 2 == 1 ? "TableRow1" : "TableRow2"%>">
								<%=map.get("param4")%>
							</td>
							<td align="left" height="22"  class="<%=(i + 1) % 2 == 1 ? "TableRow1" : "TableRow2"%>">
								<%=map.get("param5")%>
							</td>
							<td align="left" height="22"  class="<%=(i + 1) % 2 == 1 ? "TableRow1" : "TableRow2"%>">
								<%=map.get("param6")%>
							</td>
							<td align="left" height="22"  class="<%=(i + 1) % 2 == 1 ? "TableRow1" : "TableRow2"%>">
								<%=map.get("param8")%>
							</td>
							<td align="left" height="22"  class="<%=(i + 1) % 2 == 1 ? "TableRow1" : "TableRow2"%>">
								<%
									String param9=(String)map.get("param9");
									
									if(param9==null){
										param9="0.0";
									}else if(param9.trim().equals("")){
										param9="0.0";
									}
									double tmp3=Double.parseDouble(param9);
									if(lx!=null&&lx.trim().equals("090004")){
									}else if(lx!=null&&lx.trim().equals("010004")){
										tmp3=tmp3/100;
									}
									
								%>
								
								<%=tmp3 %>
							</td>
							<td align="left" height="22"  class="<%=(i + 1) % 2 == 1 ? "TableRow1" : "TableRow2"%>">
								<%
									String param10=(String)map.get("param10");
									if(param10==null){
										param10="0.0";
									}else if(param10.trim().equals("")){
										param10="0.0";
									}
									double tmp5=Double.parseDouble(param10);
								%>
								
								<%=tmp5 %>
							</td>
							<td align="left" height="22"  class="<%=(i + 1) % 2 == 1 ? "TableRow1" : "TableRow2"%>">
								
								<%=map.get("param11")%>
							</td>
							<td align="left" height="22"  class="<%=(i + 1) % 2 == 1 ? "TableRow1" : "TableRow2"%>">
							
								<%=map.get("param15")%>
							</td>
							<td align="left" height="22"  class="<%=(i + 1) % 2 == 1 ? "TableRow1" : "TableRow2"%>">
							
								<%=map.get("param14")%>
							</td>
							<td align="left" height="22"  class="<%=(i + 1) % 2 == 1 ? "TableRow1" : "TableRow2"%>">
							
								<%=map.get("param16")%>
							</td>
						</tr>
					<%
							}
						}
					%>
						<tr>
							<td align="left" height="22" class="InputTip" colspan="12">
								<%=pagegetRoll%>
							</td>
						</tr>
					</table>
				</FORM>
				<table>
					<tr>
						<td>
							<input type="button" onclick="tj();" value="返 回"
								class="button_bg">
						</td>
					</tr>
				</table>
			</DIV>
		</center>
	</body>
</html>
