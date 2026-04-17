<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="conn.jsp"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<html>


<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

</head>
<script>


function Redirect()
{	
	
	//var a=document.getElementById("rupees").value;
	//alert(a);
//	alert("Invoice Created Successfully ");
	
  //  window.location="ASCPendingInvoiceReport.jsp";
    
    var GrandTotal=document.getElementById("GrandTotal").value;
	  
	  var GST=document.getElementById("GST").value;
	  
	  var Code=document.getElementById("Code").value;
	  var invoicerefno=document.getElementById("InvoiceRefNo").value;

    window.location="ASCInvoiceConfirm.jsp?GrandTotal="+GrandTotal+"&GST="+GST+"&Code="+Code+"&invoicerefno="+invoicerefno+"";
}

function Redirect1()
{
	alert("ERROR While Creating Invoice ..........!!");
    window.location="ASCPendingInvoiceReport.jsp";
	
}
function Redirect3()
{
	
		alert("Add ERPCode Using ADD/EDIT Transporter");
		window.location="ASCPendingInvoiceReport.jsp";
		
}
</script>
<body>

<%
		erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
	%>
	<%
		Connection conn = null;
		Statement st = null, st1 = null, st3 = null, st4 = null,st5=null;
		Statement st2 = null,st6 = null,st7 = null,st8 = null;
		String BillFrom="" ,BillTo="" , Vehicle="",selectyear="",CustomerERPCode="",ERPCustName="";
		String CustomerCode="",CompanyName="",ContactPerson="",BillingCity="",BillingZip="",BillingAddress="",MobileNo="",BillingState="",Invoicerefno="";
		String Despatchmode = "Surface";
		String FreightType = "",paymentMode = "",Insurance= "",CurrType = "",invoicetype = "",InvoiceRaisedby="",BillingCountry="",BillingFax="";
		String InviceNo="";
		String ShippingState="",BillingGSTIN="",ShippingGSTIN="";
				
		
		
		try {
			conn = erp.ReturnConnection();
			st = conn.createStatement();
			st1 = conn.createStatement();
			st2 = conn.createStatement();
			st3 = conn.createStatement();
			st4 = conn.createStatement();
			st5 = conn.createStatement();
			st6 = conn.createStatement();
			st7 = conn.createStatement();
			st8 = conn.createStatement();
		} catch (Exception e) {
		}
	%>
<%

try
{
int currentmonthcount=0,currentyearcount=0;
int previousmonth=0, ppreviousmonth=0;
int previousyear=0, ppreviousyear=0;
String finalmonth="";
String currentyear="", fppreviousmonth = "";
String sql = null;
String fpreviousmonth="";

//Date tdy = new java.util.Date();
String todaysDate = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());


System.out.println("todaysdate is"+todaysDate);
String currentmonth="select MONTH('"+todaysDate+"')";
System.out.println("Current Month --------->"+currentmonth);

java.util.Date date= new java.util.Date();

String time=new SimpleDateFormat("HH:mm:ss").format(new java.util.Date());
System.out.println("time---------"+time);

ResultSet rsMonth=st1.executeQuery(currentmonth);
rsMonth.next();
currentmonthcount=rsMonth.getInt(1);
System.out.println("currentmonthcount is"+currentmonthcount);

if(currentmonthcount==1 || currentmonthcount==2 || currentmonthcount==3 || currentmonthcount==4 || currentmonthcount==5 || currentmonthcount==6 || currentmonthcount==7 || currentmonthcount==8 || currentmonthcount==9 )
//if(currentmonthcount==1)
{
finalmonth="0"+currentmonthcount;
}
else if(currentmonthcount==10 || currentmonthcount==11 || currentmonthcount==12)
{
finalmonth=Integer.toString(currentmonthcount);
}		

System.out.println("final month is "+finalmonth);

currentyear="select YEAR('"+todaysDate+"')";
System.out.println(currentyear);
ResultSet rsYear=st1.executeQuery(currentyear);
rsYear.next();
currentyearcount=rsYear.getInt(1);

System.out.println("currentyearcount is "+currentyearcount);  

