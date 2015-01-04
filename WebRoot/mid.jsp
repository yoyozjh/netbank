<!-------------------------------------------------------------------
                          标准页面服务对象引用
--------------------------------------------------------------------->
<%@ page contentType="text/html;charset=GBK" %>
 
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.bocom.midserv.base.*" %>
<%@ page import="com.bocom.midserv.web.*" %>
<%@ page import="com.bocom.midserv.gz.*" %>
<%@ page import="com.bocom.eb.des.EBDES" %>
<% 
   int i_step_id	= Integer.parseInt(request.getParameter("step_id").trim());
   int i_biz_id		= Integer.parseInt(request.getParameter("biz_id").trim());

   MidObjectView midObjectView =  new MidObjectView();
   if (midObjectView.getMidObjectView(i_biz_id) != true) 
   	System.exit(1);
   
   MidObjectStepView midObjectStepView =  new MidObjectStepView();
   //int maxstep=midObjectStepView.getMaxStepId(i_biz_id);
   
   String dse_sessionId = request.getParameter("dse_sessionId");//获取dse_sessionId
   String loginType = request.getParameter("loginType");
   GzLog log = new GzLog("c:/gzLog");
   log.Write("step1:	loginType=["+loginType+"] 业务：i_biz_id=["+i_biz_id+"]");  
%>

<!-------------------------------------------------------------------
                          标准JavaScript库引用
--------------------------------------------------------------------->
<script language="JavaScript" src="/personbank/HttpProxy?URL=/midserv/js/public.js&dse_sessionId=<%=dse_sessionId%>"></script>
<script language="JavaScript" src="/personbank/HttpProxy?URL=/midserv/js/public_card.js&dse_sessionId=<%=dse_sessionId%>"></script>

<!--------------------------------------------------------------------
   当前页面JavaScript函数部分，包括提交验证，页面动作，具体目标等代码
---------------------------------------------------------------------->
<%
//检测输入
out.print(midObjectView.writeCondition(i_biz_id,i_step_id));
//i_step_id=i_step_id+1;
%>

<!--------------------------------------------------------------------
                          页面HTML表现部分    
---------------------------------------------------------------------->
<html>
<head>
<title>交通银行网上服务</title>
<script language="JavaScript" type="text/JavaScript">
</script>
<link rel="stylesheet" href="/personbank/HttpProxy?URL=/midserv/css/personbank.css&dse_sessionId=<%=dse_sessionId%>">
</head>

<body leftmargin="0" topmargin="0">
<CENTER>
<DIV align=center>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>    	
  	<td background="/personbank/HttpProxy?URL=/midserv/images/pageTitle.gif&dse_sessionId=<%=dse_sessionId%>" class="pageTitle"><%=midObjectView.get_biz_memo().trim()%>（第二步）</td>
  	<td rowspan="2" align="right" valign="top">&nbsp;</td>
  </tr>
  <tr>
  	<td><img src="/personbank/HttpProxy?URL=/midserv/images/xianb.gif&dse_sessionId=<%=dse_sessionId%>" width="100" height="20"></td>
  </tr>
</table>

<FORM action="/personbank/HttpProxy" method=post name="form1" onsubmit="return condition()">
<input type="hidden" name="dse_sessionId" value="<%=dse_sessionId%>">
<%
if(1==2)//loginType.equals("0"))//手机版客户提交sndPass=1表示需校验动态密码
{
%>  
	<input type="hidden" name="URL" value="/midserv/mid.jsp">
<%
}
else
{
%>
	<input type="hidden" name="URL" value="/midserv/midServStep2.jsp">
<%
}
%>
<input type="hidden" name="biz_id" value="<%=midObjectView.get_biz_id()%>">
<input type="hidden" name="biz_no" value="<%=midObjectView.get_biz_no().trim()%>">
<input type="hidden" name="step_id" value="<%=i_step_id+1%>">
<%
if( i_biz_id==2 || i_biz_id==1 )
{
%>
	<input type="hidden" name="send_gate" value="0">
<%
  if(loginType.equals("1"))
  {
%>
    <%--签名增加部分3 BEGIN--%>
    <input type="hidden" name="isVerifySign"	value="1"/>		<%--验签标志,“1”，标识该交易为需要验签交易 其他：不需要验签--%>
    <input type="hidden" name="signKey" 	value="12345678"/>	<%--签名数据关键字段，该笔交易的关键标识，最好是唯一标识，便于加签数据的查询（分行端自己生成）,总行端会保存该关键字段--%>
    <input type="hidden" name="signTranCode"	value="89343"/>		<%--签名字段 分行特色业务交易码(便于加签数据的查询，分行端根据自己实际交易情况提供)，总行端会保存该交易码--%>
    <input type="hidden" name="signData"/>				<%--签名数据--%>
    <%--签名增加部分3 END--%>
<%
  }
}  
%>
<table border="0" cellspacing="2" cellpadding="0" align="center" width="50%" >
<% ResultSet rs = midObjectStepView.getStepViewNotHidByBizIdAndStepId(i_biz_id,i_step_id);
   while (rs.next()) { %>
  <tr>
     <td width="20%" align="center" height="22" class="InputTip"><%=rs.getString("input_lable").trim()%>：</td>
     <td width="30%" align="left" height="22" class="InputTip"><input type="<%=rs.getString("input_type").trim()%>" name="<%=rs.getString("input_name").trim()%>" size="<%=rs.getInt("input_size")%>" value="<%=rs.getString("input_value").trim()%>"></td>
  </tr> 
<%}
rs.close();
midObjectStepView.releaseDBConnection();
%>
</table>
<br>
   <input type="submit" class="IN" name="Submit" value="提交">
   <input type="reset" class="IN" name="Submit2" value="重填">
<br>
<br>
<p>备注：<%=midObjectView.get_biz_detail().trim()%></p>
</FORM>
<%@ include file="bottom.jsp" %>
</DIV></CENTER></BODY></HTML>
