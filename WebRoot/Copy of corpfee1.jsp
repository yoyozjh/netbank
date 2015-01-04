<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@ page import="com.bocom.midserv.gz.*"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="java.sql.*"%>


<%
	GzLog log = new GzLog("c:/gzLog");
	String dse_sessionId = MessManTool.changeChar(request.getParameter("dse_sessionId"));//获取dse_sessionId
	String biz_id = MessManTool.changeChar(request.getParameter("biz_id"));
	String CrdNo = MessManTool.changeChar(request.getParameter("cardNo"));
	//用于并发数太多的时候能够比较容易分清日志的关系
	String logRMNO = String.valueOf(Math.random()).substring(3,9);
	if (biz_id.equals("") ) {
		log.Write("[" + logRMNO + "] Step 1: 传入参数不正确，biz_id为空"); 
	}
//	List list = new ArrayList();
//发送第一个查询交易开始：发送卡号过去，获得对应的商户号和商户类别，其中商户号和商户类别都有可能不是唯一
%>

<%
//Test数据库连接开始
		Connection dbConn = null;
		Statement st = null;
		ResultSet rs = null;
		String sqlstr = "";
		String ZJSign = "";
		String checked = "";
		int i = 0;
    try {//建立数据库连接
        dbConn = DriverManager.getConnection("jdbc:sybase:Tds:182.53.15.211:6600/middb?CHARSET=cp936&amp;amp;LANGUAGE=en_US", "miduser", "miduser");
    } catch (SQLException e) {
		log.Write("[" + logRMNO + "] Step 1: getConnection......" + e.getMessage()); 
		e.printStackTrace();
    }
    
	try{//打开对话,赋给ResultSet
	    sqlstr = "select * from CrdNo_BUSINO where CrdNo like '" + CrdNo + "'";
	    st = dbConn.createStatement();
	    rs = st.executeQuery(sqlstr);
	} catch (SQLException e) {
		log.Write("[" + logRMNO + "] Step 1: createStatement......" + e.getMessage()); 
		e.printStackTrace();
	}


//Test数据库连接结束
%>


<html>
<head>
<title>test</title>
<script language="JavaScript" src="/personbank/HttpProxy?URL=/midserv/js/public.js&dse_sessionId=<%=dse_sessionId%>"></script>
<script language="JavaScript" src="/personbank/HttpProxy?URL=/midserv/js/common.js&dse_sessionId=<%=dse_sessionId%>"></script>
<script type="text/javascript">
	function tj1(){
		//上送的时间值不能为空
		if(f1.datefrom.value==''){
			alert("请选择起始日期");
			return false;
		}
		if(f1.dateto.value==''){
			alert("请选择终止日期");
			return false;
		}
		tj();
	}
</script>
<link rel="stylesheet" type="text/css" href="/personbank/HttpProxy?URL=/midserv/css/personbank.css&dse_sessionId=<%=dse_sessionId%>">
<link rel="stylesheet" type="text/css" href="/personbank/HttpProxy?URL=/midserv/css/midserv.css&dse_sessionId=<%=dse_sessionId%>">
<link rel="stylesheet" type="text/css" href="/personbank/HttpProxy?URL=/midserv/css/csspt.css&dse_sessionId=<%=dse_sessionId%>">

