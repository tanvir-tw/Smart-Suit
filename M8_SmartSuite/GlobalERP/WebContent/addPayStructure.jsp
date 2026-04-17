<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Contract Profile Master</title>
<%@ page language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="moreservlets.listeners.*" errorPage="" %>
<style type="text/css">@import url(jscalendar-1.0/calendar-blue.css);</style>
<link href="css/ERP.css" rel="stylesheet" type="text/css"></link>
<%@ page import = "java.io.FileNotFoundException"%>
<%@ page import = "java.io.FileOutputStream"%>
<%@ page import = " java.io.IOException"%>
<%@ page import="javax.activation.*" %>
<script type="text/javascript" language="javascript" src="calendar/prototype-1.js"></script>
<script type="text/javascript" language="javascript" src="calendar/prototype-base-extensions.js"></script>
<script type="text/javascript" language="javascript" src="calendar/prototype-date-extensions.js"></script>
<script type="text/javascript" language="javascript" src="calendar/behaviour.js"></script> 
<script type="text/javascript" language="javascript" src="calendar/datepicker.js"></script> 
<link rel="stylesheet" href="calendar/datepicker.css">
<script type="text/javascript" language="javascript" src="calendar/behaviors.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script> 
<%@ include file="header.jsp"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">  

<body onkeypress="hideList(event);" onclick="hideOnClick();">

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

</head>
 <body>
<%! 
Connection con ;
%>

<%

Class.forName(DB_Driver);
con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
Statement st1=con.createStatement();
Statement st2=con.createStatement();
Statement st3=con.createStatement();
Statement st4=con.createStatement();
Statement st5=con.createStatement();

String ContractorId="";     
String ContractFee="";         
String ContractFeePerMonth=""; 
String ContractFeePerAnnum=""; 
String PIFee="";               
String KRAFee="";              
String FixedFee="";            
String VehicleAllowance="";    
String MobileAllowance="";     
String LaptopAllowance="";     
String ProximityAllowance="";  
String OtherAllowance="";      
String TDSPercent="";          
String MinPIIndex="";          
String PIIndexSource="";       
String MinKRAIndex="";         
String KRAIndexSource="";      
String PayLevel="";            
String PaySequence="";  







ContractorId=request.getParameter("cont_id");
ContractFeePerMonth=request.getParameter("fee_monthly");
ContractFeePerAnnum=request.getParameter("fee_annually");
PIFee=request.getParameter("PI");
KRAFee=request.getParameter("KRA");
FixedFee=request.getParameter("fixed");
VehicleAllowance=request.getParameter("vehicle");
MobileAllowance=request.getParameter("mobile");
LaptopAllowance=request.getParameter("laptop");
ProximityAllowance=request.getParameter("proximity");
OtherAllowance=request.getParameter("others");
TDSPercent=request.getParameter("tds");
MinPIIndex=request.getParameter("PI1");
MinKRAIndex=request.getParameter("KRA1");

PIIndexSource=request.getParameter("PI_source");
KRAIndexSource=request.getParameter("KRA_Source");

PayLevel=request.getParameter("level");
PaySequence=request.getParameter("sequence");


System.out.println("Information from ContractPayStructure Page:");

System.out.println("cont_id"+ContractorId);
System.out.println("ContractFeePerMonth"+ContractFeePerMonth);
System.out.println("ContractFeePerAnnum"+ContractFeePerAnnum);
System.out.println("PIFee"+PIFee);
System.out.println("KRAFee"+KRAFee);
System.out.println("FixedFee"+FixedFee);
System.out.println("VehicleAllowance"+VehicleAllowance);
System.out.println("MobileAllowance"+MobileAllowance);
System.out.println("LaptopAllowance"+LaptopAllowance);
System.out.println("ProximityAllowance"+ProximityAllowance);
System.out.println("OtherAllowance"+OtherAllowance);
System.out.println("TDS"+TDSPercent);
System.out.println("MinPIIndex"+MinPIIndex);
System.out.println("MinKRAIndex"+MinKRAIndex);

System.out.println("PIIndexSource"+PIIndexSource);
System.out.println("KRAIndexSource"+KRAIndexSource);

System.out.println("level"+PayLevel);
System.out.println("PaySequence"+PaySequence);

Statement stsms=con.createStatement();
int sqlst=0;
	
	
	Statement stsms1=con.createStatement();




String query="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ContractorPayMaster (ContractorId,ContractFeePerMonth,ContractFeePerAnnum,PIFee,KRAFee,FixedFee,VehicleAllowance,MobileAllowance,LaptopAllowance,ProximityAllowance,OtherAllowance,TDSPercent,MinPIIndex,PIIndexSource,MinKRAIndex,KRAIndexSource,PayLevel,PaySequence) values ('"+ContractorId+"','"+ContractFeePerMonth+"','"+ContractFeePerAnnum+"','"+PIFee+"','"+KRAFee+"','"+FixedFee+"','"+VehicleAllowance+"','"+MobileAllowance+"','"+LaptopAllowance+"','"+ProximityAllowance+"','"+OtherAllowance+"','"+TDSPercent+"','"+MinPIIndex+"','"+PIIndexSource+"','"+MinKRAIndex+"','"+KRAIndexSource+"','"+PayLevel+"','"+PaySequence+"')";

sqlst= stsms.executeUpdate(query);


System.out.println("Insert Master Data  :- "+query);

String queryhistory="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ContractorPayMasterHistory (ContractorId,ContractFeePerMonth,ContractFeePerAnnum,PIFee,KRAFee,FixedFee,VehicleAllowance,MobileAllowance,LaptopAllowance,ProximityAllowance,OtherAllowance,TDSPercent,MinPIIndex,PIIndexSource,MinKRAIndex,KRAIndexSource,PayLevel,PaySequence) values ('"+ContractorId+"','"+ContractFeePerMonth+"','"+ContractFeePerAnnum+"','"+PIFee+"','"+KRAFee+"','"+FixedFee+"','"+VehicleAllowance+"','"+MobileAllowance+"','"+LaptopAllowance+"','"+ProximityAllowance+"','"+OtherAllowance+"','"+TDSPercent+"','"+MinPIIndex+"','"+PIIndexSource+"','"+MinKRAIndex+"','"+KRAIndexSource+"','"+PayLevel+"','"+PaySequence+"')";


System.out.println("Insert History Data  :- "+queryhistory);


sqlst= stsms1.executeUpdate(queryhistory);





if(sqlst>=1)
{	
	out.println("<script type=\"text/javascript\">");
	   out.println("alert('Added Successfully ','','success');");
	   
	  // swal("Good job!", "You clicked the button!", "success");
	   out.println("location='ContractMasterReport.jsp';");
	   out.println("</script>");
}else
{
	out.println("<script type=\"text/javascript\">");
	   out.println("swal('Error Occurred  ','','success');");
	   
	  // swal("Good job!", "You clicked the button!", "success");
	   out.println("location='ContractMasterReport.jsp';");
	   out.println("</script>");
	System.out.println("Error Occurred");
}







%>
</body>
</html>
</jsp:useBean>