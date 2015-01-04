<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@page pageEncoding="utf-8"%>
<%request.setCharacterEncoding("utf-8");%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="com.bocom.midserv.gz.*"%>
<%@ page import="com.viatt.bean.*"%>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
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
        <link rel="stylesheet" type="text/css" href="/personbank/css/<%=cssFileName%>">

        <!--引用总行端公用安全组件，不需要引用HttpProxy-->
		<script language="JavaScript" src="/personbank/js/public.js"></script>
		<script language=JavaScript src="/personbank/js/writeActivxObject.js"></script>
		<script language="JavaScript">
		   var clickBoolean=true;
			function beforeSubmit(){
	            if(clickBoolean){
	                if(document.safeInput1.allType()!="10000"
                        || document.safeInput1.isValid()){
	                    alert("请输入合法的密码");
	                    return;
	                }
	                if(document.form1.DynamicCode.value
	                        !='<%=request.getParameter("dynamicCode")%>'){
	                    alert('动态密码不符');
	                    return false;
	                }

	                document.safeInput1.commit("safeCommit1");
	                document.safeCommit1.submit("form1"); 
	                clickBoolean=false;
	            }
			}
		</script>
    </head>


    <body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  oncontextmenu=self.event.returnValue=false onselectstart="return false">
    <SCRIPT language=JavaScript> writeCommitActivxObject('')</SCRIPT>
    <div class="indent">
    <form action="/personbank/HttpProxy" method=post name="form1">
        <!-- 总行定义字段 -->
        <input type="hidden" name="URL" value="/midserv/Efek_460411.jsp"/>
        <input type="hidden" name="dse_sessionId" value="<%=dse_sessionId%>"/>
<%

	Map form = request.getParameterMap();


	//显示确认值
	Set keys = showKey.keySet();

	for(Iterator it = keys.iterator(); it.hasNext(); ){

		String key = (String) it.next();
		String showValue = (String)showKey.get(key);
		String type = (String)keyType.get(key);
		
		out.println("<tr class=\"tab_tr\">");
		if(form.containsKey(key)){
			String formValue = ( (String[])form.get(key) )[0];
			String formattedValue = null==type?formValue:getFormattedValue(formValue, type);
			out.println("<td align=\"right\" width=\"50%\">"
				+showValue
				+"</td>"
				+"<td align=\"left\" width=\"50%\">"
				+formattedValue
				+"</td>");
		}else{
			out.println("<td align=\"right\" width=\"50%\">"
				+showValue
				+"</td>"
				+"<td align=\"left\" width=\"50%\">null</td>");
		}
		out.println("</tr>");
	}

%>
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