<%@page import="com.gdbocom.Transactions.WelLot"%>
<%@ page language="java" contentType="text/html;charset=GBK"%>
<%@page import="java.util.List"%>
<%@include file="/includeFiles/common.jsp" %>
<%
	String buyMode=ReqParamUtil.getParamAttr(request,"buyMode");
	HpTenBallCreater creater=new HpTenBallCreater(buyMode);
	List selNumList=creater.getSelNumList();
	HpTenBallCreater.HpTenParam param=creater.getParam();//获取配置参数
	String buyModeName=param.name;
	int  buyModeInt=Integer.parseInt(buyMode);
	String selNum=String.valueOf(param.selNum);//需选择的号码个数
	
	List txtList=new ArrayList();
	int group=2;
	//如果是选二连直需显示两组数，选三前直需要显示三组数
	if(WelLot.HpTenBuy.TWO_LINE==buyModeInt){
		group=2;
		txtList.add("前位");
		txtList.add("后位");
	}else{
		group=3;
		txtList.add("第一位");
		txtList.add("第二位");
		txtList.add("第三位");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>交通银行网上服务</title>
        <link rel="stylesheet" type="text/css" href="/personbank/css/<%=cssFileName%>"></link>
        <script type="text/javascript" src="/personbank/HttpProxy?URL=/midserv/js/jquery-1.11.1.min.js&dse_sessionId=<%=dse_sessionId%>"></script>
        <script type="text/javascript"  charset="UTF-8" src="/personbank/HttpProxy?URL=/midserv/js/formValidator.js&dse_sessionId=<%=dse_sessionId%>"></script>
        <script type="text/javascript"  charset="UTF-8" src="/personbank/HttpProxy?URL=/midserv/js/formValidatorRegex.js&dse_sessionId=<%=dse_sessionId%>"></script>
        <script type="text/javascript"  charset="UTF-8" src="/personbank/HttpProxy?URL=/midserv/js/commonJS.js&dse_sessionId=<%=dse_sessionId%>"></script>
        <script type="text/javascript">
	        jQuery.extend({    
	            uniqueArray:function(a) {    
	                var r=[];    
	                for (var i=0,l=a.length; i<l; ++i)jQuery.inArray(a[i],r)<0&&r.push(a[i]);    
	                return r;    
	           }    
	        });
	    	jQuery(document).ready(function(){
	    		var group=<%=group%>;
				jQuery.formValidator.initConfig({formid:"form1",onerror:function(msg){jQuery(":button").attr("disabled",false);alert(msg);}});
				jQuery("#times").formValidator().inputValidator({min:1,max:999,type:"number",onerror: "请填写正确的投注倍数!"});
				jQuery("#form1").submit(function(){
					//获取被选择号码所属组数
					var gs=new Array();
					jQuery(":checkbox:checked").each(function(){
						var v=jQuery(this).attr("group");
						gs.push(v);
					});
					
					//过滤掉重复的组数
					var uGs=jQuery.uniqueArray(gs);
					//如果组数长度不等于归档所需的组数，即没有正确选择
					if(group!=uGs.length){
						alert("请按区位正确选择号码！");
						return false;
					}
					
					//获取被选中的号码，并保存其所属的组
					var nums=new Array();
					jQuery(":checkbox:checked").each(function(){
						var v=jQuery(this).val();
						nums.push(v);
					});
					//过滤掉重复的号码
					var uNums=jQuery.uniqueArray(nums);
					//如果两组号码数不一样，即重复
					if(nums.length!=uNums.length){
						alert("选择的号码不能重复！");
						return false;
					}
					
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
		      	<%=buyModeName%>(至少选择<%=selNum%>个):
		    </td>
		  </tr>
		  <tr></tr>
		 <tr class="tab_tr"> 
		<%
			Iterator iter=txtList.iterator();
			int g=0;
			while(iter.hasNext()){
				g++;
				String txt=(String)iter.next();
		%>
		    <tr class="tab_tr"> 
		        <td align="right">
		             <%=txt%>:
		        </td>
		        <td>
				<table>
		<%
				out.println("<table>");
		        for(int i=0;i<selNumList.size(); i++){
		        	String obj=selNumList.get(i).toString();
		        	int val=Integer.parseInt(obj);
		        	
					if(i==0||val%5==1){
    					out.print("<tr>");
    				}
		%>
						<td> 
			        		<input type='checkbox' group="<%=g%>" name='<%=g%>selNum<%=String.valueOf(i)%>' value='<%=obj%>'><%=obj%></input>
						</td>
		<%
					if(val%5==0||i==(selNumList.size()-1)){
						out.print("</tr>");
					}
				}
				out.println("</td></table>");
			}
		%>
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
	            <input type="submit" class="button_bg" value="确定" style="cursor:hand;"/>
	            <input type="button" class="button_bg" name="Submit3" value="返回" onclick="javascript:history.back()" />      
	        </td>
	     </tr>
	     <input type='hidden' name='group' value='<%=group%>'/>
	     </table>
	     <%=
			ReqParamUtil.reqParamAttrToHtmlStr(request)
		 %>
		</form>
	</div>
	</body>
</html>