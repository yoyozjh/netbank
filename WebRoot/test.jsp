<%@ page language="java" contentType="text/html;charset=GBK"%>
<html>
    <head>
        <title>��ͨ�������Ϸ���</title>
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
								alert("����У�����Ψһ��ʧ�ܣ�");
								isExist=true;
							}else{
								//�����Ψһ��У�鲻ͨ��
								if(data.isExist==true){
									alert("�þ����Ѿ����ڶ�Ӧ��¼�������ظ���");
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
        <!-- ���ж����ֶ� -->
        <input type="hidden" name="URL" value="/midserv/Wel_hTen_buyRed.jsp"/>
        <table width="90%" align="center" cellpadding="1" cellspacing="1"  class="tab">
		  <tr align="center" class="tab_title">
		    <td align="left" colspan="2">
		     ��ѡ��Ͷע��ʽ:
		    </td>
		  </tr>
		  <tr></tr>
		 <tr class="tab_tr"> 
	        <td align="right">
	             Ͷע��ʽ:
	        </td>
	        <td align="left"> 
				<SELECT name="buyMode" id="buyMode">
					<option sum="ѡ����루����ѡ��1����" selected="selected">ѡһ��Ͷ</option>
					<option  sum="ѡһ��Ͷ������ѡ��1����">ѡһ��Ͷ</option>
					<option  sum="��ѡ��������ѡ��2����">��ѡ��</option>
					<option  sum="ѡ����ֱ������ѡ��2����">ѡ����ֱ</option>
					<option  sum="ѡ�����飨����ѡ��2����">ѡ������</option>
					<option sum="��ѡ��������ѡ��3����">��ѡ��</option>
					<option  sum="ѡ��ǰֱ������ѡ��3����">ѡ��ǰֱ</option>
					<option  sum="ѡ��ǰ�飨����ѡ��3����">ѡ��ǰ��</option>
					<option  sum="��ѡ�ģ�����ѡ��4����">��ѡ��</option>
					<option sum="��ѡ�壨����ѡ��5����">��ѡ��</option> 
				</SELECT>
				<input type="hidden" name="buyModeName" id="buyModeName"/>
	        </td>
	     </tr>
	     <tr class="tab_result"> 
	        <td align="center" colspan="2">
	            <input type="submit" class="button_bg" value="ȷ��" style="cursor:hand;"/>
	        </td>
	     </tr>
	     </table>
		</form>
	</div>
	</body>
</html>