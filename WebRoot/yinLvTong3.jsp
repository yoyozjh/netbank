<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@ page import="com.bocom.midserv.gz.*"%>
<%@ page import="com.viatt.bean.*"%>
<%@ page import="com.viatt.util.*"%>
<%
	String sightName = MessManTool.changeChar(request.getParameter("sightName"));
	String sightCode=MessManTool.changeChar(request.getParameter("sightCode"));
	GzLog log = new GzLog("c:/gzLog");
	String dse_sessionId = MessManTool.changeChar(request.getParameter("dse_sessionId"));//获取dse_sessionId
	String step_id = MessManTool.changeChar(request.getParameter("step_id"));
	String actionType = MessManTool.changeChar(request.getParameter("actionType"));
	String biz_id = MessManTool.changeChar(request.getParameter("biz_id"));
	if (biz_id.equals("")||sightCode.equals("")) {
		System.out.println("传入参数不正确");
	}
	List list = new ArrayList();
	//String tmp = "1448|bocom_mid|biz_id,21|biz_no,00021|biz_step_id,4|display_zone,|jingquxingxi,"
	//		+ "2691519        青瓦台套票（平日）                                000000000580000000000003800020080428200912310201、入住青瓦台观景家庭房一间一晚（一张大床一张小床的家庭双人房）2、含岭南奇境龙山景区，千层峰景区及大斑石景点门票各2张，（小孩超过1.4米须交门票款50元）3、赠     "
	//		+ "2691520        青瓦台套票（周末）                                000000000680000000000004200020080428200912310201、入住青瓦台观景家庭房一间一晚（一张大床一张小床的家庭双人房）2、含岭南奇境龙山景区，千层峰景区及大斑石景点门票各2张，（小孩超过1.4米须交门票款50元）3、赠     "
	//		+ "2691521        峰趣楼套票（平日）                                000000000480000000000003300020080428200912310201、入住峰趣楼观景家庭房一间一晚（双床房）2、含岭南奇境龙山景区，千层峰景区及大斑石景点门票各2张，（小孩超过1.4米须交门票款50元）3、赠送早上营养中式早餐2位      "
	//		+ "2691522        峰趣楼套票（周末）                                000000000580000000000003800020080428200912310201、入住峰趣楼观景家庭房一间一晚（双床房）2、含岭南奇境龙山景区，千层峰景区及大斑石景点门票各2张，（小孩超过1.4米须交门票款50元）3、赠送早上营养中式早餐2位      "
	//		+ "2691820        大人套票                                          00000000009000000000000063002008121920091231030六选三成人套票1，包含龙山梦多奇景区（原价65）。2，杨池古村（原价20），黄岩洞（原价10），千层峰（原价30），大斑石（原价15），黑石顶（原价20）等景区任选两个      "
	//		+ "|MGID,000000|";
	String content = "biz_id," + biz_id + "|i_biz_step_id,4|Provider_Code," + sightCode + "|";
	MidServer midServer = new MidServer();
	BwResult bwResult = midServer.sendMessage(content);
	if (bwResult == null || bwResult.getCode() == null|| !bwResult.getCode().equals("000")) {
		
	}
	String tmp = bwResult.getContext();
	MessManTool messManTool = new MessManTool();
	list = messManTool.yinLvTongGetResult2(tmp);
	session.setAttribute("resultList2", list);
	int total = list.size();
	String currPage1 = request.getParameter("page") != null ? request
			.getParameter("page") : "1";
	int currPage = Integer.parseInt(currPage1);
	PageTools pageTools = new PageTools();
	pageTools.setPageSize(12);
	pageTools.setCurrPage(currPage);
	pageTools.setTotal(total);
	pageTools.setUrl("/personbank/HttpProxy?dse_sessionId="
			+ dse_sessionId + "&URL=/midserv/yinLvTong3.jsp&biz_id="
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
				tj();
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
							&nbsp;&nbsp;请 选 择 对 应 的 门 票
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
					<input type="hidden" name="URL" value="/midserv/yinLvTong4.jsp">
					<input type="hidden" name=biz_id value="<%=biz_id %>">
					<input type="hidden" name=step_id value="4">
					<input type="hidden" name=sightName value="<%=sightName%>">
					<input type="hidden" name=sightCode value="<%=sightCode%>">
					<input type="hidden" name=mpms value="">
					<input type="hidden" name=dzyhj value="">
					<input type="hidden" name=mpj value="">
					<input type="hidden" name=kcrq value="">
					<input type="hidden" name=jsrq value="">
					<input type="hidden" name=yxrq value="">
					<input type="hidden" name=bz value="">
					<table border="0" cellspacing="2" cellpadding="0" align="center"
						width="85%">
						<tr onclick="selectrow(this);" style="cursor:hand;">
							<td align="center" height="22" width="8%" class="TableRow2">
								选择
							</td>
							<td align="left" height="22" width="31%" class="TableRow2">
								景区名称
							</td>
							<td align="left" height="22" width="31%" class="TableRow2">
								门票名称
							</td>
							<td align="left" height="22" width="15%" class="TableRow2">
								门票价格
							</td>
							<td align="left" height="22" width="15%" class="TableRow2">
								电子优惠价
							</td>
						</tr>
						<%
							for (int i = 0; i < total; i++) {
								if ((i >= (currPage - 1) * pageSize)
								&& (i < currPage * pageSize)) {
									HashMap map = (HashMap) list.get(i);
									String price1 = MoneyUtils.FormatMoney(Double.parseDouble(((String) map.get("param4")).trim()) / 100, "#,##0.00元");
									String price2 = MoneyUtils.FormatMoney(Double.parseDouble(((String) map.get("param5")).trim()) / 100, "#,##0.00元");
									String price4 = MoneyUtils.FormatMoney(Double.parseDouble(((String) map.get("param4")).trim()) / 100, "###0.00");
									String price3 = MoneyUtils.FormatMoney(Double.parseDouble(((String) map.get("param5")).trim()) / 100, "###0.00");
						%>
						<tr onclick="selectrow(this);" style="cursor:hand;"
							onmouseover="showdiv('bz<%=i%>');"
							onmouseout="hiddendiv('bz<%=i%>');">
							<td align="center" height="22" width="8%"
								class="<%=(i + 1) % 2 == 1 ? "TableRow1"
									: "TableRow2"%>">
								<input type="radio"
									value="<%=((String) map.get("param2")).trim() %>"
									mpms="<%=((String) map.get("param3")).trim() %>"
									dzyhj="<%=price3 %>" 
									mpj="<%=price4 %>"
									kcrq="<%=map.get("param6") %>"
									jsrq="<%=map.get("param7") %>" 
									yxrq="<%=map.get("param8") %>"
									bz="<%=map.get("param9") %>" 
									name="ticketCode">
							</td>
							<td align="left" height="22" width="31%"
								class="<%=(i + 1) % 2 == 1 ? "TableRow1"
									: "TableRow2"%>">
								<%=sightName%>
							</td>
							<td align="left" height="22" width="31%"
								class="<%=(i + 1) % 2 == 1 ? "TableRow1"
									: "TableRow2"%>">
								<%=((String) map.get("param3")).trim()%>
							</td>
							<td align="left" height="22" width="15%"
								class="<%=(i + 1) % 2 == 1 ? "TableRow1"
									: "TableRow2"%>">
								<%=price1%>
							</td>
							<td align="left" height="22" width="15%"
								class="<%=(i + 1) % 2 == 1 ? "TableRow1"
									: "TableRow2"%>">
								<%=price2%>
							</td>
						</tr>
						<tr>
							<td colspan="5">
								<div style="display: none;" id="bz<%=i%>">
									<%=map.get("param9")%>
								</div>
							</td>
						</tr>
					<%
							}
						}
					%>
						<tr>
							<td align="left" height="22" class="InputTip" colspan="5">
								<%=pagegetRoll%>
							</td>
						</tr>
					</table>
				</FORM>
				<table>
					<tr>
						<td>
							<input type="button" onclick="tj1();" value="下一步" class="button_bg">
							<input type="button" onclick="window.history.back();" value="返 回"
								class="button_bg">
							
						</td>
					</tr>
				</table>
			</DIV>
		</center>
	</body>
</html>
