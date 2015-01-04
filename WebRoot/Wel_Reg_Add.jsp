<%@page import="javax.rmi.CORBA.Tie"%>
<%@page import="com.gdbocom.Transactions.WelLot"%>
<%@ page language="java" contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*" %>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.bocom.midserv.gz.*"%>
<%@ page import="com.gdbocom.util.PreAction" %>
<%@include file="/includeFiles/common.jsp" %>
<%
	String busStr=ReqParamUtil.getParamAttr(request,"Bus");
	int bus=Integer.parseInt(busStr);
	String title="";
	if(bus==WelLot.ADDREG){
		title="用户注册:";
	}else if(bus==WelLot.UPDREG){
		title="更改用户注册:";
	}
%>
<html>
    <head>
        <title>交通银行网上服务</title>
        <link rel="stylesheet" type="text/css" href="/personbank/css/<%=cssFileName%>"></link>
        <script type="text/javascript" src="/personbank/HttpProxy?URL=/midserv/js/jquery-1.11.1.min.js&dse_sessionId=<%=dse_sessionId%>"></script>
        <script type="text/javascript"  charset="UTF-8" src="/personbank/HttpProxy?URL=/midserv/js/formValidator.js&dse_sessionId=<%=dse_sessionId%>"></script>
        <script type="text/javascript"  charset="UTF-8" src="/personbank/HttpProxy?URL=/midserv/js/formValidatorRegex.js&dse_sessionId=<%=dse_sessionId%>"></script>
        <script type="text/javascript">
	    	jQuery(document).ready(function(){
				jQuery.formValidator.initConfig({formid:"form1",onerror:function(msg){jQuery(":button").attr("disabled",false);alert(msg);}});
				jQuery("#IdNo").formValidator().regexValidator({regexp:"idcard",datatype:"enum",onerror:"请填写正确的身份证号码!"});
				jQuery("#IdNo").formValidator().regexValidator({regexp:"idcard",datatype:"enum",onerror:"请填写正确的身份证号码!"});
				jQuery("#MobTel,#MobTel_Con").formValidator().inputValidator({min:1,onerror: "请填写正确的手机号!"});
				jQuery("#MobTel,#MobTel_Con").formValidator().regexValidator({regexp:"mobile",datatype:"enum",onerror:"请填写正确的手机号!"});
				//mobile
	    		jQuery("#commit").click(function(){
	    			var m1=jQuery("#MobTel").val();
	    			var m2=jQuery("#MobTel_Con").val();
	    			if(m1!=m2){
	    				alert("两次输入的手机号不一致！");
	    				return false;
	    			}
	    		});
	    	});
        </script>
    </head>
    <body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  oncontextmenu="self.event.returnValue=false" onselectstart="return false">
    <div class="indent">
    <form action="/personbank/HttpProxy" method="post" name="form1" id="form1">
        <!-- 总行定义字段 -->
        <input type="hidden" name="URL" value="/midserv/Wel_Reg_Pre.jsp"/>
        <input type="hidden" name="SigTyp" value="1"/>
        <!-- 发送手机动态密码字段 -->
   		<input type="hidden" name="sendPass" value="1"/>
        <%-- 
        <input type="hidden" name="dse_sessionId" value="<%=dse_sessionId%>"/>
        <input type='hidden' name='preSaveKey' value='IdTyp,IdNo,SigTyp,MobTel,MobTel_Con' />
        --%>
        <table width="90%" align="center" cellpadding="1" cellspacing="1"  class="tab">
		  <tr align="center" class="tab_title">
		    <td align="left" colspan="2">
		     <%=title%>
		    </td>
		  </tr>
		  <tr></tr>
		 <tr class="tab_tr"> 
	        <td align="right">
	             选择证件类型:
	        </td>
	        <td align="left"> 
				<SELECT name="IdTyp">
					<option value="15">身份证</option>
				</SELECT>
	        </td>
	     </tr>
	     <tr class="tab_tr"> 
	        <td align="right">
	             请输入您银行卡开户证件号:
	        </td>
	        <td align="left"> 
	        	<input type='text' name='IdNo' id='IdNo'/>
	        </td>
	     </tr>
	     <%--  
	     <tr class="tab_tr"> 
	        <td align="right">
	             签约手机号:
	        </td>
	        <td align="left"> 
	        	<SELECT name="SigTyp">
					<option value="0" selected="selected">本机手机号：<%=sjNo%></option>
					<option value="1">其他手机号</option>
				</SELECT>
	        </td>
	     </tr>
	     --%>
	     <tr class="tab_tr"> 
	        <td align="right">
	             手机号:
	        </td>
	        <td align="left"> 
				<input type='text' name='MobTel' id='MobTel'/>
	        </td>
	     </tr>
	     <tr class="tab_tr"> 
	        <td align="right">
	             再次输入手机号:
	        </td>
	        <td align="left"> 
				<input type='text' name='MobTel_Con' id='MobTel_Con'/>
	        </td>
	     </tr>
	    <tr class="tab_tr"> 
	        <td align="center" colspan="2">
	            <label style="color: red;">（用于发送投注成功确认短信以及中奖通知等相关事宜，如您期间变更手机号，请通过“签约手机号修改”功能及时变更您预留的手机号。）</label>
	        </td>
	     </tr>
	     <tr class="tab_result"> 
	        <td align="center" colspan="2">
	            <input type="submit" class="button_bg" value="确定" id="commit" style="cursor:hand;"/>
	            <input type="button" class="button_bg" name="Submit3" value="返回" onclick="javascript:history.back()" />
	        </td>
	     </tr>
		</table>
		<%=
			ReqParamUtil.reqParamAttrToHtmlStr(request)
		%>
		</form>
	</div>
    </body>
</html>