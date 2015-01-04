
<!-------------------------------------------------------------------
                          标准页面服务对象引用
--------------------------------------------------------------------->
<%@ page contentType="text/html;charset=gb2312" %>


<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.bocom.midserv.base.*" %>
<%@ page import="com.bocom.midserv.web.*" %>
<%@ page import="java.lang.*"%>

<%//获得参数，插入数据库
    String biz_memo=new String(request.getParameter("biz_memo").trim().getBytes("ISO8859_1"),"gb2312");
    String biz_detail=new String(request.getParameter("biz_detail").trim().getBytes("ISO8859_1"),"gb2312");
    MidObjectStepView midObjectStepView =  new MidObjectStepView();
    int maxbiz_id=midObjectStepView.getMaxbiz_id();
    int biz_id=maxbiz_id+1;
    String biz_no=""+biz_id+"";
    while(biz_no.length()<5){
    	biz_no="0"+biz_no;
    }

    String sql="insert into TRANS_DEF values("+biz_id+",'"+biz_no+"','"+biz_memo+"','"+biz_detail+"','x.jpg','0')";
    MidObjectView midObjectView =  new MidObjectView();
    midObjectView.insertData(sql);
%>


<!--------------------------------------------------------------------
                          页面HTML表现部分    
---------------------------------------------------------------------->
<html>
<head>
<title></title>
</head>
<body>

<%
    String _redirectURL="./add_biz1.jsp?biz_id="+biz_id+"&biz_memo="+request.getParameter("biz_memo").trim()+"&step_id=1";
    response.sendRedirect(response.encodeURL(_redirectURL));
%>
</body>
</html>