<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.bocom.midserv.gz.*"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="java.io.*" %>

<%
	GzLog log = new GzLog("c:/gzLog");
	String logRMNO = String.valueOf(Math.random()).substring(3,9);
	String CrdNo = MessManTool.changeChar(request.getParameter("cardNo"));
	String dse_sessionId = MessManTool.changeChar(request.getParameter("dse_sessionId"));//获取dse_sessionId
	String biz_id = MessManTool.changeChar(request.getParameter("biz_id"));
//	String datefrom = MessManTool.changeChar(request.getParameter("datefrom"));
//	String dateto = MessManTool.changeChar(request.getParameter("dateto"));
	String BUSINO_Sign = MessManTool.changeChar(request.getParameter("BUSINO_Sign"));
	String[] tmp2 = BUSINO_Sign.split("\\|");
	String BUSINO = tmp2[0];
	String Sign = "";
	String NAME = tmp2[2].trim();
	String Sign_NO = "";
//	BUSINO = "301440115200025";
	String datatable = "";
	if(tmp2[1].equals("1")){
		Sign = "直联商户";
		Sign_NO = "Z";
		datatable = "CORP_TRADE_ZL";
	}else if(tmp2[1].equals("2")){
		Sign = "间联商户";
		Sign_NO = "J";
		datatable = "CORP_TRADE_JL";
	}
//	SimpleDateFormat tmpdate1 = new SimpleDateFormat("yyyy-MM-dd");
//	SimpleDateFormat tmpdate2 = new SimpleDateFormat("yyyyMMdd");
//	String result = tmpdate2.format(tmpdate1.parse("2009-12-55"));

//	String datefrom2 = tmpdate2.format(tmpdate1.parse(datefrom));
//	String dateto2 = tmpdate2.format(tmpdate1.parse(dateto));

/*
//	String content = "|biz_id," + biz_id + "|i_biz_step_id,1|datefrom,20080101|dateto,20080101|CrdNo," + CrdNo + "|ZJSign,2|";
	String content = "|biz_id,111|i_biz_step_id,1|datefrom,20080101|dateto,20080101|CrdNo,60142890710180319|ZJSign,2|";
//	String content = "|biz_id,9|biz_step_id,1|CDNO,60142890710180319|PSWD,******|CarType,A1|CarNo,09B61|";
	if (biz_id.equals("") ) {
		System.out.println("传入参数不正确");
	}
	List list = new ArrayList();
	String tmp="";
	MidServer midServer = new MidServer();
	BwResult bwResult = midServer.sendMessage(content);
	if (bwResult == null || bwResult.getCode() == null
	|| !bwResult.getCode().equals("000")) {
			
	 }
	tmp = bwResult.getContext();
*/	

%>
<!-------------------------------------------------------------------
                          标准JavaScript库引用
--------------------------------------------------------------------->
<script language="JavaScript" src="/personbank/HttpProxy?URL=/midserv/js/public.js&dse_sessionId=<%=dse_sessionId%>"></script>
<script language="JavaScript" src="/personbank/HttpProxy?URL=/midserv/js/common.js&dse_sessionId=<%=dse_sessionId%>"></script>

<!--------------------------------------------------------------------
   当前页面JavaScript函数部分，包括提交验证，页面动作，具体目标等代码
---------------------------------------------------------------------->

<!--------------------------------------------------------------------
                          页面HTML表现部分    
---------------------------------------------------------------------->
<html>
<head>
<title>test</title>
<link rel="stylesheet" type="text/css" href="/personbank/HttpProxy?URL=/midserv/css/personbank.css&dse_sessionId=<%=dse_sessionId%>">
<link rel="stylesheet" type="text/css" href="/personbank/HttpProxy?URL=/midserv/css/midserv.css&dse_sessionId=<%=dse_sessionId%>">
<link rel="stylesheet" type="text/css" href="/personbank/HttpProxy?URL=/midserv/css/csspt.css&dse_sessionId=<%=dse_sessionId%>">
<script language="JavaScript" src="/personbank/HttpProxy?URL=/midserv/js/public.js&dse_sessionId=<%=dse_sessionId%>"></script>
<script language="JavaScript" src="/personbank/HttpProxy?URL=/midserv/js/common.js&dse_sessionId=<%=dse_sessionId%>"></script>

</head>
<body leftmargin="0" topmargin="0" oncontextmenu=self.event.returnValue=false onselectstart="return false">
<!-- 页面提示开始 -->
<table width="300px" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td	background="/personbank/HttpProxy?URL=/midserv/images/pageTitle.gif&dse_sessionId=<%=dse_sessionId%>" class="pageTitle">
			&nbsp;&nbsp;下 载 对 账 文 件
		</td>

	</tr>
</table>
<!-- 页面提示结束 -->
<br/>
<br/>
	<table width="400" border="0" align="center">
	  <tr style="cursor:hand;" >
	    <td class="TableRow2">绑定卡号：&nbsp;</td>
	    <td class="TableRow2"> <%= CrdNo %></td>
	  </tr>
	  <tr style="cursor:hand;">
	    <td class="TableRow2">已选择的商户编号： &nbsp;</td>
	    <td class="TableRow2"> <%= BUSINO %></td>
	  </tr>
	  <tr style="cursor:hand;">
	  	<td class="TableRow2" colspan="2">请点击对应日期的对账单进行查询：</td>
	  </tr>

<%
	try{
			SimpleDateFormat tmpdate1 = new SimpleDateFormat("yyyy-MM-dd");
			SimpleDateFormat tmpdate2 = new SimpleDateFormat("yyyyMMdd");
			int j=0;
		
			File pathName = new File("c:\\bea\\midserv\\file");
			String[] fileNames = pathName.list();
			for(int i=0;i<fileNames.length;i++){
				File f= new File(pathName.getPath(),fileNames[i]);
//				out.println(f.getName().substring(0,17));
//				out.println(f.getName().substring(0,17).equals(Sign_NO + "_" + BUSINO));
				if(f.getName().length()>27 && f.getName().substring(0,17).equals(Sign_NO + "_" + BUSINO)){
//					out.println(f.getName());
					j++;
					out.println("<tr style='cursor:hand;'>");
					out.println("<td class='TableRow1' colspan='2' align='center'><a style='text-decoration:underline;' href='/personbank/HttpProxy?dse_sessionId=" + dse_sessionId + "&URL=/midserv/file/" + f.getName() + "'>" + NAME + " " + tmpdate1.format(tmpdate2.parse(f.getName().substring(18,26))) + "对账单</a></td>");
					out.println("</tr>");
				}
			}
		out.println("<tr style='cursor:hand;'>");
		out.println("<td class='TableRow2' colspan='2'>共" + j + "个文件</td>");
		out.println("</tr>");
	}catch(Exception e){
		out.println(e);
	}
 %>

 	  <tr style='cursor:hand;'>
		<td align='center' colspan='3'><input type='button' onclick='Javascript:window.history.back()' value='上一步' class='button_bg'></td>
	</tr>	
	</table>

</body>
</html>