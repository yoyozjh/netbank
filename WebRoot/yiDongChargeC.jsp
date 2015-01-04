<%@ page language="java"  pageEncoding="gbk"%>
<%@ page import="com.bocom.midserv.gz.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="com.viatt.bean.*"%>
<%@ page import="com.viatt.util.*" %>
<%
	String dse_sessionId = MessManTool.changeChar(request.getParameter("dse_sessionId"));//获取dse_sessionId	
	GzLog log = new GzLog("c:/gzLog");
	log.Write("###########解约 最终操作结果 回显界面########yiDongChargeC.jsp######begins");
	String biz_id = MessManTool.changeChar(request.getParameter("biz_id"));
	String step_id = MessManTool.changeChar(request.getParameter("step_id"));
	String cdno = MessManTool.changeChar(request.getParameter("cardNo"));
	
	String loginType = request.getParameter("loginType");//传送登陆类别 0－注册用户(手机版) 1－证书用户 2－大众用户
	String dynamicCodeMan="";
	String dynamicCodeSeqMan="";
	String dynamicCode="";
	String dynamicCodeSeq="";
	
	if(loginType.equals("0")){
		dynamicCode=MessManTool.changeChar(request.getParameter("dynamicCode"));
		dynamicCodeSeq=MessManTool.changeChar(request.getParameter("dynamicCodeSeq"));
		
		dynamicCodeMan=MessManTool.changeChar(request.getParameter("dynamicCodeMan"));
		dynamicCodeSeqMan=MessManTool.changeChar(request.getParameter("dynamicCodeSeqMan"));
		
		log.Write("显示的动态密码："+dynamicCodeMan+" 系统的动态密码: "+dynamicCode+" 显示的动态密码序号: "+dynamicCodeSeqMan+" 系统的动态密码序号："+dynamicCodeSeq);
		
		if(!dynamicCodeMan.equals(dynamicCode)){
			System.out.println("动态密码错误！");
			log.Write("动态密码错误！");
			AppParam.setParam(dse_sessionId+"midErr1","参数错误");
			AppParam.setParam(dse_sessionId+"midErr2","动态密码错误！");
			
%>
			<script type="text/javascript">
					window.location="/personbank/HttpProxy?URL=/midserv/midservError.jsp&dse_sessionId=<%=dse_sessionId%>";
			</script>
<%
			return ;
		}
	}
	
	
	//获取签约的参数
	String IdTyp = MessManTool.changeChar(request.getParameter("IdTyp"));//证件类型
	String IdNo = MessManTool.changeChar(request.getParameter("IdNo"));//证件号码
	String ActNam = MessManTool.changeChar(request.getParameter("ActNam"));//证件姓名
	String mainNo = MessManTool.changeChar(request.getParameter("mainNo"));//签约主号码
	
	
	//还差签约类型没有 传送过来的
	
	

    String cssFileName = request.getParameter("cssFileName");//获取客户当前使用的CSS样式
	if(cssFileName ==null){
		cssFileName = "skin.css";
	}					
	
	String bocomPwd = MessManTool.changeChar(request.getParameter("bocomPwd"));//加密密码
	if(bocomPwd.equals("")){
		System.out.println("交易密码为空");
			AppParam.setParam(dse_sessionId+"midErr1","参数错误");
			AppParam.setParam(dse_sessionId+"midErr2","交易密码为空");


%>
<script type="text/javascript">
	window.location="/personbank/HttpProxy?URL=/midserv/midservError.jsp&dse_sessionId=<%=dse_sessionId%>";
</script>
<%
		return;
	}
	

	
	
	
	//开始拼装送往网关的报文，签约报文
	
	String content = "biz_id,32|biz_step_id,2|TXNSRC,WE441|BisTyp,1"+"|ActTyp,4"+
			"|ActNo,"+cdno+"|ActNam,"+ActNam+"|VchNO,"+"|IdTyp,"+IdTyp+"|IdNo,"+IdNo+"|CusNam,"+ActNam+
			"|MstTel,"+mainNo+"|PINDat,"+bocomPwd;
	
	log.Write(">>>>>>>>>>>>移动解约>>>发出去的报文:"+content);
	MidServer midServer = new MidServer();
	BwResult bwResult = midServer.sendMessage(content);
	log.Write("<<<<<<<<<<<<移动解约<<<返回的报文对象bwResult:"+bwResult);
	
	if (bwResult == null ) {
			log.Write("交易结果不对");
			AppParam.setParam(dse_sessionId+"midErr1","解约操作失败");
			AppParam.setParam(dse_sessionId+"midErr2","交易过程中网络出现问题，此次交易失败！");
%>
<script type="text/javascript">
	window.location="/personbank/HttpProxy?URL=/midserv/midservError.jsp&dse_sessionId=<%=dse_sessionId%>";
</script>
<%
	return;
	}
	String tmp ="";
    tmp = bwResult.getContext();
	log.Write("bwResult.getContext= "+tmp);
	
	String info=MessManTool.getValueByName(tmp,"MGID");
	
	
	if(info==null||info.equals("")||!info.equals("000000")){
		
			log.Write("交易不成功");
			log.Write("交易不成功 其原因是："+tmp);
			AppParam.setParam(dse_sessionId+"midErr1","解约失败");
			AppParam.setParam(dse_sessionId+"midErr2",tmp);
%>
<script type="text/javascript">
	window.location="/personbank/HttpProxy?URL=/midserv/midservError.jsp&dse_sessionId=<%=dse_sessionId%>";
</script>
<%
	return;
	}
