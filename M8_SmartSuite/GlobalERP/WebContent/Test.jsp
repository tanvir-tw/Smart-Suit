<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="tally" class="com.tally.beans.TALLY" scope="page">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
String CMID=session.getAttribute("CompanyMasterID").toString();
String SID=session.getAttribute("TallySID").toString();
String PID=session.getAttribute("TallyPID").toString();
String Connected = tally.connectTallyserver(SID,PID);
System.out.println(Connected);
try
{
	StringBuilder xmldoc = new StringBuilder();
	xmldoc.append("<ENVELOPE>\r\n");
	xmldoc.append("<HEADER>\r\n");
	xmldoc.append("<TALLYREQUEST>Import Data</TALLYREQUEST>\r\n");
	xmldoc.append("</HEADER>\r\n");
	xmldoc.append("<BODY>\r\n");
	xmldoc.append("<IMPORTDATA>\r\n");
	xmldoc.append("<REQUESTDESC>\r\n");
	xmldoc.append("<REPORTNAME>All Masters</REPORTNAME>\r\n");
	xmldoc.append("</REQUESTDESC>\r\n");
	xmldoc.append("<REQUESTDATA>\r\n");
	xmldoc.append("<TALLYMESSAGE xmlns:UDF='TallyUDF'>\r\n");
	xmldoc.append("<GROUP NAME='' ACTION='Create'>\r\n");
	xmldoc.append("<NAME.LIST>\r\n");
	xmldoc.append("<NAME>VIJAY</NAME>\r\n");
	xmldoc.append("</NAME.LIST>\r\n");
	xmldoc.append("<PARENT>Sundry Debtors</PARENT>\r\n");
	xmldoc.append("<ISSUBLEDGER>No</ISSUBLEDGER>\r\n");
	xmldoc.append("<ISBILLWISEON>No</ISBILLWISEON>\r\n");
	xmldoc.append("<ISCOSTCENTRESON>No</ISCOSTCENTRESON>\r\n");
	xmldoc.append("</GROUP>\r\n");
	xmldoc.append("<GROUP NAME='' ACTION='Create'>\r\n");
	xmldoc.append("<NAME.LIST>\r\n");
	xmldoc.append("<NAME>AJAY</NAME>\r\n");
	xmldoc.append("</NAME.LIST>\r\n");
	xmldoc.append("<PARENT>Sundry Debtors</PARENT>\r\n");
	xmldoc.append("<ISSUBLEDGER>No</ISSUBLEDGER>\r\n");
	xmldoc.append("<ISBILLWISEON>No</ISBILLWISEON>\r\n");
	xmldoc.append("<ISCOSTCENTRESON>No</ISCOSTCENTRESON>\r\n");
	xmldoc.append("</GROUP>\r\n");
	xmldoc.append("</TALLYMESSAGE>\r\n");
	xmldoc.append("</REQUESTDATA>\r\n");
	xmldoc.append("</IMPORTDATA>\r\n");
	xmldoc.append("</BODY>\r\n");
	xmldoc.append("</ENVELOPE>\r\n");

	String senddata = tally.sendTallyserver(xmldoc.toString(),SID,PID);
	System.out.println(senddata);
}
catch (Exception e)
{
}
%>
</body>
</html>
</jsp:useBean>