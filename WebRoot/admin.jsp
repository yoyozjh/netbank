 
<!-------------------------------------------------------------------
                          标准JavaScript库引用
--------------------------------------------------------------------->
<script language="JavaScript" src="./js/public.js"></script>
<script language="JavaScript" src="./js/check.js"></script>

<!-------------------------------------------------------------------
                          标准页面服务对象引用
--------------------------------------------------------------------->

<%@ page contentType="text/html;charset=gb2312" %>


<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.bocom.midserv.base.*" %>
<%@ page import="com.bocom.midserv.web.*" %>

<% MidObjectView midObjectView =  new MidObjectView();
   ResultSet rs = midObjectView.getMidViewList();
   
   if ( request.getParameter("card_no") != null )
  	 session.putValue("card_no",request.getParameter("card_no").trim());
   if ( request.getParameter("pssd_no") != null )
  	 session.putValue("pssd_no",request.getParameter("pssd_no").trim());

   
%>



<!--------------------------------------------------------------------
   当前页面JavaScript函数部分，包括提交验证，页面动作，具体目标等代码
---------------------------------------------------------------------->

<!--------------------------------------------------------------------
                          页面HTML表现部分    
---------------------------------------------------------------------->
<html>
<head>
<title>代理业务管理</title>
<script language="JavaScript" type="text/JavaScript">
</script>
<link rel="stylesheet" href="./css/personbank.css">
</head>

<body leftmargin="0" topmargin="0">
<script LANGUAGE="javascript">
function submit1()
{
self.location.replace("admin.jsp")
}
</script>
<center>

<DIV align=center>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
  	<td><img src="./images/xianb.gif" width="100" height="20"></td>
  	<td rowspan="3" align="right" valign="top">&nbsp;</td>
  </tr>
  <tr>    	
  	<td background="images/pageTitle.gif" class="pageTitle">&nbsp;&nbsp; 代 理 业 务 管 理 页 面 </td>    
  </tr>
  <tr>
  	<td><img src="./images/xianb.gif" width="100" height="20"></td>
  </tr>
</table>

<FORM action="./midServStep1.jsp" method=post name="f1">
<input type=hidden name=biz_id value="1">
<input type=hidden name=step_id value="1">
<CENTER>
<table border="0" cellspacing="2" cellpadding="0" align="center" width="80%" height="45">
        <tr align="center">
		<td width="5%" height="25"  class="InputTip">序号</td>
		<td width="35%" height="25"  class="InputTip">代理业务名称</td>
		<td width="40%" height="25"  class="InputTip">简要功能说明</td>
		<td colspan="2" height="25"  class="InputTip"></td>
	</tr>
    	<%
    	String biz_id_s="";
    	while(rs.next()){
    	biz_id_s=rs.getString("biz_id");
    	%>
	<tr align="center">
		<td width="5%" height="25" class="InputValue"><%=rs.getString("biz_id")%></td>
		<td width="35%" height="25" class="InputValue"><%=rs.getString("biz_memo")%></td>
		<td width="40%" height="25" class="InputValue"><%=rs.getString("biz_detail")%></td>
		<td width="10%" height="25" class="InputValue">
		<a href="modadd_biz.jsp?biz_id=<%=biz_id_s%>" target="_top"><font color="blue">修改</font></a>
		</td>
		<td width="10%" height="25" class="InputValue">
		<a href="#" onclick="delbiz(<%=rs.getString("biz_id")%>)"><font color="blue">删除</font></a>
		</td>
	</tr>
	<%
	}
	%>
</table>
<br>
[<a href="add_biz.jsp"><font color="blue">新增代理业务</font></a>]
<br>
</DIV>

<br>
<br>
</form>
</body>
</html>