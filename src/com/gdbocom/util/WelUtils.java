package com.gdbocom.util;

import java.util.Calendar;

/**
 *@author ken
 *@date 2015��1��9�� ����3:46:28
 */
public class WelUtils {
	
	/**�жϵ�ǰϵͳʱ���Ƿ��ܹ�����˫ɫ��
	 * @return
	 */
	public static boolean canBuyDou(){
		boolean rs=true;
		
		Calendar now = Calendar.getInstance();
		int hous=now.get(Calendar.HOUR_OF_DAY);
		//�����ǰʱ�����19�㣬���ܹ���
		if(hous>19){
			rs=false;
		}
		
		return rs;
	}
	
	public static void main(String[] args) {
		WelUtils s=new WelUtils();
		s.canBuyDou();
	}
}