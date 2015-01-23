package com.gdbocom.Transactions;

public class WelLot {

	/**
	 * ��ҳ�˵�
	 */
	public static final int ADDREG = 1;
	public static final int UPDREG = 2;
	public static final int DOUBLEBUY = 3;
	public static final int DOUBLEFIXBUY = 4;
	public static final int TENBUY = 5;

	/**
	 * ˫ɫ��Ͷע�Ӳ˵�
	 */
	public static final int DOUBLE_SEL = 31;
	public static final int DOUBLE_BETSQRY = 32;
	public static final int DOUBLE_WINQRY = 33;

	/**
	 * ˫ɫ��Ͷ�Ӳ˵�
	 */
	public static final int DOUBLE_FIX_SUMMARY = 41;
	public static final int DOUBLE_FIX_BUY = 42;
	public static final int DOUBLE_FIX_QRY = 43;
	public static final int DOUBLE_FIX_CANCEL = 44;
	public static final int DOUBLE_FIX_WINQRY = 45;

	/**
	 * ˫ɫ��Ͷ�ײ��Ӳ˵�
	 */
	public static final int DOUBLE_FIX_PACKAGE_153 = 153;
	public static final int DOUBLE_FIX_PACKAGE_76 = 76;
	
	/**
	 * ����ʮ�ֲ˵�
	 */
	public static final int HP_TEN_SUMMARY = 51;
	public static final int HP_TEN_BUY = 52;
	public static final int HP_TEN_QRY = 53;
	public static final int HP_TEN_WINQRY = 54;
	
	/**
	 * ��Ϸ����
	 */
	public class GameId{
		/**
		 * ˫ɫ��
		 */
		public static final String DOUBLE_BALL="5";
		/**
		 * ����ʮ��
		 */
		public static final String HPAAY_TEN="7";
	}
	
	/**
	 * ����ʮ��Ͷע��ʽ
	 */
	public class HpTenBuy{
		/**
		 * ѡһ��Ͷ
		 */
		public static final int ONE = 1;
		/**
		 * ѡһ��Ͷ
		 */
		public static final int ONE_RED = 2;
		/**
		 * ��ѡ��
		 */
		public static final int TWO = 3;
		/**
		 * ѡ����ֱ
		 */
		public static final int TWO_LINE= 4;
		/**
		 * ѡһ����
		 */
		public static final int TWO_GROUP= 5;
		/**
		 * ��ѡ��
		 */
		public static final int THREE = 6;
		/**
		 * ѡ��ǰֱ
		 */
		public static final int THREE_LINE= 7;
		/**
		 * ѡ��ǰ��
		 */
		public static final int THREE_GROUP=8;
		/**
		 * ��ѡ��
		 */
		public static final int FOUR = 9;
		/**
		 * ��ѡ��
		 */
		public static final int FIVE = 10;
	}
	
	/**
	 * ת���˵�ֵΪͨѶ��
	 * @param busType
	 * @return
	 */
	public static String getTxnCod(int busType){
		switch(busType){
		case ADDREG:
			return "485404";
		case UPDREG:
			return "485405";
		case DOUBLE_SEL:
			return "485412";
		case DOUBLE_BETSQRY:
			return "485413";
		case DOUBLE_WINQRY:
		case DOUBLE_FIX_WINQRY:
			return "485414";
		case DOUBLE_FIX_BUY:
			return "485407";
		case DOUBLE_FIX_QRY:
			return "485409";
		case DOUBLE_FIX_CANCEL:
			return "485410";
		case HP_TEN_BUY:
			return "485412";
		case HP_TEN_QRY:
			return "485413";
		case HP_TEN_WINQRY:
			return "485414";
		default:
			throw new IllegalArgumentException("û�ж��彻����");
		}
	}
}