<!-- 日期控件开始 -->
<script language="javascript">
function atCalendarControl(){
var calendar=this;
this.calendarPad=null;
this.prevMonth=null;
this.nextMonth=null;
this.prevYear=null;
this.nextYear=null;
this.goToday=null;
this.calendarClose=null;
this.calendarAbout=null;
this.head=null;
this.body=null;
this.today=[];
this.currentDate=[];
this.sltDate;
this.target;
this.source;

/************** 加入日历底板及阴影 *********************/
this.addCalendarPad=function(){
   document.write("<div id='divCalendarpad' style='position:absolute;top:100;left:0;width:255;height:187;display:none;'>");
   document.write("<iframe frameborder=0 height=189 width=250></iframe>");
   document.write("<div style='position:absolute;top:2;left:2;width:250;height:187;background-color:#336699;'></div>");
   document.write("</div>");
   calendar.calendarPad=document.all.divCalendarpad;
}
/************** 加入日历面板 *********************/
this.addCalendarBoard=function(){
   var BOARD=this;
   var divBoard=document.createElement("div");
   calendar.calendarPad.insertAdjacentElement("beforeEnd",divBoard);
   divBoard.style.cssText="position:absolute;top:0;left:0;width:250;height:187;border:0 outset;background-color:buttonface;";

   var tbBoard=document.createElement("table");
   divBoard.insertAdjacentElement("beforeEnd",tbBoard);
   tbBoard.style.cssText="position:absolute;top:2;left:2;width:248;height:10;font-size:9pt;";
   tbBoard.cellPadding=0;
   tbBoard.cellSpacing=1;

/************** 设置各功能按钮的功能 *********************/
   /*********** Calendar About Button ***************/
   trRow = tbBoard.insertRow(0);
   calendar.calendarAbout=calendar.insertTbCell(trRow,0,"-","center");
   calendar.calendarAbout.title="帮助 快捷键:H";
   calendar.calendarAbout.onclick=function(){calendar.about();}
   /*********** Calendar Head ***************/
   tbCell=trRow.insertCell(1);
   tbCell.colSpan=5;
   tbCell.bgColor="#99CCFF";
   tbCell.align="center";
   tbCell.style.cssText = "cursor:default";
   calendar.head=tbCell;
   /*********** Calendar Close Button ***************/
   tbCell=trRow.insertCell(2);
   calendar.calendarClose = calendar.insertTbCell(trRow,2,"x","center");
   calendar.calendarClose.title="关闭 快捷键:ESC或X";
   calendar.calendarClose.onclick=function(){calendar.hide();}

   /*********** Calendar PrevYear Button ***************/
   trRow = tbBoard.insertRow(1);
   calendar.prevYear = calendar.insertTbCell(trRow,0,"<<","center");
   calendar.prevYear.title="上一年 快捷键:↑";
   calendar.prevYear.onmousedown=function(){
    calendar.currentDate[0]--;
    calendar.show(calendar.target,calendar.returnTime,calendar.currentDate[0]+"-"+calendar.formatTime(calendar.currentDate[1])+"-"+calendar.formatTime(calendar.currentDate[2]),calendar.source);
   }
   /*********** Calendar PrevMonth Button ***************/
   calendar.prevMonth = calendar.insertTbCell(trRow,1,"<","center");
   calendar.prevMonth.title="上一月 快捷键:←";
   calendar.prevMonth.onmousedown=function(){
    calendar.currentDate[1]--;
    if(calendar.currentDate[1]==0){
     calendar.currentDate[1]=12;
     calendar.currentDate[0]--;
    }
    calendar.show(calendar.target,calendar.returnTime,calendar.currentDate[0]+"-"+calendar.formatTime(calendar.currentDate[1])+"-"+calendar.formatTime(calendar.currentDate[2]),calendar.source);
   }
   /*********** Calendar Today Button ***************/
   calendar.goToday = calendar.insertTbCell(trRow,2,"今天","center",3);
   calendar.goToday.title="选择今天 快捷键:T";
   calendar.goToday.onclick=function(){
if(calendar.returnTime) 
     calendar.sltDate=calendar.today[0]+"-"+calendar.formatTime(calendar.today[1])+"-"+calendar.formatTime(calendar.today[2])+" "+calendar.formatTime(calendar.today[3])+":"+calendar.formatTime(calendar.today[4])
else
     calendar.sltDate=calendar.today[0]+"-"+calendar.formatTime(calendar.today[1])+"-"+calendar.formatTime(calendar.today[2]);
    calendar.target.value=calendar.sltDate;
    calendar.hide();
    //calendar.show(calendar.target,calendar.today[0]+"-"+calendar.today[1]+"-"+calendar.today[2],calendar.source);
   }
   /*********** Calendar NextMonth Button ***************/
   calendar.nextMonth = calendar.insertTbCell(trRow,3,"&gt;","center");
   calendar.nextMonth.title="下一月 快捷键:→";
   calendar.nextMonth.onmousedown=function(){
    calendar.currentDate[1]++;
    if(calendar.currentDate[1]==13){
     calendar.currentDate[1]=1;
     calendar.currentDate[0]++;
    }
    calendar.show(calendar.target,calendar.returnTime,calendar.currentDate[0]+"-"+calendar.formatTime(calendar.currentDate[1])+"-"+calendar.formatTime(calendar.currentDate[2]),calendar.source);
   }
   /*********** Calendar NextYear Button ***************/
   calendar.nextYear = calendar.insertTbCell(trRow,4,"&gt;&gt;","center");
   calendar.nextYear.title="下一年 快捷键:↓";
   calendar.nextYear.onmousedown=function(){
    calendar.currentDate[0]++;
    calendar.show(calendar.target,calendar.returnTime,calendar.currentDate[0]+"-"+calendar.formatTime(calendar.currentDate[1])+"-"+calendar.formatTime(calendar.currentDate[2]),calendar.source);

   }

   trRow = tbBoard.insertRow(2);
   var cnDateName = new Array("日","一","二","三","四","五","六");
   for (var i = 0; i < 7; i++) {
    tbCell=trRow.insertCell(i)
    tbCell.innerText=cnDateName[i];
    tbCell.align="center";
    tbCell.width=35;
    tbCell.style.cssText="cursor:default;border:1 solid #99CCCC;background-color:#99CCCC;";
   }

   /*********** Calendar Body ***************/
   trRow = tbBoard.insertRow(3);
   tbCell=trRow.insertCell(0);
   tbCell.colSpan=7;
   tbCell.height=97;
   tbCell.vAlign="top";
   tbCell.bgColor="#F0F0F0";
   
   var tbBody=document.createElement("table");
   tbCell.insertAdjacentElement("beforeEnd",tbBody);
   tbBody.style.cssText="position:relative;top:0;left:0;width:245;height:103;font-size:9pt;"
   tbBody.cellPadding=0;
   tbBody.cellSpacing=1;
   calendar.body=tbBody;

   /*********** Time Body ***************/
   trRow = tbBoard.insertRow(4);
   tbCell=trRow.insertCell(0);
   calendar.prevHours = calendar.insertTbCell(trRow,0,"-","center");
   calendar.prevHours.title="小时调整 快捷键:Home";
   calendar.prevHours.onmousedown=function(){
   calendar.currentDate[3]--;
   if(calendar.currentDate[3]==-1) calendar.currentDate[3]=23;
   calendar.bottom.innerText=calendar.formatTime(calendar.currentDate[3])+":"+calendar.formatTime(calendar.currentDate[4]);
}
   tbCell=trRow.insertCell(1);
   calendar.nextHours = calendar.insertTbCell(trRow,1,"+","center");
   calendar.nextHours.title="小时调整 快捷键:End";
   calendar.nextHours.onmousedown=function(){
   calendar.currentDate[3]++;
   if(calendar.currentDate[3]==24) calendar.currentDate[3]=0;
   calendar.bottom.innerText=calendar.formatTime(calendar.currentDate[3])+":"+calendar.formatTime(calendar.currentDate[4]);
}
   tbCell=trRow.insertCell(2);
   tbCell.colSpan=3;
   tbCell.bgColor="#99CCFF";
   tbCell.align="center";
   tbCell.style.cssText = "cursor:default";
   calendar.bottom=tbCell;
   tbCell=trRow.insertCell(3);
   calendar.prevMinutes = calendar.insertTbCell(trRow,3,"-","center");
   calendar.prevMinutes.title="分钟调整 快捷键:PageUp";
   calendar.prevMinutes.onmousedown=function(){
   calendar.currentDate[4]--;
   if(calendar.currentDate[4]==-1) calendar.currentDate[4]=59;
   calendar.bottom.innerText=calendar.formatTime(calendar.currentDate[3])+":"+calendar.formatTime(calendar.currentDate[4]);
}
   tbCell=trRow.insertCell(4);
   calendar.nextMinutes = calendar.insertTbCell(trRow,4,"+","center");
   calendar.nextMinutes.title="分钟调整 快捷键:PageDown";
   calendar.nextMinutes.onmousedown=function(){
   calendar.currentDate[4]++;
   if(calendar.currentDate[4]==60) calendar.currentDate[4]=0;
   calendar.bottom.innerText=calendar.formatTime(calendar.currentDate[3])+":"+calendar.formatTime(calendar.currentDate[4]);
}

}

/************** 加入功能按钮公共样式 *********************/
this.insertTbCell=function(trRow,cellIndex,TXT,trAlign,tbColSpan){
   var tbCell=trRow.insertCell(cellIndex);
   if(tbColSpan!=undefined) tbCell.colSpan=tbColSpan;

   var btnCell=document.createElement("button");
   tbCell.insertAdjacentElement("beforeEnd",btnCell);
   btnCell.value=TXT;
   btnCell.style.cssText="width:100%;border:1 outset;background-color:buttonface;";
   btnCell.onmouseover=function(){
   btnCell.style.cssText="width:100%;border:1 outset;background-color:#F0F0F0;";

   }
   btnCell.onmouseout=function(){
    btnCell.style.cssText="width:100%;border:1 outset;background-color:buttonface;";
   }
// btnCell.onmousedown=function(){
// btnCell.style.cssText="width:100%;border:1 inset;background-color:#F0F0F0;";
// }
   btnCell.onmouseup=function(){
    btnCell.style.cssText="width:100%;border:1 outset;background-color:#F0F0F0;";
   }
   btnCell.onclick=function(){
    btnCell.blur();
   }
   return btnCell;
}

this.setDefaultDate=function(){
   var dftDate=new Date();
   calendar.today[0]=dftDate.getYear();
   calendar.today[1]=dftDate.getMonth()+1;
   calendar.today[2]=dftDate.getDate();
   calendar.today[3]=dftDate.getHours();
   calendar.today[4]=dftDate.getMinutes();
}

/****************** Show Calendar *********************/
this.show=function(targetObject,returnTime,defaultDate,sourceObject){
   if(targetObject==undefined) {
    alert("未设置目标对象. \n方法: ATCALENDAR.show(obj 目标对象,boolean 是否返回时间,string 默认日期,obj 点击对象);\n\n目标对象:接受日期返回值的对象.\n默认日期:格式为\"yyyy-mm-dd\",缺省为当前日期.\n点击对象:点击这个对象弹出calendar,默认为目标对象.\n");
    return false;
   }
   else calendar.target=targetObject;
   
   if(sourceObject==undefined) calendar.source=calendar.target;
   else calendar.source=sourceObject;

   if(returnTime) calendar.returnTime=true;
   else calendar.returnTime=false;

   var firstDay;
   var Cells=new Array();
   if((defaultDate==undefined) || (defaultDate=="")){
    var theDate=new Array();
    calendar.head.innerText = calendar.today[0]+"-"+calendar.formatTime(calendar.today[1])+"-"+calendar.formatTime(calendar.today[2]);
    calendar.bottom.innerText = calendar.formatTime(calendar.today[3])+":"+calendar.formatTime(calendar.today[4]);

    theDate[0]=calendar.today[0]; theDate[1]=calendar.today[1]; theDate[2]=calendar.today[2];
theDate[3]=calendar.today[3]; theDate[4]=calendar.today[4];
   }
   else{
    var Datereg=/^\d{4}-\d{1,2}-\d{2}$/
    var DateTimereg=/^(\d{1,4})-(\d{1,2})-(\d{1,2}) (\d{1,2}):(\d{1,2})$/
    if((!defaultDate.match(Datereg)) && (!defaultDate.match(DateTimereg))){
     alert("默认日期(时间)的格式不正确！\t\n\n默认可接受格式为:\n1、yyyy-mm-dd \n2、yyyy-mm-dd hh:mm\n3、(空)");
calendar.setDefaultDate();
     return;
    }

if(defaultDate.match(Datereg)) defaultDate=defaultDate+" "+calendar.today[3]+":"+calendar.today[4];
var strDateTime=defaultDate.match(DateTimereg);
var theDate=new Array(4)
theDate[0]=strDateTime[1];
theDate[1]=strDateTime[2];
theDate[2]=strDateTime[3];
theDate[3]=strDateTime[4];
theDate[4]=strDateTime[5];
    calendar.head.innerText = theDate[0]+"-"+calendar.formatTime(theDate[1])+"-"+calendar.formatTime(theDate[2]);
    calendar.bottom.innerText = calendar.formatTime(theDate[3])+":"+calendar.formatTime(theDate[4]);
}
   calendar.currentDate[0]=theDate[0];
   calendar.currentDate[1]=theDate[1];
   calendar.currentDate[2]=theDate[2];
   calendar.currentDate[3]=theDate[3];
   calendar.currentDate[4]=theDate[4];
   
   theFirstDay=calendar.getFirstDay(theDate[0],theDate[1]);
   theMonthLen=theFirstDay+calendar.getMonthLen(theDate[0],theDate[1]);
   //calendar.setEventKey();

   calendar.calendarPad.style.display="";
   var theRows = Math.ceil((theMonthLen)/7);
   //清除旧的日历;
   while (calendar.body.rows.length > 0) {
    calendar.body.deleteRow(0)
   }
   //建立新的日历;
   var n=0;day=0;
   for(i=0;i<theRows;i++){
    theRow=calendar.body.insertRow(i);
    for(j=0;j<7;j++){
     n++;
     if(n>theFirstDay && n<=theMonthLen){
      day=n-theFirstDay;
      calendar.insertBodyCell(theRow,j,day);
     }

     else{
      var theCell=theRow.insertCell(j);
      theCell.style.cssText="background-color:#F0F0F0;cursor:default;";
     }
    }
   }

   //****************调整日历位置**************//
   var offsetPos=calendar.getAbsolutePos(calendar.source);//计算对象的位置;
   if((document.body.offsetHeight-(offsetPos.y+calendar.source.offsetHeight-document.body.scrollTop))<calendar.calendarPad.style.pixelHeight){
    var calTop=offsetPos.y-calendar.calendarPad.style.pixelHeight;
   }
   else{
    var calTop=offsetPos.y+calendar.source.offsetHeight;
   }
   if((document.body.offsetWidth-(offsetPos.x+calendar.source.offsetWidth-document.body.scrollLeft))>calendar.calendarPad.style.pixelWidth){
    var calLeft=offsetPos.x;
   }
   else{
    var calLeft=calendar.source.offsetLeft+calendar.source.offsetWidth;
   }
   //alert(offsetPos.x);
   calendar.calendarPad.style.pixelLeft=calLeft;
   calendar.calendarPad.style.pixelTop=calTop;
}
/****************** 计算对象的位置 *************************/
this.getAbsolutePos = function(el) {
   var r = { x: el.offsetLeft, y: el.offsetTop };
   if (el.offsetParent) {
    var tmp = calendar.getAbsolutePos(el.offsetParent);
    r.x += tmp.x;
    r.y += tmp.y;
   }
   return r;
};

//************* 插入日期单元格 **************/
this.insertBodyCell=function(theRow,j,day,targetObject){
   var theCell=theRow.insertCell(j);
   if(j==0) var theBgColor="#FF9999";
   else var theBgColor="#FFFFFF";
   if(day==calendar.currentDate[2]) var theBgColor="#CCCCCC";
   if(day==calendar.today[2]) var theBgColor="#99FFCC";
   theCell.bgColor=theBgColor;
   theCell.innerText=day;
   theCell.align="center";
   theCell.width=35;
   theCell.style.cssText="border:1 solid #CCCCCC;cursor:hand;";
   theCell.onmouseover=function(){ 
    theCell.bgColor="#FFFFCC"; 
    theCell.style.cssText="border:1 outset;cursor:hand;";
   }
   theCell.onmouseout=function(){ 
    theCell.bgColor=theBgColor; 
    theCell.style.cssText="border:1 solid #CCCCCC;cursor:hand;";
   }
   theCell.onmousedown=function(){ 
    theCell.bgColor="#FFFFCC"; 
    theCell.style.cssText="border:1 inset;cursor:hand;";
   }
   theCell.onclick=function(){
if(calendar.returnTime) 
     calendar.sltDate=calendar.currentDate[0]+"-"+calendar.formatTime(calendar.currentDate[1])+"-"+calendar.formatTime(day)+" "+calendar.formatTime(calendar.currentDate[3])+":"+calendar.formatTime(calendar.currentDate[4])
else
     calendar.sltDate=calendar.currentDate[0]+"-"+calendar.formatTime(calendar.currentDate[1])+"-"+calendar.formatTime(day);
    calendar.target.value=calendar.sltDate;
    calendar.hide();
   }
}
/************** 取得月份的第一天为星期几 *********************/
this.getFirstDay=function(theYear, theMonth){
   var firstDate = new Date(theYear,theMonth-1,1);
   return firstDate.getDay();
}
/************** 取得月份共有几天 *********************/

this.getMonthLen=function(theYear, theMonth) {
   theMonth--;
   var oneDay = 1000 * 60 * 60 * 24;
   var thisMonth = new Date(theYear, theMonth, 1);
   var nextMonth = new Date(theYear, theMonth + 1, 1);
   var len = Math.ceil((nextMonth.getTime() - thisMonth.getTime())/oneDay);
   return len;
}
/************** 隐藏日历 *********************/
this.hide=function(){
   //calendar.clearEventKey();
   calendar.calendarPad.style.display="none";
   
}
/************** 从这里开始 *********************/
this.setup=function(defaultDate){
   calendar.addCalendarPad();
   calendar.addCalendarBoard();
   calendar.setDefaultDate();
}
/************** 格式化时间 *********************/
this.formatTime = function(str) {
str = ("00"+str);
return str.substr(str.length-2);
}

/************** 关于AgetimeCalendar *********************/
this.about=function(){
   var strAbout = "\nWeb 日历选择输入控件操作说明:\n\n";
   strAbout+="-\t: 关于\n";
   strAbout+="x\t: 隐藏\n";
   strAbout+="<<\t: 上一年\n";
   strAbout+="<\t: 上一月\n";

   strAbout+="今日\t: 返回当天日期\n";
   strAbout+=">\t: 下一月\n";
   strAbout+="<<\t: 下一年\n";
   strAbout+="\nWeb日历选择输入控件\tVer:v1.0\t\nDesigned By:wxb \t\t2004.11.22\t\n";
   alert(strAbout);
}

document.onkeydown=function(){
if(calendar.calendarPad.style.display=="none"){
   window.event.returnValue= true;
   return true ;
}
switch(window.event.keyCode){
   case 27 : calendar.hide(); break; //ESC
   case 37 : calendar.prevMonth.onmousedown(); break;//←
   case 38 : calendar.prevYear.onmousedown();break; //↑
   case 39 : calendar.nextMonth.onmousedown(); break;//→
   case 40 : calendar.nextYear.onmousedown(); break;//↓
   case 84 : calendar.goToday.onclick(); break;//T
   case 88 : calendar.hide(); break;   //X
   case 72 : calendar.about(); break;   //H 
   case 36 : calendar.prevHours.onmousedown(); break;//Home
   case 35 : calendar.nextHours.onmousedown(); break;//End
   case 33 : calendar.prevMinutes.onmousedown();break; //PageUp
   case 34 : calendar.nextMinutes.onmousedown(); break;//PageDown
   } 
   window.event.keyCode = 0;
   window.event.returnValue= false;
   }

calendar.setup();
}

