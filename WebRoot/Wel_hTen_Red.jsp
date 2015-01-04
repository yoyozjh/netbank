<%@ page language="java" contentType="text/html;charset=GBK"%>
<%@ page import="com.bocom.midserv.gz.*"%>
<%@ page import="com.gdbocom.util.PreAction" %>
<%@ page import="com.gdbocom.Transactions.WelLot" %>
<%@include file="/includeFiles/common.jsp" %>
<%
	int bus = Integer.parseInt(ReqParamUtil.reqParamTirm(request,"Bus"));
	request.setAttribute("Bus",ReqParamUtil.getParamAttr(request,"Bus"));	
	String action_next;
	if(bus==WelLot.HP_TEN_SUMMARY){
		action_next="Wel_hTen_Sum.jsp";
	}else if(bus==WelLot.HP_TEN_BUY){
		action_next="Wel_hTen_buySel.jsp";
		//action_next="/ToHtml?url=/WelLot/Wel_hTen_buySel.jsp";
	}else if(bus==WelLot.HP_TEN_QRY||bus==WelLot.HP_TEN_WINQRY){
		action_next="Wel_hTen_Comm.jsp";
		request.setAttribute("BetTyp","0");
		request.setAttribute("BegDat","19990101");
		request.setAttribute("EndDat","29991231");
		//准备调用参数
		HpTenBallCreater.setDefuCallParam(request);
	}else{
		action_next="Wel_Bus_Sel.jsp";
	}
	
	RequestDispatcher rd = request.getRequestDispatcher(action_next);
	rd.forward(request, response);
%>
