<%@ page pageEncoding="GBK"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<% request.setCharacterEncoding("GBK");%>

<%@ page import="com.bocom.midserv.gz.*"%>
<%@ page import="com.viatt.bean.*"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.util.*"%>
<%

    String uri = request.getRequestURI();
    /* 获取总行全局参数 */
    //获取客户当前使用的CSS样式
    String cssFileName = request.getParameter("cssFileName");
    //获取dse_sessionId
    String dse_sessionId = request.getParameter("dse_sessionId");
    //获取卡号
    String cardNo = request.getParameter("cardNo");
    //获取卡号
    String custName = request.getParameter("custName");

    //创建日志实例
    GzLog log = new GzLog("c:/gzLog");
    log.Write(cardNo+"进入["+uri+"]");

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

    <body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  oncontextmenu=self.event.returnValue=false onselectstart="return false" >

    <div class="indent">
    <form action="/personbank/HttpProxy" method=post name="form1">
        <!-- 总行定义字段 -->
        <input type="hidden" name="URL" value="/midserv/Gds_GdsBIds.jsp"/>
        <input type="hidden" name="dse_sessionId" value="<%=dse_sessionId%>"/>
<%
	//获取已签约数据
	String signResult = request.getParameter("Gds_signResult");
%>
        <!-- 特色业务字段 -->
        <input type="hidden" name="Gds_signResult" value="<%=signResult%>"/>

		<table width="90%" align="center" cellpadding="1" cellspacing="1" class="tab">
<%
    //可以签约的交易列表
    Map business = GdsPubData.getSignBusiness();
    Iterator itBusiness = business.keySet().iterator();
    if(itBusiness.hasNext()){
%>
        <tr align="left" class="tab_title"> 
            <td>
                已受理
            </td>
        </tr>
<%
    }

    while (itBusiness.hasNext()) {
        String businessKey = (String) itBusiness.next();
        if (signResult.indexOf(String.valueOf(businessKey)) != -1) {
%>
        <tr class="tab_tr">
            <td align="left">
                <p><%=business.get(businessKey) %></p>
            </td>
        </tr>

<%
        }
    }
%>
        <tr class="tab_title">
            <td align="left">
                请选择签约业务的类型
            </td>
        </tr>
        <tr class="tab_tr">
            <td align="left">
                <p><a href='/personbank/HttpProxy?URL=/midserv/Gds_Ele_Note.jsp&dse_sessionId=<%=dse_sessionId%>'>电费签约</a></p>
            </td>
        </tr>
        <tr class="tab_tr">
            <td align="left">
<%
    itBusiness = business.keySet().iterator();
    while (itBusiness.hasNext()) {
        String businessKey = (String) itBusiness.next();
        if (signResult.indexOf(String.valueOf(businessKey)) < 0) {
            out.println("<p><input type='checkbox' name='GdsBId"
                    +businessKey+"' value='"
                    +businessKey+"' >"
                    +business.get(businessKey)+"</input></p>");
        }
    }

 %>
            </td>
        </tr>
        <tr class="tab_tr">
            <td align="left">
                <p><font style="color:red;">温馨提示：</font>1、已受理签约业务，如要重新办理，请到网点柜台办理；2、已成功签约业务，如需撤销，请凭有效身份证件到相关收费单位营业厅办理。</p>
            </td>
        </tr>
		<tr class="tab_result">
		    <td align="center">
		        <input type="submit"  class="button_bg"  value="确定" style={cursor:hand;}/>
		        <input type="button" class="button_bg" name="Submit3" value="返回" onclick="javascript:history.back()" />      
		    </td>      
		</tr>
		</table>
    </form> 
    </div>
    </body>
</html>