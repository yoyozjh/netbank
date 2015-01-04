<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.bocom.midserv.gz.*"%>
<%@ page import="com.viatt.bean.*"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="java.io.*" %>
<%@ page import="com.viatt.rpt.comm.*" %>
<%@ page import="org.apache.poi.hssf.usermodel.*" %>
<%@ page import="java.sql.*" %>

<%
	GzLog log = new GzLog("c:/gzLog");
	String logRMNO = String.valueOf(Math.random()).substring(3,9);
	String CrdNo = MessManTool.changeChar(request.getParameter("cardNo"));
	String dse_sessionId = MessManTool.changeChar(request.getParameter("dse_sessionId"));//获取dse_sessionId
	String biz_id = MessManTool.changeChar(request.getParameter("biz_id"));
	String datefrom = MessManTool.changeChar(request.getParameter("datefrom"));
	String dateto = MessManTool.changeChar(request.getParameter("dateto"));
	String BUSINO_Sign = MessManTool.changeChar(request.getParameter("BUSINO_Sign"));
	String[] tmp2 = BUSINO_Sign.split("\\|");
	String BUSINO = tmp2[0];
	String Sign = "";
//	BUSINO = "301440115200025";
	String datatable = "";
	if(tmp2[1].equals("1")){
		Sign = "直联商户";
		datatable = "CORP_TRADE_ZL";
	}else if(tmp2[1].equals("2")){
		Sign = "间联商户";
		datatable = "CORP_TRADE_JL";
	}
	SimpleDateFormat tmpdate1 = new SimpleDateFormat("yyyy-MM-dd");
	SimpleDateFormat tmpdate2 = new SimpleDateFormat("yyyyMMdd");
//	String result = tmpdate2.format(tmpdate1.parse("2009-12-55"));

	String datefrom2 = tmpdate2.format(tmpdate1.parse(datefrom));
	String dateto2 = tmpdate2.format(tmpdate1.parse(dateto));

/*
//	String content = "|biz_id," + biz_id + "|i_biz_step_id,1|datefrom,20080101|dateto,20080101|CrdNo," + CrdNo + "|ZJSign,2|";
	String content = "|biz_id,111|i_biz_step_id,1|datefrom,20080101|dateto,20080101|CrdNo,60142890710180319|ZJSign,2|";
//	String content = "|biz_id,9|biz_step_id,1|CDNO,60142890710180319|PSWD,******|CarType,A1|CarNo,09B61|";
	if (biz_id.equals("") ) {
		System.out.println("传入参数不正确");
	}
	List list = new ArrayList();
	String tmp="";
	MidServer midServer = new MidServer();
	BwResult bwResult = midServer.sendMessage(content);
	if (bwResult == null || bwResult.getCode() == null
	|| !bwResult.getCode().equals("000")) {
			
	 }
	tmp = bwResult.getContext();
*/	
	//===================================================
	//生成xls对账文件
	

    	HSSFWorkbook workbook = new HSSFWorkbook();
    	HSSFSheet aSheet = null;
		aSheet = workbook.createSheet();
		HSSFPrintSetup printSetup = aSheet.getPrintSetup();
		printSetup.setPaperSize(HSSFPrintSetup.A4_PAPERSIZE);
		printSetup.setLandscape(true);
		printSetup.setFooterMargin(0.0);
		printSetup.setHeaderMargin(0.0);
		aSheet.setMargin(HSSFSheet.LeftMargin, 0.1);
		aSheet.setMargin(HSSFSheet.RightMargin, 0.1);
		aSheet.setMargin(HSSFSheet.TopMargin, 0.5);
		aSheet.setMargin(HSSFSheet.BottomMargin, 0.3);
			
		ExcelUtil excelUtil = new ExcelUtil();
		//设置列宽
		aSheet.setColumnWidth(0, excelUtil.getColumnWidth(30));
		aSheet.setColumnWidth(1, excelUtil.getColumnWidth(12));
		aSheet.setColumnWidth(2, excelUtil.getColumnWidth(7));
		aSheet.setColumnWidth(3, excelUtil.getColumnWidth(8));
		aSheet.setColumnWidth(4, excelUtil.getColumnWidth(10));
		aSheet.setColumnWidth(5, excelUtil.getColumnWidth(10));
		aSheet.setColumnWidth(6, excelUtil.getColumnWidth(10));
		aSheet.setColumnWidth(7, excelUtil.getColumnWidth(10));
		aSheet.setColumnWidth(8, excelUtil.getColumnWidth(10));
		aSheet.setColumnWidth(9, excelUtil.getColumnWidth(8));
		
		//设置标题一单元格格式
		HSSFCellStyle aStyle = workbook.createCellStyle();
		HSSFFont titlefont = workbook.createFont();
		titlefont.setFontHeightInPoints((short) 16);
		titlefont.setFontName("黑体");
		titlefont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		aStyle.setFont(titlefont);
		aStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		aStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
