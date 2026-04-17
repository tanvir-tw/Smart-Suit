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
	alert("Record Deleted Succesfully ");
    window.location="ASCPendingInvoiceReport.jsp";
	
}

function Redirect1()
{
	alert("Record  Not Deleted Succesfully ");
    window.location="ASCPendingInvoiceReport.jsp";
	
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
String Amcfromdate="",Amctodate="",Ownername="",toDate1="",InvoiceNumber="";
String EntryBy="";
%>
<%

try{
Id=request.getParameter("id");

Company=request.getParameter("company");

String Data="Select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ASCSummaryDetails where SRNumber='"+Id+"' and Ownername='"+Company+"'";
ResultSet rs1=st.executeQuery(Data);

if(rs1.next());
{
	Amcfromdate=rs1.getString("Amcfromdate"); 
	Amctodate=rs1.getString("Amctodate"); 
	InvoiceNumber=rs1.getString("InvoiceNumber");
	Ownername=rs1.getString("Ownername");
}

String UpdateQuery="Update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ASCSummaryDetails set InvoiceStatus='Deleted' where SRNumber='"+Id+"' and Ownername='"+Company+"' ";


st.executeUpdate(UpdateQuery);

System.out.println("------Update Query----------"+UpdateQuery);

String UpdateVehASCMaster="update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"VehASCSummaryDetails set InvoiceStatus='Deleted' where Amcfromdate='"+Amcfromdate+"' and Amctodate='"+Amctodate+"' and InvoiceRefNo='"+InvoiceNumber+"' and Ownername='"+Ownername+"'";

st.executeUpdate(UpdateVehASCMaster);
System.out.println("------UpdateVehASCMaster Query----------"+UpdateVehASCMaster);


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