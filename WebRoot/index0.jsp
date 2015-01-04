<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="com.bocom.eb.des.EBDES" %>

<%
	String dse_sessionId = request.getParameter("dse_sessionId");//获取dse_sessionId
	String cardNo = request.getParameter("cardNo");//获取交易卡号
	String passWord = request.getParameter("passWord");//加密密码
	if(passWord != null)
	{
		passWord = EBDES.decryptoDES(passWord, dse_sessionId);//解密后密码
	}
	String remoteIp = request.getParameter("remoteIp");//获取客户断IP
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>交通银行</title>
<script language="JavaScript" type="text/JavaScript">

function openNewMaxWindow(businame)
{	  
  var popup=null;
  popup=open(businame,'mainPageMax','top=150,left=150,width=436,height=298');
}

function openNewWindow(businame)
{	  
  var popup=null;
  popup=open(businame,'mainPage','top=150,left=150,width=436,height=298');
}
</script>


<link rel="stylesheet" href="/personbank/HttpProxy?URL=/midserv/css/personbank.css&dse_sessionId=<%=dse_sessionId%>">
</head>

<body >
  <map name="FPMap0">
      <area href="javascript:;" shape="rect" coords="0, 0, 246, 72" onMousedown="javascript:openNewWindow('fx/logon.html')">
      <area href="/personbank/HttpProxy?URL=/midserv/midSelect.jsp&dse_sessionId=<%=dse_sessionId%>" shape="rect" coords="608, 162, 795, 190" target=_top>
  </map>
  <div align="center">
  <table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td><img src="/personbank/HttpProxy?URL=/midserv/images/back1.gif&dse_sessionId=<%=dse_sessionId%>" width="800" height="154"></td>
    </tr>
    
    <tr>
      <td><img src="/personbank/HttpProxy?URL=/midserv/images/back2.jpg&dse_sessionId=<%=dse_sessionId%>" width="796" height="206" usemap="#FPMap0"></td>
    </tr>
    
    <tr>
      <td><img src="/personbank/HttpProxy?URL=/midserv/images/back3.gif&dse_sessionId=<%=dse_sessionId%>" width="800" height="117"></td>
    </tr>
    
    <tr>
      <td><img src="/personbank/HttpProxy?URL=/midserv/images/line1.gif&dse_sessionId=<%=dse_sessionId%>" width="800" height="1"></td>
    </tr>
    <tr>
      <td><img src="/personbank/HttpProxy?URL=/midserv/images/line2.jpg&dse_sessionId=<%=dse_sessionId%>" width="800" height="14"></td>
    </tr>
    <tr>
      <td><img src="/personbank/HttpProxy?URL=/midserv/images/line3.gif&dse_sessionId=<%=dse_sessionId%>" width="800" height="2"></td>
    </tr>
    <tr> 
      <td width="800" height="9" align="center">
       	  <br>
          &copy; 2003交通银行版权所有
          <br>
          <br>
          建议使用IE4.0以上版本浏览器在1024×768分辨率下浏览本网站 
          <br>
      </td>
    </tr>
  </table>
  </div>
</body>
</html>