if(currentmonthcount==1)
{
previousyear=currentyearcount-1;
previousmonth=12;

//	currentmonthcount=12;
}
else 
{
previousyear=currentyearcount;
System.out.println("finalmonth is "+finalmonth);
previousmonth=Integer.parseInt(finalmonth)-1;
System.out.println("previousmonth is  "+previousmonth);
}
if(previousmonth==1 || previousmonth==2 || previousmonth==3 || previousmonth==4 || previousmonth==5 || previousmonth==6 || previousmonth==7 || previousmonth==8 || previousmonth==9 )
	//if(previousmonth==1)
	{
		fpreviousmonth="0"+Integer.toString(previousmonth);
	}
	else if(previousmonth==10 || previousmonth==11 || previousmonth==12)
	{
		fpreviousmonth=Integer.toString(previousmonth);
	}

/************************************************************************/
if(previousmonth==1)
{
	ppreviousyear=previousyear-1;
	ppreviousmonth=12;
    
	//	currentmonthcount=12;
}
else 
{
	ppreviousyear=previousyear;
	System.out.println("final previous month is  "+fpreviousmonth);
	ppreviousmonth=Integer.parseInt(fpreviousmonth)-1;
	System.out.println("pprevious month is  "+ppreviousmonth);
}
if(ppreviousmonth==1 || ppreviousmonth==2 || ppreviousmonth==3 || ppreviousmonth==4 || ppreviousmonth==5 || ppreviousmonth==6 || ppreviousmonth==7 || ppreviousmonth==8 || ppreviousmonth==9 )
	//if(previousmonth==1)
	{
		fppreviousmonth="0"+Integer.toString(ppreviousmonth);
	}
	else if(ppreviousmonth==10 || ppreviousmonth==11 || ppreviousmonth==12)
	{
		fppreviousmonth=Integer.toString(ppreviousmonth);
	}

 //selectyear=currentyearcount+"_"+"0"+previousmonth;

 
 selectyear=currentyearcount+"_"+fppreviousmonth;
 
 System.out.println("-----Selected Year--"+selectyear);
 

 NumberFormat nf = new DecimalFormat("#0.00");
String  Total=request.getParameter("Total");
double total=Double.parseDouble(Total);
total=Math.round(total);

String GrandTotal=request.getParameter("GrandTotal");

double grandtotal=Double.parseDouble(GrandTotal);
grandtotal=Math.round(grandtotal);

String TotalInWords=request.getParameter("Rupees");

String Id=request.getParameter("id");
String Company=request.getParameter("company");

System.out.println("---Total----"+Total+"---GrandTotal-----"+GrandTotal+"-----Id-----"+Id+"-----Company----------"+Company+"------In Words--------"+TotalInWords);

String BillDate="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ASCSummaryDetails where SRNumber='"+Id+"' and Ownername='"+Company+"'";

ResultSet rs=st.executeQuery(BillDate);
System.out.println("Bilform Query ------->"+BillDate);
if(rs.next())
{
	BillFrom=rs.getString("Amcfromdate");
	BillTo=rs.getString("Amctodate");
}

String VehicleList="select group_concat(distinct(vehiclenumber)) as VehicleRegNo from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"VehASCSummaryDetails where ownername like '%"+Company+"%'  and itemcode is not NULL and billfrom='"+BillFrom+"' and billto='"+BillTo+"'";
ResultSet rs1=st.executeQuery(VehicleList);



System.out.println("---Vehicle List----"+VehicleList);
String ItemCode="";
if(rs1.next())
{
	Vehicle=rs1.getString("VehicleRegNo");
	//ItemCode=rs1.getString("itemcode");
}

System.out.println("---Vehicle List----"+Vehicle);

//System.out.println("---ItemCode----"+ItemCode);

//String ERPCode="select *  from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+selectyear+" where Transporter='"+Company+"' limit 1";

String ERPCode="select ERPCode from db_gps.t_transporter where TypeValue='"+Company+"' limit 1";
ResultSet rs3=st.executeQuery(ERPCode);

System.out.println("---FVERP List----"+ERPCode);

