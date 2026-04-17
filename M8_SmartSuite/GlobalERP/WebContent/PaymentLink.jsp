<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict/aaa/EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%-- <%@ include file="conn.jsp"%>
 --%>
 <%@ page language="java" import="java.sql.*" import=" java.text.*" import=" java.util.*" errorPage="" 
%>
<%@
page import="javax.*,java.awt.*,
java.util.ArrayList,
java.util.HashMap,
java.util.List,
java.util.Date,
org.json.JSONException,
org.json.JSONObject,
org.apache.commons.lang3.StringUtils,
 com.lowagie.text.Chunk,  
 com.lowagie.text.Document,  
 com.lowagie.text.DocumentException,  
com.lowagie.text.Font, 
com.lowagie.text.FontFactory,  
com.lowagie.text.HeaderFooter,  
com.lowagie.text.Image,  
com.lowagie.text.PageSize,  
com.lowagie.text.Paragraph,  
com.lowagie.text.Phrase,
 com.lowagie.text.pdf.BaseFont,  
 com.lowagie.text.pdf.PdfContentByte,  
 com.lowagie.text.pdf.PdfImportedPage,  
com.lowagie.text.pdf.PdfLayer,  
com.lowagie.text.pdf.PdfReader,  
com.lowagie.text.pdf.PdfStamper,  
com.lowagie.text.pdf.PdfString,  
com.lowagie.text.pdf.PdfWriter,  
java.io.FileOutputStream,
java.io.*,
java.util.*,
java.awt.*,
java.awt.geom.Rectangle2D,
com.lowagie.text.pdf.*,
com.lowagie.text.pdf.PdfPCellEvent,
com.lowagie.text.*,
com.lowagie.text.Image,
org.jfree.chart.ChartFactory,
org.jfree.chart.JFreeChart,
org.jfree.chart.plot.PlotOrientation,
org.jfree.data.DefaultCategoryDataset,
org.jfree.data.DefaultPieDataset,
org.jfree.chart.ChartFrame,
org.jfree.chart.renderer.BarRenderer,
org.jfree.chart.plot.CategoryPlot,
org.jfree.chart.plot.PiePlot3D"%>



<%@page import="com.lowagie.text.Rectangle,com.razorpay.*"%><jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<%@ page language="java" import=" java.util.*" %>

 
	<script src="dropdown.js" type="text/javascript"></script>
	<script src="dynamic.js" type="text/javascript"></script>

	
	<script type="text/javascript">
	</script>
	<script >
	function Redirect2()
	{
		var a1=document.getElementById("link").value;
		var b1=document.getElementById("exdate").value;

	alert("Payment Link Is Already Created  "+"\n Payment Link Is="+a1+"\n Expiry Date Is="+b1);
	
	//    window.location="showinvoicelist.jsp";
	    
	    var a="showinvoicelist.jsp?id=View";
		
		//link="http://twtech.in:8080/ETEST/"+a;
		link="http://twtech.in/GlobalERP/"+a;

		
	    window.location=""+link;


	}
	function Redirect3()
	{
		//var a=document.getElementById("link").value;
		//var b=document.getElementById("exdate").value;
		var link="";
		var webadd="FetchInvoiceTest.jsp";
		var CompanyMasterID=document.getElementById("CompanyMasterID").value;
		     link=webadd+'?CompanyMasterID='+CompanyMasterID;
		     //link="http://173.234.153.82:8181/ETEST3/PaymentLink.jsp?transactionId=SI290118001";
		     //response.sendRedirect("http://173.234.153.82:8181/ETEST3/PaymentLink.jsp?transactionId=SI250118001");
			window.open(link,'jav');

	}

function Redirect1()
{
	alert("Error While Creating Payment Link ");
	 var a="showinvoicelist.jsp?id=View";
		
		//link="http://twtech.in:8080/ETEST/"+a;
		link="http://twtech.in/GlobalERP/"+a;

		
	    window.location=""+link;
	
}
</script>
	
	<body>
		
<%
String host = System.getenv("DB_GLOBALERP_HOST");
String user = System.getenv("DB_GLOBALERP_USER");
String pass = System.getenv("DB_GLOBALERP_PASS");
Connection conn = null;

%>
<%

/* 
 String DB_NAME="jdbc:mysql:// twdb.fleetview.in/db_GlobalERP";
String DB_NAME1="jdbc:mysql:// twdb.fleetview.in/newblankerp";  */

String DB_NAME="jdbc:mysql://"+host+"/db_GlobalERP";
String DB_NAME1="jdbc:mysql://"+host+"/newblankerp"; 

String DB_USERNAME=user;
String DB_PASSWORD=pass;
//String DB_USERNAME="java";
//String DB_PASSWORD="transjava!1";
/*String DB_NAMEPAY="jdbc:mysql:// twdb.fleetview.in/db_leaveapplication";*/
 //String DB_NAMEPAY="jdbc:mysql://202.65.131.44:3306/db_leaveapplication";
