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
	String dse_sessionId = MessManTool.changeChar(request.getParameter("dse_sessionId"));//��ȡdse_sessionId
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
		Sign = "ֱ���̻�";
		datatable = "CORP_TRADE_ZL";
	}else if(tmp2[1].equals("2")){
		Sign = "�����̻�";
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
		System.out.println("�����������ȷ");
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
	//����xls�����ļ�
	

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
		//�����п�
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
		
		//���ñ���һ��Ԫ���ʽ
		HSSFCellStyle aStyle = workbook.createCellStyle();
		HSSFFont titlefont = workbook.createFont();
		titlefont.setFontHeightInPoints((short) 16);
		titlefont.setFontName("����");
		titlefont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		aStyle.setFont(titlefont);
		aStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		aStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
/*		aStyle.setBorderBottom((short) 1);
		aStyle.setBorderTop((short) 1);
		aStyle.setBorderLeft((short) 1);
		aStyle.setBorderRight((short) 1);
*/
		//���ñ������Ԫ���ʽ
		HSSFCellStyle titleStyle2 = workbook.createCellStyle();
		HSSFFont titlefont2 = workbook.createFont();
		titlefont2.setFontHeightInPoints((short) 14);
		titlefont2.setFontName("����");
		titlefont2.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		titleStyle2.setFont(titlefont2);
		titleStyle2.setAlignment(HSSFCellStyle.ALIGN_LEFT);
		titleStyle2.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
/*		titleStyle2.setBorderBottom((short) 1);
		titleStyle2.setBorderTop((short) 1);
		titleStyle2.setBorderLeft((short) 1);
		titleStyle2.setBorderRight((short) 1);
*/		
		//���ñ�������Ԫ���ʽ
		HSSFCellStyle titleStyle3 = workbook.createCellStyle();
		HSSFFont titlefont3 = workbook.createFont();
		titlefont3.setFontHeightInPoints((short) 10);
		titlefont3.setFontName("����");
		titlefont3.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		titleStyle3.setFont(titlefont3);
		titleStyle3.setAlignment(HSSFCellStyle.ALIGN_LEFT);
		titleStyle3.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		titleStyle3.setBorderBottom((short) 1);
		titleStyle3.setBorderTop((short) 1);
		titleStyle3.setBorderLeft((short) 1);
		titleStyle3.setBorderRight((short) 1);
		
		//�������ĵ�Ԫ���ʽ
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
		excelRow0.addCell("�̻���ϸ����ܱ�", 9);
			

//�������ɴ��ͷ�ģ�û���õ�����������
/*		HSSFRow aRow1 = aSheet.createRow(1);
		ExcelRow excelRow1 = new ExcelRow(aRow1);
		excelRow1.setCellStyle(titleStyle);
		excelRow1.setSheet(aSheet);

		excelRow1.addCell("ȫ�л���", 3);
		excelRow1.addCell("������ڣ�", 4);
		excelRow1.addCell("��λ����Ԫ/����Ԫ", 3);*/

//		HSSFRow aRow2 = aSheet.createRow(2);
		HSSFRow aRow2 = aSheet.createRow(1);//createRow�Ĳ������ڶ�λ�õ�����һ��
		ExcelRow excelRow2 = new ExcelRow(aRow2);
		excelRow2.setCellStyle(titleStyle3);
		excelRow2.setSheet(aSheet);

		excelRow2.addCell("�̻�����");
		excelRow2.addCell("�̻����");
		excelRow2.addCell("�ն˱��");
		excelRow2.addCell("����ʱ��");
		excelRow2.addCell("���׽��");
		excelRow2.addCell("�̻�Ӧ��");
		excelRow2.addCell("������");
		excelRow2.addCell("��������");
		excelRow2.addCell("��ˮ��");

		
		//�������ݿ�
		//����st_TERMID���ڲ�ѯ�ն˵� Statement����st_detail���ڲ�ѯ��Ӧ�ն˵���ϸ�ĵ� Statement����
		//sqlstr_TERMID���ڲ�ѯ��Ӧ�̻��ж��ٸ��նˣ�sqlstr_detail���ڲ�ѯ��Ӧ�ն˵���ϸ
		//rs_TERMID���ڱ����ն˺����ݣ�rs_detail���ڱ����Ӧ�ն˵���ϸ

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

    	try {//�������ݿ�����
        	dbConn = DriverManager.getConnection("jdbc:sybase:Tds:182.53.15.211:6600/middb?CHARSET=cp936&amp;amp;LANGUAGE=en_US", "miduser", "miduser");
    	} catch (SQLException e) {
			log.Write("[" + logRMNO + "] Step 1: getConnection......" + e.getMessage()); 
			e.printStackTrace();
    	}
    
		try{//�򿪶Ի�,����ResultSet
			
			//��ѯ�ն�
			sqlstr_TERMID = "select distinct TERMID FROM " + datatable;
			sqlstr_TERMID = sqlstr_TERMID + " WHERE BUSINO like '%" + BUSINO + "%'";
			log.Write(sqlstr_TERMID);
	    	st_TERMID = dbConn.createStatement();
	    	rs_TERMID = st_TERMID.executeQuery(sqlstr_TERMID);
	    
	    } catch (SQLException e) {
			log.Write("[" + logRMNO + "] Step 1: createStatement......" + e.getMessage()); 
			e.printStackTrace();
		}
			
		//����xls�ļ�����

		//for (int i = 0; i<100; i++) {
		int i = 0;
		
		while(rs_TERMID.next()){
			try{//�򿪶Ի�,����ResultSet
			//��ѯ��ϸ
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
			try{//�򿪶Ի�,����ResultSet
			//���ն˻���
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
				tmpexcelRow.addCell(rs_totle.getString(1) + "�ն˱�Ż���");
				tmpexcelRow.addCell("������ " + rs_totle.getString(2) + "  ���׽��: " + rs_totle.getString(3) + "  �̻�Ӧ���� " + rs_totle.getString(4) + "  ����� " + rs_totle.getString(5),8);
				i++;
			}
		}
		i++;
		HSSFRow tmpRow2 = aSheet.createRow(i + 2);
		ExcelRow tmpexcelRow2 = new ExcelRow(tmpRow2);
		tmpexcelRow2.setCellStyle(titleStyle2);
		tmpexcelRow2.addCell("�̻���� " + BUSINO + "����");
		i++;
		
		HSSFRow aRow3 = aSheet.createRow(i + 2);//createRow�Ĳ������ڶ�λ�õ�����һ��
		ExcelRow excelRow3 = new ExcelRow(aRow3);
		excelRow3.setCellStyle(titleStyle3);
		excelRow3.setSheet(aSheet);

		excelRow3.addCell("��������");
		excelRow3.addCell("���ױ���");
		excelRow3.addCell("���׽��");
		excelRow3.addCell("������");
		excelRow3.addCell("������");
		i++;
		
		
			try{//�򿪶Ի�,����ResultSet
			//��ѯ��ϸ
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
			try{//�򿪶Ի�,����ResultSet
			//���ն˻���
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
				tmpexcelRow.addCell("С��");
				tmpexcelRow.addCell(rs_totle.getString(1));
				tmpexcelRow.addCell(rs_totle.getString(2));
				tmpexcelRow.addCell(rs_totle.getString(3));
				tmpexcelRow.addCell(rs_totle.getString(4));
				i++;
			}

			
			
		//�½�xls�ļ���file�ļ���
		File file=new File("c:/bea/midserv/file/" + CrdNo + BUSINO + ".xls");
		FileOutputStream fileOS=new FileOutputStream(file);
		//��������д���ļ�
		workbook.write(fileOS);
		try{//�ر����ݿ�����
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
<!-- ҳ����ʾ��ʼ -->
<table width="300px" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td	background="/personbank/HttpProxy?URL=/midserv/images/pageTitle.gif&dse_sessionId=<%=dse_sessionId%>" class="pageTitle">
			&nbsp;&nbsp;�� �� �� �� �� ��
		</td>

	</tr>
</table>
<!-- ҳ����ʾ���� -->
<br/>
<br/>
	<table width="400" border="0" align="center">
	  <tr style="cursor:hand;" >
	    <td class="TableRow2">���ţ�&nbsp;</td>
	    <td class="TableRow2"> <%= CrdNo %></td>
	  </tr>
	  <tr style="cursor:hand;">
	    <td class="TableRow2">��ѡ����̻��ţ� &nbsp;</td>
	    <td class="TableRow2"> <%= BUSINO %></td>
	  </tr>
	  <tr style="cursor:hand;">
	    <td class="TableRow2">��ѡ��Ľ���ʱ�䣺 &nbsp;</td>
	    <td class="TableRow2">��&nbsp; <%= datefrom %>&nbsp;��&nbsp;<%=dateto %></td>
	  </tr>
	  <tr style="cursor:hand;">
	  	<td class="TableRow2">�������أ�</td>
	  	<td class="TableRow2"><a href="/personbank/HttpProxy?dse_sessionId=<%=dse_sessionId%>&URL=/midserv/file/test.xls">�̻������ļ�����</a></td>
	  </tr>
	</table>


</body>
</html>