/*		aStyle.setBorderBottom((short) 1);
		aStyle.setBorderTop((short) 1);
		aStyle.setBorderLeft((short) 1);
		aStyle.setBorderRight((short) 1);
*/
		//设置标题二单元格格式
		HSSFCellStyle titleStyle2 = workbook.createCellStyle();
		HSSFFont titlefont2 = workbook.createFont();
		titlefont2.setFontHeightInPoints((short) 14);
		titlefont2.setFontName("黑体");
		titlefont2.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		titleStyle2.setFont(titlefont2);
		titleStyle2.setAlignment(HSSFCellStyle.ALIGN_LEFT);
		titleStyle2.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
/*		titleStyle2.setBorderBottom((short) 1);
		titleStyle2.setBorderTop((short) 1);
		titleStyle2.setBorderLeft((short) 1);
		titleStyle2.setBorderRight((short) 1);
*/		
		//设置标题三单元格格式
		HSSFCellStyle titleStyle3 = workbook.createCellStyle();
		HSSFFont titlefont3 = workbook.createFont();
		titlefont3.setFontHeightInPoints((short) 10);
		titlefont3.setFontName("黑体");
		titlefont3.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		titleStyle3.setFont(titlefont3);
		titleStyle3.setAlignment(HSSFCellStyle.ALIGN_LEFT);
		titleStyle3.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		titleStyle3.setBorderBottom((short) 1);
		titleStyle3.setBorderTop((short) 1);
		titleStyle3.setBorderLeft((short) 1);
		titleStyle3.setBorderRight((short) 1);
		
		//设置正文单元格格式
		HSSFCellStyle contentStyle = workbook.createCellStyle();
		contentStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		contentStyle.setBorderBottom((short) 1);
		contentStyle.setBorderTop((short) 1);
		contentStyle.setBorderLeft((short) 1);
		contentStyle.setBorderRight((short) 1);

		HSSFRow aRow0 = aSheet.createRow(0);
		aRow0.setHeight((short) 500);
		ExcelRow excelRow0 = new ExcelRow(aRow0);
		excelRow0.setCellStyle(aStyle);
		excelRow0.setSheet(aSheet);
		excelRow0.addCell("商户明细与汇总表", 9);
			

//用于生成大表头的，没有用到，所以屏蔽
/*		HSSFRow aRow1 = aSheet.createRow(1);
		ExcelRow excelRow1 = new ExcelRow(aRow1);
		excelRow1.setCellStyle(titleStyle);
		excelRow1.setSheet(aSheet);

		excelRow1.addCell("全行汇总", 3);
		excelRow1.addCell("简表日期：", 4);
		excelRow1.addCell("单位：亿元/亿美元", 3);*/

