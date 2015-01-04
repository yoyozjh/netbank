/**
|                                                                             |
|-----------------------------------------------------------------------------|
|                   Copyright (c) 2004 Gdcn                                   |
|                       author:hansomee                                       |
|-----------------------------------------------------------------------------|
* 校验格式
* var fv = new FieldValidator();
*  fv.addField('字段名','字段中文名','字段类型',是否可为空,长度,精度,'控件类型','');
*  fv.addField('consumerName_r','字段中文名','c',false,100,0,'T','');
*   ......   
*  字段类型有:
   c  字符串类型
   i  整数型
   mm 正整数类型
   l  长整型
   
*------------------------------------------------------------------------------*/



var errorstr = new Array();
errorstr[11] = '格式不正确';
errorstr[12] = '月份超出范围';
errorstr[13] = '填入内容过多';
errorstr[14] = '应填入数字';
errorstr[15] = '数值过大';
errorstr[16] = '数值超出范围';
errorstr[17] = '请填入正数';
errorstr[18] = '请填入非负数';
errorstr[19] = '请填入整数';
errorstr[20] = '请填入正整数';
errorstr[22] = '请填入正确的IP地址';

function FieldValidator()
{
  this.fields =new Array();                                   
  this.combFields = new Array();                               
  this.compareFields = new Array();                            
  this.alertstr = "";                                           
}
 
FieldValidator.prototype.addField=function (fieldVO)
{
  if(fieldVO==null)
    return;

  var objCount=this.fields.length;               
  this.fields[objCount]=fieldVO;                  
}

 
FieldValidator.prototype.getField=function(name)
{
  var fvo = null;  
  
  for(var i=0;i<this.fields.length;i++ ) 
  {
     if ( this.fields[i].getName()== name)  
     {
        fvo = this.fields[i];
        break;
     }
  }
            
   return fvo;          
}

FieldValidator.prototype.getFieldIndex=function(name)
{
  var index =-1;  
  
  for(var i=0;i<this.fields.length;i++ ) 
  {
     if ( this.fields[i].getName()== name)  
     {
        index = i;
        break;
     }
  }
            
   return index;         
}

FieldValidator.prototype.setIsNull=function (name,isnull)
{
   var index = this.getFieldIndex(name);
   if (index !=-1)
      this.fields[index].setIsNull(isnull);            
}



 
FieldValidator.prototype.getAlias=function (name)
{
  var fvo = this.getField(name);
  if (fvo != null)
     return fvo.getCnName();   
            
}

FieldValidator.prototype.getIsNull=function (name)
{
  var fvo = this.getField(name);
  if (fvo != null)
     return fvo.getIsNull();   
            
}

FieldValidator.prototype.getInputType=function (name)
{
  var fvo = this.getField(name);
  if (fvo != null)
     return fvo.getInputType();   
            
}
 
FieldValidator.prototype.addCombField=function (combFieldVO)
{
   if(combFieldVO==null)
      return;
   var objCount=this.combFields.length;               
   this.combFields[objCount]=combFieldVO;             
}
 
FieldValidator.prototype.addField=function (name,cnname,type,isnull,len1,len2,defaultval)
{
 
  var inputType ="T";
  var fVO = new fieldVO();
  fVO.setName(name);
  fVO.setCnName(cnname);
  fVO.setType(type);
  fVO.setIsNull(isnull);
  fVO.setMLen(len1);
  fVO.setLLen(len2);
  fVO.setInputType(inputType);
  fVO.setDefaultValue(defaultval);

  var objCount=this.fields.length;               
  this.fields[objCount]=fVO;                  
}

 
FieldValidator.prototype.addField=function 

