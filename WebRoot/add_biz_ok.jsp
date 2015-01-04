 
<!-------------------------------------------------------------------
                          标准JavaScript库引用
--------------------------------------------------------------------->



<!-------------------------------------------------------------------
                          标准页面服务对象引用
--------------------------------------------------------------------->

<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="com.bocom.midserv.base.*" %>
<%@ page import="com.bocom.midserv.web.*" %>
<%@ page import="java.sql.*" %>




<%
//获得参数，插入数据库
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
String sql_ok="update TRANS_DEF set state='1' where biz_id="+biz_id_s+" and state='0'";
    midObjectView.insertData(sql_ok);
%>


<!--------------------------------------------------------------------
   当前页面JavaScript函数部分，包括提交验证，页面动作，具体目标等代码
---------------------------------------------------------------------->
	<script language="javascript">
		alert("代理业务修改成功！");
		location.replace("admin.jsp");
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
<title>新增代理业务成功</title>
<link rel="stylesheet" href="./css/personbank.css">
</head>


<body leftmargin="0" topmargin="0"  background="./images/background.gif">
</body>

</html>
