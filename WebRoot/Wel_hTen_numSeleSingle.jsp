<%@ page language="java" contentType="text/html;charset=GBK"%>
<%@page import="java.util.List"%>
<%@include file="/includeFiles/common.jsp" %>
<%
String buyMode=ReqParamUtil.getParamAttr(request,"buyMode");
HpTenBallCreater creater=new HpTenBallCreater(buyMode);
List selNumList=creater.getSelNumList();
HpTenBallCreater.HpTenParam param=creater.getParam();//获取配置参数
String buyModeName=param.name;
String selNum=String.valueOf(param.selNum);//需选择的号码个数
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
				jQuery("#BetMul").formValidator().inputValidator({min:1,max:999,type:"number",onerror: "请填写正确的投注倍数!"});
				jQuery("#commit").click(function(){
					var size=jQuery(":checkbox:checked").length;
					//判断是否选择足够号码
					if(size<<%=selNum%>){
						alert("请至少选择<%=selNum%>个号码!");
						return false;
					}
				});
	    	});
	    </script>
    </head>
    <body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  oncontextmenu="self.event.returnValue=false" onselectstart="return false">
    <div class="indent">
    <form action="/personbank/HttpProxy" method="post" name="form1" id="form1">>
        <input type="hidden" name="URL" value="/midserv/Wel_hTen_Confirm.jsp"/>
        <table width="90%" align="center" cellpadding="1" cellspacing="1"  class="tab">
		  <tr align="center" class="tab_title">
		    <td align="left" colspan="2">
		      	<%=buyModeName%>
		    </td>
		  </tr>
		  <tr></tr>
		 <tr class="tab_tr"> 
	        <td align="right">
	                 选择号码:
	        </td>
	        <td align="left"> 
	        <table  border="1">
			    <%
			        for(int i=0;i<selNumList.size(); i++){
			        	String obj=selNumList.get(i).toString();
			        	int val=Integer.parseInt(obj);
			        	
			        	if(i==0||val%5==1){
	    					out.print("<tr>");
	    				}
			    %>
							<td> 
				        		<input type='checkbox' name='1selNum<%=String.valueOf(i)%>' value='<%=obj%>'><%=obj%></input>
							</td>
				<%
		    		    //换行
		    			if(val%5==0||i==(selNumList.size()-1)){
		    				out.print("</tr>");
		    			}
					}
				%>
			</table>
	        </td>
	     </tr>
	     <tr align="center" class="tab_tr">
		    <td align="right">
		      	倍数(不超过100):
		    </td>
		    <td align="left">
		    	<input type="text" name="BetMul" id="BetMul" value="1"/>
		    </td>
		 </tr>
	     <tr class="tab_result"> 
	        <td align="center" colspan="2">
	            <input id="commit" type="submit" class="button_bg" value="确定" style="cursor:hand;"/>
	            <input type="button" class="button_bg" name="Submit3" value="返回" onclick="javascript:history.back()" />      
	        </td>
	     </tr>
	     <input type='hidden' name='group' value='1'/>
	     </table>
	     <%=
			ReqParamUtil.reqParamAttrToHtmlStr(request)
		 %>
		</form>
	</div>
	</body>
</html>