var CalendarWebControl = new atCalendarControl();
</script>
<!-- 日期控件结束 -->
</head>

<body>
<!-- 页面提示开始 -->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td	background="/personbank/HttpProxy?URL=/midserv/images/pageTitle.gif&dse_sessionId=<%=dse_sessionId%>" class="pageTitle">
			&nbsp;&nbsp;请 选 择 对 账 日 期
		</td>
		<td rowspan="2" align="right" valign="top">
			&nbsp;
		</td>
	</tr>
</table>
<!-- 页面提示结束 -->

<form action="/personbank/HttpProxy" method=post name="f1">
	<input type="hidden" name="dse_sessionId" value="<%=dse_sessionId%>">
	<input type="hidden" name="URL" value="/midserv/corpfee2.jsp">
	<input type="hidden" name="biz_id" value="<%=biz_id %>">
	<input type="hidden" name="step_id" value="2">

	<font size="50"></font>
	<table width="400" border="0" align="center">
	  <tr style="cursor:hand;" >
	    <td colspan="3" class="TableRow2">卡号：&nbsp; <%= CrdNo %></td>
	  </tr>
	  <tr style="cursor:hand;">
	    <td colspan="3" class="TableRow2">请选择对应的商户号</td>
	  </tr>
	  <tr style="cursor:hand;">
	    <td class="TableRow2">选择</td>
	    <td class="TableRow2">商户号</td>
	    <td class="TableRow2">商户类型</td>
	  </tr>