(name,cnname,datatype,isnull,len1,len2,inputType,defaultval)
{
 
  if (inputType =='')
     inputType ="T";
  //if (inputType =='B')
  //    return;   
 
  var fVO = new fieldVO();
  fVO.setName(name);
  fVO.setCnName(cnname);
  fVO.setDataType(datatype);
  fVO.setIsNull(isnull);
  fVO.setMLen(len1);
  fVO.setLLen(len2); 
  fVO.setInputType(inputType); 
  fVO.setDefaultValue(defaultval);

  var objCount=this.fields.length;               /*????*/

  this.fields[objCount]=fVO;                 /*??????*/
 
}



 
FieldValidator.prototype.addCombField=function (name,cnname,isnull,defaultval,checknum)
{
  var combfVO = new combFieldVO();
  combfVO.setName(name);
  combfVO.setCnName(cnname);
  combfVO.setIsNull(isnull);
  combfVO.setDefaultValue(defaultval);
  combfVO.setCheckNum(checknum);

  var objCount=this.combFields.length;               /*????*/
  this.combFields[objCount]=combfVO;                 /*??????*/
}

 
FieldValidator.prototype.addCompareField=function (name,cnname,value,comparetype,defaultval)
{

  var comparefVO = new compareFieldVO();
  comparefVO.setName(name);
  comparefVO.setCnName(cnname);
  comparefVO.setValue(value);
  comparefVO.setCompareType(comparetype);
  comparefVO.setDefaultValue(defaultval);

  var objCount=this.compareFields.length;               /*????*/
  this.compareFields[objCount]=comparefVO;                 /*??????*/
}
 
FieldValidator.prototype.setCompareField=function (name,cnname,value,comparetype,defaultval)
{
  for (var i=0;i<this.compareFields.length;i++)
  {
     if (this.compareFields[i].getName() == name)
      {
           this.compareFields[i].setName(name);
           this.compareFields[i].setCnName(cnname);
           this.compareFields[i].setValue(value);
           this.compareFields[i].setCompareType(comparetype);
           this.compareFields[i].setDefaultValue(defaultval);
           break;
      }

  }

}

