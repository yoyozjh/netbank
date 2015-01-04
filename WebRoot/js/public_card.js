function add_select(Obj,length,one_true_two_false)
{
	if(one_true_two_false)
	for (var i=0;i<length;i++)
	{
		Obj.options[i]=new Option("",0);
		Obj.options[i].value=i+1;
		Obj.options[i].text=i+1;
	}
	else
	for(var i=0;i<length;i++)
	{
		Obj.options[i]=new Option("",0);
		var temp;
		if(i<9)
		{
			temp=i+1;
			temp="0"+temp;
			Obj.options[i].value=temp;
			Obj.options[i].text=temp;
		}
		else{
			Obj.options[i].value=i+1;
			Obj.options[i].text=i+1;
		}
	}
}

function check_Year_Month_Day(Obj_Year,Obj_Month,Obj_Day,one_true_two_false)
{
	Year=Obj_Year.value;
	Month=Obj_Month.value;
	Day=Obj_Day.value;	
	
	var temp=Day;
	
	if((Year%4==0 && Year%100!=0) || Year%400==0)
	{
		if(Month==2)
		{
			var length=Obj_Day.length;
			for(var i=0;i<length;i++)
				Obj_Day.options[0]=null;
			add_select(Obj_Day,29,one_true_two_false);
			if(temp<30)
				Obj_Day.value=temp;
			else
				Obj_Day.value=15;			
		}
		else{
			if(Month==1 || Month==3 || Month==5 || Month==7 || Month==8 || Month==10 || Month==12)
			{
				var length=Obj_Day.length;
				for(var i=0;i<length;i++)
					Obj_Day.options[0]=null;
				add_select(Obj_Day,31,one_true_two_false);
				Obj_Day.value=temp;
			}
			else{
				var length=Obj_Day.length;
				for(var i=0;i<length;i++)
					Obj_Day.options[0]=null;
				add_select(Obj_Day,30,one_true_two_false);
				if(temp<31)
					Obj_Day.value=temp;
				else
					Obj_Day.value=15;
			}
		}
	}
	else{
		if(Month==4 || Month==6 || Month==9 || Month==11)
		{
			var length=Obj_Day.length;
			for(var i=0;i<length;i++)
				Obj_Day.options[0]=null;
			add_select(Obj_Day,30,one_true_two_false);
			if(temp<31)
				Obj_Day.value=temp;
			else
				Obj_Day.value=15;
		}
		else if(Month!=2){
			var length=Obj_Day.length;
			for(var i=0;i<length;i++)
				Obj_Day.options[0]=null;
			add_select(Obj_Day,31,one_true_two_false);
			if(temp<32)
				Obj_Day.value=temp;
			else
				Obj_Day.value=15;
		}
		else{
			var length=Obj_Day.length;
			for(var i=0;i<length;i++)
				Obj_Day.options[0]=null;
			add_select(Obj_Day,28,one_true_two_false);
			if(temp<29)
				Obj_Day.value=temp;
			else
				Obj_Day.value=15;
		}
	}	
}

//除去左右空格
function javaTrim(string)
{
	var length1, i, j;
	var string1 = "";
	
	length1 = string.length;
	for (i = 0 ; i < length1 ; i++) 
	{ 
		//除去左边空格
		if(string.charAt(i) != " ")  
		{
			//除去左边空格后
			for (j = i ; j < length1 ; j++) string1 = string1 + string.charAt(j);
			break;	
		}//除去左边空格后
	}	//除去左边空格
	
	length1 = string1.length;
	string = string1;
	string1 = "";
	for (i = length1 - 1 ; i >= 0 ; i--)
	{  
		//除去右边空格
		if(string.charAt(i) != " ")
		{
			//除去右边空格后
			for (j = 0 ; j <= i ; j++) string1 = string1 + string.charAt(j);
			break;			
		}
	}	
	string = string1;	
	return(string);
}

//判断查询起始日期是否大于截止日期
function validateStartDateAndEndDate(startYear,startMonth,startDay,endYear,endMonth,endDay)
{
	if(startYear > endYear)
	{
		alert("起始年份不能大于截止年份");
		return ;
	}
	else if(startYear == endYear)
	{
		if(startMonth > endMonth)
		{
			alert("起始月份不能大于截止月份");
			return ;
		}
		else if(startMonth == endMonth)
		{
			if(startDay <= endDay)
			{
				return true;
			}
			else
			{
				alert("起始日期不能大于截止日期");
				return ;
			}
		}
		else
		{
			return true;	
		}
	}
	else 
	{
		return true;
	}
}

