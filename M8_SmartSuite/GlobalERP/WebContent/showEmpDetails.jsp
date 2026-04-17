<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@page import="java.sql.*"%>
<%@page import="com.ConnectionClass"%>
<%@ page language="java" import=" java.text.*" import=" java.util.*"
	errorPage=""%>
<html>
<body>
	<%
	Connection conn = null;
	Statement st1=null;
	ConnectionClass connection = new ConnectionClass();
	
	try{
	conn = connection.getConnect("db_leaveapplication");
	
	 st1=conn.createStatement();
	
	}catch(Exception e){
		e.printStackTrace();
	}
String empName="", cntct="", empMail="",deptName="";

empName=request.getParameter("empName");
String sqlDet="select * from db_leaveapplication.t_leaverequest where name='"+empName+"' limit 1";
ResultSet rsDet=st1.executeQuery(sqlDet);
if(rsDet.next())
{
	cntct=rsDet.getString("details");
	empMail=rsDet.getString("emailid");
	deptName=rsDet.getString("TypeValue");
}
%>
	<table bgcolor="#CFECEC" width="100%" border="0">
		<tr>
			<td></td>
		</tr>
		<tr bgcolor="#CFECEC">
			<td><font size="2">
				<b>Email :</b></font></td>
			<td><font size="2"><%=empMail %></font></td>
		</tr>
		<tr bgcolor="#CFECEC">
			<td><font size="2">
				<b>Contact :</b></font></td>
			<td><font size="2"><%=cntct %></font></td>
		</tr>
		<tr bgcolor="#CFECEC">
			<td><font size="2">
				<b>Dept :</b></font></td>
			<td><font size="2"><%=deptName %></font></td>
		</tr>
		<tr>
			<td></td>
		</tr>

	</table>
</body>
</html>