/**
*  扩展函数 ：可由用户自行定制
*/ 
FieldValidator.prototype.extendWork=function()
{
    return true;
}
//add for report
FieldValidator.prototype.beforeCheck=function(pojbect)
{
    return true;
}
/**
*  校验主体函数
*/
FieldValidator.prototype.checkValue = function(pobject)  
{
    var ckdoc = pobject;
    var i;
    var iscorrect = true;
    var isitemcorrect = 1;
    var elvalue = null;
    var inputType ="";
    var alertstr = "";
    /*判断校验的对象是否属于window类的非可视的对象*/
    if (pobject == null || pobject.tagName == undefined){
    	 ckdoc = window.document;
    }
    this.beforeCheck(ckdoc);//add for report
    for(i=0;i<this.fields.length;i++)
    {
        isitemcorrect = true;
        this.fields[i].val = "";

        if(this.fields[i] != null && this.fields[i].getName() != null)
        {
            inputType =this.fields[i].getInputType();   
            if (inputType =='B' || inputType =='b' || inputType =='L' || inputType =='l' )   

//????????
                 continue;
            if(ckdoc.all(this.fields[i].getName()) == null)
                    continue;
                
      
     
            if (inputType =='T' || inputType =='A' || inputType =='D' || inputType=='S' || inputType=='M')   //???begin
              elvalue =ckdoc.all(this.fields[i].getName()).value;
            else 
            {
               if (inputType =='C' || inputType =='R' ) {     //????begin
                 var fcs =document.getElementsByName(this.fields[i].getName());
                 if (fcs != null) {
                   elvalue ="";
                   for(var j=0;j<fcs.length;j++) {               
                      if (fcs[j].status) {
                         if (inputType =='R') 
                            elvalue = fcs[j].value;
                         else
                            elvalue += fcs[j].value+";";                       
                      }
                    }//end for
                 
                  }
               
                }   //????end;
             } //??? end
                 

        }
        else
            continue;

        if(elvalue == null || this.Trim(elvalue) == "")
        {

            if(this.fields[i].getDefaultValue() != null && this.fields[i].getDefaultValue() 

!= "")
                elvalue = ckdoc.all(this.fields[i].getName()).value = 

this.fields[i].getDefaultValue();
            if(this.fields[i].getIsNull())
                continue;
            else
            {
                alertstr += '请填入"' + this.fields[i].getCnName() + '"！\n';
                iscorrect = false;
                continue;
            }
        }

        switch(this.fields[i].getDataType())
        {
            case 'c'  :
                        isitemcorrect = this.ischar(elvalue,this.fields[i].getMLen());
                        break;
            case 'i'  :
                        isitemcorrect = this.isint(elvalue,this.fields[i].getMLen());
                                                if(isitemcorrect == 1)
                            isitemcorrect =  compval(elvalue,this.fields[i]);
                        break;
                        case 'pi'  :
                        isitemcorrect = this.isplusint(elvalue,this.fields[i].getMLen());
                                                if(isitemcorrect == 1)
                            isitemcorrect =  compval(elvalue,this.fields[i]);
                        break;
            /*判断是否是正整数*/
            case 'nn' :
                      isitemcorrect = this.isNaturalNumber(elvalue,this.fields[i].getMLen()); 
                      break;           
            case 'l'  :
                        isitemcorrect =  this.islong(elvalue,this.fields[i].getMLen());
                        if(isitemcorrect == 1)
                            isitemcorrect =  compval(elvalue,this.fields[i]);
                        break;
            case 'dl' :
                        isitemcorrect =  
                        this.isdouble(elvalue,this.fields[i].getMLen()-this.fields[i].getLLen(),this.fields[i].getLLen());
                        //整数部分长度必须是字段总长度减去小数部分长度
                        if(isitemcorrect == 1)
                            isitemcorrect =  compval(elvalue,this.fields[i]);
                        break;
            case 'pdl':
                        isitemcorrect =  
                        this.isplusdouble(elvalue,this.fields[i].getMLen()-this.fields[i].getLLen(),this.fields[i].getLLen());
                        //整数部分长度必须是字段总长度减去小数部分长度
                        if(isitemcorrect == 1)
                            isitemcorrect =  compval(elvalue,this.fields[i]);
                        break;
            case 'f'  :
                        isitemcorrect =  
                        this.isfloat(elvalue,this.fields[i].getMLen(),this.fields[i].getLLen());
                        if(isitemcorrect == 1)
                            isitemcorrect =  compval(elvalue,this.fields[i]);
                        break;
            case 'd'  :
                        isitemcorrect =  this.validatedate(elvalue);
                        break;
            case 'dt' :
                        isitemcorrect =  this.validatedatetime(elvalue)
                        break;
            case 'm'  :
                        isitemcorrect =  this.ismail(elvalue,this.fields[i].getMLen());
                        
                        break;
            case 'ipv4' :
                       isitemcorrect =  this.isIpv4(elvalue); 
                       break;            
            default   :
                        isitemcorrect = 0;
                        break;
        }


        if(isitemcorrect != 1)
        {
            alertstr += "\""+ this.fields[i].getCnName() +'"项' + errorstr[isitemcorrect] + '！\n';
            iscorrect = false;
        }
        else
            this.fields[i].val = elvalue;
    }
       var combAlterStr = "";
        for( i=0;i<this.combFields.length;i++)
        {
            var  arrCombField = this.combFields[i].getName().split(";");
            var  arrCombFieldName = this.combFields[i].getCnName().split(";");
            var  tmpNum = 0;
            for(var j=0;j<arrCombField.length;j++)
            {
               if(arrCombField[j] != null )
        {
            if(ckdoc.all(arrCombField[j]) == null)
                continue;
            elvalue = ckdoc.all(arrCombField[j]).value;
                        if (elvalue !=null && this.Trim(elvalue) != '') {
                             tmpNum++;
                        }
                        else {
                             combAlterStr += '请填入"'+ arrCombFieldName[j] + '"！\n';
                        }
        }
        else
            continue;
            }

            if(this.combFields[i].getIsNull())
            {
                if (tmpNum!=0 && tmpNum < this.combFields[i].getCheckNum())
                {
                    alertstr +=  combAlterStr;
                    iscorrect = false;
                    continue;
                }
            }
            else
            {
                if (tmpNum < this.combFields[i].getCheckNum())
                {
                    alertstr += '请至少填入' + this.combFields[i].getCnName() + '！\n';
                    iscorrect = false;
                    continue;
                }
            }

        }

       for( i=0;i<this.compareFields.length;i++)
       {
              switch(this.compareFields[i].getCompareType())
              {
          case '>'  :
                      if (this.compareFields[i].getValue() <= 

this.compareFields[i].getDefaultValue())
                      {
                         alertstr +=  this.compareFields[i].getCnName() + '！\n';
                         iscorrect = false;
                       }
                       break;
                   case '<'  :
                      if (this.compareFields[i].getValue() >= 

this.compareFields[i].getDefaultValue())
                      {
                         alertstr +=  this.compareFields[i].getCnName() + '！\n';
                         iscorrect = false;
                       }
                       break;
                    case '>='  :
                         if (this.compareFields[i].getValue() < 

this.compareFields[i].getDefaultValue())
                         {
                            alertstr +=  this.compareFields[i].getCnName() + '！\n';
                            iscorrect = false;
                         }
                         break;
                     case '<='  :
                         if (this.compareFields[i].getValue() > 

this.compareFields[i].getDefaultValue())
                         {
                            alertstr +=  this.compareFields[i].getCnName() + '！\n';
                            iscorrect = false;
                          }
                          break;
                      case '='  :
                          if (this.compareFields[i].getValue() != 

this.compareFields[i].getDefaultValue())
                          {
                              alertstr +=  this.compareFields[i].getCnName() + '！\n';
                              iscorrect = false;
                           }
                           break;
                      default     :
                   break;
            }

        }

        this.alertstr = alertstr;
        clientflag=this.extendWork();
    if(!iscorrect | !clientflag)
        alert( this.alertstr);
        
    return   clientflag & iscorrect;
}

