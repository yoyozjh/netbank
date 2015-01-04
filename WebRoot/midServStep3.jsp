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
   log.Write("step3:	i_step_id=["+i_step_id+"] i_biz_id=["+i_biz_id+"] s_biz_no=["+s_biz_no+"]");

   MidObjectView midObjectView =  new MidObjectView();
   if (midObjectView.getMidObjectView(i_biz_id) != true) 
   	System.exit(1);
   MidObjectCtl midObjectCtl = new MidObjectCtl();
   //midObjectCtl.preInvokeNotXML(i_biz_id,i_step_id);
   
   midObjectCtl.preInvokeNotXML(request,i_biz_id,i_step_id-1);

   //请在设立配置分行网关的地址（字符型）和监听端口（整型）
   midObjectCtl.invokeConnectNotXML("182.53.15.211",3555);

   midObjectCtl.postInvokeNotXML();
   
   MidObjectStepView midObjectStepView =  new MidObjectStepView();
  
   int i_max_step_id = midObjectStepView.getMaxStepId(i_biz_id);

   i_max_step_id = i_max_step_id + 2;
  
   String dse_sessionId = request.getParameter("dse_sessionId");//获取dse_sessionId

   String passWord = request.getParameter("passWord");
   
   String remoteIp = request.getParameter("remoteIp");
   
   String loginType = request.getParameter("loginType");//传送登陆类别 0－注册用户(手机版) 1－证书用户 2－大众用户
   
   int ltFeeType = 9 ;
   String ltBusiType = "00" ;
   String ltArefldandBusId = "" ;
   if ( i_biz_id == 8 )
   {
		ltFeeType = Integer.parseInt( request.getParameter("feeType").trim() ) ; //联通费用类型 1-预付费 0-缴欠费   
   	ltBusiType = request.getParameter("busiType");//联通业务类型
   	ltArefldandBusId = midObjectCtl.get_pswd_value() ;
   	log.Write( "feeType=["+ltFeeType+"] busiType=["+ltBusiType+"] ltArefldandBusId=[" + ltArefldandBusId + "]" );
   }
      
   log.Write("step3:	cardNo=[" + cardNo + "] loginType=["+loginType+"]");  

	//签名增加部分0 BEGIN
	String logonUserDn = request.getParameter("logonUserDn");//获取登陆证书DN
	//签名增加部分0 END   
   
	String isVerifySign = request.getParameter("isVerifySign");
   
	log.Write( "获取登陆证书DN:[" + logonUserDn + "]" );
	log.Write( "isVerifySign = [" + isVerifySign + "]" );
		
	int stepCount = Integer.parseInt( request.getParameter("stepCount").trim() ) ;
		
	int MarchFlag = 0 ;
	//if( isVerifySign == null )
	if ( stepCount == 1 )
		MarchFlag = 1 ;
		
	String isVS = request.getParameter("isVS");
	if( isVS != null )
		MarchFlag = 0 ;
		
	log.Write( "isVS = [" + isVS + "]" );		
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
<%--签名增加部分1 BEGIN--%>
<script language=JavaScript src="/personbank/js/public.js"></script><%--引用总行端公用JS，不需要引用HttpProxy--%>
<script language=JavaScript src="/personbank/js/writeActivxObject.js"></script>
<script language=JavaScript> writeCommitActivxObject('/personbank/')</script>
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
		if( biz_id == 7 )
		{
			document.form1.passWord.value = '<%=midObjectCtl.get_pswd_value()%>' ;
			//alert( "passWord:" + document.form1.passWord.value );
			//return false;
		}
		if( biz_id == 8 )
		{
			document.form1.passWord.value = "000" + document.form1.feeType.value + document.form1.busiType.value ;
			//alert( "pass:" + document.form1.passWord.value + " feeType:" + document.form1.feeType.value + " busiType:" + document.form1.busiType.value );
			//return false ;
		}  	  	
    form1.submit();
    clickBoolean = false;
  }
}

