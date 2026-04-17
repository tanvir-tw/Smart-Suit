

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" import="java.text.*" import="java.util.Calendar"%>

	<% 
	
	String host2 = System.getenv("DB_GLOBALERP_HOST");
	String user2 = System.getenv("DB_GLOBALERP_USER");
	String pass2 = System.getenv("DB_GLOBALERP_PASS");
	
	String DB_Driver="com.mysql.cj.jdbc.Driver";
	//String DB_NAME="jdbc:mysql:// twdb.fleetview.in/db_GlobalERP";
	String DB_NAME="jdbc:mysql://"+host2+"/db_GlobalERP";
	String DB_USERNAME=user2;
	String DB_PASSWORD=pass2;
	
	
%>



