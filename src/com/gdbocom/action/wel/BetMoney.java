/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.gdbocom.action.wel;

import com.gdbocom.Transactions.WelLot;

/**
 * ����Ͷע���
 * 
 * @author cry
 */
public class BetMoney {

    public static final int betMode_Single = 1;  //��ʽ
    public static final int betMode_Multiple = 12; //��ʽ
    public static final int betMode_Bravery = 13; //����
    public static final int playID_N2_LinkLine = 4; //ѡ����ֱ
    public static final int playID_N3_BeforLine = 7; //ѡ��ǰֱ
    
    /**
     * ���㵥ʽ��� ������ؽ��ֵΪ0��ʾ�쳣
     *
     * @param betMode:Ͷע��ʽ
     * @param stakes:��ʽע��
     * @param multiple:Ͷע����
     * @param stakesPrice:��ע���
     * @return Ͷע���:double����ֵ
     */
    public double createSingleMoney(int betMode, int stakes, int multiple, double stakesPrice) {
        double money = 0;

        if (betMode != betMode_Single) {
            return money;
        }

        money = stakes * multiple * stakesPrice;
        return money;
    }

    /**
     * ����KENO����Ϸ�ĸ�ʽ�͵��Ͻ�� ������ؽ��ֵΪ0��ʾ�쳣
     *
     * @param playID:�淨���
     * @param betMode:Ͷעģʽ
     * @param baseNum:������
     * @param tailNum:�ϸ���(��ʽ����)
     * @param betNum:ӦͶע�������
     * @param multiple:Ͷע����
     * @param stakesPrice:��ע���
     * @return Ͷע���:double����ֵ
     *
     */
    public double createNDoubleMoney(int playID, int betMode, int baseNum, int tailNum, int betNum, int multiple, double stakesPrice) {
        int stakes = 0;
        
        if (betMode == betMode_Multiple) {
            if ((playID == playID_N2_LinkLine) || (playID == playID_N3_BeforLine)) {
                stakes = PCFormula.getStakesNum(tailNum, betNum, PCFormula.COMBINATE_FLAG) * PCFormula.getStakesNum(betNum, betNum, PCFormula.PERMUT_FLAG);
            } else {
                stakes = PCFormula.getStakesNum(tailNum, betNum, PCFormula.COMBINATE_FLAG);
            }
        } else if (betMode == betMode_Bravery) {
            if ((playID == playID_N2_LinkLine) || (playID == playID_N3_BeforLine)) {
                stakes = PCFormula.getStakesNum(tailNum, betNum - baseNum, PCFormula.COMBINATE_FLAG) * PCFormula.getStakesNum(betNum, betNum, PCFormula.PERMUT_FLAG);
            } else {
                stakes = PCFormula.getStakesNum(tailNum, betNum - baseNum, PCFormula.COMBINATE_FLAG);
            }
        }
        
        double money = stakes * multiple * stakesPrice;
        return money;
    }
    
    /**
     * ����˫ɫ���Ͷע��� ������ؽ��ֵΪ0��ʾ�쳣
     *
     * @param betMode Ͷעģʽ
     * @param multiple Ͷע����
     * @param price ��עͶע���
     * @param section ��ʽͶעע��
     * @param betRedNum ӦͶע����������
     * @param betBlueNum ӦͶע����������
     * @param redBaseNum ʵ��Ͷע���򵨺������
     * @param redTailNum ʵ��Ͷע�����к������(��ʽʵ��Ͷע�������)
     * @param blueNum ʵ��Ͷע����������
     * @return Ͷע���:double����ֵ
     */
    public double CalculateBMoney(int betMode, int multiple,
    		double price, int section, int betRedNum,
    		int betBlueNum, int redBaseNum, int redTailNum, int blueNum) {
        double money = 0;
        int stakes = 0;
        switch (betMode) {
            case betMode_Single:
                stakes = section;
                break;
            case betMode_Multiple:
                stakes = PCFormula.getStakesNum(redTailNum, betRedNum, PCFormula.COMBINATE_FLAG)
                	* PCFormula.getStakesNum(blueNum, betBlueNum, PCFormula.COMBINATE_FLAG);
                break;
            case betMode_Bravery:
                stakes = PCFormula.getStakesNum(redTailNum, betRedNum - redBaseNum, PCFormula.COMBINATE_FLAG) * PCFormula.getStakesNum(blueNum, betBlueNum, PCFormula.COMBINATE_FLAG);
                break;
            default:
        }
        
        money = stakes * multiple * price;
        return money;
    }

