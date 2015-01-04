<%@ page pageEncoding="UTF-8"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<% request.setCharacterEncoding("UTF-8");%>

<%@ page import="com.bocom.midserv.gz.*"%>
<%@ page import="com.viatt.bean.*"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.util.*"%>

<%

	String cssFileName = request.getParameter("cssFileName");//获取客户当前使用的CSS样式

	String biz_step_id="1";  

    String cdno = request.getParameter("cardNo");

	GzLog log = new GzLog("c:/gzLog");
	log.Write("==============这里是 电力缴费的第2个jsp文件========begin========================");
	String dse_sessionId = MessManTool.changeChar(request.getParameter("dse_sessionId"));//获取dse_sessionId
	String biz_id = MessManTool.changeChar(request.getParameter("biz_id")); 
	if (biz_id.equals("") ) {
		System.out.println("传入参数不正确");
	}
	log.Write("2222222222电力缴费===2222===step2:	接受查询号码并准备返回结果：i_biz_id=["+biz_id+"]"+"卡号CDNO=["+cdno+"]===========22222222");  
	//经过测试，上面的卡号和biz_id都能正确无误接收到！
	
	String cardNum = MessManTool.changeChar(request.getParameter("CDNO"));
	String clientID = MessManTool.changeChar(request.getParameter("TCusId"));
	String lchkTm = request.getParameter("LChkTm");
	
	if(lchkTm.length()==6){
		lchkTm = lchkTm+"99";
	}
	else if (lchkTm.length()==1){
		lchkTm = "99999999";
	}
	
	
	
	String TxnAmt="";//金额
	String ChkTim="";//交易日期时间
	String DptTyp="";//配营部类型
	String UsrNam="";//用户姓名
	String UsrAdd="";//用电地址
	String displayTxnAmt="";  //转格式的金额数目
	
	log.Write("2222222222电力缴费===step2:	接受查询号码并准备返回结果：客户编号=["+clientID+"] 银行卡号=["+cardNum+"] 电费日期=["+lchkTm +"]===========22222222");

	String sendContext = "biz_id,31|biz_step_id,1|CDNO,"+cardNum+"|TCusId,"+clientID+"|LChkTm,"+lchkTm+"|";
	log.Write("SENT发出去的报文："+sendContext);

	//网关
	MidServer midServer = new MidServer();	
	

	String message ="";  //用来接收查找信息的报文
	String errorMessage="";
	//获取返回的报文
	BwResult bwResult = midServer.sendMessage(sendContext);
	
	//log
	log.Write("========bwResult.getCode():"+bwResult.getCode());
	if (bwResult == null || bwResult.getCode() == null || !bwResult.getCode().equals("000")) {
		errorMessage = "您好，没有查询到任何电费欠费记录。 感谢您使用！";
	}
	
	/*
	 * 通过测试，发现当没有查询到电费记录时，bwResult会返回NULL  
	 * 当返回有欠费信息的时候， message 字符串能够完整的接收到 
	*/
	else {
			message = bwResult.getContext();
			log.Write("RETURN报文MESSAGE为："+message+"BwResult的CODE是："+bwResult.getCode());
		
	
			 TxnAmt = MessManTool.getValueByName(message, "TxnAmt");//金额
			 ChkTim = MessManTool.getValueByName(message, "ChkTim");//交易日期时间
			 DptTyp = MessManTool.getValueByName(message, "DptTyp");//配营部类型
			 UsrNam = MessManTool.getValueByName(message, "UsrNam");//用户姓名
			 UsrAdd = MessManTool.getValueByName(message, "UsrAdd");//用电地址
			
			DecimalFormat df = new DecimalFormat("###,###,###.##");
			double temp = Double.parseDouble(TxnAmt);
			displayTxnAmt = df.format(temp);   //将金额进行格式修改
		}
%>

<HTML>
	<head>
		<title>交通银行网上服务</title>
		<link rel="stylesheet" type="text/css" href="/personbank/css/<%=cssFileName%>">
	</head>


	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  oncontextmenu=self.event.returnValue=false onselectstart="return false">
	<div class="indent">
	    <% if (bwResult.getCode().equals("000")) { %>
        <form action="/personbank/HttpProxy" method=post name="form1">	    
	    	<input type="hidden" name="URL" value="/midserv/dianLiJiaoFei3.jsp"/>
			<input type="hidden" name="dse_sessionId" value="<%=dse_sessionId%>"/>
			<input type="hidden" name=biz_id value="<%=biz_id%>"/>

			<!-- 将查询回来的信息，继续传递给第三个界面 -->
			<input type="hidden" name=report value="<%=message%>"/>
			
			<!-- 将用户之前输入的编号和查询日期，也一同发往第三个页面 -->
			<input type="hidden" name=TCusId value="<%=clientID%>"/>
			<input type="hidden" name=LChkTm value="<%=lchkTm%>"/>
			
			
			 <table width="100%" align="center" cellpadding="1" cellspacing="1" class="tab">
					 <tr>
			    		<td width="35%" class="tab_title" colspan="2">查 寻 结 果</td>	    	
			        </tr>	
					 <tr>
		    			<td width="35%" class="tab_th">&nbsp;所欠金额:</td>
						<td width="65%" class="tab_tr" align="center"><%=displayTxnAmt%></td>
			    	</tr>
			    	<tr>
			    		<td width="35%" class="tab_th">&nbsp;用户姓名:</td>
						<td width="65%" class="tab_tr" align="center"><%=UsrNam%></td>
			    	</tr>
			    	<tr>
			    		<td width="35%" class="tab_th">&nbsp;用电地址:</td>
						<td width="65%" class="tab_tr" align="center"><%=UsrAdd%></td>
			    	</tr>
			  
			    
			   	   <tr class="tab_result">
				    	<td align="center" colspan="2">
						  	<input type="submit"  class="button_bg"  value="下一步" style={cursor:hand;}/>
							<input type="button" class="button_bg" name="Submit3" value="返回" onclick="javascript:history.back()" /> 	 
						</td>
				  </tr>
			 </table>  
	    </form>	
	    
	    <% }else { %>
		    <table width="100%" align="center" cellpadding="1" cellspacing="1" class="tab">
	        	 <tr align="left"> 
	          		<td colspan="6" class="tab_title">电 费 查 询 结 果 </td>
	        	 </tr>
	        	 <tr align="center" class="tab_sub_title"> 
	        	 	<td width="16%">查 询 出 现 错 误</td>
	        	 </tr>
	        	 <tr align="center" class="tab_tr"> 
	        		 <td width="16%"><%=errorMessage%></td>
	        	</tr>
	        	<tr class="tab_result">
	           		<td align="center" colspan="6">
	             		<input type="button" class="button_bg" value="返回" onClick="javascript:history.back()"/>
	          	    </td>
	          	</tr>
	   		 </table>
	    <% } %>	    
		</DIV>
	</BODY>
</HTML>


