function beforeSubmit1()
{
	var cardNo = '<%=cardNo%>';
	var mobPhone = document.form1.mobPhone.value;
	var dealBal = document.form1.dealBal.value;
	var remoteIp = '<%=remoteIp%>';

	if(document.safeInput1.isValid())
 	{
		alert("密码不合法，请输入合法的密码");		
		return false;
 	}
  <%-- 签名增加部分2 BEGIN --%>	
  <%-- 拼接需要加签数据，规则如下所示 --%>
  /*
  var signData = 'cardNo=' + cardNo + '|dealBal=' + dealBal + '|mobPhone=' + mobPhone + '|remoteIp=' + remoteIp;
  alert( signData );
    
  InfoSecNetSign1.NSServerMode = 0;
    	alert("11");
  InfoSecNetSign1.NSSetPlainText(signData);
      	alert("22");
  document.form2.signData.value = InfoSecNetSign1.NSAttachedSign('<%=logonUserDn%>');

	alert( form2.signData.value );
    
  if (!form2.signData.value)
  {
    alert("签名操作取消！");
    return;
  }
  */
  <%-- 签名增加部分2 END --%>
  
  if(clickBoolean)
  {
  	if( biz_id == 8 )
		{
			document.form1.CTSQ.value = document.form1.CTSQ.value + '<%=ltFeeType%>' + '<%=ltBusiType%>' + '<%=request.getParameter("ltString")%>' ;
			//alert( "CTSQ:" + document.form1.CTSQ.value + " feeType:" + '<%=ltFeeType%>' + " busiType:" + '<%=ltBusiType%>' + " ltstr:" + '<%=request.getParameter("ltString")%>' );
			//return false ;
		}
		if( biz_id == 7 )
		{
			document.form1.CTSQ.value = document.form1.CTSQ.value + '<%=midObjectCtl.get_pswd_value()%>' ;
			//alert( "passWord:" + document.form1.CTSQ.value );
			//return false;
		}  	
  	//form2.submit();  	
    document.safeInput1.commit("safeCommit1");
    document.safeCommit1.submit("form1");
  	clickBoolean = false;
  }
}
</script>

<style type="text/css"></style>

</head> 
<body leftmargin="0" topmargin="0" oncontextmenu=self.event.returnValue=false onselectstart="return false">
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
  <input type="hidden" name="URL" value="/midserv/midServstep3.jsp">
  <input type="hidden" name="biz_id" value="<%=midObjectView.get_biz_id()%>">
  <input type="hidden" name="biz_no" value="<%=midObjectView.get_biz_no().trim()%>">
  <input type="hidden" name="CDNO" value="<%=cardNo%>">
  <input type="hidden" name="passWord">
	<input type="hidden" name="feeType" value="<%=ltFeeType%>">
	<input type="hidden" name="busiType" value="<%=ltBusiType%>">
 	<input type="hidden" name="mobPhone" value="">
 	<input type="hidden" name="dealBal" value="">
 	<input type="hidden" name="stepCount" value="<%=stepCount+1%>">
<%if(MarchFlag==1){%> 	
	<input type="hidden" name="isVS"	value="1"/>
	<input type="hidden" name="step_id" value="<%=i_step_id%>">
	<input type="hidden" name="ltString" value="<%=ltArefldandBusId%>">
<%}else{%>	
	<input type="hidden" name="step_id" value="<%=i_step_id+1%>">
<%}

	log.Write("step3:	step=[" + i_step_id + "]");
	 
  if(midObjectCtl.get_hidden_input_buff()!=null) {
%>
		<%=midObjectCtl.get_hidden_input_buff()%>     
<%}%>
  <table border="0" cellspacing="2" cellpadding="0" align="center" width="50%" >
    <tr><td class="InputTip"><%=midObjectCtl.get_display_buff()%></td></tr>
	</table>
