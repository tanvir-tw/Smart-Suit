<%@ page language="java" import="java.sql.*" import="java.util.*" import="java.text.*" errorPage=""
    pageEncoding="ISO-8859-1"%>
    <%@ include file="header.jsp" %>
   <jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script >
function Redirect()
{
	var com=document.getElementById("company").value;
	  var code=document.getElementById("Code").value;
	  var type=document.getElementById("type").value;
	alert("Record DeActivate Succesfully ");
	
    window.location=window.location="contactdetails.jsp?Type="+type+"&companyname="+com+"&customercode="+code+"";
	
}

function Redirect1()
{
	var com=document.getElementById("company").value;
	  var code=document.getElementById("Code").value;
	  var type=document.getElementById("type").value;
	alert("Record Not DeActivate Succesfully ");
    window.location=window.location="contactdetails.jsp?Type="+type+"&companyname="+com+"&customercode="+code+"";
	
}
</script>

<body>


<%!
Connection conn=null;
%>

<%
//////////



//conn=erp.ReturnConnection();
//Statement st=conn.createStatement();
//Statement st1=conn.createStatement();

Connection conn = null, conn1=null;
Statement sterp = null, sterp1 = null, sterp2=null, sterp3=null, sterp4=null, sterp5=null, stqr=null, stsql1=null,stsql2=null;
ResultSet rs = null;
//String DB_NAME="jdbc:mysql://103.8.126.138:3306/db_gps";
//String DB_NAME="jdbc:mysql:// twdb.fleetview.in/db_gps";
String DB_NAME123="jdbc:mysql://"+host1+"/db_gps";
//String DB_NAME1="jdbc:mysql://103.8.126.138:3306/twsql_twalldata";
//String DB_NAME1="jdbc:mysql:// twdb.fleetview.in/twsql_twalldata";
String DB_NAME11234="jdbc:mysql://"+host1+"/db_GlobalERP";
String DB_USERNAME1=user1;
String DB_PASSWORD1=pass1;
Class.forName("com.mysql.cj.jdbc.Driver");
//conn=DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
conn1=DriverManager.getConnection(DB_NAME11234,DB_USERNAME1,DB_PASSWORD1);
sterp = conn1.createStatement();
sterp1 = conn1.createStatement();
sterp2 = conn1.createStatement();
sterp3 = conn1.createStatement();
sterp4 = conn1.createStatement();
sterp5 = conn1.createStatement();
stsql1= conn1.createStatement();
stsql2= conn1.createStatement();

Statement st=conn1.createStatement();
Statement st1=conn1.createStatement();
String Company="";
String Id="";
String type="",code="",Ownername="",toDate1="",InvoiceNumber="";
String EntryBy="";
%>
<%

try{
Id=request.getParameter("id");

Company=request.getParameter("companyname");
type=request.getParameter("Type");
code=request.getParameter("customercode");
%>
<input type="hidden" id="Code" name="Code" value="<%=code%>" />
<input type="hidden" id="company" name="company" value="<%=Company%>" />
<input type="hidden" id="type" name="type" value="<%=type%>" />
<%

String UpdateQuery="Update  db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"contactdet set Status='DeActive' where contact_id='"+Id+"' ";


st.executeUpdate(UpdateQuery);

System.out.println("------Update Query----------"+UpdateQuery);


 
out.println("<script>  Redirect();</script>");


}
catch(Exception e)
{
	e.printStackTrace();
	out.println("<script>  Redirect1();</script>");

}
%>
</body>
</html>
</jsp:useBean>