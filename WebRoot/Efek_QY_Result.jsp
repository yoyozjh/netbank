<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@page pageEncoding="utf-8"%>
<%request.setCharacterEncoding("utf-8");%>
<%@ page import="com.bocom.midserv.gz.*"%>
<%@ page import="com.viatt.bean.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>

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
	
	//设置需要显示的值和名称,
	Map showKey = new HashMap();
	showKey.put("JFH", "缴费号");
	showKey.put("JSHMC", "结算户名称");
	showKey.put("YDDZ", "用电地址");
	showKey.put("DFNY", "电费年月");
	showKey.put("SKJE", "实扣金额");
	showKey.put("JFJGSM", "缴费结果说明");
	showKey.put("TckNo", "会计业务流水号");


	Map keyType = new HashMap();
	keyType.put("JFH", "String");
	keyType.put("JSHMC", "String");
	keyType.put("YDDZ", "String");
	keyType.put("DFNY", "String");
	keyType.put("SKJE", "BigDecimal");
	keyType.put("JFJGSM", "String");
	keyType.put("TckNo", "String");

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
            <input type="hidden" name="URL" value="/midserv/Efek_QY_Qry_Input.jsp"/>
            <input type="hidden" name="dse_sessionId" value="<%=dse_sessionId%>"/>

            <table width="90%" align="center" cellpadding="1" cellspacing="1" class="tab">
               <tr class="tab_tr">
                    <td align="center"  colspan="2">交易成功:
                     </td>      
               </tr>
<%
	Map form = request.getParameterMap();


	//显示确认值
	Set keys = showKey.keySet();

	for(Iterator it = keys.iterator(); it.hasNext(); ){

		String key = (String) it.next();
		String showValue = (String)showKey.get(key);
		String type = (String)keyType.get(key);
		
		if(form.containsKey(key)){
			String formValue = ( (String[])form.get(key) )[0];
			String formattedValue = null==type?formValue:getFormattedValue(formValue, type);
			out.println("<tr class=\"tab_tr\">"
				+"<td align=\"right\">"
				+showValue
				+"</td>"
				+"<td align=\"left\">"
				+formattedValue
				+"</td>"
				+"</tr>");
		}else{
			out.println("<tr class=\"tab_tr\">"
				+"<td align=\"right\">"
				+showValue
				+"</td>"
				+"<td align=\"left\">"
				+"null"
				+"</td>"
				+"</tr>");
		}
	}

%>
                <tr class="tab_result">
                    <td align="center"  colspan="2">
			            <input type="submit"  class="button_bg"  value="确定" style={cursor:hand;}/>
			            <input type="button" class="button_bg" name="Submit3" value="返回" onclick="javascript:history.back()" />      
                     </td>      
               </tr>
           </table>
        </form> 
    </div>
    </body>
</html>
<%!
	public String getFormattedValue(String value, String type){
		if("BigDecimal".equals(type)){
			return new DecimalFormat("#,###.00").format(Double.parseDouble(value)/100.0);
		}else{
			return value;
		}

	}
%>