//判断数值,必须为纯数字
function checkNumber(string) 
{ 
	var length1 , i , j;
	var string1="";
   
  
    string1 = javaTrim(string)
	length1 = string1.length;
	if (length1 == 0) 
	{
		return ; 
	}
	
	for (i = 0 ; i < length1 ; i++) 
	{  //判断每位数字
		if(isNaN(parseInt(string.charAt(i),10)))  
		{
				alert( "错误！请输入数值型数据！");					
				return ; 
		} 
	}

	return (true);
}

//判断数值,是否为浮点数
function checkFloat(string) { 
	var length1 , i , j , k;
	var string1="";
  
    string1 = javaTrim(string)
	length1 = string1.length;
	if (length1 == 0) 
	{
		alert( "错误！空串！");
		return ; 
	}
	
	if (string.charAt(0)=="0" )
	{
		 if (length1 == 1)
		 {
	     	alert("金额不能为0，请重新填写！");
	     	return ;
		 }
		 else
		 {
		 	if (!(string.charAt(1)=="."))
		  	{
		    	alert("金额首位不能为0，请重新填写！");
		    	return ;
		    }
		}
	}
	
	j=0;
	k=0;
	for (i = 0 ; i < length1 ; i++) 
	{  
		//判断每位字符是否为数字
		if(isNaN(parseInt(string.charAt(i),10)))  
		{
			//不是数字
			if(string.charAt(i) != ".") 
			{
				alert( "错误！请输入数值型数据！");					
				return ; 
			} 
			else  
			{
				j++;
				if(length1 - i > 3 )
				{
					alert("小数点后只能有两位！");
					return ;
				}
			}
 		}	
 		else
 		{
 			//是数字
 			if(string1.charAt(i)=="0")
 			{
 				k++;	
 			}
 		}		
	}
	
	if(j > 1) 
	{
		alert( "错误！小数点只能有一个!");			
		return ;
	}
	
	if(k == length1-1)
	{
		alert( "金额不能全为0!");			
		return ;	
	}	

	return (true);
}

//**********金额检查**********
function moneyCheck(moneyString)
{		
	var j=0;		
	var stringTemp = javaTrim(moneyString);	
	var stringlength = stringTemp.length;
	
	if (stringlength == 0) 
	{
		alert("不能输入空字符");
		return ; 
	}
	
	if(stringTemp.substring(0,1) == ".")
	{
		alert("金额输入错误，请重新输入");
		return;
	}
	
	//判断金额是否为"0",为"0"时给出出错提示
	if ((stringTemp == "0.00")||(stringTemp == "0.0")||(stringTemp == "0.")||(stringTemp == "0")||(stringTemp == ".0")) 
	{
    alert("金额不能为0，请重新填写");    
		return ;
	}
	
	//检查金额不能为"0",且次位非小数点时首位不能为"0"
	if (stringTemp.charAt(0)=="0" )
	{		
		if (stringlength == 1)
		{		
		 	alert("金额不能为0，请重新填写！");
	   	return ;
	  }
	  else
	  {	  	
	  	if (!(stringTemp.charAt(1)=="."))
	  	{	  	
				alert("金额首位不能为0，请重新填写！");
				return ;
			}						
		}
	}
	
	//判断每位数字
	for (i = 0 ; i < stringlength ; i++) 
	{ 		
		if(isNaN(parseInt(stringTemp.charAt(i),10)))  
		{		
			if(stringTemp.charAt(i) != ".")  
			{
				alert( "请输入数值型数据");
				return ; 
			} 
			else  
			{			
				j++;
							
				if(stringlength - i > 3 )
				{
					alert("小数点后只能有两位");
					return ;
				}
			}						
		}	
	} //End For	
	
	if(stringTemp.charAt(stringlength-1) == ".")
	{
		alert( "请输入数值型数据");
		return ; 
	} 
	
	//检查小数点只能是一个
	if(j > 1) 
	{
		alert( "小数点只能有一个!");			
		return ;
	}
	else if ((j == 1)&&(stringlength == 1))
	{
		alert("请输入数值型数据");
		return ;
	}
	
	return(true);
		
}

//动态按钮效果
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}