if(rs3.next())
{
	CustomerERPCode=rs3.getString("ERPCode");
	//ERPCustName=rs3.getString("ERPCustName");
}
else
{
	out.println("<script>  Redirect3();</script>");
}



System.out.println("---ERP Code----"+CustomerERPCode);

String Address="select concat(phone,',',fax,',',emailid,',',website) as InvRaisedConDet , State,godownaddress ,Companyname from db_GlobalERP.CompanyMaster  limit 1";
ResultSet rs6=st2.executeQuery(Address);

rs6.next();
String InvRaisedConDet=rs6.getString("InvRaisedConDet");

String godownaddress=rs6.getString("godownaddress");

String Companyname=rs6.getString("Companyname");

String State=rs6.getString("State");

System.out.println("-----Invoice------------"+InvRaisedConDet+"------godownaddress----------"+godownaddress);



String CustomerDet="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerdet where CustomerCode='"+CustomerERPCode+"' ";
ResultSet rs4=st1.executeQuery(CustomerDet);

System.out.println("---Customerdet----"+CustomerDet);

if(rs4.next())
{
	        CustomerCode=rs4.getString("CustomerCode");
			MobileNo=rs4.getString("MobileNo");
			CompanyName=rs4.getString("CompanyName");
			BillingState=rs4.getString("BillingState");
			ShippingState=rs4.getString("ShippingState");
			BillingGSTIN=rs4.getString("BillingGSTN");
			ShippingGSTIN=rs4.getString("ShippingGSTN");
			ContactPerson=rs4.getString("ContactPerson");
			BillingCity=rs4.getString("BillingCity");
			BillingZip=rs4.getString("BillingZip");
			BillingAddress=rs4.getString("BillingAddress");
			BillingCountry=rs4.getString("BillingCountry");
					BillingFax=rs4.getString("BillingFax");		
			        Despatchmode = "Surface";
					FreightType = "Collect(To Pay)";
					paymentMode = "Advance";
					Insurance   = "Ins Cert Enclosed";
					CurrType = "Rupees";
					invoicetype = "ASCInvoice";
					InvoiceRaisedby ="Transworld Technologies Ltd.C-3/8,Rakshalekha,KoregaonPark,Pune-411001";
					
					
					
					
					
}

System.out.println("-----InvoiceRefno------------");


String invoicerefno="select concat( concat('SI',day(curdate()),month(curdate()),year(curdate())),count(invoiceno)+1) as invoicerefno from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"invoicedet where  date(invoicedate)='"+todaysDate+"' ";
System.out.println("-----InvoiceRefno------------"+invoicerefno);
ResultSet rs5=st2.executeQuery(invoicerefno);

rs5.next();
Invoicerefno=rs5.getString("invoicerefno");

System.out.println("-----InvoiceRefno------------"+Invoicerefno);

String Invoice="select (max(invoiceno)+1) as invoiceno from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"invoicedet";
ResultSet rs7=st3.executeQuery(Invoice);

System.out.println("-----Insert Query-------Invoice-----"+Invoice);
rs7.next();
InviceNo=rs7.getString("invoiceno");
String invoicetype1 = "ASCInvoice";
String Terms="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"TermsMaster where InvoiceType='"+invoicetype1+"'";
ResultSet rs9=st3.executeQuery(Terms);
System.out.println("-----Insert Query-------Invoice--Terms---"+Terms);

rs9.next();
String terms=rs9.getString("terms");


String InsertInvoice="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"invoicedet (invoiceno,BillingGSTIN,ShippingGSTIN,CustomerCode,InvoiceDate,thegroup,terms,Despatchmode,FreightType,paymentMode,Insurance,ShipmentDate,InvoiceCancelled,InvoiceTime,InvoiceRaisedby,CurrType,TWEmpName,companyname,ContactPerson,Address,City,zip,state,country,phone,fax,invoicerefno,invoicetype,InvRaisedBillAdd,InvRaisedShipAdd,InvRaisedConDet,InvRaisedCompName) values ('"+InviceNo+"','"+BillingGSTIN+"','"+ShippingGSTIN+"','"+CustomerCode+"','"+todaysDate+"','3','"+terms+"','"+Despatchmode+"','"+FreightType+"','"+paymentMode+"','"+Insurance+"','"+todaysDate+"','0','"+time+"','"+InvoiceRaisedby+"','"+CurrType+"','"+session.getAttribute("EmpName")+"','"+CompanyName+"','"+ContactPerson+"','"+BillingAddress+"','"+BillingCity+"','"+BillingZip+"','"+BillingState+"','"+BillingCountry+"','"+MobileNo+"','"+BillingFax+"','"+Invoicerefno+"','"+invoicetype+"','"+godownaddress+"','"+godownaddress+"','"+InvRaisedConDet+"','"+Companyname+"')";

