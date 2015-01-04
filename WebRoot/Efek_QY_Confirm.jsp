<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@page pageEncoding="utf-8"%>
<%request.setCharacterEncoding("utf-8");%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.bocom.midserv.gz.*"%>
<%@ page import="com.viatt.bean.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>

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

    //手机动态密码字段
    String sendPass = request.getParameter("sendPass");
    if(!("0".equals(sendPass)||"1".equals(sendPass))){
        response.sendRedirect("Gds_Pub_Agree.jsp");
    }
    String dynamicCode = request.getParameter("dynamicCode");
    String dynamicCodeSeq = request.getParameter("dynamicCodeSeq");
    log.Write( "sendPass=["+sendPass+"] 动态密码=["+dynamicCode+"] 动态密码序号=["+dynamicCodeSeq+"]" );

	
	//设置需要显示的值和名称,
	Map showKey = new HashMap();
	showKey.put("JFH", "缴费号");
	showKey.put("JSHMC", "结算户名称");
	showKey.put("YDDZ", "用电地址");
	showKey.put("DFNY", "电费年月");
	showKey.put("QFJE", "欠费金额");
	showKey.put("BJ", "本金");
	showKey.put("WYJ", "违约金");


	Map keyType = new HashMap();
	keyType.put("JFH", "String");
	keyType.put("JSHMC", "String");
	keyType.put("YDDZ", "String");
	keyType.put("DFNY", "String");
	keyType.put("QFJE", "BigDecimal");
	keyType.put("BJ", "BigDecimal");
	keyType.put("WYJ", "BigDecimal");

	//备注
	String remark = "请仔细核对信息，如因客户输入错误导致缴费失败的，将不予退还缴费金额";
%>
<html>
    <head>
        <title>交通银行网上服务</title>
        <!-- 总行样式表，定义总体色调与表格等格式 -->
        <link rel="stylesheet" type="text/css" href="/personbank/css/<%=cssFileName%>">
        <!-- 分行样式表，定义段落、超链接格式 -->
        <link rel="stylesheet" type="text/css"
            href="/personbank/HttpProxy?URL=/midserv/css/css.css&dse_sessionId=<%=dse_sessionId%>">
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
            <input type="hidden" name="URL" value="/midserv/Efek_460444.jsp"/>
            <input type="hidden" name="dse_sessionId" value="<%=dse_sessionId%>"/>

<%
	Map form = request.getParameterMap();
	//设置隐藏表单值
	Iterator itKeys = form.keySet().iterator();
	while(itKeys.hasNext()){
		String key = (String)itKeys.next();
		String[] values = ( (String[]) form.get(key) );
		if(1==values.length){
			out.println("<input type='hidden' name='"+key+"' value=\""+values[0]+"\"/><br/>");
		}
	}

%>
            <table width="90%" align="center" cellpadding="1" cellspacing="1" class="tab">
               <tr class="tab_tr">
                    <td align="center"  colspan="2">请确认缴费信息:
                     </td>      
               </tr>

<%
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
			      <tr class="tab_tr"> 
			        <td align="right">
			            请输入交易密码：
			        </td>
			        <td align="left">
			<SCRIPT language=JavaScript> writePwdActivxObjectLenClass('safeInput1','safeInput1','','password',20,6,'20','153')</SCRIPT>
			        </td>
			      </tr>
			      <tr class="tab_tr"> 
			        <td align="right">
			            请输入手机动态密码：
			        </td>
			        <td align="left">
			            <input type="text" name="DynamicCode">序号：（<%=dynamicCodeSeq %>）
			        </td>
			      </tr>
			      <tr class="tab_result"> 
			        <td align="right">
			            <input type="button" class="button_bg" onclick="javascript:beforeSubmit();" value="提交" style={cursor:hand;}>
			        </td>
			        <td align="left">
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