 
<!-------------------------------------------------------------------
                          标准JavaScript库引用
--------------------------------------------------------------------->
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


<%//获得参数
    MidObjectView midObjectView =  new MidObjectView();
    String step_id=request.getParameter("step_id").trim();
    if (step_id==null||step_id.equals("")){
       step_id=(String)session.getAttribute("step_id");
    }else{
       session.setAttribute("step_id",new String(step_id));
    }
    int step_id_s=Integer.parseInt(step_id);

    String biz_memo=new String(request.getParameter("biz_memo").trim().getBytes("ISO8859_1"),"gb2312");
    if (biz_memo==null||biz_memo.equals("")){
       biz_memo=(String)session.getAttribute("biz_memo");
    }else{
       session.setAttribute("biz_memo",new String(biz_memo));
    }
    String biz_id=request.getParameter("biz_id").trim();
    if (biz_id==null||biz_id.equals("")){
       biz_id=(String)session.getAttribute("biz_id");
    }else{
       session.setAttribute("biz_id",new String(biz_id));
    }
    int biz_id_s=Integer.parseInt(biz_id);
    MidObjectStepView midObjectStepView =  new MidObjectStepView();
    ResultSet rs= midObjectStepView.getStepView(biz_id_s,step_id_s);
    String sql2="";
    if(rs.next()){
        sql2="delete from TRANS_VIEW_DEF where biz_id="+biz_id_s+" and biz_step_id="+step_id_s+"";
        midObjectView.insertData(sql2);
    }
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
  name_ch_value=(name_ch[i]==null?"":new String(name_ch[i].trim().getBytes("ISO8859_1"),"gb2312"));
  explain_value=(explain[i]==null?"":new String(explain[i].trim().getBytes("ISO8859_1"),"gb2312"));
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

        sql="insert into TRANS_VIEW_DEF values("+biz_id_s+","+step_id_s+","+serino+",'"+name_ch_value+"','"+explain_value+"','"+name_en_value+"','"+type_s_value+"',"+length_input+",'',"+viewmod+","+i_word_type+","+i_check_sign+")";
        midObjectView.insertData(sql);
}
    
step_id_s=step_id_s+1;
int i_max_step_id = midObjectStepView.getMaxStepId(biz_id_s);
%>


<!--------------------------------------------------------------------
   当前页面JavaScript函数部分，包括提交验证，页面动作，具体目标等代码
---------------------------------------------------------------------->


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
<style type="text/css">
	.t{behavior:url(./images/dtable.htc)}
</style>
</head>

<body leftmargin="0" topmargin="0"  background="./images/background.gif">
<p align="center"> 
<form name='form1' method="POST" action=''  onsubmit="return condition()">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
  	<td align="center"><img src="./images/xianb.gif" width="100" height="20"></td>
  	<td rowspan="3" align="right" valign="top">&nbsp;</td>
  </tr>
  <tr>    	
  	<td background="images/pageTitle.gif" class="pageTitle" align="center"> 新 增 代 理 业 务</td>      
  </tr>  
  <tr>    	 
  	<td background="images/pageTitle.gif" class="pageTitle" align="center"> <%=biz_memo%> 第 <%=step_id_s%> 步 </td>      
  </tr>  
  <tr>  
  	<td align="center"><img src="./images/xianb.gif" width="100" height="20"></td>  
  </tr>  
</table>
 
