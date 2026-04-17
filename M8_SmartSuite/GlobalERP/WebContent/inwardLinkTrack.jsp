<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*" import="java.util.*"
	import=" java.text.*" errorPage=""%>
<%@ include file="headConn.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Inward Report</title>
</head>
<body>
	<%
try
{

String serverid="",usernm="",passwd="";
	
String fname=request.getParameter("filename");
String refno=request.getParameter("iwno");
String empname=request.getParameter("empName");

Statement st2=conn.createStatement();


String sqlftp="select * from t_ftpconnection";
ResultSet rsftp=st2.executeQuery(sqlftp);
rsftp.next();
serverid=rsftp.getString("ServerID");
usernm=rsftp.getString("Username");
passwd=rsftp.getString("Password");


response.sendRedirect("ftp://"+usernm+":"+passwd+"@"+serverid+"/test/"+fname+"");
}
catch(Exception e)
{
	out.println("Exceprtion========>>"+e);
}

%>
</body>
</html>