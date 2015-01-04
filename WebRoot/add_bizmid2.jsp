
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
    String biz_id=request.getParameter("biz_id").trim();
    if (biz_id==null||biz_id.equals("")){
       biz_id=(String)session.getAttribute("biz_id");
    }else{
       session.setAttribute("biz_id",new String(biz_id));
    }
    int i_biz_id=Integer.parseInt(biz_id);

    String sql="update TRANS_DEF set biz_memo='"+biz_memo+"',biz_detail='"+biz_detail+"' where biz_id="+i_biz_id+"";
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