<table align=center width="733">       
<tr>       
<td width="37"></td>       
<td width="71" class="InputTip">名称</td>      
<td width="70" class="InputTip">说明</td>      
<td width="70" class="InputTip">表单标识</td>     
<td width="75" class="InputTip">表单类型</td>     
<td width="65" class="InputTip">表单长度</td>     
<td width="53" class="InputTip">字符类型</td>    
<td width="59" class="InputTip">检测长度</td>   
<td width="81"></td>   
</tr>   
<tr>    
      <td width="43" height="26"  bgcolor="#FFFFFF">   
        <div align="center">   
          <INPUT TYPE="button" onclick="javascript:document.all.table1.addnew();" value="增加">   
        </div>   
           
      </td>
      <td width="546" height="26" colspan="8">  
      <%
      if(i_max_step_id>=step_id_s){
      int i_Maxserino=midObjectStepView.getMaxserino(biz_id_s,step_id_s);
      ResultSet rs2= midObjectStepView.getStepView(biz_id_s,step_id_s);
      while(rs2.next()){
      %>  
        <table id="table<%=i_Maxserino%>" width="116%" border="1" cellspacing="0" cellpadding="0" bordercolorlight='#6699cc' bordercolordark='#ECF5FF' class="t">   
          <tr>    
            <td height="26" width="93%">   
              <input type="text" name="name_ch" size=10 value="<%=rs2.getString("input_lable").trim()%>">   
               
              <input type="text" name="explain" size=10 value="<%=rs2.getString("input_memo").trim()%>">      
                
                 
              <input type="text" name="name_en" size=10 value="<%=rs2.getString("input_name").trim()%>">      
                 
                  
              <select size="1" name="type_s">      
          	<option value="<%=rs2.getString("input_type").trim()%>"><%=rs2.getString("input_type").trim()%></option>
          	<option value="text">text</option>
          	<option value="hidden">hidden</option>
          	<option value="password">password</option>
              </select>
            
            
              <input type="text" name="length_s" size=10     
              OnKeypress="if(event.keyCode<47||event.keyCode>57)    
              event.returnValue=false; "  value="<%=rs2.getInt("input_size")%>">
              <select size="1" name="word_type">      
          	<option value="<%=rs2.getInt("word_type")%>">
          	<%
          	if(rs2.getInt("word_type")==1){
          	%>
          	    混合型
          	<%
          	}
          	if(rs2.getInt("word_type")==2){
          	%>
          	    数字型
          	<%
          	}
          	if(rs2.getInt("word_type")==3){
          	%>
          	    金额型
          	<%
          	}
          	%>
          	</option>
          	<option value="1">混合型</option>
          	<option value="2">数字型</option>
          	<option value="3">金额型</option>
              </select><select size="1" name="check_sign">
                <option value="<%=rs2.getInt("check_sign")%>">
          	<%
          	if(rs2.getInt("check_sign")==1){
          	%>
          	检测
          	<%
          	}
          	else{
          	%>
          	不检测
          	<%
          	}
          	%>
          	</option>
          	<option value="1">检测</option>
          	<option value="0">不检测</option>
              </select>
            
            </td>   
            <td width="7%" onclick="javascript:document.all.table<%=i_Maxserino%>.del()">删除 </td>   
          </tr>   
        </table>
      <%
      i_Maxserino--;
      }
          
      }
      else{
      %>  
        <table id="table1" width="116%" border="1" cellspacing="0" cellpadding="0" bordercolorlight='#6699cc' bordercolordark='#ECF5FF' class="t">   
          <tr>    
            <td height="26" width="93%">   
              <input type="text" name="name_ch" size=10>   
               
              <input type="text" name="explain" size=10>      
                
                 
              <input type="text" name="name_en" size=10>      
                 
                  
              <select size="1" name="type_s">      
          	<option value="text">text</option>
          	<option value="hidden">hidden</option>
          	<option value="password">password</option>
              </select>
            
            
              <input type="text" name="length_s" size=10     
              OnKeypress="if(event.keyCode<47||event.keyCode>57)    
              event.returnValue=false;    
              "><select size="1" name="word_type">      
          	<option value="1">混合型</option>
          	<option value="2">数字型</option>
          	<option value="3">金额型</option>
              </select><select size="1" name="check_sign">
          	<option value="1">检测</option>
          	<option value="0">不检测</option>
              </select>
            
            
            </td>   
            <td width="7%">删除 </td>   
          </tr>   
        </table>
      <%
      }
      %>
      </td>   
         
    </tr>   
</table>

  <p align="center">　</p>
  <p align="center">　</p>
  <input type="hidden" name="biz_id" value="<%=biz_id%>">
  <input type="hidden" name="biz_memo" value="<%=biz_memo%>">
  <input type="hidden" name="step_id" value="<%=step_id_s%>">
  <p align="center">
  <% 
  if(step_id_s==2){
  %>
  <input type="button" value="上一步" name="B1" onclick="back2()">
  <%
  }else{
  %>
  <input type="button" value="上一步" name="B1" onclick="back3()">
  <%
  }
  %>
  <input type="button" value="下一步" name="B1" onclick="next()"> <input type="reset" value=" 重 写 " name="B2"> <input type="button" value=" 预 览 " name="see" onclick="preview()"> <input type="button" value="删除此步" name="del" onclick="delstep()"> <input type="button" value=" 完 成 " name="B3" onclick="go()"></p>
</form>

</body>

</html>
