<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page language="java" contentType="text/html;charset=GBK"%>
<%@ page import="java.net.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.bocom.midserv.gz.*"%>
<%@ page import="com.gdbocom.util.communication.*" %>
<%@ page import="com.gdbocom.Transactions.WelLot" %>
<%@include file="/includeFiles/common.jsp" %>
<%
//保存交易密码值
	String password =ReqParamUtil.reqParamTirm(request,"password");
	String CrdNo = ReqParamUtil.reqParamTirm(request,"CrdNo");
	if(StringUtils.isEmpty(CrdNo)){
		CrdNo=ReqParamUtil.reqParamTirm(request,"cardNo");
	}
	request.setAttribute("CrdNo", CrdNo);
	
	String custName =ReqParamUtil.reqParamTirm(request,"custName");
	request.setAttribute("CusNam",custName);

	//获取bus字段,判断交易类型
	String busStr=ReqParamUtil.reqParamTirm(request,"Bus");
	//String busStr = (String)pageContext.getAttribute("Bus", PageContext.SESSION_SCOPE);
	int bus =Integer.parseInt(busStr);

	//设置正常情况需要跳转的页面
	String forwardPage = null;
	//设置出错情况需要跳转的页面
	String errPage = "errPage.jsp";
	//设置需要从网关正常返回中获取下来的值的名称,
	String saveKey = null;
	//保存上一页面的值
	
	request.setAttribute("password",password);
	//是否需要验证短信密码
	int isCheckMessagePw = 0;//0:不检验，非0检验


	//根据业务标志来进行通讯
	int txnCod;
	String txnName = null;
	String serverName = "";
	//报文字段存放容器
	Map callMap=new HashMap();
	callMap.put("GameId",WelLot.GameId.DOUBLE_BALL);//标识只查询双色球记录
	
	if(bus==WelLot.ADDREG){//用户注册
		txnCod=TransationFactory.WEL485404;
		serverName = "@WEL_A";
		isCheckMessagePw = 1;
		forwardPage = "Wel_Result.jsp";
	}else if(bus==WelLot.UPDREG){//注册变更
		txnCod=TransationFactory.WEL485405;
		serverName = "@WEL_A";
		isCheckMessagePw = 1;
		forwardPage = "Wel_Result.jsp";
	}else if(bus==WelLot.DOUBLE_SEL){//双色球自选
		txnCod=TransationFactory.WEL485412;
		serverName = "@WEL_B";
		isCheckMessagePw = 1;
		forwardPage = "Wel_Result.jsp";
	}else if(bus==WelLot.DOUBLE_BETSQRY){//双色球投注查询
		txnCod=TransationFactory.WEL485413;
		serverName = "@WEL_B";
		isCheckMessagePw = 0;
		forwardPage = "Wel_More_Result.jsp";
	}else if(bus==WelLot.DOUBLE_WINQRY||bus==WelLot.DOUBLE_FIX_WINQRY){//双色球中奖查询(定投/实时)
		txnCod=TransationFactory.WEL485414;
		serverName = "@WEL_B";
		isCheckMessagePw = 0;
		forwardPage = "Wel_More_Result.jsp";
	}else if(bus==WelLot.DOUBLE_FIX_BUY){//双色球定投录入
		txnCod=TransationFactory.WEL485407;
		serverName = "@WEL_A";
		isCheckMessagePw = 1;
		forwardPage = "Wel_Result.jsp";
	}else if(bus==WelLot.DOUBLE_FIX_QRY){//双色球定投查询、撤销
		txnCod=TransationFactory.WEL485409;
		serverName = "@WEL_A";
		isCheckMessagePw = 0;
		forwardPage = "Wel_Fix_QryD.jsp";
	}else if(bus==WelLot.DOUBLE_FIX_CANCEL){//双色球定投查询、撤销
		txnCod=TransationFactory.WEL485410;
		serverName = "@WEL_A";
		isCheckMessagePw = 1;
		forwardPage = "Wel_Result.jsp";
	}else{
		throw new IllegalArgumentException("没有定义的BUS代码");
	}
	
	txnName = WelLot.getTxnCod(bus);
	
	//获取调用字段
	callMap.put("TTxnCd", txnName);
	callMap.put("FeCod", txnName );
    //获取attribute和parameter的全部参数
    Map paMap=ReqParamUtil.getParamAttr(request);
    callMap.putAll(paMap);
    
    DebugUtils.printMap(request, callMap);
	
	if(0!=isCheckMessagePw){
		//BEGIN 身份认证
		//
		/*String verify = request.getHeader("MBK_VERIFY_RESULT");
		if(verify!=null&&!verify.equals("P")){
			String RspCod = "MID999";
			String RspMsg = "手机短信密码验证不通过"; 
			gzLog.Write("["+uri+"]MGID不正确");

			StringBuffer forwardString = new StringBuffer();
			forwardString.append(errPage).append("?");
			forwardString.append("RspCod").append("=").append(RspCod);
			forwardString.append("&");
			forwardString.append("RspMsg").append("=").append(RspMsg);
	        pageContext.forward(forwardString.toString());
		}*/
	    //END 身份认证
	}

	txnName = WelLot.getTxnCod(bus);
	Map responseValues = new HashMap();
	try{
		responseValues.putAll(
				Transation.exchangeData(IcsServer.getServer(serverName),
                callMap,
                txnCod)
				);

	}catch(Exception e){
		String RspCod = "LOT999";
		String RspMsg = "通讯故障"; 
		DebugUtils.log(request,"MGID不正确");
		
		StringBuffer forwardString = new StringBuffer();
		forwardString.append(errPage).append("?");
		forwardString.append("RspCod").append("=").append(RspCod);
		forwardString.append("&");
		forwardString.append("RspMsg").append("=").append(RspMsg);
        pageContext.forward(forwardString.toString());
	}

	request.setAttribute("responseVal", responseValues);
	if ("N".equals(responseValues.get("MsgTyp"))) {// ICS返回Normal
		DebugUtils.log(request,"forward到"+forwardPage);
	    pageContext.forward(forwardPage);

    } else if ("E".equals(responseValues.get("MsgTyp"))) {// ICS返回Error
		String RspMsg =responseValues.get("RspMsg").toString(); 
		DebugUtils.log(request,"MGID不正确  RspMsg:"+RspMsg);
        pageContext.forward(errPage);
    }
%>