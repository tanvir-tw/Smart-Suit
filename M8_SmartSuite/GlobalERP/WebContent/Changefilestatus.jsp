<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="header.jsp"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<%@page import="java.util.Date"%>
	<script src="dropdown.js" type="text/javascript"></script>
		<script src="ledgerDetails.js" type="text/javascript"></script>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body >
<%
     erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
	 
	 Connection conn = null;
     Statement st = null,st1=null,st2=null;
%>

<%
try {
conn = erp.ReturnConnection();
st = conn.createStatement();
st1 = conn.createStatement();
st2 = conn.createStatement();

String filename=request.getParameter("filename");
System.out.println(" File name  :: "+filename);
String currentstatus=request.getParameter("status");
String crdate= request.getParameter("CreationDate");
String crtdate= request.getParameter("CreationDate");
String acty= request.getParameter("AccoutType");

System.out.println(" File name  :: "+currentstatus);
%>
	<div
		style="font-size: 1.6em; text-align: center; margin-top: 0.5em; margin-bottom: 0.5em;">
	<a>Change File Status</a>
	</div>
<form name="file" method="post" action="updatestatus.jsp">

<input type="hidden" name="filename1" id="filename1" value="<%=filename %>">
<table   class='sortable' >
<tr>
		<th>File Name :</th>
				<td><div align="left"><%=filename %></div> </td>
</tr>
<tr>
		<th>Account Type :</th>
				<td><div align="left"><%=acty %></div> </td>
</tr>
<tr>
		<th>Creation Date :</th>
				<td><div align="left"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss" ).parse(crtdate))%></div> </td>
</tr>
<tr>
		<th>Current Status :</th>
				<td><div align="left"><%=currentstatus %></div> </td>
</tr>
<tr>
		<th>New Status :</th>
				<td><div align="left"><select name="newstatus" id="newstatus">
<option value="Pending">Pending</option>
<option value="Uploaded">Uploaded</option>
<option value="Cancelled">Cancelled</option>
</select>
</div> </td>
</tr>
</table>

<br>
<table  align="center">
<tr align="center">
<td align="center"><input type="submit" value="Submit"></td>
</tr>
</table>
</form>
<%
}catch(Exception e)
{}
%>
</body>
</html>
</jsp:useBean>