<%@page import="com.gdbocom.util.ReqParamUtil"%>
<%@page import="com.gdbocom.util.DebugUtils"%>
<%@ page language="java" contentType="text/html;charset=GBK"%>
<%@ page import="com.bocom.midserv.gz.*"%>
<%@ page import="java.util.*" %>
<%@ page import="com.gdbocom.Transactions.WelLot" %>
<%@include file="/includeFiles/common.jsp" %>
<%
	String busVal=ReqParamUtil.reqParamTirm(request,"Bus");
	
	int bus = Integer.parseInt(busVal);
	String action_next;
	if(bus==WelLot.ADDREG){
		action_next="Wel_Reg_Add.jsp";
		//action_next="test.jsp";
	}else if(bus==WelLot.UPDREG){
		action_next="Wel_Reg_Add.jsp";

	}else if(bus==WelLot.DOUBLEBUY){
		action_next="Wel_Dou_Sel.jsp";

	}else if(bus==WelLot.DOUBLEFIXBUY){
		action_next="Wel_Fix_Sel.jsp";

	}else if(bus==WelLot.TENBUY){
		action_next="Wel_hTen_Sel.jsp";

	}else{
		action_next="Wel_Bus_Sel.jsp";
	}
	
	RequestDispatcher rd = request.getRequestDispatcher(action_next);
	rd.forward(request, response);
%>