System.out.println("-----Insert Query------------"+InsertInvoice);
st1.executeUpdate(InsertInvoice);

System.out.println("-----Insert Query------------"+InsertInvoice);

String Sales_InvItem="";


//String ItemCodeList="select group_concat(distinct(itemcode)) as itemcode from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"VehASCSummaryDetails where ownername='"+Company+"'  and itemcode is not NULL and billfrom='"+BillFrom+"' and billto='"+BillTo+"'";



String invoice="",thegroup="",make="",itemcode="",quantity="",sellingprice="",TheTableToBeAccessed="",stpercent="",itemdescription="";

/* String InvoiceNO="select (max(invoiceno)+1) as invoiceno from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"salesinv_items";
ResultSet rs9=st3.executeQuery(InvoiceNO);

rs9.next();
String InviceNo1=rs9.getString("invoiceno");

System.out.println("-----Invoice ItemCode InviceNo1------------"+InviceNo1); */

String ItemCodeList="select (select (max(invoiceno)+1) from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"salesinv_items ) as invoice,3 as thegroup,26 as make,a.itemcode,sum(days)as quantity,format (sellingprice,2) as sellingprice,'"+session.getAttribute("CompanyMasterID").toString()+"tbl_digitim_make26'as TheTableToBeAccessed,case when itemcode=2643 then 1 when itemcode=2644 then 11 when itemcode=2645 then 21 end as itemsrno,15 as stpercent,itemdescription from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"VehASCSummaryDetails a where ownername='"+Company+"'  and itemcode is not NULL and Amcfromdate='"+BillFrom+"' and Amctodate='"+BillTo+"' and InvoiceStatus='-' and InvoiceRefNo='-' group by itemdescription";
System.out.println("-----Invoice ItemCode List------------"+ItemCodeList);
ResultSet rs8=st2.executeQuery(ItemCodeList);
double CGSTRate=0.00;
double cgsttax=0.00;
double SGSTRate=0.00;
double sgsttax=0.00;
double IGSTRate=0.00;
double igsttax=0.00;
double GST=0.00;
double taxableamount=0.00;
double totaltaxableamount=0.00;
double TotCGSTValue=0.00;
double TotSGSTValue=0.00;
double TotIGSTValue=0.00;
double TotGST=0.00;
double TotAmount=0.00;
while(rs8.next())
{
	//invoice=rs8.getString("invoice");
	thegroup=rs8.getString("thegroup");
	make=rs8.getString("make");
	itemcode=rs8.getString("itemcode");
	quantity=rs8.getString("quantity");
	sellingprice=rs8.getString("sellingprice");
	TheTableToBeAccessed=rs8.getString("TheTableToBeAccessed");
	stpercent=rs8.getString("stpercent");
	itemdescription=rs8.getString("itemdescription");
	
	
	String dynamicitem="select ItemCode,SACCode,HSNCode,Description,ServiceCategory  from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"searchitems  where ItemCode='"+itemcode+"' and ServiceCategory!='-' ";
	
	ResultSet rsdynamicitem=st6.executeQuery(dynamicitem);
	
	String desc="";
	double rate=0.00;
	String TaxCategory="";
	String TaxCode="";
	if(rsdynamicitem.next())
	{
		TaxCode=rsdynamicitem.getString("SACCode");
		TaxCategory=rsdynamicitem.getString("ServiceCategory");
	//	rate=rsdynamicitem.getDouble("TaxRate");
		desc=rsdynamicitem.getString("Description");
		//desc="Monthly Subscription Charge - Mobile Eye Standard";
	}
	
	String dynamictaxrate="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"GSTINRateMaster where Code='"+TaxCode+"' and Category='"+TaxCategory+"' ";
	
	ResultSet rsdynamictaxrate=st7.executeQuery(dynamictaxrate);
	
	if(rsdynamictaxrate.next())
	{
		rate=rsdynamictaxrate.getDouble("TaxRate");
	}
	
	
	
	if(ShippingState.equals(" "))
	{
		if(BillingState.equals(State))
		{
			 CGSTRate=rate/2;
			 
			 SGSTRate=rate/2;
			 
			 IGSTRate=0.00;
			 
			 taxableamount=Double.parseDouble(sellingprice)*Double.parseDouble(quantity);
			 
			   cgsttax=taxableamount*CGSTRate/100;
		       sgsttax=taxableamount*SGSTRate/100;
		       igsttax=taxableamount*IGSTRate/100;
		       
		       System.out.println(" cgstamt:- "+cgsttax);
		       System.out.println(" sgstamt:- "+sgsttax);
		       System.out.println(" igstamt:- "+igsttax);
		      
		      double totamt=taxableamount+cgsttax+sgsttax+igsttax;
		      
		      
		      
			 
			 
			  System.out.println(" totamt:- "+totamt);
			  
			   TotCGSTValue=TotCGSTValue+cgsttax;
			  TotSGSTValue=TotSGSTValue+sgsttax;
			  TotIGSTValue=TotIGSTValue+igsttax;
			  
			 System.out.println("TotCGSTValue" +TotCGSTValue);
			 System.out.println("TotSGSTValue" +TotSGSTValue);
			 System.out.println("TotIGSTValue" +TotIGSTValue);
		}
		else{
			IGSTRate=rate;
			
			taxableamount=Double.parseDouble(sellingprice)*Double.parseDouble(quantity);
			 
			   cgsttax=taxableamount*CGSTRate/100;
		      sgsttax=taxableamount*SGSTRate/100;
		      igsttax=taxableamount*IGSTRate/100;
		      
		      System.out.println(" cgstamt:- "+cgsttax);
		       System.out.println(" sgstamt:- "+sgsttax);
		       System.out.println(" igstamt:- "+igsttax);
		      
		      double totamt=taxableamount+cgsttax+sgsttax+igsttax;
		      
		      totaltaxableamount=totaltaxableamount+totamt;
		      
			  System.out.println(" totamt:- "+totamt);
			  TotCGSTValue=TotCGSTValue+cgsttax;
			  TotSGSTValue=TotSGSTValue+sgsttax;
			  TotIGSTValue=TotIGSTValue+igsttax;
			  System.out.println("TotCGSTValue" +TotCGSTValue);
				 System.out.println("TotSGSTValue" +TotSGSTValue);
				 System.out.println("TotIGSTValue" +TotIGSTValue);
			 
		}
	}
	else
	{
		if(ShippingState.equals(State))
		{
			 CGSTRate=rate/2;
			 
			 SGSTRate=rate/2;
			 
			 IGSTRate=0.00;
			 
			 taxableamount=Double.parseDouble(sellingprice)*Double.parseDouble(quantity);
			 
			   cgsttax=taxableamount*CGSTRate/100;
		       sgsttax=taxableamount*SGSTRate/100;
		       igsttax=taxableamount*IGSTRate/100;
		      
		       System.out.println(" cgstamt:- "+cgsttax);
		       System.out.println(" sgstamt:- "+sgsttax);
		       System.out.println(" igstamt:- "+igsttax);
		       
		      double totamt=taxableamount+cgsttax+sgsttax+igsttax;
		      
		      totaltaxableamount=totaltaxableamount+totamt;
		      
			  System.out.println(" totamt:- "+totamt);
			  TotCGSTValue=TotCGSTValue+cgsttax;
			  TotSGSTValue=TotSGSTValue+sgsttax;
			  TotIGSTValue=TotIGSTValue+igsttax;
			  
			  System.out.println("TotCGSTValue" +TotCGSTValue);
				 System.out.println("TotSGSTValue" +TotSGSTValue);
				 System.out.println("TotIGSTValue" +TotIGSTValue);
			 
		}
		else{
			IGSTRate=rate;
			
			taxableamount=Double.parseDouble(sellingprice)*Double.parseDouble(quantity);
			 
			  cgsttax=taxableamount*CGSTRate/100;
		       sgsttax=taxableamount*SGSTRate/100;
		       igsttax=taxableamount*IGSTRate/100;

		       System.out.println(" cgstamt:- "+cgsttax);
		       System.out.println(" sgstamt:- "+sgsttax);
		       System.out.println(" igstamt:- "+igsttax);
		       
		       
		      double totamt=taxableamount+cgsttax+sgsttax+igsttax;
		      
		      totaltaxableamount=totaltaxableamount+totamt;
		      
			  System.out.println(" totamt:- "+totamt);
			  System.out.println("TotCGSTValue" +TotCGSTValue);
				 System.out.println("TotSGSTValue" +TotSGSTValue);
				 System.out.println("TotIGSTValue" +TotIGSTValue);
			  
		}
		
		
	}
	
	
	
//	String InsertSales="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"salesinv_items (InvoiceNo,thegroup,make,itemcode,quantity,sellingprice,TheTableToBeAccessed,stpercent,itemdescription) values ('"+InviceNo+"','"+thegroup+"','"+make+"','"+itemcode+"','"+quantity+"','"+sellingprice+"','"+TheTableToBeAccessed+"','"+stpercent+"','"+itemdescription+"') ";

	String InsertSales="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"salesinv_items (InvoiceNo,thegroup,make,itemcode,quantity,sellingprice,TheTableToBeAccessed,itemdescription,SACCode,CGSTRate,CGSTValue,SGSTRate,SGSTValue,IGSTRate,IGSTValue) values ('"+InviceNo+"','"+thegroup+"','"+make+"','"+itemcode+"','"+quantity+"','"+sellingprice+"','"+TheTableToBeAccessed+"','"+itemdescription+"','"+TaxCode+"','"+nf.format(CGSTRate)+"','"+nf.format(cgsttax)+"','"+nf.format(SGSTRate)+"','"+nf.format(sgsttax)+"','"+nf.format(IGSTRate)+"','"+nf.format(igsttax)+"')";;

	System.out.println("-----Insert Query Sales------------"+InsertSales);
	
	st1.executeUpdate(InsertSales);
	
	System.out.println("-----Insert Query Sales------------"+InsertSales);
}

