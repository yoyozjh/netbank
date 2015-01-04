<%--
	功能描述：分行特色业务证书用户加签范例
	作者：chenp@bankcomm.com
	创建日期：2006-02-13
--%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="com.bocom.eb.des.EBDES" %>

<%
	String webAppPath = "/personbank/";
	
	String dse_sessionId = request.getParameter("dse_sessionId");//获取dse_sessionId
	String cardNo = request.getParameter("cardNo");//获取交易卡号
	String passWord = request.getParameter("passWord");//加密密码
	if(passWord != null)
	{
		passWord = EBDES.decryptoDES(passWord, dse_sessionId);//解密后密码
	}
	String remoteIp = request.getParameter("remoteIp");//获取客户断IP
	
	//签名增加部分0 BEGIN
	String loginType = request.getParameter("loginType");//传送登陆类别 0－注册用户(手机版) 1－证书用户 2－大众用户
	String logonUserDn = request.getParameter("logonUserDn");//获取登陆证书DN
	//签名增加部分0 END
%>

<!--------------------------------------------------------------------
                          页面HTML表现部分    
---------------------------------------------------------------------->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>交通银行个人网上银行</title>
<%--签名增加部分1 BEGIN--%>
<script language=JavaScript src="<%=webAppPath%>js/public.js"></script><%--引用总行端公用JS，不需要引用HttpProxy--%>
<script language=JavaScript> writeSignActivxObject('<%=webAppPath%>')</script>
<%--签名增加部分1 END--%>
<script language=JavaScript>
var clickBoolean = true;	//防止两次提交
function beforeSubmit()
{
	var cardNo = '<%=cardNo%>';
	var loginType = '<%=loginType%>';
	var mobPhone = document.form1.mobPhone.value;
	var dealBal = document.form1.dealBal.value;
	var remoteIp = '<%=remoteIp%>';
	<%-- 拼接需要加签数据，规则如下所示 --%>
	var signData = 'cardNo=' + cardNo + '|dealBal=' + dealBal + '|mobPhone=' + mobPhone + '|remoteIp=' + remoteIp;
	<%-- 签名增加部分2 BEGIN --%>
	alert( signData );
	InfoSecNetSign1.NSServerMode = 0;
	alert( InfoSecNetSign1.NSServerMode );
	InfoSecNetSign1.NSSetPlainText(signData);
	alert( "22" );
	document.form2.signData.value = InfoSecNetSign1.NSAttachedSign('<%=logonUserDn%>');
	alert( document.form2.signData.value );
	if (!form2.signData.value)
	{
		alert("签名操作取消！");
		return;
	}
	if(clickBoolean)//防止form两次提交，注意在触发交易事件中，用onClick事件触发交易，不要用href链接触发
	{
		alert( "33" );
		form2.submit();
		clickBoolean = false;
	}
	<%-- 签名增加部分2 END --%>
}
</script>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"> 
<form name="form1">
	手机充值<br><br>
	手机号码：<input name="mobPhone" type="text" maxlength="20"><br>
	交易金额：<input name="dealBal" type="text" maxlength="20"><br>
</form>

<input type="button" onclick="javascript:beforeSubmit();" value="submit" style={cursor:hand;}>

<form name="form2" method="post" action="/personbank/HttpProxy">
	<input type="hidden" name="URL" 			value="/servlet/TransServlet"/>
	<input type="hidden" name="dse_sessionId" 	value="<%=dse_sessionId%>"/>
	<%--签名增加部分3 BEGIN--%>
	<input type="hidden" name="isVerifySign"	value="1"/>			<%--验签标志,“1”，标识该交易为需要验签交易 其他：不需要验签--%>
	<input type="hidden" name="signKey" 		value="12345678"/>	<%--签名数据关键字段，该笔交易的关键标识，最好是唯一标识，便于加签数据的查询（分行端自己生成）,总行端会保存该关键字段--%>
	<input type="hidden" name="signTranCode"	value="89343"/>		<%--签名字段 分行特色业务交易码(便于加签数据的查询，分行端根据自己实际交易情况提供)，总行端会保存该交易码--%>
	<input type="hidden" name="signData"/>							<%--签名数据--%>
	<%--签名增加部分3 END--%>
</form> 

</body>
</html>