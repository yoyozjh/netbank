<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@ page import="com.bocom.midserv.gz.*"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="java.sql.*"%>


<%
	GzLog log = new GzLog("c:/gzLog");
	String dse_sessionId = MessManTool.changeChar(request.getParameter("dse_sessionId"));//获取dse_sessionId
	String biz_id = MessManTool.changeChar(request.getParameter("biz_id"));
	String CrdNo = MessManTool.changeChar(request.getParameter("cardNo"));
	//用于并发数太多的时候能够比较容易分清日志的关系
	String logRMNO = String.valueOf(Math.random()).substring(3,9);
	if (biz_id.equals("") ) {
		log.Write("[" + logRMNO + "] Step 1: 传入参数不正确，biz_id为空"); 
	}
//	List list = new ArrayList();
//发送第一个查询交易开始：发送卡号过去，获得对应的商户编号和商户类别，其中商户编号和商户类别都有可能不是唯一
%>

<%
//Test数据库连接开始
		Connection dbConn = null;
		Statement st = null;
		ResultSet rs = null;
		Statement st2 = null;
		ResultSet rs2 = null;
		String sqlstr = "";
		String ZJTable = "";
		String checked = "";
		String finalstr = "";
		int i = 0;
    try {//建立数据库连接
        dbConn = DriverManager.getConnection("jdbc:sybase:Tds:182.53.15.211:6600/middb?CHARSET=cp936&amp;amp;LANGUAGE=en_US", "miduser", "miduser");
    } catch (SQLException e) {
		log.Write("[" + logRMNO + "] Step 1 得到商户编号: getConnection......" + e.getMessage()); 
		e.printStackTrace();
    }
    
	try{//打开对话,赋给ResultSet
	    sqlstr = "select BUSINO, ZJSign from CrdNo_BUSINO where CrdNo like '" + CrdNo + "'";
	    log.Write(sqlstr);
	    st = dbConn.createStatement();
	    rs = st.executeQuery(sqlstr);
	} catch (SQLException e) {
		log.Write("[" + logRMNO + "] Step 1 得到商户编号: createStatement......" + e.getMessage()); 
		e.printStackTrace();
	}


//Test数据库连接结束
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
<script language="JavaScript" src="/personbank/HttpProxy?URL=/midserv/js/public.js&dse_sessionId=<%=dse_sessionId%>"></script>
<script language="JavaScript" src="/personbank/HttpProxy?URL=/midserv/js/common.js&dse_sessionId=<%=dse_sessionId%>"></script>
<script type="text/javascript">
	function tj1(){
		//上送的时间值不能为空
		tj();
	}
</script>
<link rel="stylesheet" type="text/css" href="/personbank/HttpProxy?URL=/midserv/css/personbank.css&dse_sessionId=<%=dse_sessionId%>">
<link rel="stylesheet" type="text/css" href="/personbank/HttpProxy?URL=/midserv/css/midserv.css&dse_sessionId=<%=dse_sessionId%>">
<link rel="stylesheet" type="text/css" href="/personbank/HttpProxy?URL=/midserv/css/csspt.css&dse_sessionId=<%=dse_sessionId%>">
</head>

<body leftmargin="0" topmargin="0" oncontextmenu=self.event.returnValue=false onselectstart="return false">
<!-- 页面提示开始 -->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td	background="/personbank/HttpProxy?URL=/midserv/images/pageTitle.gif&dse_sessionId=<%=dse_sessionId%>" class="pageTitle">
			&nbsp;&nbsp;请 选 择 对 账 日 期
		</td>
		<td rowspan="2" align="right" valign="top">
			&nbsp;
		</td>
	</tr>
</table>
<!-- 页面提示结束 -->