//TotGST=TotCGSTValue+TotSGSTValue+TotIGSTValue;
TotAmount=totaltaxableamount;
TotAmount=Math.round(TotAmount);
String GSTName="GST";

System.out.println("totaltaxableamount :- "+totaltaxableamount);
/* System.out.println("TotCGSTValue :- "+cgsttax);
System.out.println("TotSGSTValue :- "+sgsttax);
System.out.println("TotIGSTValue :- "+igsttax); */
System.out.println("TotGST :- "+TotGST);
System.out.println("TotAmount :- "+TotAmount);

String updategsttax="update "+session.getAttribute("CompanyMasterID").toString()+"invoicedet set CGSTValue='"+nf.format((Math.round(TotCGSTValue)))+"' , SGSTValue='"+nf.format((Math.round(TotSGSTValue)))+"' ,IGSTValue='"+nf.format((Math.round(TotIGSTValue)))+"' ,Total ='"+nf.format(TotAmount)+"' , GrandTotal='"+nf.format(TotAmount)+"' where invoiceRefNo='"+Invoicerefno+"' ";

System.out.println("Invoice Update :- "+updategsttax);

st7.executeUpdate(updategsttax);

grandtotal=Math.round(TotAmount);

int transactionId;
String transactionNo="select MAX(TransactionId) from "+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount";
ResultSet rsNo=st2.executeQuery(transactionNo);
rsNo.next();
	transactionId=rsNo.getInt(1);
