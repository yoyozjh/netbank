<!-------------------------------------------------------------------
                          标准页面服务对象引用
-------------------------------------------------------------------->
<%@ page language="java" contentType="text/html;charset=GBK" %>

<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.bocom.midserv.base.*" %>
<%@ page import="com.bocom.midserv.web.*" %>
<%@ page import="com.bocom.midserv.gz.*" %>
<%@ page import="com.bocom.eb.des.EBDES" %>

<% 
   int		i_step_id	= Integer.parseInt(request.getParameter("step_id").trim());
   int		i_biz_id	= Integer.parseInt(request.getParameter("biz_id").trim());
   String	s_biz_no	= request.getParameter("biz_no").trim();
   String	cardNo			= request.getParameter("cardNo").trim();

   GzLog log = new GzLog("c:/gzLog");
   log.Write("step2:	i_step_id=["+i_step_id+"] i_biz_id=["+i_biz_id+"] s_biz_no=["+s_biz_no+"]");

   MidObjectView midObjectView =  new MidObjectView();
   if (midObjectView.getMidObjectView(i_biz_id) != true) 
   	System.exit(1);
   MidObjectCtl midObjectCtl = new MidObjectCtl();
   //midObjectCtl.preInvokeNotXML(i_biz_id,i_step_id);
   
   midObjectCtl.preInvokeNotXML(request,i_biz_id,i_step_id-1);

   //请在设立配置分行网关的地址（字符型）和监听端口（整型）
   midObjectCtl.invokeConnectNotXML("182.53.15.16",3555);

   midObjectCtl.postInvokeNotXML();
   
   MidObjectStepView midObjectStepView =  new MidObjectStepView();
  
   int i_max_step_id = midObjectStepView.getMaxStepId(i_biz_id);

   i_max_step_id = i_max_step_id + 2;
  
   String dse_sessionId = request.getParameter("dse_sessionId");//获取dse_sessionId

   String passWord = request.getParameter("passWord");
   
   String remoteIp = request.getParameter("remoteIp");
   
   String loginType = request.getParameter("loginType");//传送登陆类别 0－注册用户(手机版) 1－证书用户 2－大众用户
   
   String ltArefldandBusId = "" ;
      
   log.Write("step2: 	 cardNo=[" + cardNo + "] loginType=["+loginType+"]");  

	//if( loginType.equals("1") )	//证书用户
  //{
   	//签名增加部分0 BEGIN
   	//String logonUserDn = request.getParameter("logonUserDn");//获取登陆证书DN
   	//签名增加部分0 END   
   
   	//String isVerifySign = request.getParameter("isVerifySign");
   
   	//log.Write( "获取登陆证书DN:[" + logonUserDn + "]" );
   	//log.Write( "isVerifySign = [" + isVerifySign + "]" );
  //}
   
	//if( loginType.equals("0") )	//注册用户(手机版)
  //{
		String sendPass = request.getParameter("sendPass");
		String dynamicCode = request.getParameter("dynamicCode");
		
		log.Write( "sendPass=["+sendPass+"] 动态密码=["+dynamicCode+"]" ); 
	//}
	
	int stepCount = Integer.parseInt( request.getParameter("stepCount").trim() ) ;
		
	int MarchFlag = 0 ;
	//if ( ( loginType.equals("0") && sendPass==null ) || ( loginType.equals("1") && isVerifySign==null ) )
	//if ( sendPass==null )
	if ( stepCount == 1 )
		MarchFlag = 1 ;
log.Write( "stepCount=["+stepCount+"] MarchFlag=["+MarchFlag+"]" );		
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
<SCRIPT LANGUAGE=javascript>
function go(){
	location.replace="/personbank/HttpProxy?URL=/midserv/midSelect.jsp&dse_sessionId=<%=dse_sessionId%>";
}
</script>

<!--------------------------------------------------------------------
                          页面HTML表现部分    
---------------------------------------------------------------------->

<html>
<head>
<title>交通银行网上服务</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<!--link rel="stylesheet" type="text/css" href="/personbank/HttpProxy?URL=/midserv/css/csspt.css&dse_sessionId=<%=dse_sessionId%>"-->   
<link rel="stylesheet" href="/personbank/HttpProxy?URL=/midserv/css/personbank.css&dse_sessionId=<%=dse_sessionId%>">
<script language="JavaScript" src="/personbank/js/public.js"></script>
<script language=JavaScript src="/personbank/js/writeActivxObject.js"></script>
<script language=JavaScript> writeCommitActivxObject('/personbank/')</script>
<script language="JavaScript" type="text/JavaScript">
<%--签名增加部分1 BEGIN--%>
<script language=JavaScript src="/personbank/js/public.js"></script><%--引用总行端公用JS，不需要引用HttpProxy--%>
<script language=JavaScript> writeSignActivxObject('/personbank/')</script>
<%--签名增加部分1 END--%>

<SCRIPT language=javascript event=onkeydown for=document>   
if( event.keyCode == 13 )
{   
	//alert("13") ;
	return false ;
}   
</SCRIPT> 

