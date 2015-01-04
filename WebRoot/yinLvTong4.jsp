<%@ page language="java"  pageEncoding="gbk"%>
<%@ page import="com.bocom.midserv.gz.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="com.viatt.util.*" %>
<%
	String dse_sessionId = MessManTool.changeChar(request.getParameter("dse_sessionId"));//获取dse_sessionId	
	GzLog log = new GzLog("c:/gzLog");
	String loginType = MessManTool.changeChar(request.getParameter("loginType"));
	String kcrq=MessManTool.changeChar(request.getParameter("kcrq"));
	String jsrq=MessManTool.changeChar(request.getParameter("jsrq"));
	String yxrq=MessManTool.changeChar(request.getParameter("yxrq"));
	String dqrq=DateUtils.FormatDate(new Date(),"yyyyMMdd");
	int yxrq1=0;
	String kcrq3="";
	String jsrq3="";
	String isCheck="yes";
	if(kcrq.equals("")||kcrq.length()!=8){
		isCheck="no";
	}else{
		String tmp1=kcrq.substring(0,4);
		String tmp2=kcrq.substring(4,6);
		String tmp3=kcrq.substring(6,8);
		kcrq=tmp1+"/"+tmp2+"/"+tmp3;
		kcrq3=tmp1+"-"+tmp2+"-"+tmp3;
	}
	if(jsrq.equals("")||jsrq.length()!=8){
		isCheck="no";
	}else{
		String tmp1=jsrq.substring(0,4);
		String tmp2=jsrq.substring(4,6);
		String tmp3=jsrq.substring(6,8);
		jsrq=tmp1+"/"+tmp2+"/"+tmp3;
		jsrq3=tmp1+"-"+tmp2+"-"+tmp3;
	}
	if(yxrq.equals("")){
		isCheck="no";
	}else{
		yxrq1=Integer.parseInt(yxrq);
	}
	if(yxrq1<1){
		isCheck="no";
	}
	String step_id = MessManTool.changeChar(request.getParameter("step_id"));
	
	String biz_id = MessManTool.changeChar(request.getParameter("biz_id"));
	if (biz_id.equals("")) {
		System.out.println("传入参数不正确");
	}
%>

<!-------------------------------------------------------------------
                          标准JavaScript库引用