transactionId++;
System.out.println("TRAN   ID   IS "+transactionId);

String sqlBalance1="SELECT * FROM  "+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount where CustomerCode="+CustomerCode+" order by TransactionDate DESC limit 1";

ResultSet rsbalance1=st5.executeQuery(sqlBalance1);
System.out.println("sql"+sqlBalance1);
double balance1 = 0;
//double debitamount1=0;
//double creditamount1=0;
//double transactionid1=0;
if(rsbalance1.next())
{
	//transactionid1=rsbalance.getDouble("transactionid");
	//debitamount1=rsbalance.getDouble("debitamount");
	//creditamount1=rsbalance.getDouble("creditamount");
	balance1=rsbalance1.getDouble("Balance");
	balance1=grandtotal+balance1;
									
}
else{
	balance1=0.00;	
}



String Ledger="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount(TransactionId,CustomerCode,TransactionType,TransactionDetail,TransactionDate,DebitAmount,CreditAmount,Balance,EmpName,PaymentVoucherNo,DebitParty,CreditParty) values('"+transactionId+"','"+CustomerCode+"','Invoice','"+Invoicerefno+"','"+todaysDate+"','"+nf.format(grandtotal)+"','0','"+nf.format(balance1)+"','"+session.getAttribute("EmpName")+"','-','"+Company+"','Sales Account')";

