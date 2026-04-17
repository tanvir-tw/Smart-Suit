<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.ConnectionClass"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" errorPage="" %>
<html>
<head>
</head>
<body>
<%
Connection conn =null;
Statement st2=null;

ConnectionClass connection = new ConnectionClass();
try {
	conn = connection.getConnect("db_leaveapplication");    	
	st2=conn.createStatement();

	
	String s1=request.getParameter("ftpFile");
	System.out.println(s1);
	System.out.println(s1+"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"+s1.replace("%"," ")); 
	s1=s1.replace("%"," ");
	
	System.out.println(s1);
	
	String serverid="",usernm="",passwd="";
	String sqlftp="select * from t_ftpconnection";
	ResultSet rsftp=st2.executeQuery(sqlftp);
	rsftp.next();
	serverid=rsftp.getString("ServerID");
	usernm=rsftp.getString("Username");
	passwd=rsftp.getString("Password");

response.sendRedirect("ftp://"+usernm+":"+passwd+"@"+serverid+"/test/"+s1);
%>
</body>
<%
	}
catch(Exception e)
{e.printStackTrace();}

%>

</html>