%>


<!-------------------------------------------------------------------
                          标准JavaScript库引用
--------------------------------------------------------------------->
<script language="JavaScript" src="/personbank/HttpProxy?URL=/midserv/js/public.js&dse_sessionId=<%=dse_sessionId%>"></script>
<script language="JavaScript" src="/personbank/HttpProxy?URL=/midserv/js/common.js&dse_sessionId=<%=dse_sessionId%>"></script>
<script language="JavaScript" src="/personbank/HttpProxy?URL=/midserv/js/date.js&dse_sessionId=<%=dse_sessionId%>"></script>
<!--------------------------------------------------------------------
   当前页面JavaScript函数部分，包括提交验证，页面动作，具体目标等代码
---------------------------------------------------------------------->

<!--------------------------------------------------------------------
                          页面HTML表现部分    
---------------------------------------------------------------------->

<html>
	<head>
	  <meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>交通银行网上服务</title>
		<link rel="stylesheet" type="text/css" href="/personbank/css/<%=cssFileName%>">
	</head>

	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
		<center>
			<DIV align=center>
				<table width="100%" align="center" cellpadding="1" cellspacing="1" class="tab">
					<tr align="left"> 
						<td class="tab_title">解约交易操作成功，具体信息如下：</td>
					</tr>
					
				<FORM action="/personbank/HttpProxy" method=post name="f1">
					<input type="hidden" name="dse_sessionId"	value="<%=dse_sessionId%>">
					<input type="hidden" name="URL" value="/midserv/yiDongCharge1.jsp">
					<input type="hidden" name=biz_id value="<%=biz_id%>">
					<input type="hidden" name=step_id value="1">
					
						<tr class="tab_tr">
							<td width="50%" align="right" height="22" class="InputTip">
								用户姓名：
							</td>
							<td width="50%" align="left" height="22" class="InputTip">
								<input type="text" name="ActNam" value="<%=ActNam%>" readonly="readonly">
							</td>
						</tr>
						<tr class="tab_tr">
							<td width="50%" align="right" height="22" class="InputTip">
								证件类型:
							</td>
							<td width="50%" align="left" height="22" class="InputTip">
								<input type="hidden" name="IdTyp" value="<%=IdTyp%>"  readonly="readonly">
								<%=IdTyp%>
							</td>
						</tr>
						<tr class="tab_tr">
							<td width="50%" align="right" height="22" class="InputTip">
								证件号码：
							</td>
							<td width="50%" align="left" height="22" class="InputTip">
								<input type="text" name="IdNo" value="<%=IdNo%>"  readonly="readonly">
							</td>
						</tr>
						<tr class="tab_tr">
							<td width="50%" align="right" height="22" class="InputTip">
								签约主号码：
							</td>
							<td width="50%" align="left" height="22" class="InputTip">
								<input type="text" name="mainNo" value="<%=mainNo%>"  readonly="readonly">
							</td>
						</tr>
						
					</table>
				</FORM>

			</DIV>
		</center>
		
  	<div class="guide">
  		<ul>温馨提示：
  			  <li>*&nbsp;&nbsp;尊敬的客户，您签约的手机号将收到10086业务办理短信，请于48小时内回复“Y”或“是”进行办理，不回复或回复其他内容，本业务将办理不成功。</li>
  			  <li>*&nbsp;&nbsp;如有疑问可咨询中国移动服务热线10086或交行客服95559。</li>
  		</ul>
  	</div>	
    					  	
	</body>
</html>
