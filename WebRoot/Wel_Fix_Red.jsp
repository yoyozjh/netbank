<%@ page language="java" contentType="text/html;charset=GBK"%>
<%@ page import="com.bocom.midserv.gz.*"%>
<%@ page import="com.gdbocom.util.PreAction" %>
<%@ page import="com.gdbocom.Transactions.WelLot" %>
<%@include file="/includeFiles/common.jsp" %>
<%
	String cdno = ReqParamUtil.reqParamTirm(request,"cardNo");
	int bus = Integer.parseInt(ReqParamUtil.reqParamTirm(request,"Bus"));

	String action_next;

	request.setAttribute("CrdNo", cdno);
	if(bus==WelLot.DOUBLE_FIX_SUMMARY){
		action_next="Wel_Fix_Sum.jsp";

	}else if(bus==WelLot.DOUBLE_FIX_BUY){
		//保存通讯字段
		/*pageContext.setAttribute("BetTyp", "", PageContext.SESSION_SCOPE);
		pageContext.setAttribute("BegDat", "19990101", PageContext.SESSION_SCOPE);
		pageContext.setAttribute("EndDat", "29991231", PageContext.SESSION_SCOPE);*/

		action_next="Wel_Pck_Sel.jsp";

	}else if(bus==WelLot.DOUBLE_FIX_QRY){
		//保存通讯字段
		/*pageContext.setAttribute("BetTyp", "1", PageContext.SESSION_SCOPE);
		pageContext.setAttribute("BegDat", "19990101", PageContext.SESSION_SCOPE);
		pageContext.setAttribute("EndDat", "29991231", PageContext.SESSION_SCOPE);*/
		
		request.setAttribute("BetTyp", "1");
		request.setAttribute("BegDat", "19990101");
		request.setAttribute("EndDat", "29991231");

		action_next="Wel_Pub_Comm.jsp";

	}else if(bus==WelLot.DOUBLE_FIX_WINQRY){
		//保存通讯字段
		request.setAttribute("BetTyp", "1");
		request.setAttribute("BegDat", "19990101");
		request.setAttribute("EndDat", "29991231");

		action_next="Wel_Pub_Comm.jsp";

	}else{
		action_next="Wel_Bus_Sel.jsp";
	}
	
	RequestDispatcher rd = request.getRequestDispatcher(action_next);
	rd.forward(request, response);
%>