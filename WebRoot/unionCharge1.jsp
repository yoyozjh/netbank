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
    String cdno = request.getParameter("cardNo");
	String tradeName = "广东省联通充值";
	GzLog log = new GzLog("c:/gzLog");
	log.Write("=============="+tradeName+"========begin========================");
	String dse_sessionId = MessManTool.changeChar(request.getParameter("dse_sessionId"));//获取dse_sessionId
	String biz_id = MessManTool.changeChar(request.getParameter("biz_id")); //我想问这个是从哪里得到的？？？？？？？？
	if (biz_id.equals("") ) {
		System.out.println("传入参数不正确");
	}
	log.Write("=============="+tradeName+"========step1:输入编号查询业务：i_biz_id=["+biz_id+"]"+"卡号CDNO=["+cdno+"]================");  
	//经过测试，上面的卡号和biz_id都能正确无误接收到！

%>
<html>

	<head>
		<title>交通银行网上服务</title>
		<!-- 总行CSS文件 -->
		<link href="/personbank/css/csspt.css" rel="stylesheet"
			type="text/css">
		<link href="/personbank/css/content.css" rel="stylesheet"
			type="text/css">
		<!-- 分行CSS文件 -->
		<link rel="stylesheet"
			href="/personbank/HttpProxy?URL=/midserv/css/personbank.css&dse_sessionId=<%=dse_sessionId%>">
		<!-- link rel="stylesheet"
			href="/personbank/HttpProxy?URL=/midserv/css/midserv.css&dse_sessionId=<%=dse_sessionId%>"-->
		<!-- 表单项合法性判断与字符转换函数 -->
        <script language="JavaScript"
            src="/personbank/HttpProxy?URL=/midserv/js/public.js&dse_sessionId=<%=dse_sessionId%>"></script>
		<!-- 表单项合法性判断 -->
        <script language="JavaScript"
            src="/personbank/HttpProxy?URL=/midserv/js/common.js&dse_sessionId=<%=dse_sessionId%>"></script>
		<!-- 日历输入控件 -->
        <script language="JavaScript"
            src="/personbank/HttpProxy?URL=/midserv/js/date.js&dse_sessionId=<%=dse_sessionId%>"></script>
		
		<script language="JavaScript" type="text/JavaScript">
		
			var doubleClick = false;
			var dateCheck = false;
			function beforeSubmit(){
				//alert(document.form1.TCusId.value);
				//alert(document.form1.LChkTm.value);
				//对于输入日期的一种判断和提示：
				if (PhoneCheck(document.form1.TelNum.value)){
					dateCheck = true;
				}else{
					alert("手机号输入不合法!");
					dateCheck = false;
				}
				return dateCheck;
			}
	
			function tiJiao(){
				//避免重复提交
				if(beforeSubmit()&&!clickBoolean){
					clickBoolean = true;
					tj();
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
					&nbsp;&nbsp;<%=tradeName %>
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
			<input type="hidden" name="URL" value="/midserv/unionCharge2.jsp">
			<input type="hidden" name="dse_sessionId" value="<%=dse_sessionId%>">
			<input type="hidden" name=biz_id value="<%=biz_id%>">
			<input type="hidden" name=cdno value="<%=cdno%>">
			<input type="hidden" name=step_id value="1">
			
			<table border="0" cellspacing="2" cellpadding="0" align="center" width="78%">
				<tr>
					<td width="50%" align="right" height="22" class="InputTip">充值号码:</td>
					<td width="50%" align="left" height="22" class="InputTip">
						<input type="text" name="TelNum" size="20" value="" maxlength="21">
					</td>
				</tr>
			</table>
			<br>

		  	<input type="button" onclick="tiJiao();" value="确定" style={cursor:hand;}>
			<input type="reset" class="IN" name="Submit2" value="重填">
			<input type="button" class="IN" name="Submit3" value="返回" onclick="javascript:history.back()" > 	
		<br>
		<br>
		</FORM>
	</div>
	</body>
</html>