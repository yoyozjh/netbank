package com.gdbocom.util;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Pattern;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;

import com.gdbocom.Transactions.WelLot;
import com.gdbocom.action.wel.BetMoney;

/**
 *@author ken
 *@date 2014��12��12�� ����5:18:01
 */
public class HpTenBallCreater{
	/**
	 * Ͷע����У���������ʽ
	 */
	private static final Pattern BETMUL_PATTERN=Pattern.compile("[0-9]+");
	private static final DecimalFormat NUM_FORMAT=new DecimalFormat("00");
	private static final Map CONFIG_MAP=new HashMap();
	private HpTenParam param=null;//��ǰͶעģʽ�Ĳ���

	/**
	 * ���ɺ��뿪ʼ��
	 */
	private int startNum=1;
	/**
	 * ���ɺ��������
	 */
	private int endNum=20;
	
	public HpTenBallCreater(String buyMode) {
		if(CONFIG_MAP.isEmpty()){
			init();
		}
		//��ȡ���ò���
		param=getParam(buyMode);
		startNum=param.start;
		endNum=param.end;
	}
	
	/**
	 * ��ʼ�����ò���
	 */
	private void init(){
		HpTenParam p1=new HpTenParam(1, 18, 1,"ѡһ��Ͷ");
		CONFIG_MAP.put(String.valueOf(WelLot.HpTenBuy.ONE), p1);
		
		HpTenParam p2=new HpTenParam(19,20, 1,"ѡһ��Ͷ");
		CONFIG_MAP.put(String.valueOf(WelLot.HpTenBuy.ONE_RED), p2);
		
		HpTenParam p3=new HpTenParam(2,"��ѡ��");
		CONFIG_MAP.put(String.valueOf(WelLot.HpTenBuy.TWO), p3);
		
		HpTenParam p4=new HpTenParam(2,"ѡ����ֱ");
		CONFIG_MAP.put(String.valueOf(WelLot.HpTenBuy.TWO_LINE), p4);
		
		HpTenParam p5=new HpTenParam(2,"ѡ������");
		CONFIG_MAP.put(String.valueOf(WelLot.HpTenBuy.TWO_GROUP), p5);
		
		HpTenParam p6=new HpTenParam(3,"��ѡ��");
		CONFIG_MAP.put(String.valueOf(WelLot.HpTenBuy.THREE), p6);
		
		HpTenParam p7=new HpTenParam(3,"ѡ��ǰֱ");
		CONFIG_MAP.put(String.valueOf(WelLot.HpTenBuy.THREE_LINE), p7);
		
		HpTenParam p8=new HpTenParam(3,"ѡ��ǰ��");
		CONFIG_MAP.put(String.valueOf(WelLot.HpTenBuy.THREE_GROUP), p8);
		
		HpTenParam p9=new HpTenParam(4,"��ѡ��");
		CONFIG_MAP.put(String.valueOf(WelLot.HpTenBuy.FOUR), p9);
		
		HpTenParam p10=new HpTenParam(5,"��ѡ��");
		CONFIG_MAP.put(String.valueOf(WelLot.HpTenBuy.FIVE), p10);
	}
	
	/**����Ͷע��ʽ�����ȡ�����
	 * @param mCode
	 * @return
	 */
	public HpTenParam getParam(String buyMode){
		return (HpTenParam)CONFIG_MAP.get(buyMode);
	}
	
	/**��ȡ���õĺ���
	 * @return
	 */
	public List getSelNumList(){
		List rs=new ArrayList();
		for(int i=startNum;i<=endNum;i++){
			rs.add(StringUtils.trimToEmpty(NUM_FORMAT.format(i)));
		}
		return rs;
	}
	
	public HpTenParam getParam() {
		return param;
	}
	
	/**����ѡ���������,�������У��ʧ�ܣ�������false
	 * @param request
	 * @return
	 */
	private static boolean processSelNum(HttpServletRequest request,HpTenParam param,int playId){
		StringBuffer sbShow=new StringBuffer();
		StringBuffer sbData=new StringBuffer();
		
		//��ȡ��ʾ��������
		String groupStr=ReqParamUtil.getParamAttr(request,"group");
		int group=Integer.parseInt(groupStr);
		//��ȡѡ��ĺ���
		Set nSet=new HashSet();//��ű�ѡ�����
		Set gSet=new HashSet();//��ű�ѡ�����������
		List selNums=new ArrayList();//��ű�ѡ��ĺ���
		String name="selNum";
		//������ѡ�������������ر���ѯ��ȡ����
		for(int g=1;g<=group;g++){
			String pKey=String.valueOf(g)+name;
			for(int i=0;i<21;i++){
				String v=ReqParamUtil.getParamAttr(request,pKey+String.valueOf(i));
				if(StringUtils.isNotEmpty(v)){
					selNums.add(v);
					nSet.add(v);
					gSet.add(String.valueOf(g));
				}
			}
		}
		
		String errorCode="";
		String errorStr="";
		//��֤�Ƿ񰴹���ѡ����룬���ѡ���������������ѡ�������С�����ã����ǷǷ�
		if(gSet.size()<group||selNums.size()<param.selNum){
			errorCode="vg001";
			errorStr="�밴����ѡ�����";
			request.setAttribute("errorCode",errorCode);
			request.setAttribute("errorStr",errorStr);
			return false;
		}
		
		//�����ѡ������Set���ϵĸ�����һ����˵�������ظ�����
		if(selNums.size()!=nSet.size()){
			errorCode="vg001";
			errorStr="��ѡ���벻���ظ�";
			request.setAttribute("errorCode",errorCode);
			request.setAttribute("errorStr",errorStr);
			return false;
		}
		
		//�����ѡһ��Ͷ��ֻ����1920
		if(playId==WelLot.HpTenBuy.ONE_RED){
			selNums=new ArrayList();
			selNums.add("19");
			selNums.add("20");
		}
		
		String sizeStr=NUM_FORMAT.format(selNums.size());
		sbData.append(sizeStr);
		Iterator iter=selNums.iterator();
		while(iter.hasNext()){
			String obj=(String) iter.next();
			sbData.append(obj);
			sbShow.append(","+obj);
		}
		String showRS=sbShow.toString().replaceFirst(",","");
		
		request.setAttribute("BetNum",sizeStr);//�ܺ������
		request.setAttribute("BetLin", sbData.toString());//Ͷע����
		request.setAttribute("showNum",showRS);
		
		return true;
	}
	