/**
*  提交前将的表单域如select,radio,checkbox disabled = false，保证数据不丢失
*/
FieldValidator.prototype.changeStatus = function(editFlag)  
{    
    if ( this.fields != null) {
      for(var i=0;i<this.fields.length;i++ ) 
      {  
        if (this.fields[i] !="") 
        {        
           field = this.fields[i].getName();
         //  alert("f=========="+field);
           inputType = this.getInputType(field);
             //此域在表单中存在;
           if (document.all(field) != null ) 
           {
              //确定此域表现的控件形式
               //radio类型  
               if ( inputType =='R' )
               {         
                            
	              var radioField = document.getElementsByName(field);               
	              if (radioField != null && radioField.length >0)
	              {
	                 for (radioCount=0;radioCount<radioField.length;radioCount++)
	                 {
	                   radioField[radioCount].disabled = !editFlag; 
	                 }
	              }                         
               }
                //下拉框选择类型 
               if ( inputType =='S' )  
	           {
	                       
	              if ( document.getElementById(field) != null)
	                 document.getElementById(field).disabled =!editFlag;             
	           }  
               
              //复选框型 
              if (inputType =='C') 
	           {          
	              
	              var fcs =document.getElementsByName(field);
		   	      	if (fcs != null) 
		   	      	{
		            	for(var j=0;j<fcs.length;j++)	             
		               	fcs[j].disabled = !editFlag ;
		   	      	}
		   	      	 	        
	           }  
           }   
           
        }
      }    
    
    }
}



