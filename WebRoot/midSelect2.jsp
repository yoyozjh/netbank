<!-------------------------------------------------------------------
                          标准页面服务对象引用
--------------------------------------------------------------------->
<%@ page language="java" contentType="text/html;charset=GBK"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.bocom.midserv.gz.*"%>
<%@ page import="com.bocom.midserv.web.*"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.viatt.bean.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.io.*"%>

<%

  MidObjectView midObjectView = new MidObjectView();
	String up_biz_id = request.getParameter("up_biz_id")!=null?request.getParameter("up_biz_id"):"";
	if(up_biz_id.equals("")){
		up_biz_id="0";
	}
	MidSelectUtil midSelectUtil=new MidSelectUtil();
	ResultSet rs = midSelectUtil.getMidViewList(up_biz_id);

	GzLog log = new GzLog("c:/gzLog");
	String dse_sessionId = request.getParameter("dse_sessionId");//获取dse_sessionId
	
	String cdno = request.getParameter("cdno");
	//System.out.println("卡号："+cdno);
	String loginType = request.getParameter("loginType");
	String remoteIp = request.getParameter("remoteIp");

	String s_step_id = request.getParameter("step_id");

	//测试时将canPass置0，则只有设定的测试卡(canPass==1)可以使用。
	int canPass = 1;
	log.Write("\n===================midselect2.jsp begin ==============================");
	log.Write("select:	IP=[" + remoteIp + "] CDNO=[" + cdno
			+ "] loginType=[" + loginType + "] step_id=[" + s_step_id
			+ "]"+"dse_sessionId=["+dse_sessionId+"]");
			
	String cssFileName = request.getParameter("cssFileName");//获取客户当前使用的CSS样式
	
	if(cssFileName ==null){
		cssFileName = "skin.css";
	}		
	
	
	
	//##########################################################
	String testIp="182.53.15.200";
	int testPort=35850;
	
	String businessIp="182.53.1.6";
	int businessPort=35850;
	
	String ipAddress=businessIp;
	int portNum=businessPort;
	
	char errorFlag='U';  // Default value
  
	
	
	
	int crdLength = cdno.length();
	//如果卡号的长度小于21位 则需要在右侧补空格，补成21bit长
	if(crdLength<21){
		for (int i=crdLength; i<21; i++){
		 	cdno=cdno+" ";
		}
	}
	
	
	
	String packageHead2="00000192000048217100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
	String insertContent=packageHead2+cdno;
					      
                
                
	// Socket communication to the ics
 try{	
 			BufferedReader inputStream = null; /* receive */
 			PrintWriter outputStream = null; /* send */
 			
 			/*
 			 Of course, once we opened one socket communication, we should end it while the timming is good!
 			*/
 			Socket soc = new Socket(ipAddress, portNum);
 			inputStream = new BufferedReader(new InputStreamReader(soc.getInputStream()));
 			outputStream = new PrintWriter(new BufferedWriter(new OutputStreamWriter(soc.getOutputStream())), true);
 			
 			//send the pacakge into ICS
 			outputStream.println(insertContent);
 			
 			//fetch the reponse from ics
 			String feedback=inputStream.readLine();
 			int backLength=feedback.length();
 			errorFlag=feedback.charAt(11);
 			
 			//Do the log
 			log.Write("the feedback package info is :"+feedback+"\n the errorFlag is: "+errorFlag);		
 			
 			
 			/*
 				Be attention that the the errorFlag could be “E” which means the ICS cannot handl the corresponding transaction
 				properly. Only when the errorFlag returns as "N" the ICS transaction runs correct and bring the database query result
 				with the response package info.
 			*/
 			 
 			 
 			if(feedback.charAt(backLength-1)=='T')
 			{
 			   // this means the cardno number insert operation did successfully
                
        			
 			}
 			
 			log.Write("The inesrt cardno operation result is  :"+feedback.charAt(backLength-1));		
 			
 			/*
 				shut down what we opened
 			*/
 			inputStream.close();
 			outputStream.close();
 			soc.close();
 			
 			
 }catch (Exception e) {
 				e.printStackTrace();
 } 
	
	
%>



<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>交通银行网上服务</title>
		<link rel="stylesheet" type="text/css" href="/personbank/css/<%=cssFileName%>">
  </head>
	
	<body leftmargin="0" topmargin="0" oncontextmenu=self.event.returnValue=false onselectstart="return false">
		<center>
			<div class="indent">
				<%
					if (loginType.equals("2")) {
						rs.close();
						midObjectView.releaseDBConnection();
						midSelectUtil.releaseDBConnection();
				%>
				普通用户不能使用此业务。
				<%
				} else if (canPass == 1) {
				%>
				<table width="100%" align="center" cellpadding="1" cellspacing="1" class="tab">
					<tr align="left"> 
							<td class="tab_title">请 选 择 代 理 业 务 种 类</td>
					</tr>
				
				<form name="f1" method="post" action="/personbank/HttpProxy">
					<input type="hidden" name="dse_sessionId"	value="<%=dse_sessionId%>">
					<input type="hidden" name="URL" value="/servlet/TransServlet">
					<input type="hidden" name=biz_id value="">
					<input type="hidden" name="up_biz_id" value="">
					<input type="hidden" name=step_id value="">
					<input type="hidden" name="biz_no" value="">
					
					<%
							while (rs.next()) {
								String branch = rs.getString("branch");
								MidSelectUtil midSelectUtil1=new MidSelectUtil();
								int tmp=midSelectUtil1.isShow(cdno,branch);
								if(tmp!=0){
									continue;
								}
								int biz_id = rs.getInt("biz_id");
								String biz_no = rs.getString("biz_no");
								String web_url = rs.getString("web_url").trim();
								String biz_memo = rs.getString("biz_memo");
						%>
						<tr class="tab_tr">
							<td width="100%" align="center" class="InputTip">	
								<A
									onClick="
     document.f1.URL.value='<%=web_url %>';
     document.f1.biz_id.value='<%=biz_id %>';
     document.f1.up_biz_id.value='<%=biz_id %>';
     document.f1.step_id.value='1';
     document.f1.biz_no.value='<%=biz_no %>';
     document.f1.submit();
     return false;"  HREF="#1">
     							<%=biz_memo.trim() %>
								</A>
							</td>
						</tr>
						<%
							}
							rs.close();
							midObjectView.releaseDBConnection();
							midSelectUtil.releaseDBConnection();
						%>
						<tr class="tab_result">
	    				<td align="center" colspan="2">
             		<input type="button" class="button_bg" value="返 回" onClick="history.go(-3);"/>
           		</td>  	
	    			</tr>
					</table>
					<br>
				</form>
				<%
						} else if(canPass!=1){
						rs.close();
						midObjectView.releaseDBConnection();
						midSelectUtil.releaseDBConnection();
				%>
				系统维护中...
				<%
				}
				%>
				<%@ include file="bottom.jsp"%>
				</DIV>
		</center>
	</body>
</html>