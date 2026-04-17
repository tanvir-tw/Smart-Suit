<%@page import="javax.sound.midi.SysexMessage"%>
<%@page import="java.sql.*"%>
<%@page import="com.ConnectionClass"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>List Of Monthly Invoices</title>
<script src="sorttable.js" type="text/javascript"></script>
<link href="css/table.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
String month=request.getParameter("month");
String year=request.getParameter("year");
System.out.println("YEAR :-  "+year+"  "+month);
String buffer="";
File f = null;
int i=1;
Connection conn = null;
 
	
    Statement st1= null, st2=null;
	Statement sterp2 = null;
	String selectedName,fpreviousmonth="";
	String FollowUpType = "",Group="", strcustomer = "", strgroupname = "";
	 String strhtml="";
	 String strhtml1="";
	 String stringtowrite1;
	 String stringtowrite;
     ConnectionClass connection = new ConnectionClass();
	 try {
			conn = connection.getConnect("db_GlobalERP");    
			st1 = conn.createStatement();
		    st2 = conn.createStatement();
		   
		} catch (Exception e) {
		    e.printStackTrace();
		} 
	
	 
	 try {

	     
	     buffer += "<table class='sortable' name='invoiceList' style='height: 90px;'>";
	     buffer += "<tr>";
	     buffer += "<th>Sr. No.</th>";
	     buffer += "<th>Company Name</th>";
	     buffer += "<th>File Name</th>";
	     buffer += "</tr>";

	     String FileName = "", InvNo = "", CompName = "";

                 FileName = "";
	             InvNo = "";
	             CompName = "";
                 System.out.println("File Name :- " + FileName);

	             // Remove extension to get invoice number
	             if (FileName.contains(".")) {
	                 InvNo = FileName.substring(0, FileName.lastIndexOf("."));
	             } else {
	                 InvNo = FileName;
	             }

	             System.out.println("Invoice :- " + InvNo);

	             //String CustName = "Select Distinct(CompanyName) from db_GlobalERP."+ session.getAttribute("CompanyMasterID").toString()+ "performainvoicedet where invoicerefno='" + InvNo + "'";
				 String CustName = "Select distinct(InvoiceRefNo),Transporter from db_GlobalERP."+ session.getAttribute("CompanyMasterID").toString()+ "fv_erp_relation"+year+"_"+month+" where InvoiceRefNo!='-'";
	             System.out.println("Query :- " + CustName);
                 //ResultSet rsCustName = st2.executeQuery(CustName);
	             PreparedStatement pscust = conn.prepareStatement(CustName, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
	             ResultSet rsCustName = pscust.executeQuery();
	             if(rsCustName.next()){
	             
	             rsCustName.previous();
	             while (rsCustName.next()) {
	                // CompName = rsCustName.getString("CompanyName");
	                 CompName = rsCustName.getString("Transporter");
	                 
	                 if (Integer.parseInt(year) < 2026){
	                	 FileName = rsCustName.getString("InvoiceRefNo")+".pdf";
	                 }
	                 else if (Integer.parseInt(year)> 2026){
	                	 FileName = rsCustName.getString("InvoiceRefNo")+"_"+year+"_"+month+".pdf";
	                 }
	                 else if (Integer.parseInt(year) == 2026){
	                     if(Integer.parseInt(month)>=2){
	                         FileName = rsCustName.getString("InvoiceRefNo")+"_"+year+"_"+month+".pdf";
	                     }else{
	                	    FileName = rsCustName.getString("InvoiceRefNo")+".pdf";
	                     }
	                 }
	                 
	             buffer += "<tr>";
	             buffer += "<td>" + i + "</td>";
	             buffer += "<td style='text-align:left;'>" + (CompName == null ? "" : CompName) + "</td>";
	             buffer += "<td style='text-align:left;'>";
	             //buffer += "<a href='Download_2.jsp?year=" + year + "&month=" + month + "&filename=" + FileName.replace(" ", "^") + "'>";
	             buffer += "<a href='Download_2.jsp?filename=" + FileName.replace(" ", "^") + "' target=_blank>";
	             buffer += FileName + "</a>";
	             buffer += "</td>";
	             buffer += "</tr>";

	             i++;
	             
	         }
	     
	             }else{
	            	 buffer += "<tr><td colspan='3' style='text-align:center;'>No Invoices For This Month</td></tr>";
	             }

	     buffer += "</table>";

	 } catch (Exception e) {

	     e.printStackTrace();

	     buffer = "<table class='sortable' name='invoiceList'>";
	     buffer += "<tr><th>Sr. No.</th><th>Company Name</th><th>File Name</th></tr>";
	     buffer += "<tr><td colspan='3' style='text-align:center;'>No Invoices For This Month</td></tr>";
	     buffer += "</table>";
	 }

	 out.println(buffer);
%>
</body>
</html>