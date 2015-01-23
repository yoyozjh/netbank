package com.gdbocom.util.format;

import com.gdbocom.Transactions.WelLot;

public class WelFormatter implements FormatterInterface{

	/** ������Ʊ����ĸ�ʽ������ */
	public static final int BETNUM = 2;
	/**
	 * ����ʮ�ָ�ʽ
	 */
	public static final int BETNUM_HPTEN = 7;
	/** ��ʽ��������� */
	public static final int CURRENCY = 3;
	/** ��ʽ���ײ����� */
	public static final int PACKAGE = 4;
	/** ��ʽ���� */
	private int formatterType = 0;
	/** ���� */
	private static WelFormatter betNumFormatter =
			new WelFormatter(WelFormatter.BETNUM);
	private static WelFormatter hpTenFormatter =
			new WelFormatter(WelFormatter.BETNUM_HPTEN);
	private static WelFormatter currencyFormatter =
			new WelFormatter(WelFormatter.CURRENCY);
	private static WelFormatter packageFormatter =
			new WelFormatter(WelFormatter.PACKAGE);


	/**
	 * ���ɶ�Ӧ�ĸ�ʽ��
	 * @param FormatterType
	 */
	private WelFormatter(int formatterType){
		this.formatterType = formatterType;
	}

	/**
	 * Ϊ��ֹ��ʽ��̫�࣬ʹ�õ���ģʽ��ȡ��ʽ������
	 * @param formatterType
	 * @return
	 */
	public static WelFormatter getSingleton(int formatterType){
		if(BETNUM==formatterType){
			return betNumFormatter;

		}else if(CURRENCY==formatterType){
			return currencyFormatter;

		}else if(PACKAGE==formatterType){
			return packageFormatter;
			
		}else if(BETNUM_HPTEN==formatterType){
			return hpTenFormatter;
			
		}else{
			return null;
		}

	}

	/**
	 * ���ݲ�ͬ��ʽ��������ʽ��ֵ
	 * @param value
	 * @param formatterType
	 * @return
	 */
	public String getFormattedValue(String value) {
		if(BETNUM==this.formatterType){
			return getBetNumFormatter(value);
		}else if(BETNUM_HPTEN==this.formatterType){
			return hpTenBetNumFormatter(value);
		}else if(CURRENCY==this.formatterType){
			return getCurrencyFormatter(value);

		}else if(PACKAGE==this.formatterType){
			return getPackageFormatter(Integer.valueOf(value).intValue());

		}else{
			return value;
		}
	}

	/**
	 * ���͹��������ֺ������ӡ�Ԫ������Ϊ��λ
	 * @param value
	 * @return
	 */
	private static String getCurrencyFormatter(String value){
		return CommonFormatter.getSingleton(CommonFormatter.CURRENCY)
				.getFormattedValue(value)
				+ " Ԫ";
	};

	/**
	 * �ײ����ƴ���ת��
	 * @param value
	 * @return
	 */
	private static String getPackageFormatter(int value){
		if(value==WelLot.DOUBLE_FIX_PACKAGE_153){
			return "˫ɫ��153���ײ�";
		}else if(value==WelLot.DOUBLE_FIX_PACKAGE_76){
			return "˫ɫ��76���ײ�";
		}else{
			return "�Ƿ��ײ�";
		}
	};

	/**
	 * ��ʽ��Ͷע���룬��
	 * 021112032223����ʽ����11��12#03��22��23
	 * @param value
	 * @return
	 */
	private static String getBetNumFormatter(String betNum){

		String formattedBetNum = betNum.trim();
		StringBuffer result = new StringBuffer();
		int offset = 0;

		//ǰ��
		int foreCnt = Integer.valueOf(formattedBetNum.substring(0, 2)).intValue();
		offset += 2;
		for(int i=0; i<foreCnt; i++, offset +=2){
			result.append(formattedBetNum.substring(i*2+2, i*2+4));

			//���һ�����벻��Ҫ����
			if(i<foreCnt-1){
				result.append(", ");
			}
			
		}
		result.append("#");

		//˫ɫ����û�к���
		if(offset<formattedBetNum.length()){
			//����
			int backCnt = Integer.valueOf(formattedBetNum.substring(offset, offset+2)).intValue();
			offset += 2;

			for(int i=0; i<backCnt; i++, offset +=2){
				//foreCnt*2+i*2+4�ļ��㷽���ǣ�ǰ������*ÿ����λ��+�����ڼ�����+����ǰ�����������ÿ���������2��
				String number = formattedBetNum.substring(foreCnt*2+i*2+4, foreCnt*2+i*2+6);
				result.append(number);
				//���һ�����벻��Ҫ����
				if(i<backCnt-1){
					result.append(", ");
				}
				
				
			}
		}
		return result.toString();

	}
	
	/**
	 * ����ʮ��Ͷע���뷴��ʽ������
	 * 020110����ʽ����1��10
	 * @return
	 */
	private static String hpTenBetNumFormatter(String betNum){
		String formattedBetNum = betNum.trim();
		StringBuffer result = new StringBuffer();
		int offset = 0;

		int count = Integer.valueOf(formattedBetNum.substring(0, 2)).intValue();
		offset += 2;
		for(int i=0; i<count; i++, offset +=2){
			result.append(formattedBetNum.substring(i*2+2, i*2+4));
			//���һ�����벻��Ҫ����
			if(i<count-1){
				result.append(", ");
			}
		}
		return result.toString();
	}

	public static void main(String[] args) {

		System.out.println(WelFormatter.getSingleton(WelFormatter.BETNUM)
				.getFormattedValue("0211120122"));

		System.out.println(WelFormatter.getSingleton(WelFormatter.BETNUM)
				.getFormattedValue("02111203222324"));
		
		System.out.println(WelFormatter.getSingleton(WelFormatter.CURRENCY)
				.getFormattedValue("1011"));

		System.out.println(WelFormatter.getSingleton(WelFormatter.PACKAGE)
				.getFormattedValue(String.valueOf(WelLot.DOUBLE_FIX_PACKAGE_76)));


	}

}