	/**��ҵ�����ݽ��д���
	 * @param request
	 * @return
	 */
	public static void processData(HttpServletRequest request,HttpServletResponse response){
		String errorCode="";
		String errorStr="";
		//��ȡ�淨ID
		String playIdStr=ReqParamUtil.getParamAttr(request,"buyMode");
		int palyId=Integer.parseInt(playIdStr);
		
		//��ȡ��ǰ�淨�����ò���
		HpTenParam param=(HpTenParam) CONFIG_MAP.get(playIdStr);
		
		//��ʾ�Ƿ�ͨ��У��
		boolean isOk=true;
		//����ѡ�������ҵ����
		isOk=processSelNum(request,param,palyId);
		if(!isOk){
			//У�鲻ͨ��
			toErrorPage(request, response);
			return;
		}
		
		//Ͷע����
		String betMulStr=ReqParamUtil.getParamAttr(request,"BetMul");
		//���Ϊ�ջ��߲���������
		if (StringUtils.isEmpty(betMulStr)
				|| !(BETMUL_PATTERN.matcher(betMulStr).matches())) {
			errorCode="v0002";
			errorStr="Ͷע��������Ϊ������";
			request.setAttribute("errorCode",errorCode);
			request.setAttribute("errorStr",errorStr);
			//У�鲻ͨ��
			toErrorPage(request, response);
			return;
		}
		int betMul=Integer.parseInt(betMulStr);
		
		//��ȡ�������
		String betNumStr=ReqParamUtil.getParamAttr(request,"BetNum");
		int betNum=Integer.parseInt(betNumStr);
		
		//���㵥��ʽ
		int betMod=getBetMod(betNum, playIdStr,param);
		request.setAttribute("BetMod",String.valueOf(betMod));
		
		//����Ĭ�ϵ��ò���
		setDefuCallParam(request);
		
		//������
		double betAmt=calAmount(betMod, betNum, palyId, betMul, param);
		request.setAttribute("BetAmt",String.valueOf((int)betAmt*100));
		request.setAttribute("BetAmtShow",String.valueOf(betAmt));
	}

	/**
	 * ����Ͷע���
	 */
	private static double calAmount(int betMod, int num, int playId,
			int betMul,HpTenParam param) {
		int betNum=param.selNum;//ӦͶע�������
		int baseNum=0;//ʵ��Ͷע���������
		
		return new BetMoney().CalculateNMoney(playId, betMod, betMul,2,
				1, betNum, baseNum, num);
	}

	/**����Ͷ�ʷ�ʽ(����ʽ)
	 * @param numSize �������
	 * @param playId �淨���
	 */
	private static int getBetMod(int numSize,String playId,HpTenParam param){
		int playIdInt=Integer.parseInt(playId);
		//Ĭ�ϵ�ʽ
		int betMod=BetMoney.betMode_Single;
		//����û�ѡ��ĸ�������Ӧѡ��������Ϊ��ʽ �޳� ѡһ��Ͷ
		if(WelLot.HpTenBuy.ONE_RED!=playIdInt&&numSize>param.selNum){
			betMod=BetMoney.betMode_Multiple;
		}
		
		return betMod;
	}
	
	public static void setDefuCallParam(HttpServletRequest request){
		String crdNo=ReqParamUtil.getParamAttr(request,"cardNo");
		String buyMode = ReqParamUtil.reqParamTirm(request,"buyMode");
		request.setAttribute("BetTyp","0");//0:ʵʱͶע
		request.setAttribute("SchTyp","1");//�������ͣ�1��ֱ��Ͷע��
		request.setAttribute("SecLev","1");//�����ȼ���1������Ͷע��
		request.setAttribute("CrdNo",crdNo);//�ͻ����п���
		request.setAttribute("GameId","7");//��Ϸ���
		request.setAttribute("PlayId",buyMode);//�淨���
		request.setAttribute("DrawId","");//��ǰ����
		request.setAttribute("KenoId","");//��ǰС��
		request.setAttribute("BetMet","1");//Ͷע�������̶���д1��
		request.setAttribute("GrpNum","1");//���������
	}
	
	public static void toErrorPage(HttpServletRequest request,
			HttpServletResponse response) {
		RequestDispatcher rd = request
				.getRequestDispatcher("/errPage.jsp");
		try {
			rd.forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException();
		}
	}
	
	/**
	 * ����ʮ�ָ�Ͷע��ʽ����
	 */
	public class HpTenParam{
		public int start=1;//��ʼ����
		public int end=20;//��������
		public int selNum=1;//ѡ�������
		public String name="";//Ͷע��ʽ����
		
		public HpTenParam(int selNum,String name){
			this.selNum=selNum;
			this.name=name;
		}
		
		public HpTenParam(int start,int end,int selNum,String name){
			this.start=start;
			this.end=end;
			this.selNum=selNum;
			this.name=name;
		}
	}
}