--------------------------------------------------------------------->
<script language="JavaScript" src="/personbank/HttpProxy?URL=/midserv/js/public.js&dse_sessionId=<%=dse_sessionId%>"></script>
<script language="JavaScript" src="/personbank/HttpProxy?URL=/midserv/js/common.js&dse_sessionId=<%=dse_sessionId%>"></script>
<script language="JavaScript" src="/personbank/HttpProxy?URL=/midserv/js/date.js&dse_sessionId=<%=dse_sessionId%>"></script>

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
			function tj1(){
				var kcrq='<%=kcrq %>';
				var jsrq='<%=jsrq %>';
				var yxrq=<%=yxrq1 %>;
				var isCheck='<%=isCheck%>';
				var input=document.forms[0].getElementsByTagName("input");
				var bn=true;
				for(var i=0;i<input.length;i++){
					var type=input[i].getAttribute("type");
					if(type=='text'||type=='password'){
						if(input[i].value==''||input[i].value==null){
							bn=false;
							break;
						}
					}
				}
				if(bn){
					var tmp0=document.getElementById("gmzs").value;
					var tmp1=document.getElementById("sjhm1").value;
					var tmp2=document.getElementById("sjhm2").value;
					var mprq=document.getElementById("mprq").value;
					if(tmp0<=0){
						alert("购买张数不能小于一张!");
						return;
					}
					if(!isNaN(tmp0)){
						if(tmp1.isMobile()){
							if(tmp1 == tmp2){
								if(isCheck=='yes'){
									var d1 = new Date(mprq.replace(/-/g, "/"));
									var d2 = new Date(kcrq.replace(/-/g, "/"));
									var d3 = new Date(jsrq.replace(/-/g, "/"));
									var d8 = new Date('<%=DateUtils.FormatDate(new Date(),"yyyy/MM/dd")%>');
									var days1 = parseInt(d1.getTime() / (1000 * 60 * 60 * 24));
									var days2 = parseInt(d2.getTime() / (1000 * 60 * 60 * 24));
									var days3 = parseInt(d3.getTime() / (1000 * 60 * 60 * 24));
									var dqrq = parseInt(d8.getTime() / (1000 * 60 * 60 * 24));
									if((days1-days2)<0){
										alert("你选择的日期不在该景点协议期内!");
										return;
									}
									if((days3-days1)<0){
										alert("你选择的日期不在该景点协议期内!");
										return;
									}
									if((days1-dqrq)<0){
										alert("你选择的日期不能小于当天!");
										return;
									}
									var tmp8=days3-days1+1;
									if((yxrq-tmp8) < 0){
										document.getElementById("yxrq").value=yxrq;
									}else{
										document.getElementById("yxrq").value=tmp8;
									}
									tj();;
								}else{
									tj();;
								}
								
							}else{
								alert("二次输入手机号码不一致!");
							}
						}else{
							alert("手机号码格式不对!");
						}	
					}else{
						alert("张数不能为非数字!");
					}
				}else{
					alert("请输入完整信息");
				}
			}
		</script>
	</head>

	<body leftmargin="0" topmargin="0" oncontextmenu=self.event.returnValue=false onselectstart="return false">
		<center>
			<DIV align=center>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td
							background="/personbank/HttpProxy?URL=/midserv/images/pageTitle.gif&dse_sessionId=<%=dse_sessionId%>"
							class="pageTitle">
							&nbsp;&nbsp;请 输 入 相 应 信 息 （所有项均为必输项）
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
				<FORM action="/personbank/HttpProxy" method=post>
					<input type="hidden" name="dse_sessionId"
						value="<%=dse_sessionId%>">
					<input type="hidden" name="URL" value="/midserv/yinLvTong5.jsp">
					<input type="hidden" name=biz_id value="<%=biz_id %>">
					<input type="hidden" name=step_id value="5">
					<input type="hidden" name=yxrq value="">
					<input type="hidden" name=ticketCode value="<%=MessManTool.changeChar(request.getParameter("ticketCode")) %>" >
					<input type="hidden" name=mpj value="<%=MessManTool.changeChar(request.getParameter("mpj")) %>" >
					<input type="hidden" name=sightName value="<%=MessManTool.changeChar(request.getParameter("sightName")) %>">
					<input type="hidden" name=sightCode value="<%=MessManTool.changeChar(request.getParameter("sightCode"))%>">
					<input type="hidden" name=mpms value="<%=MessManTool.changeChar(request.getParameter("mpms")) %>">
					<input type="hidden" name=dzyhj value="<%=MessManTool.changeChar(request.getParameter("dzyhj")) %>">
					<input type="hidden" name=bz value="<%=MessManTool.changeChar(request.getParameter("bz")) %>">
					<input type="hidden" name="sendPass" value="<%=loginType.endsWith("0")?"1":"0" %>">
					<table border="0" cellspacing="2" cellpadding="0" align="center"
						width="78%">
						<tr>
							<td width="50%" align="right" height="22" class="InputTip">
								购买张数：
							</td>
							<td width="50%" align="left" height="22" class="InputTip">
								<input name="gmzs" value="" onkeypress="onlyMunNoPointer();" maxlength="2">
							</td>
						</tr>
						<tr>
							<td width="50%" align="right" height="22" class="InputTip">
								手机类型：
							</td>
							<td width="50%" align="left" height="22" class="InputTip">
								<select name="sjlx">
									<option value="11">中国移动彩信手机</option>
									<option value="00">非中国移动彩信手机</option>
								</select>
							</td>
						</tr>
						<tr>
							<td width="50%" align="right" height="22" class="InputTip" >
								手机号码：
							</td>
							<td width="50%" align="left" height="22" class="InputTip">
								<input type="text" name="sjhm1" onkeypress="onlyMunNoPointer();" maxlength="11">
							</td>
						</tr>
						<tr>
							<td width="50%" align="right" height="22" class="InputTip">
								手机号码的确定：
							</td>
							<td width="50%" align="left" height="22" class="InputTip">
								<input type="text" name="sjhm2" onkeypress="onlyMunNoPointer();" maxlength="11">
							</td>
						</tr>
						<tr> 
							<td width="50%" align="right" height="22" class="InputTip">
								门票使用日期：
							</td>
							<td width="50%" align="left" height="22" class="InputTip">
								<script type="text/javascript">dateSelector('<%=dqrq %>','mprq');display();</script>
							</td>
						</tr>
						<tr>
							<td  align="center" height="22" class="InputTip" colspan="2">
								<font size="2" color="red">< 门 票 有 效 期 为：<%=yxrq1 %>天。 使 用 日 期 为：<%=kcrq3 %>到<%=jsrq3 %> ></font>
							</td>
						</tr>
					</table>
				</FORM>
				<table>
					<tr>
						<td>
							<input type="button" onclick="tj1();" value="下一步" class="button_bg">
							<input type="button" onclick="window.history.back();" value="返 回" class="button_bg">
						</td>
					</tr>
				</table>
			</DIV>
		</center>
	</body>
</html>