FieldValidator.prototype.changeAllStatus = function(editFlag)  
{    
    if ( this.fields != null) {
      for(var i=0;i<this.fields.length;i++ ) 
      {  
        if (this.fields[i] !="") 
        {        
           field = this.fields[i].getName();
    
           inputType = this.getInputType(field);
             //此域在表单中存在;
           if (document.all(field) != null ) 
           {
              //确定此域表现的控件形式
               //radio类型  
               if ( inputType =='R' )
               {         
                            
	              var radioField = document.getElementsByName(field);               
	              if (radioField != null && radioField.length >0)
	              {
	                 for (radioCount=0;radioCount<radioField.length;radioCount++)
	                 {
	                   radioField[radioCount].disabled = !editFlag; 
	                 }
	              }                         
               }
                //下拉框选择类型 
               if ( inputType =='S' || inputType =='B')  
	           {
	                       
	              if ( document.getElementById(field) != null)
	                 document.getElementById(field).disabled =!editFlag;             
	           }  
               
               
               if (inputType =='T' || inputType =='A' || inputType =='D') {
                 if ( document.getElementById(field) != null) {                      
	                 document.getElementById(field).setAttribute('readOnly',!editFlag);  
	                 if (inputType =='D') {
	                      document.getElementById(field).onclick ="";
	                 } //还需要将单击事件置为空
	             } 
	            
               }
              //复选框型 
              if (inputType =='C') 
	           {          
	              
	              var fcs =document.getElementsByName(field);
		   	      	if (fcs != null) 
		   	      	{
		            	for(var j=0;j<fcs.length;j++)	             
		               	fcs[j].disabled = !editFlag ;
		   	      	}
		   	      	 	        
	           }  
           }   
           
        }
      }    
    
    }
}


 
FieldValidator.prototype.validatedate =function( strValue )
{
  /*
  strValue must be as:  yyyy/mm/dd or yyyy-mm-dd or yyyy.mm.dd
  */
  var objRegExp = /^\d{4}(\-|\/|\.)\d{1,2}(\-|\/|\.)\d{1,2}$/;
  if(!objRegExp.test(strValue))
  {
    return 11;
  }
  else{
    var strSeparator = strValue.substring(4,5);
    var arrayDate = strValue.split(strSeparator); //split date into month, day, year
    //create a lookup for months not equal to Feb.
    var arrayLookup = { '01' : 31,'03' : 31, '04' : 30,'05' : 31,'06' : 30,'07' : 31,
                        '08' : 31,'09' : 30,'10' : 31,'11' : 30,'12' : 31};
    var intDay = eval(arrayDate[2]);
    var intMonth = eval(arrayDate[1]);
    if(intMonth > 12 || intMonth <= 0) return 12;
    if(arrayDate[1].length < 2) arrayDate[1] = '0' + arrayDate[1];

    //check if month value and day value agree
    if(arrayLookup[arrayDate[1]] != null ) {
      if(intDay <= arrayLookup[arrayDate[1]] && intDay != 0)
        return 1; //found in lookup table, good date
    }
    //check for February
    if(intMonth == 2)
    {
      var intYear = parseInt(arrayDate[0]);
      if( ((intYear % 4 == 0 && intDay <= 29) || (intYear % 4 != 0 && intDay <=28)) && 

intDay !=0)
        return 1;
    }

  }
  return 11;
}
 
FieldValidator.prototype.validatetime = function( strValue )
{
  /*
  strValue must be as:  hh:mm:ss or hh:mm;
  */
  var arrayTime = strValue.split(":")
  if (arrayTime.length==2) 
  {
      strHour=arrayTime[0];
      strMinute=arrayTime[1];

      if((parseInt(strHour)>=0 && parseInt(strHour)<=24) && (parseInt(strMinute)>=0 && 

parseInt(strMinute)<=60) )
        return 1;
  }
  if (arrayTime.length==3)
  {
      strHour=arrayTime[0];
      strMinute=arrayTime[1];
      strSecond=arrayTime[2];
      if((parseInt(strHour)>=0 && parseInt(strHour)<=24) && (parseInt(strMinute)>=0 && 

parseInt(strMinute)<=60) && (parseInt(strSecond)>=0 && parseInt(strSecond)<=60))
        return 1;
      return 11;
  }
  return 11;
}
 
FieldValidator.prototype.validatedatetime =function( strValue )
{
    arrayValue = strValue.split(" ");
    if(arrayValue.length==2)
    {
        var rv = this.validatedate(arrayValue[0]);
        if(rv == 1)
            rv = this.validatetime(arrayValue[1]);
        return rv;
    }
    return 11;
}
 
FieldValidator.prototype.ischar =function(val,len)
{
    if(getUniCodeLength(val)<=len)
            return 1;
    return 13;
}
 
FieldValidator.prototype.isint =function(val,len)
{

    if (this.Trim(val) == '') return 14;
    if(!isNumberInt(val)) return 14;
        if(val.indexOf(".")>0) return 19;
    if(val.length<=len) return 1;
    return 15;
}


function isNumberInt(inputString)
{
  if(/^[0-9]+$/.test(inputString)){
    return true;
  }
  else{
    return false;
  }
}
 
