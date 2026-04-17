<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" import="java.text.*" import="java.util.Calendar"%>

	<% 
	
	String host = System.getenv("DB_GLOBALERP_HOST");
	String user = System.getenv("DB_GLOBALERP_USER");
	String pass = System.getenv("DB_GLOBALERP_PASS");
	
	String DB_Driver1="com.mysql.cj.jdbc.Driver";
	String DB_NAME12="jdbc:mysql://"+host+"/db_gps";
	String DB_USERNAME1=user;
	String DB_PASSWORD1=pass;
    	try {
		String abc = session.getAttribute("user").toString();

	} catch (Exception ee) {
		response.sendRedirect("index.jsp?err=err2");
		return;
	}
%>
