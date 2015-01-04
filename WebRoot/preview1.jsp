 
<!-------------------------------------------------------------------
                          标准JavaScript库引用
--------------------------------------------------------------------->
<script language="JavaScript" src="./card/public_card.js"></script>


<!-------------------------------------------------------------------
                          标准页面服务对象引用
--------------------------------------------------------------------->





<%@ page contentType="text/html;charset=gb2312" %>

 
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.bocom.midserv.base.*" %>
<%@ page import="com.bocom.midserv.web.*" %>
<% 
   int i_step_id	= Integer.parseInt(request.getParameter("step_id").trim());
   int i_biz_id		= Integer.parseInt(request.getParameter("biz_id").trim());

   MidObjectView midObjectView =  new MidObjectView();
   if (midObjectView.getMidObjectView(i_biz_id) != true) 
   	System.exit(1);
   
   
%>

<!--------------------------------------------------------------------
   当前页面JavaScript函数部分，包括提交验证，页面动作，具体目标等代码
---------------------------------------------------------------------->
<SCRIPT LANGUAGE=javascript>
function txing(){
	alert("此页只供预览，请关闭窗口！");
}
</script>

<!--------------------------------------------------------------------
                          页面HTML表现部分    
---------------------------------------------------------------------->
<html>
<head>
<title>交通银行网上服务</title>
<script language="JavaScript" type="text/JavaScript">
</script>
<link rel="stylesheet" href="./css/personbank.css">
</head>

<body leftmargin="0" topmargin="0">
<center>

<DIV align=center>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
  	<td><img src="./images/xianb.gif" width="100" height="20"></td>
  	<td rowspan="3" align="right" valign="top">&nbsp;</td>
  </tr>
  <tr>    	
  	<td background="images/pageTitle.gif" class="pageTitle"><%=midObjectView.get_biz_memo().trim()%>（第<%=i_step_id%>步 预览）</td>    
  </tr>
  <tr>
  	<td><img src="./images/xianb.gif" width="100" height="20"></td>
  </tr>
</table>

<FORM action="" method=post name="" onsubmit="">


<CENTER>
<table border="0" cellspacing="2" cellpadding="0" align="center" width="50%" >
<%
int row=1,column=5;
int i=0,k=0;
String sql="";
String [] name_ch=new String[20];
String [] explain=new String[40];
String [] name_en=new String[15];
String [] type_s=new String[15];
String [] length_s=new String[15];
String [] word_type=new String[15];
String [] check_sign=new String[15];
String name_ch_value,explain_value,name_en_value,type_s_value="",length_s_value="",word_type_value="",check_sign_value="";
int length_input=1,viewmod=1,i_word_type,i_check_sign;
if(request.getParameter("row")!=null){
  row=Integer.parseInt(request.getParameter("row"));
}
if(request.getParameter("column")!=null){
  column=Integer.parseInt(request.getParameter("column"));
}
if(request.getParameterValues("name_ch")!=null){
  name_ch=request.getParameterValues("name_ch");
}
if(request.getParameterValues("explain")!=null){
  explain=request.getParameterValues("explain");
}
if(request.getParameterValues("name_en")!=null){
  name_en=request.getParameterValues("name_en");
}
if(request.getParameterValues("type_s")!=null){
  type_s=request.getParameterValues("type_s");
}
if(request.getParameterValues("length_s")!=null){
  length_s=request.getParameterValues("length_s");
}
if(request.getParameterValues("word_type")!=null){
  word_type=request.getParameterValues("word_type");
}
if(request.getParameterValues("check_sign")!=null){
  check_sign=request.getParameterValues("check_sign");
}
for(i=0;i<row;i++){
if(i<row){
  name_ch_value=(name_ch[i]==null?"":name_ch[i].trim());
  explain_value=(explain[i]==null?"":explain[i].trim());
  name_en_value=(name_en[i]==null?"":name_en[i].trim());
  type_s_value=(type_s[i]==null?"":type_s[i].trim());
  length_s_value=(length_s[i]==null?"":length_s[i].trim());
  word_type_value=(word_type[i]==null?"":word_type[i].trim());
  check_sign_value=(check_sign[i]==null?"":check_sign[i].trim());
}else{
  name_ch_value="";
  explain_value="";
  name_en_value="";
  type_s_value="";
  length_s_value="";
  word_type_value="";
  check_sign_value="";
}

int serino;
serino=i+1;
length_input=Integer.parseInt(length_s_value);
i_word_type=Integer.parseInt(word_type_value);
i_check_sign=Integer.parseInt(check_sign_value);
viewmod=1;
if(type_s_value.equals("hidden")){
    viewmod=-1;
}

if(viewmod==1){
%>
  <tr>
     <td width="20%" align="center" height="22" class="InputTip">
     <%=new String(name_ch_value.getBytes("ISO8859_1"),"gb2312")%>：
     </td>
     <td width="30%" align="left" height="22" class="InputTip">
     <input type="<%=type_s_value%>" name="<%=name_en_value%>" size="<%=length_input%>" value="">
     </td>
  </tr> 
<%
}
else{
%>
	<input type="<%=type_s_value%>" name="<%=name_en_value%>" size="<%=length_input%>" value="">
<%
}
}
%>
</table>
<br>
   <input type="button" class="IN" name="Submit" value="提交" onclick="txing()">
   <input type="button" class="IN" name="Submit2" value="重填" onclick="txing()">
<br>

</CENTER></DIV>

<br>
<p>备注：<%=midObjectView.get_biz_detail().trim()%></p>
<DIV align=center>
<br>
   <input type="button" class="IN" name="fanh" value="关闭窗口" onclick="javascript:window.close()">
<br>
</DIV>
</FORM></BODY></HTML>
