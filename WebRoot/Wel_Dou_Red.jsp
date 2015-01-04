<%@ page language="java" contentType="text/html;charset=GBK"%>
<%@ page import="com.bocom.midserv.gz.*"%>
<%@ page import="com.gdbocom.util.PreAction" %>
<%@ page import="com.gdbocom.Transactions.WelLot" %>
<%@include file="/includeFiles/common.jsp" %>
<%
	String cdno = ReqParamUtil.reqParamTirm(request,"CrdNo");
	String busVal=ReqParamUtil.reqParamTirm(request,"Bus");
	int bus = Integer.parseInt(busVal);
	
	String action_next;
	if(bus==WelLot.DOUBLE_SEL){
		action_next="Wel_Dou_Buy.jsp";

	}else if(bus==WelLot.DOUBLE_BETSQRY){
		//保存通讯字段
		/*
		pageContext.setAttribute("CrdNo", cdno, PageContext.SESSION_SCOPE);
		pageContext.setAttribute("BetTyp", "", PageContext.SESSION_SCOPE);
		pageContext.setAttribute("BegDat", "19990101", PageContext.SESSION_SCOPE);
		pageContext.setAttribute("EndDat", "29991231", PageContext.SESSION_SCOPE);
		*/
		request.setAttribute("CrdNo", cdno);
		request.setAttribute("BetTyp","0");
		request.setAttribute("BegDat","19990101");
		request.setAttribute("EndDat","29991231");
		
		action_next="Wel_Pub_Comm.jsp";

	}else if(bus==WelLot.DOUBLE_WINQRY){
		//保存通讯字段
		/*
		pageContext.setAttribute("CrdNo", cdno, PageContext.SESSION_SCOPE);
		pageContext.setAttribute("BetTyp", "", PageContext.SESSION_SCOPE);
		pageContext.setAttribute("BegDat", "19990101", PageContext.SESSION_SCOPE);
		pageContext.setAttribute("EndDat", "29991231", PageContext.SESSION_SCOPE);
		*/
		
		request.setAttribute("CrdNo", cdno);
		request.setAttribute("BetTyp","0");
		request.setAttribute("BegDat","19990101");
		request.setAttribute("EndDat","29991231");

		action_next="Wel_Pub_Comm.jsp";

	}else{
		action_next="Wel_Bus_Sel.jsp";
	}
	
	
	RequestDispatcher rd = request.getRequestDispatcher(action_next);
	rd.forward(request, response);
%>