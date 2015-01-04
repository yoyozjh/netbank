function condition()
{
	var j=0;
	if(document.all("explain").length>1){
		for(j=0;j<document.all("name_ch").length;j++){
			if (document.all("name_ch")[j].value==""||document.all("name_ch")[j].value==null)
			{
				alert("请输入名称！");
				return false;
  			}
  			if (document.all("explain")[j].value==""||document.all("explain")[j].value==null)
			{
				alert("请输入说明！");
				return false;
  			}
  			if (document.all("name_en")[j].value==""||document.all("name_en")[j].value==null)
			{
				alert("请输入表单标识！");
				return false;
  			}
  			if (document.all("length_s")[j].value==""||document.all("length_s")[j].value==null)
			{
				alert("请输入表单长度！");
				return false;
  			}
  		}
  	}
  	else{
  		if (this.document.form1.name_ch.value==""||this.document.form1.name_ch.value==null)
		{
			alert("请输入名称！");
			return false;
  		}
  		if (this.document.form1.explain.value==""||this.document.form1.explain.value==null)
		{
			alert("请输入说明！");
			return false;
  		}
  		if (this.document.form1.name_en.value==""||this.document.form1.name_en.value==null)
		{
			alert("请输入表单标识！");
			return false;
  		}
  		if (this.document.form1.length_s.value==""||this.document.form1.length_s.value==null)
		{
			alert("请输入表单长度！");
			return false;
  		}
  	}
 	return true;
}

function go(){
	if(condition()){
		var j=1,kk=0;
		var sign=1;
		
		if(document.all("explain").length>1){
		j=document.all("explain").length;
		}
		form1.action="add_biz_ok.jsp?row="+j+"";
		form1.target="_top";
		form1.submit();
	}
}

function next(){
	if(condition()){
		var k=1;
		if(document.all("explain").length>1){
		k=document.all("explain").length;
		}
		form1.action="add_biz2.jsp?row="+k+"";
		form1.target="_top";
		form1.submit();
	}
}

function preview(){
	if(condition()){
		var j=1,kk=0;
		if(document.all("explain").length>1){
		j=document.all("explain").length;
		}
		form1.action="preview1.jsp?row="+j+"";
		form1.target="_blank";
		form1.submit();
	}
}

function back1(){

			form1.action="modadd_biz.jsp";
			form1.target="_top";
			form1.submit();

}

function back2(){

			form1.action="modadd_biz1.jsp";
			form1.target="_top";
			form1.submit();
}

function back3(){

			form1.action="modadd_biz2.jsp";
			form1.target="_top";
			form1.submit();
}

function delbiz(biz_id){
	question = confirm("您确认要删除此代理业务吗？")
	if (question != "0"){
		window.open("del_biz.jsp?biz_id="+biz_id,"del","top=150,left=180,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,width=400,height=300")
   	}
}

function delstep(){
	question = confirm("您确认要删除此步吗？")
	if (question != "0"){
		form1.action="del_step.jsp";
		form1.target="_top";
		form1.submit();
	}
}