FieldValidator.prototype.isplusint =function(val,len)
{

        if (this.Trim(val) == '') return 14;
    if(isNaN(val)) return 14;
        if(val.indexOf(".")>0) return 19;
        if (val <=0) return 17;
    if(val.length<=len) return 1;
    return 15;
}
 
FieldValidator.prototype.islong = function(val,len)
{
    
    return isint(val,len);
}
/*检查输入的变量是否是正整数*/
FieldValidator.prototype.isNaturalNumber = function(val,len)
{
    var returnvalue = 1;
    /*参数为自然数*/
    if(checkNaturalNumber(val) == false){
       returnvalue = 20;
    }
    /*判断填入数据是否超过指定长度*/
    if(val.length > len) {
    	returnvalue =  15;
    }
    return returnvalue;
}


FieldValidator.prototype.isdouble = function(val,len1,len2)
{
   try{
    if (this.Trim(val) == '') return 14;
    if(isNaN(val)) return 14;
    if(val.indexOf(".")<0)
    {
        if(val.length<=len1) return 1;
        return 15;
    }
    if(val.substring(0,val.indexOf(".")).length <= len1 && val.length-val.indexOf('.')-1 <= 

len2)
        return 1;
  }catch(e){
    alert(e.description);
  }      
    return 16;
}

FieldValidator.prototype.isplusdouble = function(val,len1,len2)
{
        if (this.Trim(val) == '') return 14;
    if(isNaN(val)) return 14;
        if (val <=0) return 17;
    if(val.indexOf(".")<0)
    {
        if(val.length<=len1) return 1;
        return 15;
    }
    if(val.substring(0,val.indexOf(".")).length <= len1 && val.length-val.indexOf('.')-1 <= 

len2)
        return 1;
    return 16;
}

 
FieldValidator.prototype.isfloat =function(val,len1,len2)
{
    //?isfloat??
    return this.isdouble(val,len1,len2);
}

 
FieldValidator.prototype.ismail = function(val,len)
{
    var i=0 ;
    var slength=val.length;
    if (val.length>len)
        return 13;
    if(val.charAt(0)=="@")
        return 11;
    while((i<slength)&&(val.charAt(i)!="@"))
        i++;
    if (i>=slength)
        return 11;
    else i+=2;
    while((i<slength)&&(val.charAt(i)!="."))
        i++;
    if(i>=slength-1)
        return 11;
    return 1;
}
FieldValidator.prototype.isIpv4 = function(val){
   if (Ipv4Validate(val) == true )
   return 1;
   else
   return 22;

}

 
function checkmail(mail)
{
    var  strr;
    re=/(\w+@\w+\.\w+)(\.{0,1}\w*)(\.{0,1}\w*)/i;
    re.exec(mail);
    if  (RegExp.$3!=""&&RegExp.$3!="."&&RegExp.$2!=".")  strr=RegExp.$1+RegExp.$2+RegExp.$3
    else
        if  (RegExp.$2!=""&&RegExp.$2!=".")  strr=RegExp.$1+RegExp.$2
        else    strr=RegExp.$1
    if  (strr!=mail)  {alert("请填写正确的邮件地址！");return false}
    return  true;
}

function compval(val1,val2)
{
    if(val2 == null || val2 == '')
        return 1;
    var val11 = parseFloat(val1);
    if(val2.maxval != null && val2.maxval != '')
        if(val11 - val2.maxval > 0.00001)
            return 16;
    if(val2.minval != null && val2.minval != '')
        if(val11 - val2.minval < -0.00001)
            return 16;
    return 1;
}
function compareval(val1,val2,msg)
{
    var temp1 = '';
    var temp2 = '';

    if (document.all(val1) !=null)
        temp1 = document.all(val1).value;
    if (document.all(val2) !=null)
        temp2 = document.all(val2).value;

    if(temp1 == null || temp1 == '' || temp2 == null || temp2 == '')
        return true;

    var retval = (parseFloat(temp2) > parseFloat(temp1));

    if (!retval && msg != null && msg != '')
        alert(msg);

    return retval;
}


