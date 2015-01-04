package com.viatt.rpt.action;


import java.io.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.*;
import javax.servlet.http.*;
/*
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFPrintSetup;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.viatt.rpt.comm.*;
*/
public class ExcelServlet2 extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response)
    throws IOException, ServletException
    {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Hello World!</title>");
        out.println("</head>");
        out.println("<body>");
        out.println("<h1>Hello World!</h1>");
        out.println("</body>");
        out.println("</html>");
/*
    	try{
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
			aSheet.setColumnWidth(0, excelUtil.getColumnWidth(22));
			aSheet.setColumnWidth(1, excelUtil.getColumnWidth(8));
			aSheet.setColumnWidth(2, excelUtil.getColumnWidth(7));
			aSheet.setColumnWidth(3, excelUtil.getColumnWidth(7));
			aSheet.setColumnWidth(4, excelUtil.getColumnWidth(7));
			aSheet.setColumnWidth(5, excelUtil.getColumnWidth(10));
			aSheet.setColumnWidth(6, excelUtil.getColumnWidth(10));
			aSheet.setColumnWidth(7, excelUtil.getColumnWidth(11));
			aSheet.setColumnWidth(8, excelUtil.getColumnWidth(8));
			aSheet.setColumnWidth(9, excelUtil.getColumnWidth(8));

			HSSFCellStyle aStyle = workbook.createCellStyle();
			HSSFFont titlefont = workbook.createFont();
			titlefont.setFontHeightInPoints((short) 16);
			titlefont.setFontName("黑体");
			titlefont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
			aStyle.setFont(titlefont);
			aStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
			aStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
			aStyle.setBorderBottom((short) 1);
			aStyle.setBorderTop((short) 1);
			aStyle.setBorderLeft((short) 1);
			aStyle.setBorderRight((short) 1);

			HSSFRow aRow0 = aSheet.createRow(0);
			aRow0.setHeight((short) 500);
			ExcelRow excelRow0 = new ExcelRow(aRow0);
			excelRow0.setCellStyle(aStyle);
			excelRow0.setSheet(aSheet);

			excelRow0.addCell("广东省分行交通银行业务简表", 9);

			
			HSSFCellStyle titleStyle = workbook.createCellStyle();
			titleStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
			titleStyle.setBorderBottom((short) 1);
			titleStyle.setBorderTop((short) 1);
			titleStyle.setBorderLeft((short) 1);
			titleStyle.setBorderRight((short) 1);

			HSSFRow aRow1 = aSheet.createRow(1);
			ExcelRow excelRow1 = new ExcelRow(aRow1);
			excelRow1.setCellStyle(titleStyle);
			excelRow1.setSheet(aSheet);

			excelRow1.addCell("全行汇总", 3);
			excelRow1.addCell("简表日期：", 4);
			excelRow1.addCell("单位：亿元/亿美元", 3);

			HSSFRow aRow2 = aSheet.createRow(2);
			ExcelRow excelRow2 = new ExcelRow(aRow2);
			excelRow2.setCellStyle(titleStyle);
			excelRow2.setSheet(aSheet);

			excelRow2.addCell("科目名称 ");
			excelRow2.addCell("当日数 ");
			excelRow2.addCell("比上日");
			excelRow2.addCell("比上月");
			excelRow2.addCell("比上年");
			excelRow2.addCell("比上年增幅（％）");
			excelRow2.addCell("去年同期比年初");
			excelRow2.addCell("去年同期增幅（％）");
			excelRow2.addCell("比去年同期");
			excelRow2.addCell("增幅（％）");

			List list = new ArrayList();



			HSSFCellStyle contentStyle = workbook.createCellStyle();
			contentStyle.setAlignment(HSSFCellStyle.ALIGN_LEFT);
			contentStyle.setBorderBottom((short) 1);
			contentStyle.setBorderTop((short) 1);
			contentStyle.setBorderLeft((short) 1);
			contentStyle.setBorderRight((short) 1);


			response.setContentType("application/vnd.ms-excel");
			response.setContentType("application/vnd.ms-excel;charset=GBK");
			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
			Date date2 = new Date();
			String date1 = formatter.format(date2);
			response.setHeader("Content-Disposition",
					"attachment;filename= jtyhywjb" + date1 + "excel.xls");
			ServletOutputStream sos = response.getOutputStream();
			
			File file=new File("D:/test/test.xls");
			file.mkdirs();
			FileOutputStream fileOS=new FileOutputStream(file);
		//-------------------------------------------
			workbook.write(fileOS);
			/*sos.flush();
			sos.close();

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	private void jbrptExcel(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		HSSFWorkbook workbook = new HSSFWorkbook();
		HSSFSheet aSheet = null;
		String strDate = MyRequest.GetString(request, "rptDate");
		int iRptType = MyRequest.GetInt(request,"rptdim",1);
		
		try {
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
			
			
			HSSFCellStyle aStyle = workbook.createCellStyle();
			HSSFFont titlefont = workbook.createFont();
			titlefont.setFontHeightInPoints((short) 16);
			titlefont.setFontName("黑体");
			titlefont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
			aStyle.setFont(titlefont);
			aStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
			aStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
			aStyle.setBorderBottom((short) 1);
			aStyle.setBorderTop((short) 1);
			aStyle.setBorderLeft((short) 1);
			aStyle.setBorderRight((short) 1);
			

			ExcelUtil excelUtil = new ExcelUtil();
			aSheet.setColumnWidth(0, excelUtil.getColumnWidth(10));
			aSheet.setColumnWidth(1, excelUtil.getColumnWidth(6));
			aSheet.setColumnWidth(2, excelUtil.getColumnWidth(6));
			aSheet.setColumnWidth(3, excelUtil.getColumnWidth(6));
			aSheet.setColumnWidth(4, excelUtil.getColumnWidth(6));
			aSheet.setColumnWidth(5, excelUtil.getColumnWidth(6));
			aSheet.setColumnWidth(6, excelUtil.getColumnWidth(6));
			aSheet.setColumnWidth(7, excelUtil.getColumnWidth(6));
			aSheet.setColumnWidth(8, excelUtil.getColumnWidth(6));
			aSheet.setColumnWidth(9, excelUtil.getColumnWidth(6));
			aSheet.setColumnWidth(10, excelUtil.getColumnWidth(6));
			aSheet.setColumnWidth(11, excelUtil.getColumnWidth(6));
			aSheet.setColumnWidth(12, excelUtil.getColumnWidth(6));
			aSheet.setColumnWidth(13, excelUtil.getColumnWidth(6));
			aSheet.setColumnWidth(14, excelUtil.getColumnWidth(6));
			aSheet.setColumnWidth(15, excelUtil.getColumnWidth(6));

			HSSFRow aRow0 = aSheet.createRow(0);
			aRow0.setHeight((short) 500);
			ExcelRow excelRow0 = new ExcelRow(aRow0);
			excelRow0.setCellStyle(aStyle);
			excelRow0.setSheet(aSheet);
			if(iRptType==1){
				excelRow0.addCell("交通银行广东省分行（全辖）人民币贷款一览表", 16);
			}else if(iRptType==2){
				excelRow0.addCell("交通银行广东省分行（全辖）人民币存款一览表", 16);
			}else if(iRptType==3){
				excelRow0.addCell("交通银行广东省分行（全辖）外币存贷款一览表", 16);
			}

			HSSFCellStyle titleStyle = workbook.createCellStyle();
			titleStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
			titleStyle.setBorderBottom((short) 1);
			titleStyle.setBorderTop((short) 1);
			titleStyle.setBorderLeft((short) 1);
			titleStyle.setBorderRight((short) 1);

			HSSFRow aRow1 = aSheet.createRow(1);
			ExcelRow excelRow1 = new ExcelRow(aRow1);
			excelRow1.setCellStyle(titleStyle);
			excelRow1.setSheet(aSheet);
			if(iRptType==1){
				excelRow1.addCell("人民币");
				excelRow1.addCell("各项贷款" ,3);
				excelRow1.addCell("对公贷款", 3);
				excelRow1.addCell("个人贷款", 3);
				excelRow1.addCell("票据贴现", 3);
				excelRow1.addCell("其中：人民币中长期贷款", 3);
			}else if(iRptType==2){
				excelRow1.addCell("人民币");
				excelRow1.addCell("各项贷款" ,3);
				excelRow1.addCell("对公贷款", 3);
				excelRow1.addCell("储蓄存款", 3);
				excelRow1.addCell("同业存款", 3);
				excelRow1.addCell("人民币",2);
				excelRow1.addCell("外币");
			}else if(iRptType==3){
				excelRow1.addCell("外币");
				excelRow1.addCell("各项贷款" ,3);
				excelRow1.addCell("对公贷款", 3);
				excelRow1.addCell("储蓄存款", 3);
				excelRow1.addCell("同业存款", 3);
				excelRow1.addCell("各项贷款", 3);
			}

			
			HSSFRow aRow2 = aSheet.createRow(2);
			ExcelRow excelRow2 = new ExcelRow(aRow2);
			excelRow2.setCellStyle(titleStyle);
			excelRow2.setSheet(aSheet);
			if(iRptType==1){
				excelRow2.addCell(" ");
				excelRow2.addCell("A=B+C+D",3);
				excelRow2.addCell("B",3);
				excelRow2.addCell("C",3);
				excelRow2.addCell("D",3);
				excelRow2.addCell(" ",3);
			}else if(iRptType==2){
				excelRow2.addCell(" ");
				excelRow2.addCell("E=F+G",3);
				excelRow2.addCell("F",3);
				excelRow2.addCell("G",3);
				excelRow2.addCell(" ",3);
				excelRow2.addCell(" ",2);
				excelRow2.addCell(" ");
			}else if(iRptType==3){
				excelRow2.addCell(" ");
				excelRow2.addCell("E=F+G",3);
				excelRow2.addCell("F",3);
				excelRow2.addCell("G",3);
				excelRow2.addCell(" ",3);
				excelRow2.addCell(" ",3);
			}
			
			HSSFRow aRow3 = aSheet.createRow(3);
			ExcelRow excelRow3 = new ExcelRow(aRow3);
			excelRow3.setCellStyle(titleStyle);
			excelRow3.setSheet(aSheet);

			if(iRptType==1){
				excelRow3.addCell("行名");
				excelRow3.addCell("本日余额");
				excelRow3.addCell("比上日");
				excelRow3.addCell("比年初");
				excelRow3.addCell("本日余额");
				excelRow3.addCell("比上日");
				excelRow3.addCell("比年初");
				excelRow3.addCell("本日余额");
				excelRow3.addCell("比上日");
				excelRow3.addCell("比年初");
				excelRow3.addCell("本日余额");
				excelRow3.addCell("比上日");
				excelRow3.addCell("比年初");
				excelRow3.addCell("本日余额");
				excelRow3.addCell("比上日");
				excelRow3.addCell("比年初");
			}else if(iRptType==2){
				excelRow3.addCell("行名");
				excelRow3.addCell("本日余额");
				excelRow3.addCell("比上日");
				excelRow3.addCell("比年初");
				excelRow3.addCell("本日余额");
				excelRow3.addCell("比上日");
				excelRow3.addCell("比年初");
				excelRow3.addCell("本日余额");
				excelRow3.addCell("比上日");
				excelRow3.addCell("比年初");
				excelRow3.addCell("本日余额");
				excelRow3.addCell("比上日");
				excelRow3.addCell("比年初");
				excelRow3.addCell("余额存贷比");
				excelRow3.addCell("增量存贷比");
				excelRow3.addCell("余额存贷比");
			}else if(iRptType==3){
				excelRow3.addCell("行名");
				excelRow3.addCell("本日余额");
				excelRow3.addCell("比上日");
				excelRow3.addCell("比年初");
				excelRow3.addCell("本日余额");
				excelRow3.addCell("比上日");
				excelRow3.addCell("比年初");
				excelRow3.addCell("本日余额");
				excelRow3.addCell("比上日");
				excelRow3.addCell("比年初");
				excelRow3.addCell("本日余额");
				excelRow3.addCell("比上日");
				excelRow3.addCell("比年初");
				excelRow3.addCell("本日余额");
				excelRow3.addCell("比上日");
				excelRow3.addCell("比年初");
			}
			List list = new ArrayList();


			list =  dao.findByDateAndRt(strDate.replaceAll("-",""),iRptType);
			
			HSSFCellStyle contentStyle = workbook.createCellStyle();
			contentStyle.setAlignment(HSSFCellStyle.ALIGN_LEFT);
			contentStyle.setBorderBottom((short) 1);
			contentStyle.setBorderTop((short) 1);
			contentStyle.setBorderLeft((short) 1);
			contentStyle.setBorderRight((short) 1);
			

			response.setContentType("application/vnd.ms-excel");
			response.setContentType("application/vnd.ms-excel;charset=GBK");
			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
			Date date2 = new Date();
			String date1 = formatter.format(date2);
			response.setHeader("Content-Disposition",
					"attachment;filename= jbrpt" + date1 + "excel.xls");
			ServletOutputStream sos = response.getOutputStream();
			workbook.write(sos);
			sos.flush();
			sos.close();


    	}catch(Exception e){ 
    	System.out.println(e); 
    	} */
    }
   	 
}