<!-- 查询数据库循环输出商户号和类别开始 -->
<%	
if(rs.next()){
	do {//循环输出字段
		if(rs.getString(3).equals("1")){
			ZJSign = "直联商户";
		}else if(rs.getString(3).equals("2")){
			ZJSign = "间联商户";
		}else{
			ZJSign = "不详";
		}
		if(i==0){
			checked = "checked";
		}else{
			checked = "";
		}

		out.println("<tr style='cursor:hand;'>");
		out.println("<td class='TableRow1'><input name='BUSINO_Sign' type='radio' value='" + rs.getString(2).trim() + "|" + rs.getString(3) + "' " + checked + "/></td>");
		out.println("<td class='TableRow1'>" + rs.getString(2) + "</td>");
		out.println("<td class='TableRow1'>" + ZJSign + "</td>");
		out.println("</tr>");
		i++;
	}while (rs.next());


 %>
<!-- 查询数据库循环输出商户号和类别结束 -->
	  <tr style='cursor:hand;'>
	    <td align="center" colspan="3" class='TableRow1'>起始日期：&nbsp;<input type="text" name="datefrom" onFocus="CalendarWebControl.show(this,false,this.value);"></td>
	  </tr>
	  <tr>
	    <td align="center" colspan="3" class='TableRow1'>终止日期：&nbsp;<input type="text" name="dateto" onFocus="CalendarWebControl.show(this,false,this.value);"></td>
	  </tr>
	  <tr style='cursor:hand;'>
	  	<td colspan="3" align="center"><input type="button" onclick="tj1();" value="下一步" class="button_bg"></td>
	  </tr>

<%
}else{
	out.println("<tr style='cursor:hand;'>");
	out.println("<td align='center' colspan='3' class='TableRow1'>卡号没有关联对应的商户号，请返回</td>");
	out.println("</tr>");
	out.println("<tr style='cursor:hand;'>");
	out.println("<td align='center' colspan='3'><input type='button' onclick='Javascript:window.history.back()' value='返回' class='button_bg'></td>");
	out.println("</tr>");
}
 %>

	</table>

</form>
<%
	try{//关闭数据库连接
		dbConn.close();
	}catch(SQLException e){
		log.Write("[" + logRMNO + "] Step 1: close dbConn......" + e.getMessage());
	}
 %>
</body>
</html>