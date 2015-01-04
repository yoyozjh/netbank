<%@page pageEncoding="UTF-8"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import="com.bocom.midserv.gz.*"%>
<%@ page import="com.viatt.bean.*"%>
<%
    String uri = request.getRequestURI();
    /* 获取总行全局参数 */
    //获取客户当前使用的CSS样式
    String cssFileName = request.getParameter("cssFileName");
    //获取dse_sessionId
    String dse_sessionId = request.getParameter("dse_sessionId");
    //获取卡号
    String CrdNo = request.getParameter("cardNo");
    //获取卡号
    String custName = request.getParameter("custName");

    //创建日志实例
    GzLog log = new GzLog("c:/gzLog");
    log.Write(CrdNo+"进入["+uri+"]");

	String action_next;

	String qdbz = request.getParameter("QDBZ").trim();
	if("1".equals(qdbz)){
		action_next="Efek_QY_Upd_Input.jsp";
	}else if("0".equals(qdbz)){
		action_next="Efek_QY_Add_Input.jsp";
	}else if("2".equals(qdbz)){
		action_next="Efek_QY_Confirm.jsp";
	}else{
		action_next="Efek_QY_Qry_Input.jsp";
	}

%>
<html>
    <head>
        <title>交通银行网上服务</title>
        <!-- 总行样式表，定义总体色调与表格等格式 -->
        <link rel="stylesheet" type="text/css" href="/personbank/css/<%=cssFileName%>">
        <!-- 分行样式表，定义段落、超链接格式 -->
        <link rel="stylesheet" type="text/css"
            href="/personbank/HttpProxy?URL=/midserv/css/css.css&dse_sessionId=<%=dse_sessionId%>">
    </head>


    <body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  oncontextmenu=self.event.returnValue=false onselectstart="return false">
		<jsp:forward page="<%=action_next%>">
		</jsp:forward>
    </body>
</html>
