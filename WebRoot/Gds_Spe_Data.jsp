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
        <link rel="stylesheet" type="text/css" href="/personbank/css/<%=cssFileName%>">
    </head>


    <body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  oncontextmenu=self.event.returnValue=false onselectstart="return false" >
    <div class="indent">
    <form action="/personbank/HttpProxy" method=post name="form1">
        <!-- 总行定义字段 -->
        <input type="hidden" name="URL" value="/midserv/Gds_Pub_Confirm.jsp"/>
        <input type="hidden" name="dse_sessionId" value="<%=dse_sessionId%>"/>

<%
    //获取已签约数据
    String signResult = request.getParameter("Gds_signResult");
    String Gds_GdsBIds = request.getParameter("Gds_GdsBIds");

    //设置注册版手机银行字段,本来需要对网银类型进行区分，但文档并没有特别要求，而且
    //天讯缴费等交易也对区分进行了屏蔽
    String loginType = request.getParameter("loginType");
%>
    <!-- 发送手机动态密码字段 -->
    <input type="hidden" name="sendPass" value="1"/>

    <!-- 特色业务字段 -->
    <input type="hidden" name="Gds_signResult" value="<%=signResult%>"/>
    <input type="hidden" name="Gds_GdsBIds" value="<%=Gds_GdsBIds%>"/>

	<table width="90%" align="center" cellpadding="1" cellspacing="1" class="tab">
<%

    String[] gdsBids = Gds_GdsBIds.split(",");
    Map business = GdsPubData.getSignBusiness();
    for(int i=0; i<gdsBids.length; i++){
        if( null==gdsBids[i] || ("".equals(gdsBids[i])) ){
            continue;
        }

        String businessId = gdsBids[i];
        String businessName = (String) business.get(businessId);
        if(businessId.equals(GdsPubData.businessOfMobile)){
%>
      <tr align="center" class="tab_sub_title"> 
        <td colspan="2">
        <%=businessName %>
        </td>
      </tr>
      <tr class="tab_tr"> 
        <td align="right" width="50%">
        <%="请选择签约类型:" %>
        </td>
        <td align="left" width="50%">
        <input type='radio' name='TAgtTp<%=businessId %>' value='1'
            onclick=TCusId.style.display='none' >主号签约</input>
        <input type='radio' name='TAgtTp<%=businessId %>' value='2'
            onclick=TCusId.style.display='block' >副号签约</input>
        </td>
      </tr>
      <tr class="tab_tr"> 
        <td align="right" width="50%">
        <%="请输入"+businessName+"主号:" %>
        </td>
        <td align="left" width="50%">
        <input type='text' name='MCusId<%=businessId %>' />
        </td>
      </tr>
      <tr class="tab_tr" id='TCusId' style="display:none"> 
        <td align="right">
        <%="请输入"+businessName+"副号:" %>
        </td>
        <td align="left">
        <input type='text' name='TCusId<%=businessId %>' />
        </td>
      </tr>
<%

        }else{
%>
      <tr align="center" class="tab_sub_title"> 
        <td colspan="2">
        <%=businessName %>
        </td>
      </tr>
      <tr class="tab_tr"> 
        <td align="right" width="50%">
        <%="请输入"+businessName+"缴费号:" %>
        </td>
        <td align="left" width="50%">
        <input type='text' name='TCusId<%=businessId %>' />
        </td>
      </tr>
      <tr class="tab_tr"> 
        <td align="right">
        <%="请输入"+businessName+"缴费户名:" %>
        </td>
        <td align="left">
        <input type='text' name='TCusNm<%=businessId %>' />
        </td>
      </tr>
<%
        }
    }
%>

	  <tr>
      <tr class="tab_result"> 
        <td align="right">
            <input type="submit"  class="button_bg"  value="确定" style={cursor:hand;}/>
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