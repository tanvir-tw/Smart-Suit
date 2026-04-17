<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" import="java.text.*" import="java.util.Calendar"%>

	<% 
	
	String host1 = System.getenv("DB_GLOBALERP_HOST");
	String user1 = System.getenv("DB_GLOBALERP_USER");
	String pass1 = System.getenv("DB_GLOBALERP_PASS");
	
	String DB_Driver="com.mysql.cj.jdbc.Driver";
	//String DB_NAME="jdbc:mysql:// twdb.fleetview.in/db_GlobalERP";
	//String DB_NAME="jdbc:mysql://202.65.131.44:3306/db_GlobalERP";
	String DB_NAME="jdbc:mysql://"+host1+"/db_GlobalERP?autoReconnect=true&useSSL=false";
	String DB_NAME1="jdbc:mysql://"+host1+"/newblankerp?autoReconnect=true&useSSL=false";
	
	String DB_USERNAME=user1;
	String DB_PASSWORD=pass1;
    //String DB_USERNAME="java";
    //String DB_PASSWORD="transjava!1";
	/*String DB_NAMEPAY="jdbc:mysql:// twdb.fleetview.in/db_leaveapplication";*/
	 //String DB_NAMEPAY="jdbc:mysql://202.65.131.44:3306/db_leaveapplication";
	String DB_NAMEPAY="jdbc:mysql:// "+host1+"/db_leaveapplication?autoReconnect=true&useSSL=false";
		
	
	String DB_Driver_OI="com.mysql.cj.jdbc.Driver";
	String DB_NAME_OI="jdbc:mysql://"+host1+"/db_GlobalERP?autoReconnect=true&useSSL=false";
	
	String DB_USERNAME_OI=user1;
	String DB_PASSWORD_OI=pass1;
	
	try {
		String abc = session.getAttribute("user").toString();
	} catch (Exception ee) {
		response.sendRedirect("index.jsp?err=err2");
		return;
	}
%>