<form action="/personbank/HttpProxy" method=post name="f1">
	<input type="hidden" name="dse_sessionId" value="<%=dse_sessionId%>">
	<input type="hidden" name="URL" value="/midserv/corpfee2.jsp">
	<input type="hidden" name="biz_id" value="<%=biz_id %>">
	<input type="hidden" name="step_id" value="2">

	<font size="50"></font>
	<table width="400" border="0" align="center">
	  <tr style="cursor:hand;" >
	    <td colspan="3" class="TableRow2">绑定卡号：&nbsp; <%= CrdNo %></td>
	  </tr>
	  <tr style="cursor:hand;">
	    <td colspan="3" class="TableRow2">请选择对应的商户编号，并点击下一步</td>
	  </tr>
	  <tr style="cursor:hand;">
	    <td class="TableRow2" align='center' width='30px'>选择</td>
	    <td class="TableRow2" align='center' width='125px'>商户编号</td>
	    <td class="TableRow2" align='center'>商户名称</td>
	  </tr>
<!-- 查询数据库循环输出商户编号和类别开始 -->
<%	
if(rs.next()){
	do {//循环输出字段
	try{
		if(rs.getString(2).equals("1")){
			ZJTable = "CORP_ZL";
		}else{
			ZJTable = "CORP_JL";
		}
		if(i==0){
			checked = "checked";
		}else{
			checked = "";
		}
		//查询客户名称

		try{//打开对话,赋给ResultSet
		    sqlstr = "select CUSTNAME from " + ZJTable + " WHERE BUSINO LIKE '" + rs.getString(1).trim() + "'";
		    log.Write(sqlstr);
		    st2 = dbConn.createStatement();
		    rs2 = st2.executeQuery(sqlstr);
		} catch (SQLException e) {
			log.Write("[" + logRMNO + "] Step 2 得到商户名称: createStatement......" + e.getMessage()); 
			e.printStackTrace();
		}

		if(rs2.next()){
			do{
				out.println("<tr style='cursor:hand;'>");
				out.println("<td class='TableRow1' align='center'><input name='BUSINO_Sign' type='radio' value='" + rs.getString(1).trim() + "|" + rs.getString(2)+ "|" + rs2.getString(1).trim() + "' " + checked + "/></td>");
				out.println("<td class='TableRow1' align='center'>" + rs.getString(1).trim() + "</td>");
				out.println("<td class='TableRow1' align='center'>" + rs2.getString(1).trim() + "</td>");
				out.println("</tr>");
			}while(rs2.next());
		}else{
//			log.Write(finalstr);
			finalstr += "<tr style='cursor:hand;'>";
			finalstr += "<td class='TableRow1' align='center' colspan='3'>卡号没有关联对应的商户编号，请返回</td>";
			finalstr += "</tr>";
			
//			log.Write(finalstr);
		}
		i++;
		rs2 = null;
		st2 = null;
	}catch(Exception e){
		log.Write(e.getMessage());
	}
	}while (rs.next());
	out.println(finalstr);

 %>
<!-- 查询数据库循环输出商户编号和类别结束 -->
	  <tr style='cursor:hand;'>
		<td align='center' colspan='3'>
			<input type='button' onclick='Javascript:window.history.back()' value='上一步' class='button_bg'>
		  	<input type="button" onclick="tj1();" value="下一步" class="button_bg"></td>
	  </tr>

<%
}else{
	out.println("<tr style='cursor:hand;'>");
	out.println("<td align='center' colspan='3' class='TableRow1'>卡号没有关联对应的商户编号，请返回</td>");
	out.println("</tr>");
	out.println("<tr style='cursor:hand;'>");
	out.println("<td align='center' colspan='3'><input type='button' onclick='Javascript:window.history.back()' value='返回' class='button_bg'></td>");
	out.println("</tr>");
}
 %>

	</table>

</form>
<%
	try{//关闭数据库连接
		rs = null;
		st = null;
		dbConn.close();
	}catch(SQLException e){
		log.Write("[" + logRMNO + "] Step 1: close dbConn......" + e.getMessage());
	}
 %>
</body>
</html>