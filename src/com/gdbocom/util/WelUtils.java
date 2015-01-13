package com.gdbocom.util;

import java.util.Calendar;

/**
 *@author ken
 *@date 2015年1月9日 下午3:46:28
 */
public class WelUtils {
	
	/**判断当前系统时间是否能够购买双色球
	 * @return
	 */
	public static boolean canBuyDou(){
		boolean rs=true;
		
		Calendar now = Calendar.getInstance();
		int hous=now.get(Calendar.HOUR_OF_DAY);
		//如果当前时间大于19点，不能购买
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
