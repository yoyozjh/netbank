<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@ page import="com.bocom.midserv.gz.*"%>
<%@ page import="com.viatt.bean.*"%>
<%@ page import="com.viatt.util.*"%>
<%
	// example:
	// <a href="download.jsp?path=img/&name=test.gif">download image</a>
   
   String root = getServletContext().getRealPath("/");
   String path = request.getParameter("path");
   String name = request.getParameter("name");
   
   response.setContentType("unknown");
   response.addHeader("Content-Disposition", "filename=\"" + name + "\"");
   
   try
   {
   java.io.OutputStream os = response.getOutputStream();
   java.io.FileInputStream fis = new java.io.FileInputStream(root + path + name);
   
   byte[] b = new byte[1024];
   int i = 0;
   
   while ( (i = fis.read(b)) > 0 ) 
   {
   os.write(b, 0, i);
   }
   
   fis.close();
   os.flush();
   os.close();
   }
   catch ( Exception e )
   {
   }
  %>