<%if ( midObjectCtl.get_mgid_value().equals("000000") ){
%>
	<table border="0" cellspacing="2" cellpadding="0" align="center" width="50%" >
<%
		ResultSet rs = midObjectStepView.getStepViewNotHidByBizIdAndStepId(i_biz_id,i_step_id);
    while( rs.next() )
    {   
      if ( midObjectCtl.checkHidden(rs.getString("input_name").trim()) != true ) 
      {
				if( ( i_biz_id==2 || ( i_biz_id==8 && ltFeeType==1 ) || ( i_biz_id==20 && ltFeeType==1 ) || i_biz_id==23) 
				&& rs.getString("input_name").trim().equals("AMT1") )//小灵通或联通业务充值金额选择
        {
        	if ( request.getParameter("AMT1") == null )
        	{
%>	 
		<input type="hidden" name="AMT1" value='000000000005000'>
		<tr>
			<td width="30%" align="middle" height="22" class="InputTip">充值金额</td>
			<td width="70%" align="left" height="22" class="InputTip">
				<input onClick="form1.AMT1.value='000000000005000';" type="radio" name="radiobutton" checked="true">50 元<br>
				<input onClick="form1.AMT1.value='000000000010000';" type="radio" name="radiobutton">100 元<br>
				<input onClick="form1.AMT1.value='000000000015000';" type="radio" name="radiobutton">150 元<br>
				<input onClick="form1.AMT1.value='000000000020000';" type="radio" name="radiobutton">200 元<br>
			</td>
		</tr>
<%
					}
					else
					{
%>					
		<tr>
			<td width="30%" align="middle" height="22" class="InputTip">充值金额</td>
			<td width="70%" align="left" height="22" class="InputTip"><%=Integer.parseInt(request.getParameter("AMT1"))/100%>元</td>
		</tr>
		<input type="hidden" name="AMT1" value="<%=request.getParameter("AMT1")%>">
<%					
					}
        }
        else
        {      
					if ( ( ( i_biz_id==8 && ltFeeType==0 ) || i_biz_id==7 ) && rs.getString("input_name").trim().equals("AMT1") ) 
					{
						log.Write("step2:	AMT1=[" +  midObjectCtl.get_amt1_value() + "]" );
%>	    				
		<input type="hidden" name="AMT1" size="<%=rs.getInt("input_size")%>"  value="<%=midObjectCtl.get_amt1_value()%>">
<%				
					}
					else
					{ 
%>
		<tr>
			<td width="20%" align="center" height="22" class="InputTip"><%=rs.getString("input_lable").trim()%>：</td>
			<td width="30%" align="left" height="22" class="InputTip"><input type="<%=rs.getString("input_type").trim()%>" name="<%=rs.getString("input_name").trim()%>" size="<%=rs.getInt("input_size")%>"  value="<%=rs.getString("input_value").trim()%>"></td>
		</tr> 
<%
					}
				}
      } 
      else
      { 
				if ( rs.getString("input_name").trim().equals("CDNO") || rs.getString("input_name").trim().equals("PSWD") ) 
				{
				}
				else
				{
%>
	  			<input type="hidden" name="<%=rs.getString("input_name").trim()%>" size="<%=rs.getInt("input_size")%>">  
<%	
				}
      }
    }
    rs.close();
    midObjectStepView.releaseDBConnection();    
    
    //if( MarchFlag != 1 )
    if ( stepCount == 2 )
    {
%>
     <tr>     
			<td height="27" align="center" class="InputTip">交易密码</td>
			<td class="InputTip"><SCRIPT language=JavaScript> writePwdActivxObjectLenClass('safeInput1','safeInput1','','passWord',6,6,'20','120')</SCRIPT></td>  
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
    	if ( i_step_id  == 2 )
    	{ 
%>
	<br>
	<input type="button" onclick="javascript:beforeSubmit0();" value="确认缴费" style={cursor:hand;}>
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
	<input type="button" class="IN" name="Submit3" value="返回" onclick="javascript:history.back()" >
	<br>			
<%
			}
    }
  } if( i_biz_id == 30 )
  {
%>
  <input type="button" class="IN" name="Submit4" value="返回" onclick="javascript:history.back()" >
  <% } %>  
</FORM>
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

</DIV></CENTER></BODY></HTML>