//		HSSFRow aRow2 = aSheet.createRow(2);
		HSSFRow aRow2 = aSheet.createRow(1);//createRow的参数用于定位用的是哪一行
		ExcelRow excelRow2 = new ExcelRow(aRow2);
		excelRow2.setCellStyle(titleStyle3);
		excelRow2.setSheet(aSheet);

		excelRow2.addCell("商户名称");
		excelRow2.addCell("商户编号");
		excelRow2.addCell("终端编号");
		excelRow2.addCell("交易时间");
		excelRow2.addCell("交易金额");
		excelRow2.addCell("商户应付");
		excelRow2.addCell("清算金额");
		excelRow2.addCell("交易类型");
		excelRow2.addCell("流水号");

		
		//连接数据库
		//其中st_TERMID用于查询终端的 Statement对象，st_detail用于查询对应终端的明细的的 Statement对象
		//sqlstr_TERMID用于查询对应商户有多少个终端，sqlstr_detail用于查询对应终端的明细
		//rs_TERMID用于保存终端号数据，rs_detail用于保存对应终端的明细

		Connection dbConn = null;
		Statement st_TERMID = null;
		Statement st_detail = null;
		Statement st_totle = null;
		ResultSet rs_TERMID = null;
		ResultSet rs_detail = null;
		ResultSet rs_totle = null;
		String sqlstr_TERMID = "";
		String sqlstr_detail = "";
		String sqlstr_totle = "";

    	try {//建立数据库连接
        	dbConn = DriverManager.getConnection("jdbc:sybase:Tds:182.53.15.211:6600/middb?CHARSET=cp936&amp;amp;LANGUAGE=en_US", "miduser", "miduser");
    	} catch (SQLException e) {
			log.Write("[" + logRMNO + "] Step 1: getConnection......" + e.getMessage()); 
			e.printStackTrace();
    	}
    
		try{//打开对话,赋给ResultSet
			
			//查询终端
			sqlstr_TERMID = "select distinct TERMID FROM " + datatable;
			sqlstr_TERMID = sqlstr_TERMID + " WHERE BUSINO like '%" + BUSINO + "%'";
			log.Write(sqlstr_TERMID);
	    	st_TERMID = dbConn.createStatement();
	    	rs_TERMID = st_TERMID.executeQuery(sqlstr_TERMID);
	    
	    } catch (SQLException e) {
			log.Write("[" + logRMNO + "] Step 1: createStatement......" + e.getMessage()); 
			e.printStackTrace();
		}
			
		//生成xls文件内容

		//for (int i = 0; i<100; i++) {
		int i = 0;
		
		while(rs_TERMID.next()){
			try{//打开对话,赋给ResultSet
			//查询明细
				sqlstr_detail = "select CUSTNAME, BUSINO, TERMID, TxnDat, TxnAmt, CorpShouldPay, TxnAmt-CorpShouldPay, TrdTyp, AthTlr";
	    		sqlstr_detail = sqlstr_detail + " from " + datatable;
	    		sqlstr_detail = sqlstr_detail + " where TERMID like '%" + rs_TERMID.getString(1) + "%' and BUSINO like '%" + BUSINO + "%' and convert(char,TxnDat,112) between '" + datefrom2 + "' and '" + dateto2 + "'";
				sqlstr_detail = sqlstr_detail + " order by TERMID";
			log.Write(sqlstr_detail);
			
	    		st_detail = dbConn.createStatement();
	    		rs_detail = st_detail.executeQuery(sqlstr_detail);
	    
	    	} catch (SQLException e) {
				log.Write("[" + logRMNO + "] Step 1: createStatement......" + e.getMessage()); 
				e.printStackTrace();
			}
			
			while(rs_detail.next()){
				HSSFRow tmpRow = aSheet.createRow(i + 2);
				ExcelRow tmpexcelRow = new ExcelRow(tmpRow);
				tmpexcelRow.setCellStyle(contentStyle);
				tmpexcelRow.addCell(rs_detail.getString(1));
				tmpexcelRow.addCell(rs_detail.getString(2));
				tmpexcelRow.addCell(rs_detail.getString(3));
				tmpexcelRow.addCell(rs_detail.getString(4));
				tmpexcelRow.addCell(rs_detail.getString(5));
				tmpexcelRow.addCell(rs_detail.getString(6));
				tmpexcelRow.addCell(rs_detail.getString(7));
				tmpexcelRow.addCell(rs_detail.getString(8));
				tmpexcelRow.addCell(rs_detail.getString(9));
				i++;
			}
			try{//打开对话,赋给ResultSet
			//按终端汇总
				sqlstr_totle = "select TERMID, count(ActDat), sum(TxnAmt), sum(CorpShouldPay), sum(TxnAmt)-sum(CorpShouldPay)";
	    		sqlstr_totle = sqlstr_totle + " from " + datatable;
	    		sqlstr_totle = sqlstr_totle + " where TERMID like '%" + rs_TERMID.getString(1) + "%' and BUSINO like '%" + BUSINO + "%' and convert(char,TxnDat,112) between '" + datefrom2 + "' and '" + dateto2 + "'";
				sqlstr_totle = sqlstr_totle + " group by TERMID";
			log.Write(sqlstr_totle);
			
	    		st_totle = dbConn.createStatement();
	    		rs_totle = st_totle.executeQuery(sqlstr_totle);
	    
	    	} catch (SQLException e) {
				log.Write("[" + logRMNO + "] Step 1: createStatement......" + e.getMessage()); 
				e.printStackTrace();
			}
			while(rs_totle.next()){
				HSSFRow tmpRow = aSheet.createRow(i + 2);
				ExcelRow tmpexcelRow = new ExcelRow(tmpRow);
				tmpexcelRow.setCellStyle(titleStyle3);
				tmpexcelRow.addCell(rs_totle.getString(1) + "终端编号汇总");
				tmpexcelRow.addCell("笔数： " + rs_totle.getString(2) + "  交易金额: " + rs_totle.getString(3) + "  商户应付： " + rs_totle.getString(4) + "  清算金额： " + rs_totle.getString(5),8);
				i++;
			}
		}
		i++;
		HSSFRow tmpRow2 = aSheet.createRow(i + 2);
		ExcelRow tmpexcelRow2 = new ExcelRow(tmpRow2);
		tmpexcelRow2.setCellStyle(titleStyle2);
		tmpexcelRow2.addCell("商户编号 " + BUSINO + "汇总");
		i++;
		
		HSSFRow aRow3 = aSheet.createRow(i + 2);//createRow的参数用于定位用的是哪一行
		ExcelRow excelRow3 = new ExcelRow(aRow3);
		excelRow3.setCellStyle(titleStyle3);
		excelRow3.setSheet(aSheet);

		excelRow3.addCell("交易类型");
		excelRow3.addCell("交易笔数");
		excelRow3.addCell("交易金额");
		excelRow3.addCell("手续费");
		excelRow3.addCell("清算金额");
		i++;
		
		
			try{//打开对话,赋给ResultSet
			//查询明细
				sqlstr_detail = "select TrdTyp, count(ActDat), sum(TxnAmt), sum(CorpShouldPay), sum(TxnAmt)-sum(CorpShouldPay)";
	    		sqlstr_detail = sqlstr_detail + " from " + datatable;
	    		sqlstr_detail = sqlstr_detail + " where BUSINO like '%" + BUSINO + "%' and convert(char,TxnDat,112) between '" + datefrom2 + "' and '" + dateto2 + "'";
				sqlstr_detail = sqlstr_detail + " group by TrdTyp";
			log.Write(sqlstr_detail);
			
	    		st_detail = dbConn.createStatement();
	    		rs_detail = st_detail.executeQuery(sqlstr_detail);
	    
	    	} catch (SQLException e) {
				log.Write("[" + logRMNO + "] Step 1: createStatement......" + e.getMessage()); 
				e.printStackTrace();
			}
			
			while(rs_detail.next()){
				HSSFRow tmpRow = aSheet.createRow(i + 2);
				ExcelRow tmpexcelRow = new ExcelRow(tmpRow);
				tmpexcelRow.setCellStyle(contentStyle);
				tmpexcelRow.addCell(rs_detail.getString(1));
				tmpexcelRow.addCell(rs_detail.getString(2));
				tmpexcelRow.addCell(rs_detail.getString(3));
				tmpexcelRow.addCell(rs_detail.getString(4));
				tmpexcelRow.addCell(rs_detail.getString(5));
				i++;
			}
			try{//打开对话,赋给ResultSet
			//按终端汇总
				sqlstr_totle = "select count(ActDat), sum(TxnAmt), sum(CorpShouldPay), sum(TxnAmt)-sum(CorpShouldPay)";
	    		sqlstr_totle = sqlstr_totle + " from " + datatable;
	    		sqlstr_totle = sqlstr_totle + " where BUSINO like '%" + BUSINO + "%' and convert(char,TxnDat,112) between '" + datefrom2 + "' and '" + dateto2 + "'";
			log.Write(sqlstr_totle);
			
	    		st_totle = dbConn.createStatement();
	    		rs_totle = st_totle.executeQuery(sqlstr_totle);
	    
	    	} catch (SQLException e) {
				log.Write("[" + logRMNO + "] Step 1: createStatement......" + e.getMessage()); 
				e.printStackTrace();
			}
			while(rs_totle.next()){
				HSSFRow tmpRow = aSheet.createRow(i + 2);
				ExcelRow tmpexcelRow = new ExcelRow(tmpRow);
				tmpexcelRow.setCellStyle(titleStyle3);
				tmpexcelRow.addCell("小计");
				tmpexcelRow.addCell(rs_totle.getString(1));
				tmpexcelRow.addCell(rs_totle.getString(2));
				tmpexcelRow.addCell(rs_totle.getString(3));
				tmpexcelRow.addCell(rs_totle.getString(4));
				i++;
			}

			
			
		//新建xls文件到file文件夹
		File file=new File("c:/bea/midserv/file/" + CrdNo + BUSINO + ".xls");
		FileOutputStream fileOS=new FileOutputStream(file);
		//将工作表写进文件
		workbook.write(fileOS);
		try{//关闭数据库连接
			dbConn.close();
		}catch(SQLException e){
			log.Write("[" + logRMNO + "] Step 1: close dbConn......" + e.getMessage());
		}
