<%@ page language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" errorPage="" %>
<%
String host11 = System.getenv("DB_GLOBALERP_HOST");
String user11 = System.getenv("DB_GLOBALERP_USER");
String pass11 = System.getenv("DB_GLOBALERP_PASS");
Connection conn=null;
try
{
Class.forName("com.mysql.cj.jdbc.Driver");
conn=DriverManager.getConnection("jdbc:mysql://"+host11+"/db_leaveapplication",user11,pass11);
//conn=DriverManager.getConnection("jdbc:mysql://192.168.2.55/db_leaveapplication","erp","1@erp");
}
catch(Exception e)
{
	System.out.println("Exception=========>>"+e);
}
%>
