<%@ page pageEncoding="UTF-8"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<% request.setCharacterEncoding("UTF-8");%>


<%@ page import="java.util.*"%>
<%@ page import="com.bocom.midserv.gz.*"%>
<%@ page import="com.viatt.bean.*"%>
<%@ page import="com.viatt.util.*"%>


<%
	String cssFileName = request.getParameter("cssFileName");//获取客户当前使用的CSS样式


	String cdno = request.getParameter("cardNo");
	GzLog log = new GzLog("c:/gzLog");
	log.Write("============== 电力缴费的第3个jsp文件========begin========================");
	String dse_sessionId = MessManTool.changeChar(request.getParameter("dse_sessionId"));//获取dse_sessionId
	String biz_id = MessManTool.changeChar(request.getParameter("biz_id")); 
	if (biz_id.equals("") ) {
		System.out.println("传入参数不正确");
	}
	log.Write("3333333电力缴费===3===step3:	要求用户输入密码，然后进行付款：i_biz_id=["+biz_id+"]"+"卡号CDNO=["+cdno+"]======3333333");  
	
	
	String queryInfo = MessManTool.changeChar(request.getParameter("report")); //将page2传来查询信息读取出来
	String TCusId = MessManTool.changeChar(request.getParameter("TCusId"));
	String LChkTm = MessManTool.changeChar(request.getParameter("LChkTm"));
	
	log.Write("the query information translated from the page 2 is"+ queryInfo);
	String report = queryInfo + "ActNo,"+cdno+"|TCusId," + TCusId + "|LChkTm," + LChkTm + "|";	
	
	log.Write("=33333333333333333=电力缴费的第3个jsp文件===3333333333333333 " + report);
%>


<HTML>
	<head>
		<title>交通银行网上服务</title>
		<link rel="stylesheet" type="text/css" href="/personbank/css/<%=cssFileName%>">
		<script type="text/JavaScript">		
			var isOK = false;
			//判断输入的密码位数
			function beforeSubmit(){
				if(document.form1.passWord.value.length!=6){				
					return false;
				}
				else {
					return true;
				}			
			}
			
			//提交函数
			function tiJiao(){
	
				isOK = beforeSubmit();
				if (isOK){
					isOK = false;
					document.forms[0].submit();
				}
				else{
					alert("密码位数不正确，请重新输入6位密码！");
				}				
			}		
		</script>
	</head>
	
	<BODY leftmargin="0" topmargin="0"  oncontextmenu=self.event.returnValue=false onselectstart="return false">
	    <DIV align=center>
	    	<form action="/personbank/HttpProxy" method=post name="form1">	    
		    	<input type="hidden" name="URL" value="/midserv/dianLiJiaoFei4.jsp"/>
				<input type="hidden" name="dse_sessionId" value="<%=dse_sessionId%>"/>
				<input type="hidden" name=biz_id value="<%=biz_id%>"/>
				<input type="hidden" name=step_id value="2"/>
				<input type="hidden" name="report" value="<%=report%>"/>
				
				<table width="100%" align="center" cellpadding="1" cellspacing="1" class="tab">
					<tr>
			    		<td width="35%" class="tab_title" colspan="2">输 入 缴 费 密 码 </td>	    	
			        </tr>	
					<tr>
						<td width="35%" class="tab_th">&nbsp;交易密码: </td>
						<td width="65%" class="tab_tr" align="center">
							<input type="password" name="passWord" size="20" value="" minleng='6' maxleng='6'/>
						</td>
					</tr>
					<tr class="tab_result">
				    	<td align="center" colspan="2">
						  	<input type="button" class="button_bg" onclick="tiJiao()" value="确认" style={cursor:hand;}/>
							<input type="reset" class="button_bg" name="Submit2" value="重填"/>
							<input type="button" class="button_bg" name="Submit3" value="返回" onclick="javascript:history.back()" /> 	
				   </tr>
				</table>				
			</form>
		</DIV>
	</BODY>	
</HTML>