    /**
     * ����KENO��Ͷע��� ������ؽ��ֵΪ0��ʾ�쳣
     *
     * @param playID:�淨���
     * @param betMode:Ͷעģʽ
     * @param multiple:Ͷע����
     * @param price ��עͶע���
     * @param section ��ʽͶעע��
     * @param betNum ӦͶע�������
     * @param baseNum ʵ��Ͷע���������
     * @param tailNum ʵ��Ͷע�к������(��ʽʵ��Ͷע�������)
     * @return Ͷע���:double����ֵ
     */
    public double CalculateNMoney(int playID, int betMode, int multiple, double price, int section, int betNum, int baseNum, int tailNum) {
        double money = 0;

        switch (betMode) {
            case 1:
                money = createSingleMoney(betMode, section, multiple, price);
                break;
            case 12:
                money = createNDoubleMoney(playID, betMode, 0, tailNum, betNum, multiple, price);
                break;
            case 13:
                money = createNDoubleMoney(playID, betMode, baseNum, tailNum, betNum, multiple, price);
                break;
            default:

        }
        
        return money;
    }
    
    public static void main(String[] args){
//    	//��ʽ
//    	int betMode = BetMoney.betMode_Single;//����ʽ
//    	int multiple = 1;//Ͷע����
//    	double price = 2;//��עͶע���
//    	int section = 1;//��ʽͶעע��
//    	int betRedNum = 0;//ѡ�����������,��ʽ������
//		int redTailNum = 0;//Ͷע��������ܸ���,��ʽ������
//		int betBlueNum = 0;//ӦͶע����������,��ʽ������
//		int redBaseNum = 0;//ʵ��Ͷע���򵨺������,��ʽ������
//		int blueNum = 0;//ʵ��Ͷע����������,��ʽ������
//    	System.out.println(new BetMoney().CalculateBMoney(betMode, multiple,
//        		price, section, betRedNum,
//        		betBlueNum, redBaseNum, redTailNum, blueNum));
//    	
//    	//��ʽ
//    	betMode = BetMoney.betMode_Multiple;//����ʽ
//    	multiple = 1;//Ͷע����
//    	price = 2;//��עͶע���
//    	section = 0;//��ʽͶעע��,��ʽ������
//    	betRedNum = 6;//��ע����������
//		redTailNum = 7;//ѡ�����������
//		betBlueNum = 1;//��ע����������
//		blueNum = 1;//ѡ������������
//		redBaseNum = 0;//ʵ��Ͷע���򵨺����������ʽ������
//    	System.out.println(new BetMoney().CalculateBMoney(betMode, multiple,
//        		price, section, betRedNum,
//        		betBlueNum, redBaseNum, redTailNum, blueNum));
    	
    	
        int playID=WelLot.HpTenBuy.THREE_GROUP;//�淨���
        int betMode=BetMoney.betMode_Single;//Ͷעģʽ
        int multiple=1;//Ͷע����
        double price=2;//��עͶע���
        int section=1; //��ʽͶעע��
        int betNum=3; //ӦͶע�������
        int baseNum=0;//ʵ��Ͷע���������
        int tailNum=1;//ʵ��Ͷע�к������(��ʽʵ��Ͷע�������)
        double rs=new BetMoney().CalculateNMoney(playID, betMode, multiple, price, section, betNum, baseNum, tailNum);
        System.out.println(rs);
        
        playID=WelLot.HpTenBuy.THREE_GROUP;//�淨���
        betMode=BetMoney.betMode_Multiple;//Ͷעģʽ
        multiple=1;//Ͷע����
        price=2;//��עͶע���
        section=1; //��ʽͶעע��
        betNum=3; //ӦͶע�������
        baseNum=0;//ʵ��Ͷע���������
        tailNum=20;//ʵ��Ͷע�к������(��ʽʵ��Ͷע�������)
        rs=new BetMoney().CalculateNMoney(playID, betMode, multiple, price, section, betNum, baseNum, tailNum);
        System.out.println(rs);
    }
}