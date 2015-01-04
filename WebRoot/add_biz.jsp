
<!-------------------------------------------------------------------
                          标准页面服务对象引用
--------------------------------------------------------------------->
<%@ page contentType="text/html;charset=gb2312" %>


<!--------------------------------------------------------------------
   当前页面JavaScript函数部分，包括提交验证，页面动作，具体目标等代码
---------------------------------------------------------------------->
<SCRIPT language="JavaScript">
function condition()
{
	<%-- 录入检测空值 --%>
	if (this.document.form1.biz_memo.value==""||this.document.form1.biz_memo.value==null)
	{
		alert("请输入交易名称！");
		return false;
  	}
  	if (this.document.form1.biz_detail.value==""||this.document.form1.biz_detail.value==null)
	{
		alert("请输入简要功能说明！");
		return false;
  	}
  	
 	return true;
}



</script>

<!--------------------------------------------------------------------
                          页面HTML表现部分    
---------------------------------------------------------------------->


<html>

<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>新增代理业务</title>
<link rel="stylesheet" href="./css/personbank.css">
</head>

<body leftmargin="0" topmargin="0"  background="./images/background.gif">
<p align="center"> 
<form method="POST"  name=form1 action="add_bizmid.jsp" onsubmit="return condition()">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
  	<td align="center"><img src="./images/xianb.gif" width="100" height="20"></td>
  	<td rowspan="3" align="right" valign="top">&nbsp;</td>
  </tr>
  <tr>    	
  	<td background="images/pageTitle.gif" class="pageTitle" align="center"> 新 增 代 理 业 务 </td>    
  </tr>
  <tr>
  	<td align="center"><img src="./images/xianb.gif" width="100" height="20"></td>
  </tr>
</table>
<table border="0" width="76%">
    <tr>
      <td width="30%" class="InputTip">
        <p align="right">交易名称：</td>
      <td width="70%" class="InputTip"><input type="text" name="biz_memo" size="20"></td>
    </tr>
    <tr>
      <td width="30%" class="InputTip">
        <p align="right">简要功能说明：</td>
      <td width="70%" class="InputTip"><input type="text" name="biz_detail" size="50"></td>
    </tr>
  </table>
  <p align="center">　</p>
  <p align="center">　</p>
  <p align="center"><input type="button" value=" 返 回 " name="B1" onclick="javascript:history.back()"> <input type="submit" value="下一步" name="B1"> <input type="reset" value="全部重写" name="B2"></p>
</form>

</body>

</html>