%>
<html>
<head>
<title>test</title>
<link rel="stylesheet" type="text/css" href="/personbank/HttpProxy?URL=/midserv/css/personbank.css&dse_sessionId=<%=dse_sessionId%>">
<link rel="stylesheet" type="text/css" href="/personbank/HttpProxy?URL=/midserv/css/midserv.css&dse_sessionId=<%=dse_sessionId%>">
<link rel="stylesheet" type="text/css" href="/personbank/HttpProxy?URL=/midserv/css/csspt.css&dse_sessionId=<%=dse_sessionId%>">
<script language="JavaScript" src="/personbank/HttpProxy?URL=/midserv/js/public.js&dse_sessionId=<%=dse_sessionId%>"></script>
<script language="JavaScript" src="/personbank/HttpProxy?URL=/midserv/js/common.js&dse_sessionId=<%=dse_sessionId%>"></script>

</head>
<body>
<!-- 页面提示开始 -->
<table width="300px" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td	background="/personbank/HttpProxy?URL=/midserv/images/pageTitle.gif&dse_sessionId=<%=dse_sessionId%>" class="pageTitle">
			&nbsp;&nbsp;下 载 对 账 文 件
		</td>

	</tr>
</table>
<!-- 页面提示结束 -->
<br/>
<br/>
	<table width="400" border="0" align="center">
	  <tr style="cursor:hand;" >
	    <td class="TableRow2">卡号：&nbsp;</td>
	    <td class="TableRow2"> <%= CrdNo %></td>
	  </tr>
	  <tr style="cursor:hand;">
	    <td class="TableRow2">已选择的商户号： &nbsp;</td>
	    <td class="TableRow2"> <%= BUSINO %></td>
	  </tr>
	  <tr style="cursor:hand;">
	    <td class="TableRow2">已选择的交易时间： &nbsp;</td>
	    <td class="TableRow2">从&nbsp; <%= datefrom %>&nbsp;至&nbsp;<%=dateto %></td>
	  </tr>
	  <tr style="cursor:hand;">
	  	<td class="TableRow2">请点击下载：</td>
	  	<td class="TableRow2"><a href="/personbank/HttpProxy?dse_sessionId=<%=dse_sessionId%>&URL=/midserv/file/test.xls">商户对账文件下载</a></td>
	  </tr>
	</table>


</body>
</html>