var regexpcn = /(%u[A-F0-9]{4})/gi;
var regexp = /(%[A-F0-9]{2})/gi;
var regval = null;
function getUniCodeLength(unicodeval)
{
    if(unicodeval == null) return 0;
    regval = escape(unicodeval);
    regval = regval.replace(regexpcn,"aa");
    regval = regval.replace(regexp,"a");
    return regval.length;
}

/*
==================================================================
LTrim(string) : Returns a copy of a string without leading spaces.
==================================================================
*/
function LTrim(str)
/*
   PURPOSE: Remove leading blanks from our string.
   IN: str - the string we want to LTrim
*/
{
   var whitespace = new String(" 　\t\n\r");

   var s = new String(str);

   if (whitespace.indexOf(s.charAt(0)) != -1) {
      // We have a string with leading blank(s)...

      var j=0, i = s.length;

      // Iterate from the far left of string until we
      // don't have any more whitespace...
      while (j < i && whitespace.indexOf(s.charAt(j)) != -1)
         j++;

      // Get the substring from the first non-whitespace
      // character to the end of the string...
      s = s.substring(j, i);
   }
   return s;
}

/*
==================================================================
RTrim(string) : Returns a copy of a string without trailing spaces.
==================================================================
*/
function RTrim(str)
/*
   PURPOSE: Remove trailing blanks from our string.
   IN: str - the string we want to RTrim

*/
{
   // We don't want to trip JUST spaces, but also tabs,
   // line feeds, etc.  Add anything else you want to
   // "trim" here in Whitespace
   var whitespace = new String(" 　\t\n\r");

   var s = new String(str);

   if (whitespace.indexOf(s.charAt(s.length-1)) != -1) {
      // We have a string with trailing blank(s)...

      var i = s.length - 1;       // Get length of string

      // Iterate from the far right of string until we
      // don't have any more whitespace...
      while (i >= 0 && whitespace.indexOf(s.charAt(i)) != -1)
         i--;


      // Get the substring from the front of the string to
      // where the last non-whitespace character is...
      s = s.substring(0, i+1);
   }

   return s;
}

/*
=============================================================
Trim(string) : Returns a copy of a string without leading or trailing spaces
=============================================================
*/
FieldValidator.prototype.Trim = function(str)
/*
   PURPOSE: Remove trailing and leading blanks from our string.
   IN: str - the string we want to Trim

   RETVAL: A Trimmed string!
*/
{
   return RTrim(LTrim(str));
}


/*--------------------------------------------------------------------------------
  compareFieldVO
  

---------------------------------------------------------------------------------*/
function compareFieldVO()
{
  this.name = "";            //???
  this.value="";              //???
  this.cnname="";            //???
  this.compareType="";         //????
  this.defaultval="";         //???
 }

compareFieldVO.prototype.setName=function (name)
{
  this.name=name;
}
compareFieldVO.prototype.getName=function ()
{
  return this.name;
}
compareFieldVO.prototype.setValue=function (value)
{
  this.value=value;
}

compareFieldVO.prototype.getValue=function ()
{
  return this.value;
}

compareFieldVO.prototype.setCnName=function (cnname)
{
  this.cnname=cnname;
}

compareFieldVO.prototype.getCnName=function ()
{
  return this.cnname;
}

compareFieldVO.prototype.setCompareType=function (compareType)
{
  this.compareType=compareType;
}

compareFieldVO.prototype.getCompareType=function ()
{
  return this.compareType;
}

compareFieldVO.prototype.setDefaultValue=function (defaultval)
{
  this.defaultval=defaultval;
}

compareFieldVO.prototype.getDefaultValue=function ()
{
  return this.defaultval;
}


/*--------------------------------------------------------------------------------
  combFieldVO
  

---------------------------------------------------------------------------------*/
function combFieldVO()
{
  this.name="";              //???
  this.cnname="";            //???
  this.isnull="";            //????
  this.defaultval="";         //???
  this.checkNum =0;          //????
  this.isCompare =false;     //????????
}

combFieldVO.prototype.setName=function (name)
{
  this.name=name;
}

combFieldVO.prototype.getName=function ()
{
  return this.name;
}

combFieldVO.prototype.setCnName=function (cnname)
{
  this.cnname=cnname;
}

combFieldVO.prototype.getCnName=function ()
{
  return this.cnname;
}

