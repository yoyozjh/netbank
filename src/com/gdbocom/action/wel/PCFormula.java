/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.gdbocom.action.wel;

import java.math.BigInteger;

/**
 * ��n����ͬԪ���У���ȡm(m��n)��Ԫ�ز���һ�飬������n����ͬԪ����ȡ��m��Ԫ�ص�һ����ϣ�
 * ��n����ͬԪ����ȡ��m(m��n)��Ԫ�ص�������ϵĸ�����������n����ͬԪ����ȡ��m��Ԫ�ص������.�÷���c(n,m) ��ʾ. c(n,m)=p(n,m)/m!=n!/((n-m)!*m!)
 * ��n����ͬԪ���У���ȡm(m��n)��Ԫ�ذ���һ����˳���ų�һ�У�������n����ͬԪ����ȡ��m��Ԫ�ص�һ�����У�
 * ��n����ͬԪ����ȡ��m(m��n)��Ԫ�ص��������еĸ�����������n����ͬԪ����ȡ��m��Ԫ�ص����������÷��� p(n,m)��ʾ. p(n,m)=n(n-1)(n-2)����(n-m+1)= n!/(n-m)!(�涨0!=1). 
 * 
 * @author cry
 */
public class PCFormula {

	/** �������ʶ */
    public static final int COMBINATE_FLAG = 1;
	/** ��������ʶ */
    public static final int PERMUT_FLAG = 2;

    /**
     * ����׳�
     * @param num
     * @return
     */
    public static BigInteger Factorial(int num) {
        if (num == 0) {
            return BigInteger.valueOf(1);
        } else {
        	BigInteger result = BigInteger.valueOf(1);
        	for(int ele=num;ele>1;ele--){
        		result = BigInteger.valueOf(ele).multiply(result);
        	}
            return result;
        }
    }

    /**
     * �����n��ȡm��������ϵ�����ֵ
     * combin(n,m)=n(n-1)��(n-m+1)/1*2��m=n!/m!(n-m)!
     * 
     * @param n ����������ܳ���
     * @param m ��ѡ�ĸ���
     * @return 
     */
    private static BigInteger Combination_num(int n, int m) {
        return Factorial(n).divide(Factorial(m).multiply(Factorial(n - m)));
    }

    /**
     * �����n��ȡm���������е�����ֵ
     * p(n,m)=n(n-1)(n-2)����(n-m+1)= n!/(n-m)!(�涨0!=1)
     * 
     * @param n ����������ܳ���
     * @param m ��ѡ�ĸ���
     * @return 
     */
    private static BigInteger permutation_num(int n, int m) {
        return Factorial(n).divide(Factorial(n - m));
    }

    /**
     * ����Ͷע��ע��
     *
     * @param number �ܺ������
     * @param betnonum ѡ��Ͷע�������
     * @param flag ����ϻ�������
     *  PCFormula.COMBINATE_FLAG���
     *  PCFormula.PERMUT_FLAG����
     * @return ������
     */
    public static int getStakesNum(int number, int betnonum, int flag) {
        BigInteger stake_num = new BigInteger("0");
        
        if (flag == COMBINATE_FLAG) {
            stake_num = Combination_num(number, betnonum);
        } else if (flag == PERMUT_FLAG) {
            stake_num = permutation_num(number, betnonum);
        }        
        return stake_num.intValue();
    }

}