st1.executeUpdate(Ledger);

System.out.println("-----Insert Query Ledger------------"+Ledger);


String UpdateVehASCMaster="update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"VehASCSummaryDetails set InvoiceStatus='Invoiced' , InvoiceRefNo='"+Invoicerefno+"' where Amcfromdate='"+BillFrom+"' and Amctodate='"+BillTo+"' and Ownername='"+Company+"' and InvoiceStatus='-' ";

st1.executeUpdate(UpdateVehASCMaster);
System.out.println("Update ASC master----->"+UpdateVehASCMaster);

String CID=session.getAttribute("CompanyMasterID").toString();
//String year=""+currentyearcount;
//String month=""+ppreviousmonth;
//selectyear=currentyearcount+"_"+"0"+ppreviousmonth;   //prevoius month:- fpreviousmonth
//String Annexure="Select "+CID+"billingdetails"+currentyearcount+"_"+fpreviousmonth+".VehRegno,instdate,TotalYes as CapturedDays ,TotalYesStar,TotalYes+TotalYesStar as TotalStar from "+CID+"billingdetails"+currentyearcount+"_"+fpreviousmonth+"  ,"+CID+"fv_erp_relation"+currentyearcount+"_"+fpreviousmonth+"  where "+CID+"billingdetails"+currentyearcount+"_"+fpreviousmonth+".vehid="+CID+"fv_erp_relation"+currentyearcount+"_"+fpreviousmonth+".vehid and "+CID+"fv_erp_relation"+currentyearcount+"_"+fpreviousmonth+".ERPCode='"+CustomerCode+"'  and "+CID+"billingdetails"+currentyearcount+"_"+fpreviousmonth+".BillTransporter='Yes' and "+CID+"fv_erp_relation"+currentyearcount+"_"+fpreviousmonth+".BillTransporter='Yes' and month1='"+currentyearcount+"-"+fpreviousmonth+"-01'";

String Annexure="select vehicleNumber,installeddate,warrenty,amccovered,Amcfromdate,Amctodate,days,format(age,2) as age,format(rate,2) as rate,format(amount,2) as amount,sellingprice,ItemDescription,Ownername  from  db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"VehASCSummaryDetails where Amcfromdate='"+BillFrom+"' and Amctodate='"+BillTo+"' and Ownername='"+Company+"' and InvoiceStatus='Invoiced' and itemcode is not null";
System.out.println("-----Annexure Select Query------------"+Annexure);
ResultSet rs10=st3.executeQuery(Annexure);

System.out.println("-----Annexure Select Query------------"+Annexure);

String todaysDate1 = new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
String VehRegNo="",instdate="",warranty="",ASCCovered="",Ownername="",ASCBillFrom="",ASCBillTo="",Days="",Age="",Rate="",Amount="",RatePerDay="",Description="";

