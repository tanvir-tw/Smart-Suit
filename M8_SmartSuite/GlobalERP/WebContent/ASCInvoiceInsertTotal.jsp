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
	
	alert("Invoice Created Successfully ");
	
    window.location="ASCPendingInvoiceReport.jsp";
    
    
}

function Redirect1()
{
	alert("ERROR While Creating Invoice ..........!!");
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


String TotalInWords=request.getParameter("Rupees");
TotalInWords=TotalInWords.trim();
String Code=request.getParameter("Code");
String invoicerefno=request.getParameter("InvoiceRefNo");

System.out.println("Total :- "+TotalInWords);
System.out.println("Total :- "+Code);
System.out.println("Total :- "+invoicerefno);

String updateinvoice="update "+session.getAttribute("CompanyMasterID").toString()+"invoicedet set TotalInWords='"+TotalInWords+"' where CustomerCode='"+Code+"' and invoiceRefNo='"+invoicerefno+"' ";
st.executeUpdate(updateinvoice);

System.out.println(" updateinvoice:- "+updateinvoice);

out.println("<script>  Redirect();</script>");
}
catch(Exception e)
{
	out.println("<script>  Redirect1();</script>");
	e.printStackTrace();
	
}
%>

</body>
</html>
</jsp:useBean>