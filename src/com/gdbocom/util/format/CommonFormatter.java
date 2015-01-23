package com.gdbocom.util.format;

import java.text.*;

public class CommonFormatter implements FormatterInterface{

	/** ��ʽ��������� */
	public static final int CURRENCY = 1;
	/** ��ʽ���� */
	private int FormatterType = 0;
	/** ���� */
	private static CommonFormatter currencyFormatter =
			new CommonFormatter(CommonFormatter.CURRENCY);

	/**
	 * ���ɶ�Ӧ�ĸ�ʽ��
	 * @param FormatterType
	 */
	private CommonFormatter(int formatterType){
		this.FormatterType = formatterType;
	}

	/**
	 * Ϊ��ֹ��ʽ��̫�࣬ʹ�õ���ģʽ
	 * @param formatterType
	 * @return
	 */
	public static CommonFormatter getSingleton(int formatterType){
		if(CURRENCY==formatterType){
			return currencyFormatter;

		}else{
			return null;
		}

	}

	/**
	 * �õ���Ӧ��ֵ
	 * @param value
	 * @return
	 */
	public String getFormattedValue(String value) {
		if(CURRENCY==this.FormatterType){
			return getCurrencyFormatter(value);

		}else{
			return value;
		}

	}

	/**
	 * ��ʽ��������ǧ�ֺź�С����,��Ϊ��λ
	 * @param value
	 * @return
	 */
	private static String getCurrencyFormatter(String value){
		return new DecimalFormat("#,###.00").format(Double.parseDouble(value)/100.0);
	};

	public static void main(String[] args) {
		System.out.println(CommonFormatter.getSingleton(CommonFormatter.CURRENCY)
				.getFormattedValue("1000"));
				
		System.out.println(CommonFormatter.getSingleton(0)
				.getFormattedValue("1000"));

	}

}