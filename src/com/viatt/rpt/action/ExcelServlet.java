package com.viatt.rpt.action;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFPrintSetup;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.viatt.rpt.comm.*;

public class ExcelServlet extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String method = request.getParameter("method");
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	private void jtyhywjbExcel(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		HSSFWorkbook workbook = new HSSFWorkbook();
		HSSFSheet aSheet = null;
		String strDate = MyRequest.GetString(request, "rptDate");

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

			excelRow0.addCell("广东省分行交通银行业务简表", 10);

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
			excelRow1.addCell("简表日期：" + strDate, 4);
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

			YwjbDao dao = new YwjbDao();
			if (strDate.equals("")) {
				SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
				strDate = dateformat.format(new Date());
			}
			list = dao.findByDate(strDate.replaceAll("-", ""));
			HSSFCellStyle contentStyle = workbook.createCellStyle();
			contentStyle.setAlignment(HSSFCellStyle.ALIGN_LEFT);
			contentStyle.setBorderBottom((short) 1);
			contentStyle.setBorderTop((short) 1);
			contentStyle.setBorderLeft((short) 1);
			contentStyle.setBorderRight((short) 1);
			for (int i = 0; list!=null&&i < list.size(); i++) {
				YwjbListModel model = (YwjbListModel) list.get(i);
				HSSFRow tmpRow = aSheet.createRow(i + 3);
				ExcelRow tmpexcelRow = new ExcelRow(tmpRow);
				tmpexcelRow.setCellStyle(contentStyle);
				tmpexcelRow.addCell(model.getKmmc());
				tmpexcelRow.addCell(MyUtil.Conver2(model.getDrs()));
				tmpexcelRow.addCell(MyUtil.Conver2(model.getBsr()));
				tmpexcelRow.addCell(MyUtil.Conver2(model.getBsy()));
				tmpexcelRow.addCell(MyUtil.Conver2(model.getBsn()));
				tmpexcelRow.addCell(MyUtil.Conver_2(model.getBsnzf()));
				tmpexcelRow.addCell(MyUtil.Conver2(model.getQntqbnc()));
				tmpexcelRow.addCell(MyUtil.Conver_2(model.getQntqzf()));
				tmpexcelRow.addCell(MyUtil.Conver2(model.getBqntq()));
				tmpexcelRow.addCell(MyUtil.Conver_2(model.getZf()));
			}

			response.setContentType("application/vnd.ms-excel");
			response.setContentType("application/vnd.ms-excel;charset=GBK");
			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
			Date date2 = new Date();
			String date1 = formatter.format(date2);
			response.setHeader("Content-Disposition",
					"attachment;filename= jtyhywjb" + date1 + "excel.xls");
			ServletOutputStream sos = response.getOutputStream();
			workbook.write(sos);
			sos.flush();
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

			RptListDao dao = new RptListDao();
			if(strDate.equals(""))
			{
				strDate=dao.getMaxDateFromRList();
				if(!strDate.trim().equals(""))
				{
					strDate =DBISOtoGB.ChangeDate2(strDate);
				}
			}
			list =  dao.findByDateAndRt(strDate.replaceAll("-",""),iRptType);
			
			HSSFCellStyle contentStyle = workbook.createCellStyle();
			contentStyle.setAlignment(HSSFCellStyle.ALIGN_LEFT);
			contentStyle.setBorderBottom((short) 1);
			contentStyle.setBorderTop((short) 1);
			contentStyle.setBorderLeft((short) 1);
			contentStyle.setBorderRight((short) 1);
			
			for(int i=0;list!=null&&i<list.size();i++)
			{
				RptListModel model = (RptListModel)list.get(i);
				HSSFRow tmpRow = aSheet.createRow(i + 4);
				ExcelRow tmpexcelRow = new ExcelRow(tmpRow);
				tmpexcelRow.setCellStyle(contentStyle);
				tmpexcelRow.addCell(model.getOrg_name());
				tmpexcelRow.addCell(DBISOtoGB.Conver(model.getFl1()));
				tmpexcelRow.addCell(DBISOtoGB.Conver(model.getFl2()));
				tmpexcelRow.addCell(DBISOtoGB.Conver(model.getFl3()));
				tmpexcelRow.addCell(DBISOtoGB.Conver(model.getFl4()));
				tmpexcelRow.addCell(DBISOtoGB.Conver(model.getFl5()));
				tmpexcelRow.addCell(DBISOtoGB.Conver(model.getFl6()));
				tmpexcelRow.addCell(DBISOtoGB.Conver(model.getFl7()));
				tmpexcelRow.addCell(DBISOtoGB.Conver(model.getFl8()));
				tmpexcelRow.addCell(DBISOtoGB.Conver(model.getFl9()));
				tmpexcelRow.addCell(DBISOtoGB.Conver(model.getFl10()));
				tmpexcelRow.addCell(DBISOtoGB.Conver(model.getFl11()));
				tmpexcelRow.addCell(DBISOtoGB.Conver(model.getFl12()));
				if(iRptType==2){
					tmpexcelRow.addCell(DBISOtoGB.Conver2(model.getFl13()));
					tmpexcelRow.addCell(DBISOtoGB.Conver2(model.getFl14()));
					tmpexcelRow.addCell(DBISOtoGB.Conver2(model.getFl15()));
				}else{
					tmpexcelRow.addCell(DBISOtoGB.Conver(model.getFl13()));
					tmpexcelRow.addCell(DBISOtoGB.Conver(model.getFl14()));
					tmpexcelRow.addCell(DBISOtoGB.Conver(model.getFl15()));
				}
			}

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

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
