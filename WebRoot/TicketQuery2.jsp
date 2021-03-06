<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.bocom.mobilebank.security.*"%>
<%@ page import="com.viatt.util.GzLog" %>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE"));
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n体育彩票查询步骤2");
%>
<?xml version="1.0" encoding="utf-8"?> 
<res> 
	<content>
<%
	String TLogNo = request.getParameter("TLogNo");
	String sendContext = "|biz_id,29|biz_step_id,1|TLogNo,"
			+ TLogNo + "|";
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n发送报文为："+sendContext);
	MidServer midServer = new MidServer();
	BwResult bwResult = midServer.sendMessage(sendContext);
	
	String message = bwResult.getContext();
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n接收报文为："+message);
	//成功报文
	//message = "0394|bocom_mid|biz_id,21|biz_no,00021|biz_step_id,1|display_zone,预定内容： 广之旅调试线路20090510 test <br>服务商： 广之旅国内游总部  <br>总金额： 1.00  <br>已付金额： 0.00  <br>欠费金额： 1.00  <br>|MGID,000000|Reserve_Code,4538477|Product_Name,广之旅调试线路20090510 test|Provide_Name,广之旅国内游总部|Trans_Toal_Amount,00000000000100|Paid_Amount,00000000000000|Arrearage_Amount,00000000000100|";
	//失败报文
	//message = "0189|bocom_mid|biz_id,21|biz_no,00021|biz_step_id,1|display_zone,<font color=ff0000><b>--->订单号已缴清！<br>--->如有疑问或问题请咨询银旅通客户服务热线：4008-960-168</b></font><br>|MGID,482199|";
	String MGID = MessManTool.getValueByName(message, "MGID");
	if ("000000".equals(MGID)) {
%> 
<%
 	  String TRspCd = MessManTool.getValueByName(message, "TRspCd");
 		String TrmCod = MessManTool.getValueByName(message, "TrmCod");
 		String SigDup = MessManTool.getValueByName(message, "SigDup");
 		String LotTyp = MessManTool.getValueByName(message, "LotTyp");
 		String LotNum = MessManTool.getValueByName(message, "LotNum");
 		String NotNum = MessManTool.getValueByName(message, "NotNum");
 		String TxnAmt = MessManTool.getValueByName(message, "TxnAmt");
 %> 
	<form method='post' action='/GZMBank/yinLvTong/yinLvTongJF3.jsp'> 

		<table border="1">
			<tr>
				<td>
					状态:
				</td>
				<td>
					<%=TRspCd%>
				</td>
			</tr>
			<tr>
				<td>
					期号:
				</td>
				<td>
					<%=TrmCod%>
				</td>
			</tr>
			<tr>
				<td>
					单复式类型:
				</td>
				<td>
					<%=SigDup%>
				</td>
			</tr>
			<tr>
				<td>
					彩票类型:
				</td>
				<td>
					<%=LotTyp%> 
				</td>
			</tr>
			<tr>
				<td>
					购彩流水号:
				</td>
				<td>
					<%=TLogNo%>
				</td>
			</tr>
			<tr>
				<td>
					投注号码:
				</td>
				<td>
					<%=LotNum%> 
				</td>
			</tr>
			<tr>
				<td>
					注数:
				</td>
				<td>
					<%=NotNum%> 
				</td>
			</tr>
			<tr>
				<td>
					金额:
				</td>
				<td>
					<%=MoneyUtils.FormatMoney(Double.parseDouble(TxnAmt.trim()) / 100, "###0.00")%> 
				</td>
			</tr>
		</table>
	</form> 
<%
 	}else{
%> 
		查询失败！ 
		<br/> 
		如有疑问，请及时与开户银行联系！ 
<%
	}
%>
</content>
</res> 