combFieldVO.prototype.setIsNull=function (isnull)
{
  this.isnull=isnull;
}

combFieldVO.prototype.getIsNull=function ()
{
  return this.isnull;
}

combFieldVO.prototype.setDefaultValue=function (defaultval)
{
  this.defaultval=defaultval;
}

combFieldVO.prototype.getDefaultValue=function ()
{
  return this.defaultval;
}

combFieldVO.prototype.setCheckNum=function (checkNum)
{
  this.checkNum=checkNum;
}

combFieldVO.prototype.getCheckNum=function ()
{
  return this.checkNum;
}

combFieldVO.prototype.setIsCompare=function (isCompare)
{
  this.isCompare=isCompare;
}

combFieldVO.prototype.getIsCompare=function ()
{
  return this.isCompare;
}

/*--------------------------------------------------------------------------------
fieldVO
 

---------------------------------------------------------------------------------*/

function fieldVO()
{
  this.name="";              //???
  this.cnname="";            //???
  this.isnull="";            //????
  this.datatype="";              //????
  this.len1=0;               //??
  this.len2="";               //??
  this.inputType ="";         //html??
  this.defaultval="";         //???
}

fieldVO.prototype.setName=function (name)
{

  this.name=name;
}

fieldVO.prototype.getName=function ()
{
  return this.name;
}

fieldVO.prototype.setCnName=function (cnname)
{

  this.cnname=cnname;
}

fieldVO.prototype.getCnName=function ()
{
  return this.cnname;
}


fieldVO.prototype.setIsNull=function (isnull)
{

  this.isnull=isnull;
}

fieldVO.prototype.getIsNull=function ()
{
  return this.isnull;
}


fieldVO.prototype.setDataType=function (dataType)
{

  this.dataType=dataType;
}

fieldVO.prototype.getDataType=function ()
{
  return this.dataType;
}


fieldVO.prototype.setInputType=function (inputType)
{

  this.inputType=inputType;
}

fieldVO.prototype.getInputType=function ()
{
  return this.inputType;
}
fieldVO.prototype.setMLen=function (len1)
{

  this.len1=len1;
}

fieldVO.prototype.getMLen=function ()
{
  return this.len1;
}

fieldVO.prototype.setLLen=function (len2)
{

  this.len2=len2;
}

fieldVO.prototype.getLLen=function ()
{
  return this.len2;
}


fieldVO.prototype.setDefaultValue=function (defaultval)
{
  this.defaultval=defaultval;
}

fieldVO.prototype.getDefaultValue=function ()
{
  return this.defaultval;
}

function checkNaturalNumber(num)   
{
   var isInt = false;
   if(/^[1-9]\d*$/.test(num))   
   {   
      isInt = true;  
   }   
     return isInt;   
 }

 /*判断一个字符是否为正确IPV4的IP地址
  *@参数：ip 待检验的IP地址字符串
  *@返回值：布尔型 true 表示IP地址是正确的； false 表示IP地址是错误的
 */
function Ipv4Validate(ip){
   if (ip == null || ip == "" || typeof(ip) != "string" || ip.length > 15  || ip ==  undefined) return false;
   if(ip.length > 15) return false;
	re=/^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/  
	if(re.test(ip))
	{
	   var strarray = ip.split(".");
	   for(var i = 0 ; i < strarray.length ;i++)
	   {
			if((i == 0 || i== 3)&& new Number(strarray[i]) == 0){
			   return false;
			   break;
			}
			if( new Number(strarray[i]) >= 255) {	
			  return false;
			  break;
			}
	    }
		return true;
	}
	else
	{
		return false;
	}
   
} 
/*
 *isNaturalNumber()是否正整数判断函数接口说明:
 *@parameter  num 字符串类型  进行验正的参数
 *@parameter  len 整数类型    指定参数长度
 *return   整数类型  0 参数为正整数,验证通过；  1 参数为非正整数 ;  2 参数超过指定长度
 */
function isNaturalNumber(num,len)   
{
   if(checkNaturalNumber(num) == false){
     return 1;
   }
   if( len != null && len > 0){
      if(num.length > len) return 2;
   }  
     return 0;   
 }
  