/* String DB_NAMEPAY="jdbc:mysql:// twdb.fleetview.in/db_leaveapplication";
 */
Class.forName("com.mysql.cj.jdbc.Driver");
conn=DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD); 
    Statement st = null, st1 = null,st2=null,st3=null,st4=null,st5=null,st6=null,stlbl=null,myst=null,st7=null,st8=null;

    
	int groupCode=0,makeCode=0;
	int d=0;

	int i=0;
	String groupName="",makeName="",itemCode="",stpercent="";
	String refMakeNameTable="",fromdate="";
	String pfi="",frieght="",grandTotal="";
	String frieghtType="",grandtotal="";
	String sqlDisplayDesc=" ",totalAmount="",totalAmountInWords="",termsconditions="",salesQuoNumber="",status="",statusTD="";
	NumberFormat nf = new DecimalFormat("#0.00");
	String todaysDate=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new java.util.Date());
	
	String todaysTime=new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
	String VehRegNo="",instdate="",warranty="",ASC="",ASCBillFrom="",ASCBillTo="",Days="",Age="",Rate="",Amount="",RatePerDay="",Description="",ASCCovered="";	
	String a="",b="",c="",h="",u="",m="",n="",o="",p="",q="";
	String VehicleCount="",DaysCount="",TotalAmount="";
	
	String invoicerefno=request.getParameter("transactionId");
	String InvoiceNo="";
	String CompanyMasterID=request.getParameter("CompanyMasterID");
	
	
	%>
	
	<input type="hidden" value="<%=CompanyMasterID %>" id="CompanyMasterID" />


	<%
	//String CompanyMasterID="";
	// NumberFormat nf = new DecimalFormat("#0.00");
	System.out.println(invoicerefno);
	System.out.println(CompanyMasterID);

	try {
	st = conn.createStatement();
	st2 = conn.createStatement();
	st1 = conn.createStatement();
	st3 = conn.createStatement();
	st4 = conn.createStatement();
	st5 = conn.createStatement();
	st6 = conn.createStatement();
	st7 = conn.createStatement();
	st8 = conn.createStatement();


	stlbl = conn.createStatement();
	} catch (Exception e) {
	}

%>
	
<%	

System.out.println(" In JSP");

String paylink="";
String expirydate1="",GateWayPassword="",GateWayKey="";
///Font catFont = new Font(Font.FontFamily.TIMES_ROMAN, 18, Font.BOLD);

			//Connection con11=DriverManager.getConnection("jdbc:mysql:// twdb.fleetview.in/smartgrid", "root", "root");
		//	Statement myst=con11.createStatement();

