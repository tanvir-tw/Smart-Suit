<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@
page import=  
    
     "java.sql.Connection,
 java.sql.DriverManager,
 java.sql.PreparedStatement,
 java.sql.Statement,
 java.text.SimpleDateFormat,
 java.util.Date,
 java.util.List,
 java.util.StringTokenizer,
 java.util.TimeZone,

 org.apache.commons.lang3.StringUtils,
 org.json.JSONException,
 org.json.JSONObject"%>
 <%@page import="com.lowagie.text.Rectangle,com.razorpay.*"%><jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<%@ page language="java" import="java.sql.*" import=" java.text.*" import=" java.util.*" errorPage="" 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script>



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

function Redirect5()
{
	//alert("IN REDIRECR");	
	
	var a1=document.getElementById("link").value;
	var b1=document.getElementById("exdate").value;
	
	//alert("Payment Link Created Succesfully ");
	
	alert("Payment Link Created Succesfully "+"\n Payment Link Is="+a1+"\n Expiry Date Is="+b1);
	
	var a="showinvoicelist.jsp?id=View";
	
	//link="http://twtech.in:8080/ETEST/"+a;
	
	link="http://twtech.in/GlobalERP/"+a;

	
    window.location=""+link;
}
function Redirect()
{
	var a1=document.getElementById("link").value;
	var b1=document.getElementById("exdate").value;
	
	//alert("Payment Link Created Succesfully ");
	
	alert("Payment Link Created Succesfully "+"\n Payment Link Is="+a1+"\n Expiry Date Is="+b1);
	
	var a="showinvoicelist.jsp?id=View";
	
	//link="http://twtech.in:8080/ETEST/"+a;
	
	link="http://twtech.in/GlobalERP/"+a;

	
    window.location=""+link;
    
    //window.open(link,'jav');
	
}
function Redirect4()
{
	var a1=document.getElementById("link").value;
	var b1=document.getElementById("exdate").value;
	
	//alert("Payment Link Created Succesfully ");
	
	alert("Payment Link Created "+"\n Payment Link Is="+a1+"\n Expiry Date Is="+b1);
	
	var a="showinvoicelist.jsp?id=View";
	
	//link="http://twtech.in:8080/ETEST/"+a;
	
	link="http://twtech.in/GlobalERP/"+a;

	
    window.location=""+link;
    
    //window.open(link,'jav');
	
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

	 String short_url;
	 String fee;
	 String Invoice;
	 String test;
	String invoice_id;
	//private static String fee;
	  String description;
	  String created_at;
	  String amount_refunded;
	 String bank;
	 String error_description;
	 String captured;
	 String contact;
	 String invoice_id1;
	 String currency;
	 String id;
	 String international;
	 String email;
	 String amount;
	 String refund_status;
	 String wallet;
	 String method;
	 String vpa;
	 String tax;
	 String card_id;
	 String error_code;
	 String order_id;
	 String entity;
	 String status;
	 String conn;
	 int count;
	 String notes;
	Object epochStart;
	 Object epochEnd;
	 String customer_id;
	  String order_id1;
	  String entity1;
	  String status1;
	  String comment;
	  String receipt;
	  String group_taxes_discounts;
	  String user_id;
	  String paid_at;
	  String email_status;
	  String sms_status;
	  String expire_by;
	 String invoice_number;
	 String id1;
	 String currency1;
	 String amount_due;
	 String payment_id;
	 String terms;
	 String billing_end;
	 String customer_contact;
	 String customer_name;
	String billing_address;
	 String name;
	 String customer_email;
	 String customer_details;
	 String issued_at;
	String type;
	 String cancelled_at;
	 Object date;
	 Object tax_amount;
	 Object amount_paid;
	Object partial_payment;
	Object expired_at;
	 String gross_amount;
	 String shipping_address;
	 String gstin;

	
	
	
	 Class.forName("com.mysql.cj.jdbc.Driver");
	//	Connection con1=DriverManager.getConnection("jdbc:mysql:// twdb.fleetview.in/db_GlobalERP", "fleetview", "1@flv");
		Connection con1=DriverManager.getConnection("jdbc:mysql://"+host+"/db_GlobalERP",user,pass);

		Statement myst=con1.createStatement();
		Statement st=con1.createStatement();
		Statement st8=con1.createStatement();

	
		String CompanyMasterID=request.getParameter("CompanyMasterID");

	
		String CompanyName="Transworld";
		String GateWayKey="",GateWayPassword="";
		
		
		String keyquery="select * from db_GlobalERP.PaymentGatewayMaster where CompanyID='"+CompanyMasterID+"'";
		  System.out.println("keyquery-----"+keyquery);

			ResultSet rs9=st8.executeQuery(keyquery);
			while(rs9.next())
			{
				GateWayKey=rs9.getString("GateWayKey");
				GateWayPassword=rs9.getString("GateWayPassword");
				System.out.println("GateWayKey"+GateWayKey+"GateWayPassword"+GateWayPassword);
			}
	
	
	
	
//			RazorpayClient razorpay = new RazorpayClient("rzp_live_ZNON4JJYMt3ccE", "34Bi8pDTHpOCXtGZOGcby49u"); //live
//			RazorpayClient razorpay = new RazorpayClient("rzp_test_Aff9xUmQO5IYHE", "En5NNmEG8DUdcyyWFpGx2XLL"); //test
			RazorpayClient razorpay = new RazorpayClient(GateWayKey,GateWayPassword); //test

			try {
				  JSONObject invoiceRequest = new JSONObject();
				   
				    //supported option filters (from, to, count, skip)
				  invoiceRequest.put("count", 1);
				  invoiceRequest.put("skip", 1);
				      
				  List<Invoice> invoice = razorpay.Invoices.fetchAll(invoiceRequest);
				  System.out.println("invoice"+invoice);
				  
				  
				  String str1 = StringUtils.join(invoice);

				  System.out.println("Fetch Invoices"+str1);

				  
				  String findStr = "notes"+":[]";
				  int lastIndex = 0;
				  int count1 = 0;

				  while(lastIndex != -1){

				      lastIndex = str1.indexOf(findStr,lastIndex);

				      if(lastIndex != -1){
				          count1 ++;
				          lastIndex += findStr.length();
				      }
				  }
				  System.out.println("count"+count1);
				 /* String text    ="hello";
				  String pattern = ".*ello.*";

			        boolean matches = Pattern.matches(pattern, text);

			        System.out.println("matches = " + matches);*/
				  
				  
				  
				 String str=str1;
				 System.out.println("New String.."+str);
			         
				
				 /*if(Pattern.matches("[]", str))
				 {*/
				  
				  StringTokenizer stk1 = new StringTokenizer(str,",");
			         
				  while (stk1.hasMoreTokens()) {
					  invoice_id = stk1.nextElement().toString();
			             System.out.println("cancelled_at:-" + invoice_id);
			            
			        if (stk1.hasMoreTokens()) {
			            	 fee = stk1.nextElement().toString();
			   	             System.out.println("date:-" + fee);
			       if (stk1.hasMoreTokens()) {
			   	        	description = stk1.nextElement().toString();
				   	             System.out.println("tax_amount:-" + description);
				   	  if (stk1.hasMoreTokens()) {
				   	        	created_at = stk1.nextElement().toString();
						   	             System.out.println("amount_paid-" + created_at);
						   	          
						   	          if (stk1.hasMoreTokens()) {
						   	        	amount_refunded = stk1.nextElement().toString();
									   	             System.out.println("partial_payment:-" + amount_refunded);
									   	          if (stk1.hasMoreTokens()) {
									   	        	bank = stk1.nextElement().toString();
													   	             System.out.println("notes:-" + bank);
													   	          
													   	          if (stk1.hasMoreTokens()) {
													   	        	error_description = stk1.nextElement().toString();
																		   	             System.out.println("billing_start:-" + error_description);
																		   	          
																		   	          if (stk1.hasMoreTokens()) {
																		   	        	description = stk1.nextElement().toString();
																								   	             System.out.println("description:-" + description);
																								   	          
																								   	          if (stk1.hasMoreTokens()) {
																								   	        	contact = stk1.nextElement().toString();
																															   	             System.out.println("created_at:-" + contact);
																															   	          
																															   	          if (stk1.hasMoreTokens()) {
																															   	        	invoice_id1 = stk1.nextElement().toString();
																																							   	             System.out.println("view_less:-" + invoice_id1);
																																							   	          
																																							   	          if (stk1.hasMoreTokens()) {
																																							   	        	currency = stk1.nextElement().toString();
																																							   	        	System.out.println("line_items:-" + currency);
																																																   	          
																																																   	          if (stk1.hasMoreTokens()) {
																																																   	        	id = stk1.nextElement().toString();
																																																				System.out.println("expired_at:-" + id);
																																																										   	          
																																																				 if (stk1.hasMoreTokens()) {
																																																					 gross_amount = stk1.nextElement().toString();
																																																						System.out.println("gross_amount:-" + gross_amount);
																																																												   	          
																																																						 if (stk1.hasMoreTokens()) {
																																																							 type = stk1.nextElement().toString();
																																																								System.out.println("type:-" + type);
																																																														   	          
																																																								 if (stk1.hasMoreTokens()) {
																																																									 issued_at = stk1.nextElement().toString();
																																																										System.out.println("issued_at:-" + issued_at);
																																																																   	          
																																																										if (stk1.hasMoreTokens()) {
																																																											short_url = stk1.nextElement().toString();
																																																												System.out.println("short_url:-" + short_url);
																																																												
																																																												if (stk1.hasMoreTokens()) {
																																																													customer_details = stk1.nextElement().toString();
																																																													System.out.println("customer_details:-" + customer_details);
																																																																				   	          
																																																													if (stk1.hasMoreTokens()) {
																																																														customer_email = stk1.nextElement().toString();
																																																														System.out.println("customer_email:-" + customer_email);
																																																																					   	          
																																																														if (stk1.hasMoreTokens()) {
																																																															name = stk1.nextElement().toString();
																																																															System.out.println("name:-" + name);
																																																																						   	          
																																																															if (stk1.hasMoreTokens()) {
																																																																billing_address = stk1.nextElement().toString();
																																																																System.out.println("billing_address:-" + billing_address);
																																																																if (stk1.hasMoreTokens()) {
																																																																	shipping_address = stk1.nextElement().toString();
																																																																	System.out.println("shipping_address:-" + shipping_address);
																																																																
																																																																	if (stk1.hasMoreTokens()) {
																																																																		customer_name = stk1.nextElement().toString();
																																																																		System.out.println("customer_name:-" + customer_name);
																																																																if (stk1.hasMoreTokens()) {
																																																																	gstin = stk1.nextElement().toString();
																																																																	System.out.println("gstin:-" + gstin);
																																																																	
																																																																								   	          
																																																																	if (stk1.hasMoreTokens()) {
																																																																		email = stk1.nextElement().toString();
																																																																		System.out.println("email:-" + email);
																																																																									   	          
																																																															   	          
																																																																		if (stk1.hasMoreTokens()) {
																																																																			customer_contact = stk1.nextElement().toString();
																																																																			System.out.println("customer_contact:-" + customer_contact);
																																																																										   	          
																																																																			  
																																																																			if (stk1.hasMoreTokens()) {
																																																																				billing_end = stk1.nextElement().toString();
																																																																				System.out.println("billing_end:-" + billing_end);
																																																																				
																																																																											   	          
																																																																				if (stk1.hasMoreTokens()) {
																																																																					terms = stk1.nextElement().toString();
																																																																					System.out.println("terms:-" + terms);
																																																																									//db();			   	          
																																																																					     	
																																																																					if (stk1.hasMoreTokens()) {
																																																																						payment_id = stk1.nextElement().toString();
																																																																						System.out.println("payment_id:-" + payment_id);
																																																																										//db();			   	
																																																																						if (stk1.hasMoreTokens()) {
																																																																							amount_due = stk1.nextElement().toString();
																																																																							System.out.println("amount_due:-" + amount_due);
																																																																											//db();			   	          
																																																																							     	
																																																																							if (stk1.hasMoreTokens()) {
																																																																								currency1 = stk1.nextElement().toString();
																																																																								System.out.println("currency:-" + currency1);
																																																																												//db();			   	          
																																																																								     	
																																																																								if (stk1.hasMoreTokens()) {
																																																																									id1 = stk1.nextElement().toString();
																																																																									System.out.println("id:-" + id1);
																																																																													//db();			   	          
																																																																									     	
																																																																									if (stk1.hasMoreTokens()) {
																																																																										invoice_number = stk1.nextElement().toString();
																																																																										System.out.println("invoice_number:-" + invoice_number);
																																																																														//db();			   	          
																																																																										if (stk1.hasMoreTokens()) {
																																																																											expire_by = stk1.nextElement().toString();
																																																																											System.out.println("expire_by:-" + expire_by);
																																																																															//db();			   	          
																																																																											     	
																																																																											if (stk1.hasMoreTokens()) {
																																																																												sms_status = stk1.nextElement().toString();
																																																																												System.out.println("sms_status:-" + sms_status);
																																																																																//db();			   	          
																																																																												     	
																																																																												if (stk1.hasMoreTokens()) {
																																																																													email_status = stk1.nextElement().toString();
																																																																													System.out.println("amount:-" + email_status);
																																																																																	//db();			   
																																																																													if (stk1.hasMoreTokens()) {
																																																																														status = stk1.nextElement().toString();
																																																																														System.out.println("email_status:-" + status);
																																																																																		//db();			   	          
																																																																														     	
																																																																														if (stk1.hasMoreTokens()) {
																																																																															paid_at = stk1.nextElement().toString();
																																																																															System.out.println("paid_at:-" + paid_at);
																																																																																			//db();			   	          
																																																																															     	
																																																																															if (stk1.hasMoreTokens()) {
																																																																																user_id = stk1.nextElement().toString();
																																																																																System.out.println("user_id:-" + user_id);
																																																																																				//db();			   	   
																																																																																if (stk1.hasMoreTokens()) {
																																																																																	group_taxes_discounts = stk1.nextElement().toString();
																																																																																	System.out.println("group_taxes_discounts:-" + group_taxes_discounts);
																																																																																					//db();			   	   
																																																																																	if (stk1.hasMoreTokens()) {
																																																																																		receipt = stk1.nextElement().toString();
																																																																																		System.out.println("receipt:-" + receipt);
																																																																																						//db();			   	          
																																																																																		     	
																																																																																		if (stk1.hasMoreTokens()) {
																																																																																			comment = stk1.nextElement().toString();
																																																																																			System.out.println("comment:-" + comment);
																																																																																							//db();			   	          
																																																																																			     	
																																																																																			if (stk1.hasMoreTokens()) {
																																																																																				customer_id = stk1.nextElement().toString();
																																																																																				System.out.println("customer_id:-" + customer_id);
																																																																																								//db();			   	          
																																																																																				     	
																																																																																				if (stk1.hasMoreTokens()) {
																																																																																					order_id1 = stk1.nextElement().toString();
																																																																																					System.out.println("order_id:-" + order_id1);
																																																																																									//db();			   	          
																																																																																					     	
																																																																																					if (stk1.hasMoreTokens()) {
																																																																																						entity1 = stk1.nextElement().toString();
																																																																																						System.out.println("entity:-" + entity1);
																																																																																										//db();			   	          
																																																																																						     	
																																																																																						if (stk1.hasMoreTokens()) {
																																																																																							status1 = stk1.nextElement().toString();
																																																																																							System.out.println("status:-" + status1);
																																																																																							// System.out.println("notes---"+notes);
																																																																																							//  System.out.println("wallet---"+wallet);
																																																																																							//  wallet=wallet.substring(9, wallet.length());
																																																																																							 // System.out.println("wallet1---"+wallet);

																																																																																							//  cancelled_at=cancelled_at.substring(25, cancelled_at.length()-2);
																																																																																							//  System.out.println("cancelled_at---"+cancelled_at);
																																																																																							  
																																																																																							 // date=date.substring(6, date.length());
																																																																																							//  System.out.println("date---"+date);
																																																																																							  
																																																																																							 // tax_amount=tax_amount.substring(15, tax_amount.length()-1);
																																																																																							 // System.out.println("tax_amount---"+tax_amount);
																																																																																							  
																																																																																							 // amount_paid=amount_paid.substring(13, amount_paid.length());
																																																																																							 // System.out.println("amount_paid1---"+amount_paid); 
																																																																																							  
																																																																																							 // partial_payment=partial_payment.substring(18, partial_payment.length());
																																																																																							 // System.out.println("partial_payment---"+partial_payment); 
																																																																																							  
																																																																																							  sms_status=sms_status.substring(14, sms_status.length()-1);
																																																																																							  System.out.println("sms_status---"+sms_status); 
																																																																																							  
																																																																																							  description=description.substring(15, description.length()-1);
																																																																																							  System.out.println("description---"+description); 
																																																																																							  
																																																																																							  short_url=short_url.substring(13, short_url.length()-1);
																																																																																							  System.out.println("short_url---"+short_url); 
																																																																																							  
																																																																																							  customer_name=customer_name.substring(17, customer_name.length()-1);
																																																																																							  System.out.println("customer_name---"+customer_name); 
																																																																																							  
																																																																																							  email=email.substring(9, email.length()-1);
																																																																																							  System.out.println("email---"+email);
																																																																																							  
																																																																																							 // currency=currency.substring(12, currency.length()-1);
																																																																																							 // System.out.println("currency---"+currency);
																																																																																							  
																																																																																							  id=id.substring(13, id.length()-1);
																																																																																							  System.out.println("id1---"+id);
																																																																																							  
																																																																																							 // international=international.substring(16, international.length());
																																																																																							 // System.out.println("international1---"+international);
																																																																																							  
																																																																																							  //email=email.substring(9, email.length()-1);
																																																																																							  //System.out.println("email1---"+email);
																																																																																							  
																																																																																							  gross_amount=gross_amount.substring(15, gross_amount.length());
																																																																																							  System.out.println("gross_amount---"+gross_amount);
																																																																																							  
																																																																																							  
																																																																																							  
																																																																																							  
																																																																																							  
																																																																																							  expire_by=expire_by.substring(12, expire_by.length());
																																																																																							  System.out.println("expire_by---"+expire_by);
																																																																																							  long expirydate = Long.parseLong(expire_by);
																																																																																							  Date date1 = new Date(expirydate*1000L); 
																																																																																							   // format of the date
																																																																																							   SimpleDateFormat jdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
																																																																																							   jdf.setTimeZone(TimeZone.getTimeZone("GMT-4"));
																																																																																							   String Expiry_date = jdf.format(date1);
																																																																																							   System.out.println("\n"+Expiry_date+"\n");
																																																																																							  
																																																																																							  customer_contact=customer_contact.substring(20, customer_contact.length()-2);
																																																																																							  System.out.println("customer_contact---"+customer_contact);
																																																																																							  
																																																																																							//  method=method.substring(10, method.length()-1);
																																																																																							//  System.out.println("method1---"+method);
																																																																																							 
																																																																																							//  vpa=vpa.substring(6, vpa.length());
																																																																																							//  System.out.println("vpa1---"+vpa);
																																																																																							  
																																																																																							//  tax=tax.substring(6, tax.length());
																																																																																							//  System.out.println("tax1---"+tax);
																																																																																							  
																																																																																							//  card_id=card_id.substring(10, card_id.length());
																																																																																							//  System.out.println("card_id1---"+card_id);
																																																																																							  
																																																																																							//  error_code=error_code.substring(14, error_code.length()-1);
																																																																																							//  System.out.println("error_code1---"+error_code);
																																																																																							  
																																																																																							//  order_id=order_id.substring(11, order_id.length());
																																																																																							 // System.out.println("order_id1---"+order_id);
																																																																																							  
																																																																																							//  entity=entity.substring(10, entity.length()-1);
																																																																																							//  System.out.println("entity1---"+entity);
																																																																																							  
																																																																																							//  status=status.substring(10, status.length()-2);
																																																																																							 // System.out.println("status1---"+status);
																																																																																							  
																																																																																							  
																																																																																							  
																																																																																							 
																																																																																									//int k=0;
																																																																																									try
																																																																																									{
																																																																																										
																																																																																										
																																																																																										
																																																																																										String paylink="";
																																																																																										String expirydate1="";
																																																																																										
																																																																																										
																																																																																										String query2="select * from db_GlobalERP."+CompanyMasterID+"PayLinkDetails where invoice_id='"+description+"' and expire_by >= '"+Expiry_date+"' and short_url='"+short_url+"'";
																																																																																										  System.out.println("query2-----"+query2);

																																																																																											ResultSet rs7=st.executeQuery(query2);
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
																																																																																											else{
																																																																																												
																																																																																												
																																																																																											
																																																																																										System.out.println("Inside createTable()");
																																																																																										//String query1 = "create table IF NOT EXISTS t_config (Id int auto_increment primary key, Email varchar(100) not null, Pass varchar(100) not null, HostName varchar(100) unique, StopTime int not null, NoOfMails int not null)";
																																																																																										//String query = "create table IF NOT EXISTS t_paymentdetails like smartgrid.t_paymentde";
																																																																																											
																																																																																											
																																																																																									/*	PreparedStatement ps = (PreparedStatement) con1.prepareStatement(query);
																																																																																										int i=ps.executeUpdate();
																																																																																										*/
																																																																																										
																																																																																										
																																																																																										System.out.println("Connectivity----------------"+con1);
																																																																																									//	PreparedStatement psI = (PreparedStatement) con1.prepareStatement("insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"PayLinkDetails (invoice_id, short_url, customer_name, email, customer_contact,amount,expire_by) values (?,?,?,?,?,?,?)");// ("+username+","+password+","+host+","+interval+","+k+")");
																																																																																									
																																																																																										String insertquery="insert into db_GlobalERP."+CompanyMasterID+"PayLinkDetails (invoice_id, short_url, customer_name, email, customer_contact,amount,expire_by) values ('"+description+"','"+short_url+"','"+customer_name+"','"+email+"','"+customer_contact+"','"+gross_amount+"','"+Expiry_date+"')";
																																																																																										
																																																																																										
																																																																																										/* psI.setString(1, description);
																																																																																										psI.setString(2, short_url);
																																																																																										psI.setString(3, customer_name);
																																																																																										psI.setString(4, email);
																																																																																										psI.setString(5, customer_contact);
																																																																																										psI.setString(6, gross_amount);
																																																																																										psI.setString(7, Expiry_date);
																																																																																										
																																																																																									
																																																																																										int iI=psI.executeUpdate();
																																																																																										System.out.println("Value Inserted into t_config : "+iI); */
																																																																																										
																																																																																										
																																																																																										//
																																																																																										%>
`
																																																																																									<input type="hidden" id="link" name="link" value=<%=short_url%>/>
																																																																																									<input type="hidden" id="exdate" name="exdate" value=<%=Expiry_date%>/>
																																																																																									<% 
																																																																																									


													

																																																																																										//con1.close();
																																																																																										System.out.println("Value Inserted into t_config Before : "+insertquery); 
																																																																																										myst.executeUpdate(insertquery);
																																																																																										System.out.println("Value Inserted into t_config : "+insertquery);
																																																																																										
																																																																																										out.println("<script>  Redirect5();</script>");
																																																																																									}
																																																																																									}
																																																																																							  
																																																																																									catch(Exception e)	
																																																																																									{
																																																																																										System.out.println("Duplicate Url Entry.."+e.toString());
																																																																																										e.printStackTrace();
																																																																																										out.println("<script>  Redirect1();</script>");
																																																																																										// out.println("<script>  Redirect4();</script>");

																																																																																										
																																																																																									}																																																																																							     	
																																																																																														   	         }						   
																																																																																													   	     }						   
																																																																																										}
																																																																																											   	         }
																																																																																										   	         }
																																																																																									   	         }
																																																																																	     	
																																																																																								   	         }	
																																																																																     	
																																																																																							   	         }		
																																																																																						   	     }							   	
																																																																													
																																																																																				}
																																																																													     	
																																																																																				   	         }
																																																																																			   	         }
																																																																																		   	         }   	
																																																																																	   	   
																																																																									
																																																																																}
																																																																																   	         }
																																																																															   	         }
																																																																														   	         }
																																																																						     	
																																																																													   	         }  
																																																																												   	         }     	    	
																																																																											   	         }     	    	
																																																																										   	         }   	    	
																																																																									   	         }   	    	
																																																																								   	         }
																																																																											}
																																																																							   	         } 
																																																																										}
																																																																						   	         }   	
																																																																					   	         }         	
																																																																				   	         }         
																																																																		   	    	
																																																																		   	         }	   	
																																																																   	         }	 	
																																																														   	         }	    	
																																																												   	         }	   	    	
																																																										   	         }
																																																   	         }
																																							   	         }
																															   	         }
																								   	         }
																		   	         }
													   	         }
									   	    	
									   	         }
						   	         }
				   	    	
				   	         }
			   	    	
			   	         }
			    	
			         }
				  
				  
					
				//  System.out.println("payments="+payemntRequest);

				 // JSON.stringify({});  
				 // JSON.parse('{"foo" : 1, }');
				  
				 
				} catch (RazorpayException e) {
				  // Handle Exception 
				    System.out.println(e.getMessage());
				    out.println("<script>  Redirect1();</script>");
				}

				
			
			
		 
	 

	
	
	
	
	
	
	
	
	
	


		

%>


</body>
</html>
</jsp:useBean>