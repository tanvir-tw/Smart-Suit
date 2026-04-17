<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" import="java.text.*" import="java.util.Calendar" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Transworld</title>
</head>
<body>
<%
String host2 = System.getenv("DB_GLOBALERP_HOST");
String user2 = System.getenv("DB_GLOBALERP_USER");
String pass2 = System.getenv("DB_GLOBALERP_PASS");

Connection conn=null;
try
{
Class.forName("com.mysql.cj.jdbc.Driver");
//conn=DriverManager.getConnection("jdbc:mysql:// twdb.fleetview.in/db_leaveapplication","erp","1@erp");
conn=DriverManager.getConnection("jdbc:mysql://"+host2+"/db_leaveapplication",user2,pass2);
//conn=DriverManager.getConnection("jdbc:mysql:// twdb.fleetview.in/db_leaveapplication","erp","1@erp");
}
catch(Exception e)
{
	System.out.println("Exception=========>>"+e);
}
%>
</body>
</html>