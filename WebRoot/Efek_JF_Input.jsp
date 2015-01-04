<%@ page pageEncoding="GBK"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<% request.setCharacterEncoding("GBK");%>

<%@ page import="com.bocom.midserv.gz.*"%>

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
    <div class="indent">
        <form action="/personbank/HttpProxy" method=post name="form1">
            <input type="hidden" name="URL" value="/midserv/Efek_JF_460410.jsp"/>
            <input type="hidden" name="dse_sessionId" value="<%=dse_sessionId%>"/>

            <table width="90%" align="center" cellpadding="1" cellspacing="1" class="tab">
                <tr align="center" class="tab_title"> 
                    <td colspan="2">请输入充值信息</td>
                </tr>
                <tr class="tab_tr">
                    <td align="right">
                    	缴费卡号：
                    </td>
                    <td align="left">
                    	<%=CrdNo%>
                    </td>
                </tr>
                <tr class="tab_tr">
                    <td align="right">
                    	缴费号：
                    </td>
                    <td align="left">
                    	<input type='text' name='JFH'/>
                    </td>
                </tr>
                <tr class="tab_tr">
                    <td align="right">
                    	电费年月：
                    </td>
                    <td align="left">
                    	<input type='text' name='DFNY'/>
                    	（输入格式为YYYYMM，如：201408）
                    </td>
                </tr>
                <tr class="tab_tr">
                    <td align="right">
                    	查询方式：
                    </td>
                    <td align="left">
                    	<input type='radio' name='CXFS' value='1'>主号签约</input>
        				<input type='radio' name='' value='2' >副号签约</input>
                    </td>
                </tr>
                <tr class="tab_result">
                    <td align="center">
			            <input type="submit"  class="button_bg"  value="确定" style={cursor:hand;}/>
			            <input type="button" class="button_bg" name="Submit3" value="返回" onclick="javascript:history.back()" />      
                     </td>      
               </tr>
           </table>
			<input type='hidden' name='CrdNo' value="<%=CrdNo%>"/><br/>
        </form> 
    </div>
    </body>
</html>