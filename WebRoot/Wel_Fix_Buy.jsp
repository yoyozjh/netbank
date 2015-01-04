<%@ page language="java" contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*" %>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.bocom.midserv.gz.*"%>
<%@include file="/includeFiles/common.jsp" %>
<%
	String cdno = ReqParamUtil.reqParamTirm(request,"CrdNo");
	//补充通讯字段
	/*
	pageContext.setAttribute("GameId", "5", PageContext.SESSION_SCOPE);
	pageContext.setAttribute("PlayId", "1", PageContext.SESSION_SCOPE);
	pageContext.setAttribute("GrpNum", "2", PageContext.SESSION_SCOPE);
	pageContext.setAttribute("CrdNo", cdno, PageContext.SESSION_SCOPE);
	*/
	request.setAttribute("GameId","5");
	request.setAttribute("PlayId","1");
	request.setAttribute("GrpNum","2");
	request.setAttribute("CrdNo",cdno);
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
	    		jQuery("#form1").submit(function(){
	        		var rSize=jQuery(":checked[name^='forepart']").length;
	        		var bSize=jQuery(":checked[name^='rear']").length;
	        		var isOK=true;
	        		if(!(rSize>=6)){
	        			alert("至少选择6个红球！");
	        			isOK=false;
	        		}else if(bSize<1){
	        			alert("至少选择1个蓝球！");
	        			isOK=false;
	        		}
	        		return isOK;
	    		});
				jQuery.formValidator.initConfig({formid:"form1",onerror:function(msg){jQuery(":button").attr("disabled",false);alert(msg);}});
				jQuery("#BetMul").formValidator().inputValidator({min:1,max:100,type:"number",onerror: "请填写正确的投注倍数!"});
	    	});
        </script>
    </head>
    <body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  oncontextmenu="self.event.returnValue=false" onselectstart="return false">
    <div class="indent">
    <form action="/personbank/HttpProxy" method="post" name="form1" id="form1">
        <!-- 总行定义字段 -->
        <input type="hidden" name="URL" value="/midserv/Wel_Pck_Confirm.jsp"/>
        <table width="90%" align="center" cellpadding="1" cellspacing="1"  class="tab">
		  <tr align="center" class="tab_title">
		    <td align="left" colspan="2">
		     请选择红蓝球:
		    </td>
		  </tr>
		  <tr></tr>
		 <tr class="tab_tr"> 
	        <td align="right">
	             红色球（至少选择6个红球）:
	        </td>
	        <td align="left" colspan="50">
		    <table  border="1">
		    <%
		    	List lstFore = new ArrayList();
		    	for(int i=1; i<34; i++){lstFore.add(i+"");}
		        for(int i=0; i<7; i++){
		    %>
					<tr>
		            <%
		                for(int j=1;j<=5;j++){
							int tmp = i*5+j;
		            %>
						<td> 
					<%
							if(lstFore.contains(tmp+"")){
					%>
			        		<input type='checkbox' name='forepart<%=tmp%>' value='<%=this.formatnumber(tmp)%>'><%=this.formatnumber(tmp)%></input>
					<%
							}
					%>
						</td>
					<%				
					    }
					%>
					</tr>
			<%				
				}
			%>
			</table>
	        </td>
	     </tr>
	     	<tr class="tab_tr"> 
	        <td align="right">
	             蓝色球（至少选择1个蓝球）:
	        </td>
	        <td align="left" colspan="50">
				<table border="1">
				    <%
				    	List lstRear = new ArrayList();
				    	for(int i=1; i<17; i++){lstRear.add(i+"");}
				        for(int i=0; i<4; i++){
				    %>
							<tr>
				            <%
				                for(int j=1;j<=5;j++){
									int tmp = i*5+j;
				            %>
								<td> 
							<%
									if(lstRear.contains(tmp+"")){
							%>
					        		<input type='checkbox' name='rear<%=tmp%>' value='<%=this.formatnumber(tmp)%>'><%=this.formatnumber(tmp)%></input>
							<%
									}
							%>
								</td>
							<%				
							    }
							%>
							</tr>
					<%				
						}
					%>
				</table>
	        </td>
	     </tr>
	     <tr class="tab_tr"> 
	        <td align="right">
	             请填写倍数（倍数不超过100）:
	        </td>
	        <td align="left"> 
				<input type='text' id='BetMul' name='BetMul' value='1'/>
	        </td>
	     </tr>
	     <tr class="tab_result"> 
	        <td align="center" colspan="2">
	            <input id="commit" type="submit" class="button_bg" value="下一步" style="cursor:hand;"/>
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
<%!
	public String formatnumber(int inputstr){
		String outputstr;
		if(inputstr<=9){
			outputstr="0"+String.valueOf(inputstr);
		}else{
			outputstr = String.valueOf(inputstr);
		}
		return outputstr;
	}
%>
