<!-------------------------------------------------------------------
                          标准页面服务对象引用
-------------------------------------------------------------------->
<%@ page language="java" contentType="text/html;charset=GBK" %>

<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.bocom.midserv.base.*" %>
<%@ page import="com.bocom.midserv.web.*" %>
<%@ page import="com.bocom.eb.des.EBDES" %>

<% 
   int		i_step_id	= Integer.parseInt(request.getParameter("step_id").trim());
   int		i_biz_id	= Integer.parseInt(request.getParameter("biz_id").trim());
   String	s_biz_no	= request.getParameter("biz_no").trim();

out.print("hahaha");
   MidObjectView midObjectView =  new MidObjectView();
   if (midObjectView.getMidObjectView(i_biz_id) != true) 
   	System.exit(1);

   MidObjectCtl midObjectCtl = new MidObjectCtl();
   //midObjectCtl.preInvokeNotXML(i_biz_id,i_step_id);
   
   midObjectCtl.preInvokeNotXML(request,i_biz_id,i_step_id-1);
   //请在设立配置分行网关的地址（字符型）和监听端口（整型）
   midObjectCtl.invokeConnectNotXML("182.84.2.67",3555);
   midObjectCtl.postInvokeNotXML();
   
   MidObjectStepView midObjectStepView =  new MidObjectStepView();
   
   int i_max_step_id = midObjectStepView.getMaxStepId(i_biz_id);
   i_max_step_id = i_max_step_id + 2;
   
   //String dse_sessionId = request.getParameter("dse_sessionId");//获取dse_sessionId

  String cssFileName = request.getParameter("cssFileName");//获取客户当前使用的CSS样式
	if(cssFileName ==null){
		cssFileName = "skin.css";
	}		

%>

<!-------------------------------------------------------------------
                          标准JavaScript库引用
--------------------------------------------------------------------->
<script language="JavaScript" src="/midserv/js/public.js"></script>
<script language="JavaScript" src="/midserv/js/public_card.js"></script>

<!--------------------------------------------------------------------
   当前页面JavaScript函数部分，包括提交验证，页面动作，具体目标等代码
---------------------------------------------------------------------->
<%
//检测输入

out.print(midObjectView.writeCondition(i_biz_id,i_step_id));
//i_step_id=i_step_id+1;

%>
<SCRIPT LANGUAGE=javascript>
function go(){
	location.replace="/midserv/t_midSelect.jsp";
}
</script>

<!--------------------------------------------------------------------
                          页面HTML表现部分    
---------------------------------------------------------------------->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>交通银行网上服务</title>
<script language="JavaScript" type="text/JavaScript">
</script>
<link rel="stylesheet" type="text/css" href="/personbank/css/<%=cssFileName%>">
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<center>
<div class="indent">
<table width="100%" align="center" cellpadding="1" cellspacing="1" class="tab">
  <tr align="left">    	
  	<td class="tab_title"><%=midObjectView.get_biz_memo().trim()%></td>
  </tr>

<FORM action="/midserv/t_midServStep2.jsp" method=post name="form1"  onsubmit="return condition()">
<input type="hidden" name="biz_id" value="<%=midObjectView.get_biz_id()%>">
<input type="hidden" name="biz_no" value="<%=midObjectView.get_biz_no().trim()%>">
<input type="hidden" name="step_id" value="<%=i_step_id+1%>">
<%
if(midObjectCtl.get_hidden_input_buff()!=null){
%>
    <%=midObjectCtl.get_hidden_input_buff()%>     
<%
}
%>

<tr class="tab_tr">
  <td><%=midObjectCtl.get_display_buff()%></td>
</tr>

<% if ( midObjectCtl.get_mgid_value().equals("AAAAAAA") ) {//正常处理%>

<% ResultSet rs = midObjectStepView.getStepViewNotHidByBizIdAndStepId(i_biz_id,i_step_id);
   while (rs.next()){
	if ( midObjectCtl.checkHidden(rs.getString("input_name").trim()) != true ) {
%>
  <tr class="tab_tr">
     <td width="20%" align="center" height="22" class="InputTip"><%=rs.getString("input_lable").trim()%>：</td>
     <td width="30%" align="left" height="22" class="InputTip"><input type="<%=rs.getString("input_type").trim()%>" name="<%=rs.getString("input_name").trim()%>" size="<%=rs.getInt("input_size")%>"  value="<%=rs.getString("input_value").trim()%>"></td>
  </tr> 
<%	} else { 
		if ( rs.getString("input_name").trim().equals("CDNO") || rs.getString("input_name").trim().equals("PSWD") ) {
		// do nothing for CDNO and PSWD
		} else {
%>	
		<input type="hidden" name="<%=rs.getString("input_name").trim()%>" size="<%=rs.getInt("input_size")%>">  
<%		}
	}
}
rs.close();
midObjectStepView.releaseDBConnection();
%>
<% i_step_id=i_step_id+1;
   if ( i_step_id  == i_max_step_id) { %>
   <br>
		<a href="t_midSelect.jsp" target=_self> <font color="#003366">返回首页</font> </a>
	<br>
<%} else { %>
<tr class="tab_result">
	<td align="center" colspan="3">
   <input type="submit" class="button_bg" name="Submit" value="提交">
   <input type="reset" class="button_bg" name="Submit2" value="重填">
      <input type="button" class="button_bg" onclick="window.history.back();" value="返 回">
	</td>
</tr>

<% } %>
<% } //非正常的处理%>
</table>

</FORM></DIV></CENTER></BODY></HTML>
