<%@ page import="java.sql.*" import="java.text.*" import="java.util.Calendar"%>

	<% 
	
	String host = System.getenv("DB_GLOBALERP_HOST");
	String user = System.getenv("DB_GLOBALERP_USER");
	String pass = System.getenv("DB_GLOBALERP_PASS");
	
	String DB_Driver="com.mysql.cj.jdbc.Driver";
	//String DB_NAME="jdbc:mysql://twdb.fleetview.in/db_GlobalERP";
	String DB_NAME="jdbc:mysql://"+host+"/db_GlobalERP";
	String DB_USERNAME=user;
	String DB_PASSWORD=pass;
	
%>