try{

String GSTINNO="",MasterState="";

String compmaster="select *  from db_GlobalERP.CompanyMaster where companymid='"+CompanyMasterID+"'";
System.out.println(">>>>>>>>>>>In compmaster     "+compmaster);

ResultSet rscompmaster=st5.executeQuery(compmaster);
if(rscompmaster.next())
{
	GSTINNO=rscompmaster.getString("GSTINNO");
	MasterState=rscompmaster.getString("GSTINNO");
}

String SqlQuoDet="SELECT * from db_GlobalERP."+CompanyMasterID+"invoicedet WHERE invoiceRefNo='"+invoicerefno+"' ";
System.out.println(">>>>>>>>>>>In Invoiceref     "+SqlQuoDet);
ResultSet rsInvDet=st4.executeQuery(SqlQuoDet);
	if(rsInvDet.next()){
		
		String billdetails="Select * from db_GlobalERP."+CompanyMasterID+"customerdet where CustomerCode='"+rsInvDet.getString("CustomerCode")+"' ";
		
		System.out.println(">>>>>>>>>>>In customerdet     "+billdetails);

		ResultSet rsbilldetails=st6.executeQuery(billdetails);
		String billstate="",shipstate="",billgstin="",shipgstin="";
		if(rsbilldetails.next())
		{
			billstate=rsbilldetails.getString("BillingState");
			shipstate=rsbilldetails.getString("ShippingState");
			billgstin=rsbilldetails.getString("BillingGSTN");
			shipgstin=rsbilldetails.getString("ShippingGSTN");
		}
		


String InvRaisedCompName=rsInvDet.getString("InvRaisedCompName");
String InvRaisedBillAdd=rsInvDet.getString("InvRaisedBillAdd");
String InvRaisedShipAdd=rsInvDet.getString("InvRaisedShipAdd");
String InvRaisedConDet=rsInvDet.getString("InvRaisedConDet");

String GrandTotal=rsInvDet.getString("Total");
System.out.println("GrandTotal-----"+GrandTotal);
String GrandTotal1 = GrandTotal.replaceAll("[.]*", "");
System.out.println("GrandTotal1-----"+GrandTotal1);

String Cname=rsInvDet.getString("CompanyName");
String Address=rsInvDet.getString("Address");
	String Phone1=rsbilldetails.getString("MobileNo");
	String email=rsbilldetails.getString("email");

	  System.out.println("Cname-----"+Cname);
	  System.out.println("Address-----"+Address);
	  System.out.println("Phone-----"+Phone1);
	  System.out.println("email-----"+email);

	  String query2="select * from db_GlobalERP."+CompanyMasterID+"PayLinkDetails where invoice_id='"+invoicerefno+"' and expire_by >= '"+todaysDate+"'";
	  System.out.println("query2-----"+query2);

		ResultSet rs7=st7.executeQuery(query2);
		if(rs7.next())
		{
			paylink=rs7.getString("short_url");
		 expirydate1=rs7.getString("expire_by");
			System.out.println("paylink"+paylink+"expirydate"+expirydate1);
		  	 // out.println("Invoice Link is   "+paylink+"\n"+"\n Expired By   "+expirydate1);
%>

<input type="hidden" id="link" name="link" value=<%=paylink%>/>
<input type="hidden" id="exdate" name="exdate" value=<%=expirydate1%>/>


<% 
			  out.println("<script>  Redirect2();</script>");


		}
		else
		{
			String CompanyName="Transworld";
			
			String keyquery="select * from db_GlobalERP.PaymentGatewayMaster where CompanyName='"+CompanyName+"' and CompanyID='"+CompanyMasterID+"'";
			  System.out.println("keyquery-----"+keyquery);

				ResultSet rs9=st8.executeQuery(keyquery);
				while(rs9.next())
				{
					GateWayKey=rs9.getString("GateWayKey");
					GateWayPassword=rs9.getString("GateWayPassword");
					System.out.println("GateWayKey"+GateWayKey+"GateWayPassword"+GateWayPassword);
				}
	
	RazorpayClient razorpay = new RazorpayClient(GateWayKey,GateWayPassword); //test
	try {
		  System.out.println("In Razorpay Try block");

		
			
			
		 // System.out.println("todaysDate---"+todaysDate);
		  Date d1 = new Date();
		  
	        d1.setTime(d1.getTime() + 30L * 24 * 60 * 60 * 1000);
	        System.out.println("30 days after today is: " + d1);
			String todaysDate1=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(d1);
			System.out.println("todaysDate1------"+todaysDate1);
			  DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");

			  Object epochEnd = formatter.parse(todaysDate1).getTime() / 1000;	
		        System.out.println("epochEnd"+epochEnd);

	JSONObject invoiceRequest = new JSONObject();

	HashMap<String, String> hashmap = new HashMap<String, String>();
      hashmap.put("name", Cname);
    // hashmap.put("contact","+919921539121");
      hashmap.put("contact",Phone1);
    //  hashmap.put("email", "p_tepale@transworld-compressor.com");
         hashmap.put("email", email);
	  System.out.println("Cname-----"+Cname);
	  System.out.println("Address-----"+Address);
	  System.out.println("Phone-----"+Phone1);
	  System.out.println("GrandTotal1-----"+GrandTotal1);

	//values.addAll(c)
	//values.add("+919921539121");
	invoiceRequest.put("customer",hashmap);
    System.out.println("hashmap-----"+hashmap);

	invoiceRequest.put("type","link");
	
   // System.out.println("hashmap-----"+hashmap);

	invoiceRequest.put("view_less",1);
	invoiceRequest.put("amount",GrandTotal1);
	invoiceRequest.put( "currency","INR");
	invoiceRequest.put("description",invoicerefno);
	invoiceRequest.put("expire_by", epochEnd);
	 
	
	
	  Invoice invoice = razorpay.Invoices.create(invoiceRequest);
	  
	  
	 
	  	//  out.println("Invoice Link is   "+paylink+"\n"+"\n Expired By   "+expirydate1);
	  
      System.out.println("order-----"+invoice);
      
      
      //Needs To Run FetchInvoicesTest Details....
  
      String query3="select * from db_GlobalERP."+CompanyMasterID+"PayLinkDetails where invoice_id='"+invoicerefno+"' and expire_by >= '"+todaysDate+"'";
	  System.out.println("query3-----"+query3);

		ResultSet rs8=st8.executeQuery(query2);
		while(rs8.next())
		{
			paylink=rs8.getString("short_url");
		 expirydate1=rs8.getString("expire_by");
			System.out.println("paylink"+paylink+"expirydate"+expirydate1);
		}
		  	 // out.println("Invoice Link is   "+paylink+"\n"+"\n Expired By   "+expirydate1);
		  	  
		  	
		  	 %>

<input type="hidden" id="link" name="link" value=<%=paylink%>/>
<input type="hidden" id="exdate" name="exdate" value=<%=expirydate1%>/>


<% 
//out.println("<script>  Redirect();</script>");

out.println("<script>  Redirect3();</script>");
	 
	} catch (RazorpayException e) {
	  // Handle Exception
	  System.out.println(e.getMessage());
	  out.println("error"+e.getMessage());
		out.println("<script>  Redirect1();</script>");

	}
		
		}
	
	}
	
	
}catch(Exception e){
	e.printStackTrace();
	out.println("<script>  Redirect1();</script>");

	}
	
%>
	</body>
	</html>
</jsp:useBean>