<script language=JavaScript>
var clickBoolean = true;
var biz_id = <%=i_biz_id%>
function beforeSubmit0()
{
  if(clickBoolean)
  {	
    form1.submit();
    clickBoolean = false;
  }
}
function beforeSubmit1()
{
/*
	if(document.safeInput1.isValid())
 	{
		alert("密码不合法，请输入合法的密码");		
		return false;
 	}

 	if(document.form1.DynamicCode.value!='<%=request.getParameter("dynamicCode")%>')
 	{
   		alert('动态密码不符');//<%=request.getParameter("dynamicCode")%>');
 	  	return false;
  	}
 */
  if(clickBoolean)
  {
    //document.safeInput1.commit("safeCommit1");
    //document.safeCommit1.submit("form1");    
    clickBoolean = false;
  }
	form1.submit();
}
</script>

<style type="text/css"></style>

</head>
<body leftmargin="0" topmargin="0"><!-- onkeydown='if(event.keyCode==13) return (event.srcElement.type=="textarea")'-->
<center>
<DIV align=center>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>    	
    <td background="/personbank/HttpProxy?URL=/midserv/images/pageTitle.gif&dse_sessionId=<%=dse_sessionId%>" class="pageTitle"><%=midObjectView.get_biz_memo().trim()%>（第三步）</td>
    <td rowspan="2" align="right" valign="top">&nbsp;</td>
  </tr>
  <tr>
    <td><img src="/personbank/HttpProxy?URL=/midserv/images/xianb.gif&dse_sessionId=<%=dse_sessionId%>" width="100" height="20"></td>
  </tr>
</table>

<FORM action="/personbank/HttpProxy" method=post name="form1">
  <input type="hidden" name="dse_sessionId" value="<%=dse_sessionId%>">
  <input type="hidden" name="URL" value="/midserv/midServStep2.jsp">
  <input type="hidden" name="biz_id" value="<%=midObjectView.get_biz_id()%>">
  <input type="hidden" name="biz_no" value="<%=midObjectView.get_biz_no().trim()%>">
  <input type="hidden" name="CDNO" value="<%=cardNo%>">
  <input type="hidden" name="passWord">
	<input type="hidden" name="stepCount" value="<%=stepCount+1%>">
<%if( MarchFlag == 1 ){%>
  <input type="hidden" name="step_id" value="<%=i_step_id%>">
 	<input type="hidden" name="sendPass" value="1">
 	<input type="hidden" name="ltString" value="<%=ltArefldandBusId%>">
<%}else{%>
	<input type="hidden" name="step_id" value="<%=i_step_id+1%>">
<%}
	log.Write("step2:	step=[" + i_step_id + "]");
	  
  if(midObjectCtl.get_hidden_input_buff()!=null){
%>
    <%=midObjectCtl.get_hidden_input_buff()%>     
<%}%>

<table border="0" cellspacing="2" cellpadding="0" align="center" width="50%">
	<tr>
		<td height="27" align="center" class="InputTip">手机号码</td>
		<td class="InputTip"><input type="text" name="CTSQ" size="11"></td>
	</tr>
    <tr>
    	<td height="27" align="center" class="InputTip">储值卡类型：</td>
    	<td class="InputTip"><%=midObjectCtl.get_display_buff()%></td>
    </tr>
 </table>

<table border="0" cellspacing="2" cellpadding="0" align="center" width="50%" >  
<%	
	if ( stepCount == 2 )
	{
%>        
		<tr>     
			<td height="27" align="center" class="InputTip">交易密码</td>
			<td class="InputTip">
			<!--
			<SCRIPT language=JavaScript> writePwdActivxObjectLenClass('safeInput1','safeInput1','','passWord',6,6,'20','120')
			</SCRIPT>
			  -->
			</td>
			  
		</tr>        
		<tr>
			<td height="27" align="center" class="InputTip">动态密码</td>
			<td class="InputTip"><input type="text" name="DynamicCode" size="6"></td>
		</tr>
<%	
	}
%>
</table>

<%
	if( MarchFlag != 1 )
	{
		System.out.println("Not To March stepCount = " + stepCount );
    	i_step_id = i_step_id + 1 ;
    }    
    if ( i_step_id  == i_max_step_id ) 
    { 
%>
	<br>
	<a href="/personbank/HttpProxy?URL=/midserv/midSelect.jsp&dse_sessionId=<%=dse_sessionId%>" target=_self> <font color="#003366">返回代理缴费首页</font> </a>
	<br>
<%
    }
    else 
    { 
		if ( i_step_id == 2 )
    	{ 
%>
	<br>
	<input type="button" onclick="javascript:beforeSubmit0();" value="确认交费" style={cursor:hand;}>
	<input type="reset" class="IN" name="Submit2" value="返回" onclick="javascript:history.back()" >
	<br>
<%
		}
		else
		{
%>			
	<br>
	<input type="button" onclick="javascript:beforeSubmit1();" value="提交" style={cursor:hand;}>
	<input type="reset" class="IN" name="Submit2" value="重填">
	<br>			
<%
		}
    } 
%>
</FORM>
<%@ include file="bottom.jsp" %>
</DIV></CENTER></BODY></HTML>
