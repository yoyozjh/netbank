<%@ page language="java" contentType="text/html;charset=GBK"%>
<html>
    <head>
        <title>交通银行网上服务</title>
         <script type="text/javascript" src="/midserv/js/jquery-1.11.1.min.js"></script>
        <script type="text/javascript"  charset="UTF-8" src="/midserv/js/formValidator.js"></script>
        <script type="text/javascript"  charset="UTF-8" src="/midserv/js/formValidatorRegex.js"></script>
        <script type="text/javascript"  charset="UTF-8" src="/midserv/js/jquery.form.js"></script>
        <script type="text/javascript"  charset="UTF-8" src="/midserv/js/json2.js"></script>
        <script type="text/javascript"  charset="UTF-8" src="/midserv/js/commonJS.js"></script>
        <script type="text/javascript">
	    	jQuery(document).ready(function(){
	    		jQuery("#form1").submit(function(){
					jQuery.ajax({
						url: "http://182.53.15.140:7001/midserv/HpTenProcess.do?method=proSelNum",
						async:false,
						cache:false,
						type:"POST",
						dataType:"json",
						success:function(data){
							if(!data.isSuccess){
								alert("调用校验局向唯一性失败！");
								isExist=true;
							}else{
								//如果不唯一，校验不通过
								if(data.isExist==true){
									alert("该局向已经存在对应记录，不能重复！");
									isExist=true;
								}
							}
						},
						error:function(XMLHttpRequest, textStatus, errorThrown){
							alert(XMLHttpRequest+"    "+textStatus+"    "+errorThrown);
						}
					});
	    			return false;
	    		});
	    	});
	    	
        </script>
    </head>
    <body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
    <div class="indent">
    <form action="/personbank/HttpProxy" method="post" name="form1" id="form1">
        <!-- 总行定义字段 -->
        <input type="hidden" name="URL" value="/midserv/Wel_hTen_buyRed.jsp"/>
        <table width="90%" align="center" cellpadding="1" cellspacing="1"  class="tab">
		  <tr align="center" class="tab_title">
		    <td align="left" colspan="2">
		     请选择投注方式:
		    </td>
		  </tr>
		  <tr></tr>
		 <tr class="tab_tr"> 
	        <td align="right">
	             投注方式:
	        </td>
	        <td align="left"> 
				<SELECT name="buyMode" id="buyMode">
					<option sum="选择号码（至少选择1个）" selected="selected">选一数投</option>
					<option  sum="选一红投（至少选择1个）">选一红投</option>
					<option  sum="任选二（至少选择2个）">任选二</option>
					<option  sum="选二连直（至少选择2个）">选二连直</option>
					<option  sum="选二连组（至少选择2个）">选二连组</option>
					<option sum="任选三（至少选择3个）">任选三</option>
					<option  sum="选三前直（至少选择3个）">选三前直</option>
					<option  sum="选三前组（至少选择3个）">选三前组</option>
					<option  sum="任选四（至少选择4个）">任选四</option>
					<option sum="任选五（至少选择5个）">任选五</option> 
				</SELECT>
				<input type="hidden" name="buyModeName" id="buyModeName"/>
	        </td>
	     </tr>
	     <tr class="tab_result"> 
	        <td align="center" colspan="2">
	            <input type="submit" class="button_bg" value="确定" style="cursor:hand;"/>
	        </td>
	     </tr>
	     </table>
		</form>
	</div>
	</body>
</html>