while(rs10.next())
{
	VehRegNo=rs10.getString("vehicleNumber");
	instdate=rs10.getString("installeddate");
	warranty=rs10.getString("warrenty");
	//ASC=rs10.getString("amccovered");
	ASCBillFrom=rs10.getString("Amcfromdate");
	ASCBillTo=rs10.getString("Amctodate");
	Days=rs10.getString("days");
	Age=rs10.getString("age");
	Rate=rs10.getString("rate");
	Amount=rs10.getString("amount");
	RatePerDay=rs10.getString("sellingprice");
	Description=rs10.getString("ItemDescription");
	ASCCovered=rs10.getString("amccovered");
	Ownername=rs10.getString("Ownername");
	//System.out.println("-----Annexure Select Query------------"+VehRegNo+"*******"+instdate+"*********"+CapturedDays+"**********"+TotalYesStar+"*********"+Total1);
	
	
	//insert into db_GlobalERP.ASCAnnexureMaster(VehRegNo,InstDt,insertDate,EntryBy,invoiceno,invoicetype,
			// Warranty,ASCBillFrom,ASCBillTo,Days,Age,Rate,Amount,RatePerDay,Decsription)
	//('"+VehRegNo+"','"+instdate+"','"+todaysDate+"','"+session.getAttribute("EmpName")+"','"+invoice+"','"+invoicetype+"','"+warranty+"','"+ASCBillFrom+"',
			// '"+ASCBillTo+"','"+Days+"',,'"+Age+"','"+Ra+te"','"+Amount+"','"+RatePerDay+"','"+Description+"')
			
			
			
	String InsertAnnexure="insert into db_GlobalERP.ASCAnnexureMaster (VehRegNo,InstDt,insertDate,EntryBy,invoiceno,invoicetype,Warranty,ASCBillFrom,ASCBillTo,Days,Age,Rate,Amount,RatePerDay,Description,ASCCovered,Ownername) values('"+VehRegNo+"','"+instdate+"','"+todaysDate+"','"+session.getAttribute("EmpName")+"','"+Invoicerefno+"','"+invoicetype+"','"+warranty+"','"+ASCBillFrom+"','"+ASCBillTo+"','"+Days+"','"+Age+"','"+Rate+"','"+Amount+"','"+RatePerDay+"','"+Description+"','"+ASCCovered+"','"+Ownername+"')";
	st4.executeUpdate(InsertAnnexure);
	System.out.println("-----Annexure Insert Query------------"+InsertAnnexure);
	
	
	
}

String UpdateShortAnnexure="update db_GlobalERP.ASCAnnexureMaster set invoiceno='"+Invoicerefno+"'  where invoicetype='ASCShortSummary' and ASCBillFrom='"+ASCBillFrom+"' and ASCBillTo='"+ASCBillTo+"' and OwnerName='"+Ownername+"' and invoiceno='-' ";

st4.executeUpdate(UpdateShortAnnexure);

System.out.println("-----Annexure Insert Query------------"+UpdateShortAnnexure);



System.out.println("-----Annexure Select Query------------"+VehRegNo+"*******"+instdate);



String id=request.getParameter("id");

String UpdateInvoiceStatus="update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ASCSummaryDetails set InvoiceStatus='Invoiced' ,InvoiceNumber='"+Invoicerefno+"' ,CustomerCode='"+CustomerCode+"' where SRNumber='"+id+"'";

st4.executeUpdate(UpdateInvoiceStatus);

System.out.println("-----Invoice Status Update Query------------"+UpdateInvoiceStatus);


%>

<input type="hidden" id="GrandTotal" name="GrandTotal" value=<%=TotAmount %> />
<input type="hidden" id="Code" name="Code" value=<%=CustomerCode%> />
<input type="hidden" id="InvoiceRefNo" name="InvoiceRefNo" value=<%=Invoicerefno %> />
<input type="hidden" id="GST" name="GST" value=<%=GSTName %> />


<% 

out.println("<script>  Redirect();</script>");
//out.println("Record Inserted Sucessfully");

}
catch(Exception e)
{
	e.printStackTrace();
	out.println("<script>  Redirect1();</script>");
	//out.println("Error While Inserting Records");
}
%>

</body>
</html>
</jsp:useBean>