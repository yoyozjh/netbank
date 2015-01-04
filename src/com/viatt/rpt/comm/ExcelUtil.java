package com.viatt.rpt.comm;

import java.util.Properties;

import org.apache.poi.hssf.usermodel.HSSFSheet;

public class ExcelUtil {
	private int totalWidth = 38000;

	public int getTotalWidth() {
		return totalWidth;
	}

	public void setTotalWidth(int totalWidth) {
		this.totalWidth = totalWidth;
	}

	public int getColumnWidth(double width) {
		int result = (int) (totalWidth * (width / 100.0));
		return result;
	}

	public static void main(String args[]) {
		
	}
}
