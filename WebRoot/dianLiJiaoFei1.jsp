<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@ page import="com.bocom.midserv.gz.*"%>
<%@ page import="com.viatt.bean.*"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="com.bocom.midserv.base.*" %>
<%@ page import="com.bocom.midserv.web.*" %>
<%@ page import="com.bocom.midserv.gz.*" %>
<%@ page import="com.bocom.eb.des.EBDES" %>
<%


	String biz_step_id="1";  //临时这么写


    String cdno = request.getParameter("cardNo");

	GzLog log = new GzLog("c:/gzLog");
	log.Write("==============这里是 电力缴费的第一个界面========begin========================");
	String dse_sessionId = MessManTool.changeChar(request.getParameter("dse_sessionId"));//获取dse_sessionId
	String biz_id = MessManTool.changeChar(request.getParameter("biz_id")); //我想问这个是从哪里得到的？？？？？？？？
	if (biz_id.equals("") ) {
		System.out.println("传入参数不正确");
	}
	log.Write("#########电力缴费==========step1:	输入编号查询业务：i_biz_id=["+biz_id+"]"+"卡号CDNO=["+cdno+"]================##############");  
	//经过测试，上面的卡号和biz_id都能正确无误接收到！
%>
	

<script language="JavaScript"
	src="/personbank/HttpProxy?URL=/midserv/js/public.js&dse_sessionId=<%=dse_sessionId%>"></script>
<script language="JavaScript"
	src="/personbank/HttpProxy?URL=/midserv/js/common.js&dse_sessionId=<%=dse_sessionId%>"></script>
<script language="JavaScript"
	src="/personbank/HttpProxy?URL=/midserv/js/date.js&dse_sessionId=<%=dse_sessionId%>"></script>

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
		<link href="/personbank/css/content.css" rel="stylesheet"
			type="text/css">
		
		<script language="JavaScript" type="text/JavaScript">
		
			var clickBoolean;
			clickBoolean = false;		
			function beforeSubmit(){
				alert(document.form1.TCusId.value);
				alert(document.form1.LChkTm.value);
				//对于输入日期的一种判断和提示：
				if (document.form1.LChkTm.value.length!=6 && document.form1.LChkTm.value.length!=1){
					alert("如果想查询特定年月的电费，请输入六位号码，前4位为年份，后2位为月份。 如果想查询所有月份的记录，输入任意1位数字即可。");
					return false;
				}
				//如果输入的是6位数字，则按照规定，需要在最后不上两位9
				else if(document.form1.LChkTm.value.length==6){
					document.form1.LChkTm.value =  document.form1.LChkTm.value+"99";
					alert(document.form1.LChkTm.value);
					return true
				}
				//如果输入的是1位数字，说明需要查询所有月份的账单。将值赋值成“99999999”
				else if(document.form1.LChkTm.value.length==1){
					document.form1.LChkTm.value="99999999";
					alert("查询所有月份的话"+document.form1.LChkTm.value);
					return true
				}	
				return false;
			}
	
			function tiJiao(){
				clickBoolean = beforeSubmit();
				if(clickBoolean)
				  {
					clickBoolean = false;
					tj();
				    //window.location="/personbank/HttpProxy?dse_sessionId=<%=dse_sessionId %>&URL=/midserv/dianLiJiaoFei2.jsp&biz_id=<%=biz_id%>";
				    
				  }
				
			}	
		</script>			
	</head>
	
	<body leftmargin="0" topmargin="0">
	<DIV align=center>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td
					background="/personbank/HttpProxy?URL=/midserv/images/pageTitle.gif&dse_sessionId=<%=dse_sessionId%>"
					class="pageTitle">
					&nbsp;&nbsp;电费查询
				</td>
			</tr>
			<tr>
				<td>
					<img src="/personbank/HttpProxy?URL=/midserv/images/xianb.gif&dse_sessionId=<%=dse_sessionId%>"
						 width="100" height="20">
				</td>
			</tr>
		</table>
	

		<FORM action="/personbank/HttpProxy" method=post name="form1">
			<input type="hidden" name="URL" value="/midserv/dianLiJiaoFei2.jsp">
			<input type="hidden" name="dse_sessionId" value="<%=dse_sessionId%>">
			<input type="hidden" name=biz_id value="<%=biz_id%>">
			<input type="hidden" name=step_id value="1">	
			<input type="hidden" name="CDNO" value="<%=cdno%>">	
			
			
			<table border="0" cellspacing="2" cellpadding="0" align="center" width="78%">
				<tr>
					<td width="50%" align="right" height="22" class="InputTip">客户编号:</td>
					<td width="50%" align="left" height="22" class="InputTip">
						<input type="text" name="TCusId" size="20" value="" maxlength="21">
					</td>
				</tr>
				<tr>
					<td width="50%" align="right" height="22" class="InputTip">	电费月号:</td>
					<td width="50%" align="left" height="22" class="InputTip">
						<input type="text" name="LChkTm" size = "20" value ="" maxlength="8">
					</td>
				</tr>	
			</table>
			<br>

		  	<input type="button" onclick="tiJiao();" value="查询" style={cursor:hand;}>
			<input type="reset" class="IN" name="Submit2" value="重填">
			<input type="button" class="IN" name="Submit3" value="返回" onclick="javascript:history.back()" > 	
		<br>
		<br>
		</FORM>	
	</div>
	</body>	
</html>	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	