<%@ page language="java" contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*" %>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.bocom.midserv.gz.*"%>
<%@ page import="com.gdbocom.Transactions.WelLot" %>
<%@include file="/includeFiles/common.jsp" %>
<html>
    <head>
        <title>交通银行网上服务</title>
        <link rel="stylesheet" type="text/css" href="/personbank/css/<%=cssFileName%>"></link>
    </head>
    <body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  oncontextmenu="self.event.returnValue=false" onselectstart="return false">
    <div class="indent">
    <form action="/personbank/HttpProxy" method="post" name="form1">
        <input type="hidden" name="URL" value="/midserv/Wel_hTen_Sel.jsp"/>
        <input type="hidden" name="dse_sessionId" value="<%=dse_sessionId%>"/>
        <table width="90%" align="center" cellpadding="1" cellspacing="1"  class="tab">
		  <tr align="center" class="tab_title">
		    <td align="left" colspan="2">
		     快乐十分简介:
		    </td>
		  </tr>
		  <tr></tr>
		 <tr class="tab_tr"> 
	        <td align="center">
				<textarea rows="45" cols="100"  style="width: 100%;">
 快乐十分是中国国家福利彩票高频彩种的一种流行玩法，每天每十分钟开奖1期，每天开奖84期。11月至次年4月开奖时间为8:30-22:30,5月至10月开奖时间为9：00-23:00。快乐十分采用组合式玩法，从1-20个数字号码中选择号码进行投注，共10种玩法，其中19和20号为红色球。
（注：奖金额以福彩中心公告为准）
（1）选一数投：从01至18中任选1个,投注号码与开奖号码第一位相同即中奖25元。选号实例：
选号：01
开奖：01、02、03、04、05、06、07、08
中奖：25元
（2）选一红投：19，20为红号，从这两个号码任选一个投注，开奖号码第一位是红号（19或20）即中奖5元。选号实例：
选号：20
开奖：19、02、03、04、05、06、07、08
中奖：5元
（3）任选二：从20个号码中任选2个,投注号码与开奖号码任意两位相同即中奖8元。选号实例：
选号：01、02
开奖：01、02、03、04、05、06、07、08
中奖：8元
（4）选二连直：从20个号码中任选连续两位,投注号码与开奖号码任意连续两位数字、顺序均相同即中奖62元。选号实例：
选号：01、02
开奖：01、02、03、04、05、06、07、08
中奖：62元
（5）选二连组：从20个号码中任选2个,投注号与开奖号任意连续两位数字相同(顺序不限)即中31元。选号实例：
选号：01、02
开奖：02、01、03、04、05、06、07、08
中奖：31元
（6）任选三：从20个号码中任选3个,投注号码与开奖号码任意三位相同即中奖24元。选号实例：
选号：01、02、03
开奖：01、02、03、04、05、06、07、08
中奖：24元
（7）选三前直：从20个号码中猜开奖号码前三位,投注号码与开奖号码前三位数字、顺序均相同即中奖8000元。选号实例：
选号：01、02、03
开奖：01、02、03、04、05、06、07、08
中奖：8000元
（8）选三前组：从20个号码中猜开奖号码的前三位,投注号与开奖号前三位数字相同(顺序不限)即中1300元。选号实例：
选号：02、03、01
开奖：01、02、03、04、05、06、07、08
中奖：1300元
（9）任选四：从20个号码中任选4个,投注号码与开奖号码任意四位相同即中奖80元。
选号：01、02、05、07
开奖：01、02、03、04、05、06、07、08
中奖：80元
（10）任选五：从20个号码中任选5个,投注号码与开奖号码任意五位相同即中奖320元。选号实例：
选号：01、02、05、07、08
开奖：01、02、03、04、05、06、07、08
中奖：320元
				</textarea>
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
