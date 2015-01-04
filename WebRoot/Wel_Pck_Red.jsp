<%@ page language="java" contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*" %>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.bocom.midserv.gz.*"%>
<%@include file="/includeFiles/common.jsp" %>
<%
	String action_next = "Wel_Fix_Buy.jsp";

	RequestDispatcher rd = request.getRequestDispatcher(action_next);
	rd.forward(request, response);
%>
