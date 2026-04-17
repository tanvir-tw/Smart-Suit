<%@page import="com.ConnectionClass"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*" import="java.util.*"
	import=" java.text.*" errorPage=""%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Inward Report</title>
</head>
<body>
	<%
	Connection conn=null;
	ConnectionClass connection = new ConnectionClass();
	
	conn = connection.getConnect("db_leaveapplication");
try
{
String serverid="",usernm="",passwd="";	
String fname=request.getParameter("filename");
String refno=request.getParameter("iwno");
String empname=request.getParameter("empName");

Statement st1=conn.createStatement();
Statement st2=conn.createStatement();

String sqlftp="select * from t_ftpconnection";
ResultSet rsftp=st2.executeQuery(sqlftp);
rsftp.next();
serverid=rsftp.getString("ServerID");
usernm=rsftp.getString("Username");
passwd=rsftp.getString("Password");

String sqlUpdt="update t_inwardfollowup set checkstatus='Yes' where iwrefno='"+refno+"' and docReceiver='"+session.getAttribute("empname")+"'";
st1.executeUpdate(sqlUpdt);
System.out.println("==================>>"+sqlUpdt);
conn.close();

response.sendRedirect("ftp://"+usernm+":"+passwd+"@"+serverid+"/test/"+fname+"");
}
catch(Exception e)
{
	out.println("Exceprtion========>>"+e);
}
%>
</body>
</html>