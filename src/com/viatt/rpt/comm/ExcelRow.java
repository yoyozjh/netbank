package com.viatt.rpt.comm;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.util.Region;

public class ExcelRow {
	private int column = 0;

	private HSSFRow row = null;

	private HSSFCellStyle cellStyle = null;

	private HSSFSheet sheet = null;

	public HSSFCellStyle getCellStyle() {
		return cellStyle;
	}

	public void setCellStyle(HSSFCellStyle cellStyle) {
		this.cellStyle = cellStyle;
	}

	public HSSFRow getRow() {
		return row;
	}

	public void setRow(HSSFRow row) {
		this.row = row;
	}

	public ExcelRow(HSSFRow row) {
		this.row = row;
	}

	public void addCell(String content) {
		if (row != null) {
			HSSFCell cell = row.createCell(column);
			cell.setCellStyle(cellStyle);
			cell.setCellValue(content);
			column++;
		}
	}

	public void addCell(String content, int n) {
		int tmp=column;
		if (row != null) {
			for (int i = 0; i < n; i++) {
				if (i == 0) {
					HSSFCell cell = row.createCell(column);
					cell.setCellStyle(cellStyle);
					cell.setCellValue(content);
					column++;
				} else {
					HSSFCell cell = row.createCell(column);
					cell.setCellStyle(cellStyle);
					column++;
				}
			}
			if (sheet != null) {
				sheet.addMergedRegion(new Region(row.getRowNum(), (short) tmp,
						row.getRowNum(), (short) (tmp+n-1)));
			}
		}
	}

	public void addCell(String content, int n,int m) {
		int tmp=column;
		if (row != null) {
			for (int i = 0; i < n; i++) {
				if (i == 0) {
					HSSFCell cell = row.createCell(column);
					cell.setCellStyle(cellStyle);
					cell.setCellValue(content);
					column++;
				} else {
					HSSFCell cell = row.createCell(column);
					cell.setCellStyle(cellStyle);
					column++;
				}
			}
			if (sheet != null) {
				sheet.addMergedRegion(new Region(row.getRowNum(), (short) tmp,
						(row.getRowNum()+m-1), (short) (tmp+n-1)));
			}
		}
	}
	
	public int getColumn() {
		return column;
	}

	public void setColumn(int column) {
		this.column = column;
	}

	public HSSFSheet getSheet() {
		return sheet;
	}

	public void setSheet(HSSFSheet sheet) {
		this.sheet = sheet;
	}
}
