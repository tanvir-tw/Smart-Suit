<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict/aaa/EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="header.jsp"%>
<%@ page language="java" import="java.sql.*" import=" java.text.*" import=" java.util.*" errorPage="" 
%>
<%@
page import="javax.*,java.awt.*,

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

<%@page import="com.lowagie.text.Rectangle"%>
<%@page import="javax.swing.GroupLayout.Alignment"%><jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
 
<script src="dropdown.js" type="text/javascript"></script>
<script src="dynamic.js" type="text/javascript"></script>
<script type="text/javascript">
</script>
<body>
	 
<%
	erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
%>
<%
 	Connection conn = null;
 	Statement st = null, st1 = null, st3 = null, st4 = null;
 	Statement st2 = null;
 	String selectedName;
 	String FollowUpType = "";
 	Font cat = new Font();
 	String tgrp="",tmake="",tmodel="";String a="",b="",c="",j="",m="",n="";
%>
<%
 	String fromDateCal = "", toDateCal = "", sql = "";
 	String todaysTime = new SimpleDateFormat(" HH:mm:ss")
 				.format(new java.util.Date());

 	Date tdy = new Date();
 	Date tomorrow = new Date();
 	Calendar cal = Calendar.getInstance();
 	Calendar now = Calendar.getInstance();
 	cal.setTime(tdy);
 	
 	cal.setTime(tdy);
	Date tendays=new Date();
	cal.add(Calendar.DAY_OF_MONTH, +10);
	tendays=cal.getTime();
	String tendaysformat1=new SimpleDateFormat("yyyy-MM-dd").format(tendays);
	String tendaysInMMM=new SimpleDateFormat("dd-MMM-yyyy").format(tendays);
 	
 	String todaysDate = new SimpleDateFormat("dd-MMM-yyyy")
 				.format(tdy);
 	cal.add(Calendar.DAY_OF_MONTH, -1);
 	Date YesterdaysDateAsDate = cal.getTime();
 	String yesterdaysDate = new SimpleDateFormat("dd-MMM-yyyy")
 				.format(YesterdaysDateAsDate);

 	fromDateCal = toDateCal = new SimpleDateFormat("dd-MMM-yyyy")
 				.format(new java.util.Date());
 	DecimalFormat nf=new DecimalFormat("#.##");

 	System.out.println("11111");
 	String customer=request.getParameter("cust");
 	System.out.println(customer);
 	String custname=request.getParameter("name");
 	System.out.println(custname);
 	String year=request.getParameter("year");
 	System.out.println(year);
 	String month=request.getParameter("month");
 	System.out.println(month);
 	String groupname=request.getParameter("group");
 	System.out.println(groupname);
 	String vehiclenos=request.getParameter("vehiclenos");
 	System.out.println(vehiclenos);
 	String ratepervehicle=request.getParameter("rateperveh");
 	System.out.println("no of veh "+vehiclenos);
	int jrmcount=0;
	System.out.println(request.getParameter("jrmcount"));
 	if(request.getParameter("jrmcount")==null || request.getParameter("jrmcount").equals("null"))
 	{
 	jrmcount=0;
 	}
 	else 
 		
 	jrmcount=Integer.parseInt(request.getParameter("jrmcount"));
 	System.out.println("jrm count  "+jrmcount); 	
 	String billtype=request.getParameter("billtype");
 	int salcount=Integer.parseInt(request.getParameter("slacount"));
 	int billdays=Integer.parseInt(request.getParameter("billdays"));
 	String lastdayofmonth="";
 	
 	if(month.equals("01") || month.equals("03") || month.equals("05") ||month.equals("07") || month.equals("08") || month.equals("10") || month.equals("12") || month.equals("12"))
	{
 		 	lastdayofmonth=year+"-"+month+"-31";	
	}

	if(month.equals("04") || month.equals("06") || month.equals("09") ||month.equals("11"))
	{
		lastdayofmonth=year+"-"+month+"-30";
	}

	if(month.equals("02"))
	{
		lastdayofmonth=year+"-"+month+"-28";
	}
 	
 	System.out.println(custname+""+customer+""+year+""+month+""+groupname+""+vehiclenos+""+ratepervehicle);
 	try {
 			conn = erp.ReturnConnection();
 			st = conn.createStatement();
 			st1 = conn.createStatement();
 			st2 = conn.createStatement();
 			st3 = conn.createStatement();
 			st4 = conn.createStatement();
 		}
 		catch (Exception e) 
 		{
 		}
%>
	
<%

response.setContentType("application/pdf");
String filename="Annexture.pdf";
response.addHeader("Content-Disposition", "attachment;filename="+filename);

///Font catFont = new Font(Font.FontFamily.TIMES_ROMAN, 18, Font.BOLD);

Document document = new Document();
try{
ByteArrayOutputStream buffer = new ByteArrayOutputStream();
PdfWriter writer=PdfWriter.getInstance(document, buffer);
	
Font catFont = new Font(Font.TIMES_ROMAN,10,Font.BOLD);
Font headerFont = new Font(Font.TIMES_ROMAN,9,Font.BOLD);
Font NormalFont = new Font(Font.TIMES_ROMAN,8);
Font underline=new Font(Font.TIMES_ROMAN,10,Font.UNDERLINE);
Font Fontforname = new Font(Font.TIMES_ROMAN,9,Font.BOLD);
Font smallfont = new Font(Font.TIMES_ROMAN,6,Font.BOLD);
Font smallfont2 = new Font(Font.TIMES_ROMAN,8,Font.BOLD);

document.open();

double invcamount=0;

/*              logic for invoice no  */
int SINumber;


String sqldate="select DATEDIFF('"+lastdayofmonth+"','"+year+"-"+month+"-01')";
ResultSet rsDate=st1.executeQuery(sqldate);
System.out.println(sqldate);
rsDate.next();
int daysinmonth=rsDate.getInt(1);
daysinmonth=daysinmonth+1;
System.out.println("DAys in MONTH ARE  "+daysinmonth);

String sqlOrderno="SELECT MAX(InvoiceNo) from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet ";
ResultSet rsNew=st.executeQuery(sqlOrderno);
System.out.println(sqlOrderno);
rsNew.next();  
	SINumber=rsNew.getInt(1);
SINumber++;
System.out.println("&&&&****&& N "+SINumber);

String SIRefNumber="";
java.text.DecimalFormat df = new java.text.DecimalFormat("000");

try{
	
	Date today = new Date();
	 
	SIRefNumber="SI";

	String date =  new SimpleDateFormat("ddMMyy").format(new Date());

	String sql3="SELECT invoiceRefNo  from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet  where invoiceRefNo like ('"+SIRefNumber+""+date+"%') ORDER BY invoiceRefNo DESC LIMIT 1";
	ResultSet rs=st2.executeQuery(sql3);
	    System.out.println(sql3);     
	  if(rs.next())
		  SIRefNumber=rs.getString(1).substring(0,rs.getString(1).length()-3)+df.format(Integer.parseInt(rs.getString(1).substring(rs.getString(1).length()-3, rs.getString(1).length()))+1);
	  else
		  SIRefNumber+=date+"001";
	  
}catch(Exception e){
e.printStackTrace();		
}

/*       ******************************************        end of invc logic   **************************************************    */


/*    ***************************************          start of logic for opening balance  ***************************************   */
	String sqlupdate="";
	String sqlBalance="SELECT * FROM  "+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount where CustomerCode="+customer+" order by TransactionDate ASC";

	ResultSet rsbalance=st1.executeQuery(sqlBalance);
	System.out.println("sql"+sqlBalance);
		double balance = 0;
		double debitamount=0;
		double creditamount=0;
		double transactionid=0;
       	while(rsbalance.next())
		{
       		transactionid=rsbalance.getDouble("transactionid");
		    debitamount=rsbalance.getDouble("debitamount");
		    creditamount=rsbalance.getDouble("creditamount");
		    System.out.println(transactionid+" "+debitamount+ " "+creditamount);
		    
		    balance = balance + debitamount-creditamount;
		    System.out.println(balance);
		    sqlupdate = "UPDATE "+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount set balance="+balance+" where transactionid="+transactionid;
		    //st2.executeUpdate(sqlupdate);
		    System.out.println("sql1"+sqlupdate);
		    System.out.println("debitamount: "+debitamount+" Creditamount: "+creditamount+" Balance :"+balance);
		}



/*   *********************************           end of opening balancelogic  ***************************************************************  */

Paragraph preface = new Paragraph();
preface.add(new Paragraph("Transworld Compressor Technologies Limited",catFont));
preface.setAlignment("center");
preface.add(new Paragraph("Survey No. 921 Kad Vasti,Next to Raisony Collage,Wagholi Domkhel Road,Wagholi,Pune- 412207",NormalFont));
preface.setAlignment("center");
preface.add(new Paragraph("Tel:020-41215555 Fax:020-41265555 sales@transworld-compressor.com www.transworld-compressor.com",NormalFont));
preface.setAlignment("center");

document.add(preface);
document.add( Chunk.NEWLINE );


Paragraph invoiceno = new Paragraph();
invoiceno.add(new Paragraph("Invoice No : "+SIRefNumber+"                 "+todaysDate+"",catFont));
invoiceno.setAlignment("center");
document.add(invoiceno);
document.add( Chunk.NEWLINE );

String address="",country="",zip="",contactperson="",phone="";

String sqldata="select * from "+session.getAttribute("CompanyMasterID").toString()+"custaddrdet where CustomerCode='"+customer+"'";
ResultSet rsdata=st.executeQuery(sqldata);
System.out.println(sqldata);
if(rsdata.next())
{
	address=rsdata.getString("BillingAddress");
	country=rsdata.getString("BillingCountry");
	zip=rsdata.getString("BillingZip");
	contactperson=rsdata.getString("ContactPerson");
	phone=rsdata.getString("BillingPhone");
}
else
{
}

PdfPTable tableFirst = new PdfPTable(2);

tableFirst.setWidthPercentage(100);
tableFirst.getDefaultCell().setBorder(Rectangle.NO_BORDER);
tableFirst.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
tableFirst.getDefaultCell().setVerticalAlignment(Element.ALIGN_MIDDLE);


PdfPCell firstcell = new PdfPCell();
firstcell.setFixedHeight(90f);
firstcell.addElement(new Paragraph(""+custname+" " ,smallfont2));
firstcell.addElement(new Paragraph(""+address+" " ,NormalFont));
firstcell.addElement(new Paragraph(""+country+"",Fontforname));
firstcell.addElement(new Paragraph(""+zip+"",NormalFont));
firstcell.addElement(new Paragraph(""+phone+"  "+contactperson+"",NormalFont));
tableFirst.addCell(firstcell);

PdfPCell firstcell1 = new PdfPCell();
firstcell1.setFixedHeight(90f);
firstcell1.addElement(new Paragraph(""+custname+"",smallfont2 ));
firstcell1.addElement(new Paragraph(""+address+"",NormalFont ));
firstcell1.addElement(new Paragraph(""+country+"" ,NormalFont));
firstcell1.addElement(new Paragraph(""+zip+"",NormalFont ));
firstcell1.addElement(new Paragraph(""+phone+"  "+contactperson+"" ,NormalFont));
tableFirst.addCell(firstcell1);
document.add(tableFirst);
document.add( Chunk.NEWLINE );

/*   ************************************* LOGIC TO CALCULATE INVOICE BALANACE  ********************************************** */

double grandtotalnew=(Integer.parseInt(vehiclenos) * Integer.parseInt(ratepervehicle));
double BillAmtnew1 =  0;
BillAmtnew1 =Integer.parseInt(vehiclenos)*Integer.parseInt(ratepervehicle);
 
if(jrmcount>0)
{
	BillAmtnew1 = BillAmtnew1 + (jrmcount * 100);
	grandtotalnew=grandtotalnew+ (jrmcount * 100);
	System.out.println("BIll amount at jrm  "+BillAmtnew1);
}

String Sqldata11 ="";
double CapTot1 = 0, OffTot1 = 0,ToTDays1 = 0;
double diff1=0,Rate11=0;
if(billtype=="Combined" || billtype.equals("Combined"))
{
	Sqldata11 = "Select "+session.getAttribute("CompanyMasterID").toString()+"billingdetails"+year+"_"+month+".VehRegno,instdate,"+session.getAttribute("CompanyMasterID").toString()+"billingdetails"+year+"_"+month+".Transporter,TotalYes as CapturedDays ,TotalYesStar,TotalYes+TotalYesStar,TotalNo,TotalDays from "+session.getAttribute("CompanyMasterID").toString()+"billingdetails"+year+"_"+month+"  ,"+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+year+"_"+month+"  where "+session.getAttribute("CompanyMasterID").toString()+"billingdetails"+year+"_"+month+".vehid="+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+year+"_"+month+".vehid and "+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+year+"_"+month+".ERPCode='"+customer+"'  and GroupName='"+groupname+"' and "+session.getAttribute("CompanyMasterID").toString()+"billingdetails"+year+"_"+month+".BillTransporter='Yes' and "+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+year+"_"+month+".BillTransporter='Yes' and month1='"+year+"-"+month+"-01'";
}
else 
{
	Sqldata11="Select "+session.getAttribute("CompanyMasterID").toString()+"billingdetails"+year+"_"+month+" .VehRegno,instdate,"+session.getAttribute("CompanyMasterID").toString()+"billingdetails"+year+"_"+month+".Transporter,TotalYes as CapturedDays ,TotalYesStar,TotalYes+TotalYesStar,TotalNo,TotalDays,jrm from "+session.getAttribute("CompanyMasterID").toString()+"billingdetails"+year+"_"+month+" ,"+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+year+"_"+month+" where "+session.getAttribute("CompanyMasterID").toString()+"billingdetails"+year+"_"+month+".vehid="+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+year+"_"+month+".vehid and "+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+year+"_"+month+".ERPCode='"+customer+"'  and GroupName='"+groupname+"' and  "+session.getAttribute("CompanyMasterID").toString()+"billingdetails"+year+"_"+month+".BillTransporter='Yes'  and "+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+year+"_"+month+" .BillTransporter='Yes' and TotalYes+TotalYesStar >=(TotalDays/100)*("+salcount+") and month1='"+year+"-"+month+"-01'"; 
}	
	
	ResultSet rsSql11=st1.executeQuery(Sqldata11);
	System.out.println(Sqldata11);	
	while(rsSql11.next())
	{
	    CapTot1 = CapTot1 + rsSql11.getDouble("CapturedDays");
	    OffTot1 = OffTot1 + rsSql11.getDouble("TotalYesStar");
	    ToTDays1 = ToTDays1 + rsSql11.getDouble("totalDays");
	}
	
	System.out.println(CapTot1 +"  "+OffTot1+"  "+ToTDays1);
	System.out.println("value  "+(billdays)*(Integer.parseInt(vehiclenos)));
	if(ToTDays1!=(billdays)*(Integer.parseInt(vehiclenos)))
	{
		System.out.println("IN IFF ");
		diff1=(billdays*Integer.parseInt(vehiclenos)) - ToTDays1;
		Rate11 = Integer.parseInt(ratepervehicle) / billdays;
		System.out.println(diff1+" diff and rate "+Rate11);
	}
	
	if(billtype=="Combined" || billtype.equals("Combined"))
	{
	BillAmtnew1 = BillAmtnew1 - (diff1*Rate11);
	grandtotalnew=grandtotalnew+(diff1*Rate11);
	System.out.println("bill at adjustment  "+BillAmtnew1);
	
	}
	
	double shortfalldays1=0;
if(salcount != 0)
{
		
	  if (CapTot1 + OffTot1 >= ToTDays1 * salcount / 100)
	  {
      shortfalldays1 = 0;
	  }
      else
      {
    	  shortfalldays1 = (ToTDays1 * salcount / 100) - (CapTot1 + OffTot1);
      }
	
	if(shortfalldays1 > 0)
	{
		
        Rate11 = Integer.parseInt(vehiclenos)/billdays;
	}
	
	BillAmtnew1 = BillAmtnew1 - (shortfalldays1 * Rate11);
	grandtotalnew=grandtotalnew+(shortfalldays1*Rate11);
	System.out.println("Bill amount at volun SLA  "+BillAmtnew1);
	String insert3="Insert Into "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items () values ()";
	//st2.executeUpdate(insert3);
}

String sqltax1="select * from "+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+year+"_"+month+" where GroupName='"+groupname+"'";
ResultSet rstax1=st3.executeQuery(sqltax1);
System.out.println(sqltax1);
rstax1.next();
int servicetax1=rstax1.getInt("ST");
int servicecharge1=rstax1.getInt("SC");

double InvAmtnew1 = BillAmtnew1;
System.out.println("INVOICE AMOUNT AT START  "+InvAmtnew1);
if(servicetax1 > 0)

{
	

	InvAmtnew1 = InvAmtnew1 + (BillAmtnew1 * 12 / 100);

	grandtotalnew=grandtotalnew+ BillAmtnew1*12/100;

	
	InvAmtnew1 = InvAmtnew1+ ((BillAmtnew1 * 12 / 100) * 2 / 100);
	grandtotalnew=grandtotalnew+((BillAmtnew1*12)/100 * 0.2);
	String insert5="Insert into "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items () values ()";
	//st.executeUpdate(insert5);

	
	InvAmtnew1 = InvAmtnew1 + ((BillAmtnew1 * 12 / 100) * 1 / 100);
	grandtotalnew=grandtotalnew+((BillAmtnew1*12)/100 * 0.1);
	
	String insert6="Insert into "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items () values ()";
	//st1.executeUpdate(insert6);
	
}



if(servicecharge1 > 0)
{

	
	InvAmtnew1 = InvAmtnew1 + BillAmtnew1 * 12.36 / 100;
	grandtotalnew=grandtotalnew+(BillAmtnew1 * 12.36 / 100);
	
	
	
}

/* ********************************************* END LOGIC TO CALCULATE INVOICE BALANACE  ************************************************* */


PdfPTable tableNew = new PdfPTable(6);
tableNew.setWidthPercentage(100);
PdfPCell cNew = new PdfPCell(new Phrase("Opening Balance",headerFont));
cNew.setHorizontalAlignment(Element.ALIGN_CENTER);
tableNew.addCell(cNew);

cNew = new PdfPCell(new Phrase("Credits",headerFont));
cNew.setHorizontalAlignment(Element.ALIGN_CENTER);
tableNew.addCell(cNew);

cNew = new PdfPCell(new Phrase("Charges",headerFont));
cNew.setHorizontalAlignment(Element.ALIGN_CENTER);
tableNew.addCell(cNew);

cNew = new PdfPCell(new Phrase("This Balance",headerFont));
cNew.setHorizontalAlignment(Element.ALIGN_CENTER);
tableNew.addCell(cNew);

cNew = new PdfPCell(new Phrase("Amount Due",headerFont));
cNew.setHorizontalAlignment(Element.ALIGN_CENTER);
tableNew.addCell(cNew);

cNew = new PdfPCell(new Phrase("Due Date",headerFont));
cNew.setHorizontalAlignment(Element.ALIGN_CENTER);
tableNew.addCell(cNew);

cNew = new PdfPCell(new Phrase(""+nf.format( balance)+"",NormalFont));
cNew.setHorizontalAlignment(Element.ALIGN_RIGHT);
tableNew.addCell(cNew);

cNew = new PdfPCell(new Phrase("0.00",NormalFont));
cNew.setHorizontalAlignment(Element.ALIGN_RIGHT);
tableNew.addCell(cNew);

cNew = new PdfPCell(new Phrase("0.00",NormalFont));
cNew.setHorizontalAlignment(Element.ALIGN_RIGHT);
tableNew.addCell(cNew);

cNew = new PdfPCell(new Phrase(""+nf.format(grandtotalnew)+"",NormalFont));
cNew.setHorizontalAlignment(Element.ALIGN_RIGHT);
tableNew.addCell(cNew);

cNew = new PdfPCell(new Phrase(""+nf.format((balance+grandtotalnew))+"",NormalFont));
cNew.setHorizontalAlignment(Element.ALIGN_RIGHT);
tableNew.addCell(cNew);

cNew = new PdfPCell(new Phrase(""+tendaysInMMM+"",NormalFont));
cNew.setHorizontalAlignment(Element.ALIGN_LEFT);
tableNew.addCell(cNew);

document.add(tableNew);
document.add( Chunk.NEWLINE );

Paragraph title = new Paragraph();
title.add(new Paragraph("Last 3 Transactions",catFont));
title.setAlignment("center");
document.add(title);

PdfPTable table = new PdfPTable(6);
table.setWidthPercentage(100);
PdfPCell c1 = new PdfPCell(new Phrase("Tr.Date",headerFont));
c1.setHorizontalAlignment(Element.ALIGN_CENTER);
table.addCell(c1);

c1 = new PdfPCell(new Phrase("Tr.Details",headerFont));
c1.setHorizontalAlignment(Element.ALIGN_CENTER);
table.addCell(c1);

c1 = new PdfPCell(new Phrase("Tr.Type",headerFont));
c1.setHorizontalAlignment(Element.ALIGN_CENTER);
table.addCell(c1);

c1 = new PdfPCell(new Phrase("Cr.",headerFont));
c1.setHorizontalAlignment(Element.ALIGN_CENTER);
table.addCell(c1);


c1 = new PdfPCell(new Phrase("Db.",headerFont));
c1.setHorizontalAlignment(Element.ALIGN_CENTER);
table.addCell(c1);

c1 = new PdfPCell(new Phrase("Balance",headerFont));
c1.setHorizontalAlignment(Element.ALIGN_CENTER);
table.addCell(c1);


String sql1 = "SELECT TransactionDate,TransactionDetail,TransactionType,CreditAmount,DebitAmount,Balance FROM  "+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount where CustomerCode='"
	+ customer
	+ "' ORDER BY  concat(TransactionDate , TransactionId ) Desc limit 3";
ResultSet rs1=st1.executeQuery(sql1);
while(rs1.next())
{
	c1 = new PdfPCell(new Phrase(""+  new SimpleDateFormat("dd-MMM-yyyy")
	.format(new SimpleDateFormat(
	"yyyy-MM-dd").parse(rs1
	.getString(1))) +"",NormalFont));
	c1.setHorizontalAlignment(Element.ALIGN_LEFT);
	table.addCell(c1);
	
	
	c1 = new PdfPCell(new Phrase(""+ rs1.getString(2) +"",NormalFont));
	c1.setHorizontalAlignment(Element.ALIGN_LEFT);
	table.addCell(c1);
	
	c1 = new PdfPCell(new Phrase(""+ rs1.getString(3) +"",NormalFont));
	c1.setHorizontalAlignment(Element.ALIGN_LEFT);
	table.addCell(c1);
	
	c1 = new PdfPCell(new Phrase(""+ rs1.getString(4) +"",NormalFont));
	c1.setHorizontalAlignment(Element.ALIGN_RIGHT);
	table.addCell(c1);
	
	c1 = new PdfPCell(new Phrase(""+ rs1.getString(5) +"",NormalFont));
	c1.setHorizontalAlignment(Element.ALIGN_RIGHT);
	table.addCell(c1);
	
	
	c1 = new PdfPCell(new Phrase(""+ rs1.getString(6) +"",NormalFont));
	c1.setHorizontalAlignment(Element.ALIGN_RIGHT);
	table.addCell(c1);
	

}

document.add(table);

document.add( Chunk.NEWLINE );
int count=1;
double grandtotal=0;

PdfPTable table3 = new PdfPTable(5);
table3.setWidthPercentage(100);
PdfPCell c3= new PdfPCell(new Phrase("Sr No",headerFont));
c3.setHorizontalAlignment(Element.ALIGN_CENTER);
table3.addCell(c3);

c3 = new PdfPCell(new Phrase("Description",headerFont));
c3.setHorizontalAlignment(Element.ALIGN_CENTER);
table3.addCell(c3);

c3 = new PdfPCell(new Phrase("Quantity",headerFont));
c3.setHorizontalAlignment(Element.ALIGN_CENTER);
table3.addCell(c3);
c3 = new PdfPCell(new Phrase("Rate",headerFont));
c3.setHorizontalAlignment(Element.ALIGN_CENTER);
table3.addCell(c3);
c3 = new PdfPCell(new Phrase("Amount",headerFont));
c3.setHorizontalAlignment(Element.ALIGN_CENTER);
table3.addCell(c3);

/*String sqlcheck="Select * from "+session.getAttribute("CompanyMasterID").toString()+"billingcrossschecking where month1='"+year+"-"+month+"-01' and BillGroup='"+groupname+"'";
ResultSet rsSqlchk=st3.executeQuery(sqlcheck);*/

c3 = new PdfPCell(new Phrase(""+ count +"",NormalFont));
c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
table3.addCell(c3);

c3 = new PdfPCell(new Phrase("Monthly Billing Charges",NormalFont));
c3.setHorizontalAlignment(Element.ALIGN_LEFT);
table3.addCell(c3);


c3 = new PdfPCell(new Phrase(""+vehiclenos+"",NormalFont));
c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
table3.addCell(c3);

c3 = new PdfPCell(new Phrase(""+ratepervehicle+"",NormalFont));
c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
table3.addCell(c3);

c3 = new PdfPCell(new Phrase(""+(Integer.parseInt(vehiclenos) * Integer.parseInt(ratepervehicle))  +"",NormalFont));
c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
table3.addCell(c3);


grandtotal=(Integer.parseInt(vehiclenos) * Integer.parseInt(ratepervehicle));

String sqlInsert="Insert into "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items() value ()";
//st.executeUpdate(sqlInsert);

count ++;
 double BillAmtnew =  0;
 BillAmtnew =Integer.parseInt(vehiclenos)*Integer.parseInt(ratepervehicle);
System.out.println("BILL AMONUT 111  "+BillAmtnew);
 
 
if(jrmcount>0)
{
	
	c3 = new PdfPCell(new Phrase(""+ count +"",NormalFont));
	c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
	table3.addCell(c3);
	
	c3 = new PdfPCell(new Phrase("JRM - Monthly Road Risk Data Flat Charges",NormalFont));
	c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
	table3.addCell(c3);

	c3 = new PdfPCell(new Phrase(""+jrmcount+"",NormalFont));
	c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
	table3.addCell(c3);
	
	c3 = new PdfPCell(new Phrase(""+jrmcount+"",NormalFont));
	c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
	table3.addCell(c3);
	
	c3 = new PdfPCell(new Phrase(""+(jrmcount * 100)  +"",NormalFont));
	c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
	table3.addCell(c3);

	BillAmtnew = BillAmtnew + (jrmcount * 100);
	grandtotal=grandtotal+ (jrmcount * 100);
	System.out.println("BIll amount at jrm  "+BillAmtnew);
	String sqlInsert1="Insert into "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items() value ()";
	//st1.executeUpdate(sqlInsert1);	
	
}

String Sqldata1 ="";
double CapTot = 0, OffTot = 0,ToTDays = 0;
double diff=0,Rate1=0;
if(billtype=="Combined" || billtype.equals("Combined"))
{
	Sqldata1 = "Select "+session.getAttribute("CompanyMasterID").toString()+"billingdetails"+year+"_"+month+".VehRegno,instdate,"+session.getAttribute("CompanyMasterID").toString()+"billingdetails"+year+"_"+month+".Transporter,TotalYes as CapturedDays ,TotalYesStar,TotalYes+TotalYesStar,TotalNo,TotalDays from "+session.getAttribute("CompanyMasterID").toString()+"billingdetails"+year+"_"+month+"  ,"+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+year+"_"+month+"  where "+session.getAttribute("CompanyMasterID").toString()+"billingdetails"+year+"_"+month+".vehid="+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+year+"_"+month+".vehid and "+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+year+"_"+month+".ERPCode='"+customer+"'  and GroupName='"+groupname+"' and "+session.getAttribute("CompanyMasterID").toString()+"billingdetails"+year+"_"+month+".BillTransporter='Yes' and "+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+year+"_"+month+".BillTransporter='Yes' and month1='"+year+"-"+month+"-01'";
}
else 
{
	Sqldata1="Select "+session.getAttribute("CompanyMasterID").toString()+"billingdetails"+year+"_"+month+" .VehRegno,instdate,"+session.getAttribute("CompanyMasterID").toString()+"billingdetails"+year+"_"+month+".Transporter,TotalYes as CapturedDays ,TotalYesStar,TotalYes+TotalYesStar,TotalNo,TotalDays,jrm from "+session.getAttribute("CompanyMasterID").toString()+"billingdetails"+year+"_"+month+" ,"+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+year+"_"+month+" where "+session.getAttribute("CompanyMasterID").toString()+"billingdetails"+year+"_"+month+".vehid="+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+year+"_"+month+".vehid and "+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+year+"_"+month+".ERPCode='"+customer+"'  and GroupName='"+groupname+"' and  "+session.getAttribute("CompanyMasterID").toString()+"billingdetails"+year+"_"+month+".BillTransporter='Yes'  and "+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+year+"_"+month+" .BillTransporter='Yes' and TotalYes+TotalYesStar >=(TotalDays/100)*("+salcount+") and month1='"+year+"-"+month+"-01'"; 
}	
	
	ResultSet rsSql1=st1.executeQuery(Sqldata1);
	System.out.println(Sqldata1);	
	while(rsSql1.next())
	{
	    CapTot = CapTot + rsSql1.getDouble("CapturedDays");
	    OffTot = OffTot + rsSql1.getDouble("TotalYesStar");
	    ToTDays = ToTDays + rsSql1.getDouble("totalDays");
	}
	
	System.out.println(CapTot +"  "+OffTot+"  "+ToTDays);
	System.out.println("value  "+(billdays)*(Integer.parseInt(vehiclenos)));
	if(ToTDays!=(billdays)*(Integer.parseInt(vehiclenos)))
	{
		System.out.println("IN IFF ");
		diff=(billdays*Integer.parseInt(vehiclenos)) - ToTDays;
		Rate1 = Integer.parseInt(ratepervehicle) / billdays;
		System.out.println(diff+" diff and rate "+Rate1);
	}
	
	if(billtype=="Combined" || billtype.equals("Combined"))
	{
		
		
		c3 = new PdfPCell(new Phrase(""+ count++ +"",NormalFont));
		c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
		table3.addCell(c3);
		
		c3 = new PdfPCell(new Phrase("Adjustment in Bill Days",NormalFont));
		c3.setHorizontalAlignment(Element.ALIGN_LEFT);
		table3.addCell(c3);
		
		c3 = new PdfPCell(new Phrase("",NormalFont));
		c3.setHorizontalAlignment(Element.ALIGN_LEFT);
		table3.addCell(c3);
		
		c3 = new PdfPCell(new Phrase("",NormalFont));
		c3.setHorizontalAlignment(Element.ALIGN_LEFT);
		table3.addCell(c3);
		
		c3 = new PdfPCell(new Phrase(""+nf.format((diff*Rate1))+"",NormalFont));
		c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
		table3.addCell(c3);
		
	BillAmtnew = BillAmtnew - (diff*Rate1);
	grandtotal=grandtotal+(diff*Rate1);
	System.out.println("bill at adjustment  "+BillAmtnew);
	String insert2="Insert into "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items() value()";
	//st.executeUpdate(insert2);
	}
	
	double shortfalldays=0;
if(salcount != 0)
{
	
	
	  if (CapTot + OffTot >= ToTDays * salcount / 100)
	  {
      shortfalldays = 0;
	  }
      else
      {
    	  shortfalldays = (ToTDays * salcount / 100) - (CapTot + OffTot);
      }
	
	if(shortfalldays > 0)
	{
		
        Rate1 = Integer.parseInt(vehiclenos)/billdays;
	}
	  
	c3 = new PdfPCell(new Phrase(""+ count++ +"",NormalFont));
	c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
	table3.addCell(c3);

	c3 = new PdfPCell(new Phrase("Voluntary SLA Adjustment",NormalFont));
	c3.setHorizontalAlignment(Element.ALIGN_LEFT);
	table3.addCell(c3);

	c3 = new PdfPCell(new Phrase("",NormalFont));
	c3.setHorizontalAlignment(Element.ALIGN_LEFT);
	table3.addCell(c3);
	c3 = new PdfPCell(new Phrase("",NormalFont));
	c3.setHorizontalAlignment(Element.ALIGN_LEFT);
	table3.addCell(c3);
	c3 = new PdfPCell(new Phrase(""+nf.format((shortfalldays*Rate1))+"",NormalFont));
	c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
	table3.addCell(c3);

	BillAmtnew = BillAmtnew - (shortfalldays * Rate1);
	grandtotal=grandtotal+(shortfalldays*Rate1);
	System.out.println("Bill amount at volun SLA  "+BillAmtnew);
	String insert3="Insert Into "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items () values ()";
	//st2.executeUpdate(insert3);
}

String sqltax="select * from "+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+year+"_"+month+" where GroupName='"+groupname+"'";
ResultSet rstax=st3.executeQuery(sqltax);
System.out.println(sqltax);
rstax.next();
int servicetax=rstax.getInt("ST");
int servicecharge=rstax.getInt("SC");

double InvAmtnew = BillAmtnew;
System.out.println("INVOICE AMOUNT AT START  "+InvAmtnew);
if(servicetax > 0)

{
	
	c3 = new PdfPCell(new Phrase(""+ count++ +"",NormalFont));
	c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
	table3.addCell(c3);
	
	c3 = new PdfPCell(new Phrase("Basic ST 12%",NormalFont));
	c3.setHorizontalAlignment(Element.ALIGN_LEFT);
	table3.addCell(c3);
	
	c3 = new PdfPCell(new Phrase("",NormalFont));
	c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
	table3.addCell(c3);
	
	c3 = new PdfPCell(new Phrase("",NormalFont));
	c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
	table3.addCell(c3);
	
	c3 = new PdfPCell(new Phrase(""+nf.format((BillAmtnew*12)/100)+"",NormalFont));
	c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
	table3.addCell(c3);
	

	InvAmtnew = InvAmtnew + (BillAmtnew * 12 / 100);

	grandtotal=grandtotal+ BillAmtnew*12/100;
	String insert4="Insert into "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items () values ()";
	//st3.executeUpdate(insert4);
	
	
	c3 = new PdfPCell(new Phrase(""+ count++ +"",NormalFont));
	c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
	table3.addCell(c3);
	
	c3 = new PdfPCell(new Phrase("Edu.Cess 2% on Basic ST",NormalFont));
	c3.setHorizontalAlignment(Element.ALIGN_LEFT);
	table3.addCell(c3);
	
	c3 = new PdfPCell(new Phrase("",NormalFont));
	c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
	table3.addCell(c3);
	
	c3 = new PdfPCell(new Phrase("",NormalFont));
	c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
	table3.addCell(c3);
	
	c3 = new PdfPCell(new Phrase(""+nf.format((BillAmtnew*12)/100 * 0.2)+"",NormalFont));
	c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
	table3.addCell(c3);
	

	
	InvAmtnew = InvAmtnew + ((BillAmtnew * 12 / 100) * 2 / 100);
	grandtotal=grandtotal+((BillAmtnew*12)/100 * 0.2);
	String insert5="Insert into "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items () values ()";
	//st.executeUpdate(insert5);
	
	
		c3 = new PdfPCell(new Phrase(""+ count++ +"",NormalFont));
	c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
	table3.addCell(c3);
	
	c3 = new PdfPCell(new Phrase("High Edu. Cess 1% on Basic ST",NormalFont));
	c3.setHorizontalAlignment(Element.ALIGN_LEFT);
	table3.addCell(c3);
	
	c3 = new PdfPCell(new Phrase("",NormalFont));
	c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
	table3.addCell(c3);
	
	c3 = new PdfPCell(new Phrase("",NormalFont));
	c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
	table3.addCell(c3);
	
	c3 = new PdfPCell(new Phrase(""+nf.format((BillAmtnew*12)/100 * 0.1)+"",NormalFont));
	c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
	table3.addCell(c3);
	

	
	InvAmtnew = InvAmtnew + ((BillAmtnew * 12 / 100) * 1 / 100);
	grandtotal=grandtotal+((BillAmtnew*12)/100 * 0.1);
	
	String insert6="Insert into "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items () values ()";
	//st1.executeUpdate(insert6);
	
}



if(servicecharge > 0)
{
	
	c3 = new PdfPCell(new Phrase(""+ count++ +"",NormalFont));
	c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
	table3.addCell(c3);
	
	c3 = new PdfPCell(new Phrase("Service Charge 12.36%",NormalFont));
	c3.setHorizontalAlignment(Element.ALIGN_LEFT);
	table3.addCell(c3);
	
	c3 = new PdfPCell(new Phrase("",NormalFont));
	c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
	table3.addCell(c3);
	
	c3 = new PdfPCell(new Phrase("",NormalFont));
	c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
	table3.addCell(c3);
	
	c3 = new PdfPCell(new Phrase(""+nf.format( BillAmtnew * 12.36 / 100)+"",NormalFont));
	c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
	table3.addCell(c3);
	
	
	InvAmtnew = InvAmtnew + BillAmtnew * 12.36 / 100;
	grandtotal=grandtotal+(BillAmtnew * 12.36 / 100);
	String insert7="Insert into "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items () values ()";
	//st1.executeUpdate(insert7);
	
	
}

document.add(table3);

Paragraph totalvalue=new Paragraph();
totalvalue.add(new Paragraph("Grand Total : "+nf.format(grandtotal)+"",smallfont2));
totalvalue.setAlignment("Right");
document.add(totalvalue);

invcamount=grandtotal;




Paragraph terms=new Paragraph();
terms.add(new Paragraph("Terms & Conditions :-",smallfont2));
terms.setAlignment("Left");
document.add(terms);

if(servicetax!=0)
{
	Paragraph terms1=new Paragraph();
	terms1.add(new Paragraph("1. Service Tax 12.36 %.",smallfont));
	terms1.add(new Paragraph("2. Payment - 100 % within 10 days from the Invoice date." ,smallfont));
	terms1.add(new Paragraph("3. Monthly Rental Charges for the Period 01-"+month+"-"+year+" To 31-"+month+"-"+year+" " ,smallfont));
	terms1.add(new Paragraph("4. Usage charges will be billed seperately if any." ,smallfont));
	terms1.add(new Paragraph("5. Applicable Taxes Included." ,smallfont));
	terms1.setAlignment("Left");
	document.add(terms1);
	
}
else  if(servicecharge != 0)
{
	Paragraph terms2=new Paragraph();
	terms2.add(new Paragraph("1. Service Charge 12.36 %.",smallfont));
	terms2.add(new Paragraph("2. Payment - 100 % within 10 days from the Invoice date." ,smallfont));
	terms2.add(new Paragraph("3. Monthly Rental Charges for the Period 01-"+month+"-"+year+" To 31-"+month+"-"+year+" " ,smallfont));
	terms2.add(new Paragraph("4. Usage charges will be billed seperately if any." ,smallfont));
	terms2.add(new Paragraph("5. Applicable Taxes Included." ,smallfont));
	terms2.setAlignment("Left");
	document.add(terms2);
	
}	
else 
{
	Paragraph terms3=new Paragraph();
	terms3.add(new Paragraph("1. Payment - 100 % within 10 days from the Invoice date." ,smallfont));
	terms3.add(new Paragraph("2. Monthly Rental Charges for the Period 01-"+month+"-"+year+" To 31-"+month+"-"+year+" " ,smallfont));
	terms3.add(new Paragraph("3. Usage charges will be billed seperately if any." ,smallfont));
	terms3.add(new Paragraph("4. Applicable Taxes Included." ,smallfont));
	terms3.setAlignment("Left");
	document.add(terms3);
	
}





Paragraph para1=new Paragraph();
para1.add(new Paragraph("For TRANSWORLD COMPRESSOT TECHNOLOGIES LTD. , ",smallfont2));
para1.add(new Paragraph("Anand Mahajan",smallfont2));
para1.setAlignment("Right");
document.add(para1);

Paragraph parabottom5=new Paragraph();
parabottom5.add(new Paragraph("Subject to Pune Jurisdiction ",smallfont2));
parabottom5.setAlignment("Left");
document.add(parabottom5);

Paragraph parabottom6=new Paragraph();
parabottom6.add(new Paragraph("BST No 412207/S/352/WEF 11/4/2000 CST No 412207/C/241/WEF 5/6/2000",smallfont));
parabottom6.add(new Paragraph("PAN No AABCT4318G Service Tax no AABCT 4318G ST001 Service Category - Business Auxiliary Services" ,smallfont));
parabottom6.setAlignment("Left");
document.add(parabottom6);

Paragraph parabottom3=new Paragraph();
parabottom3.add(new Paragraph("We are a Small Enterprise Under the Micro Medium and Small Enterprise Act 2006. Govt. of India",smallfont));
parabottom3.add(new Paragraph("Queries regarding this Invoice to be addressed to sales@transworld-compressor.com Tel 020 41265555",smallfont));
parabottom3.setAlignment("Left");
document.add(parabottom3);

document.add( Chunk.NEWLINE );

Paragraph para2=new Paragraph();
para2.add(new Paragraph("Day Wise Bill Report For "+month+"-"+year+" of "+custname+" ",smallfont2));
para2.setAlignment("Left");
document.add(para2);

Paragraph para3=new Paragraph();
para3.add(new Paragraph("Bill Period 01-"+month+"-"+year+" to "+daysinmonth+"-"+month+"-"+year+" ",smallfont2));
para3.setAlignment("Left");
document.add(para3);

Paragraph annexturetoinvc=new Paragraph();
annexturetoinvc.add(new Paragraph("Annexture To Invoice "+SIRefNumber+"",smallfont2));
annexturetoinvc.setAlignment("Left");
document.add(annexturetoinvc);
document.add( Chunk.NEWLINE );

PdfPTable tableData = new PdfPTable(4);
tableData.setWidthPercentage(100);

PdfPCell celldata= new PdfPCell(new Phrase("Sr No",headerFont));
celldata.setHorizontalAlignment(Element.ALIGN_CENTER);
tableData.addCell(celldata);

celldata = new PdfPCell(new Phrase("Veh Reg No",headerFont));
celldata.setHorizontalAlignment(Element.ALIGN_CENTER);
tableData.addCell(celldata);

celldata = new PdfPCell(new Phrase("Inst Dt",headerFont));
celldata.setHorizontalAlignment(Element.ALIGN_CENTER);
tableData.addCell(celldata);

celldata = new PdfPCell(new Phrase("Total",headerFont));
celldata.setHorizontalAlignment(Element.ALIGN_CENTER);
tableData.addCell(celldata);

int srnoforveh=1;
int totaldays=0;
String sqlVehdata="Select "+session.getAttribute("CompanyMasterID").toString()+"billingdetails"+year+"_"+month+".VehRegno,instdate,"+session.getAttribute("CompanyMasterID").toString()+"billingdetails"+year+"_"+month+".Transporter,TotalYes as CapturedDays ,TotalYesStar,TotalYes+TotalYesStar,TotalNo,TotalDays from "+session.getAttribute("CompanyMasterID").toString()+"billingdetails"+year+"_"+month+"  ,"+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+year+"_"+month+"  where "+session.getAttribute("CompanyMasterID").toString()+"billingdetails"+year+"_"+month+".vehid="+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+year+"_"+month+".vehid and "+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+year+"_"+month+".ERPCode='"+customer+"'  and GroupName='"+groupname+"' and "+session.getAttribute("CompanyMasterID").toString()+"billingdetails"+year+"_"+month+".BillTransporter='Yes' and "+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+year+"_"+month+".BillTransporter='Yes' and month1='"+year+"-"+month+"-01'";
ResultSet rsveh=st.executeQuery(sqlVehdata);
System.out.println(sqlVehdata);
while(rsveh.next())
{
	
	int count2=1;
	celldata = new PdfPCell(new Phrase(""+ srnoforveh +"",headerFont));
	celldata.setHorizontalAlignment(Element.ALIGN_RIGHT);
	tableData.addCell(celldata);

	celldata = new PdfPCell(new Phrase(""+ rsveh.getString("VehRegno") +"",headerFont));
	celldata.setHorizontalAlignment(Element.ALIGN_LEFT);
	tableData.addCell(celldata);

	celldata = new PdfPCell(new Phrase(""+new Phrase(""+ new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsveh.getString("InstDate")))) +"",headerFont));
	celldata.setHorizontalAlignment(Element.ALIGN_RIGHT);
	tableData.addCell(celldata);

	celldata = new PdfPCell(new Phrase(""+ rsveh.getString("TotalDays")  +"",headerFont));
	celldata.setHorizontalAlignment(Element.ALIGN_RIGHT);
	tableData.addCell(celldata);	


	
	srnoforveh ++;
	totaldays=totaldays+Integer.parseInt(rsveh.getString("TotalDays"));
	
}

document.add(tableData);
document.add( Chunk.NEWLINE);
Paragraph total=new Paragraph();
total.add(new Paragraph("Total : "+totaldays+" ",headerFont));
total.setAlignment("Right");
document.add(total);


Paragraph para4=new Paragraph();
para4.add(new Paragraph("SUMMARY OF BILL   ",headerFont));
para4.setAlignment("Left");
document.add(para4);


Paragraph para5=new Paragraph();
para5.add(new Paragraph("Amount per vehicle="+ratepervehicle+"   ",headerFont));
para5.setAlignment("Left");
document.add(para5);

Paragraph para6=new Paragraph();
para6.add(new Paragraph("Days in Bill Period ="+daysinmonth+"   ",headerFont));
para6.setAlignment("Left");
document.add(para6);


Paragraph para7=new Paragraph();
para7.add(new Paragraph("Amount For 1 Day ="+Integer.parseInt(ratepervehicle)/daysinmonth+"   ",headerFont));
para7.setAlignment("Left");
document.add(para7);

/*        ********************************* start of calculations for SLA  ****************************************   */
if(salcount != 0)
{

Paragraph para8=new Paragraph();
para8.add(new Paragraph("SLA="+salcount+"   ",headerFont));
para8.setAlignment("Left");
document.add(para8);


Paragraph para9=new Paragraph();
para9.add(new Paragraph("No of Total Days(TD) in "+month+"-"+year+" ="+totaldays+"  ",headerFont));
para9.setAlignment("Left");
document.add(para9);


Paragraph para10=new Paragraph();
para10.add(new Paragraph("NO Of Captured Days(CD) for all vehicles (Captured Days+Ignition Off Days)= "+(CapTot+OffTot)+"  ",headerFont));
para10.setAlignment("Left");
document.add(para10);


Paragraph para11=new Paragraph();
para11.add(new Paragraph("SLA Days=  "+(ToTDays * salcount/ 100)+"",headerFont));
para11.setAlignment("Left");
document.add(para11);


double shortfall = 0;
if( CapTot + OffTot >= ToTDays * salcount / 100)
shortfall = 0;
else
shortfall = (ToTDays * salcount / 100) - (CapTot + OffTot);

Paragraph para12=new Paragraph();
para12.add(new Paragraph("Short fall in SLA Days =(CD-SLA Days) or (SLA Days-CD) = "+shortfall+" ",headerFont));
para12.setAlignment("Left");
document.add(para12);

}

/*        ********************************* start of calculations for SLA  ****************************************   */


Paragraph td=new Paragraph();
td.add(new Paragraph("No Of Total Days(TD) in "+month+"-"+year+" = "+totaldays+"",headerFont));
td.setAlignment("Left");
document.add(td);


Paragraph para13=new Paragraph();
para13.add(new Paragraph("Total Amount= "+ (Integer.parseInt(ratepervehicle)/daysinmonth)*totaldays+"",headerFont));
para13.setAlignment("Left");
document.add(para13);


Paragraph para14=new Paragraph();
para14.add(new Paragraph("Net Bill Amount = "+ (Integer.parseInt(ratepervehicle)/daysinmonth) * totaldays+"  ",headerFont));
para14.setAlignment("Left");
document.add(para14);


Paragraph para15=new Paragraph();
para15.add(new Paragraph("Invoice Amount = Net Bill Amt * 12.36 Service Charge = "+ (Integer.parseInt(ratepervehicle)/daysinmonth) *totaldays+" ",headerFont));
para15.setAlignment("Left");
document.add(para15);


document.close();

DataOutput dataOutput = new DataOutputStream(response.getOutputStream());
byte[] bytes = buffer.toByteArray();
response.setContentLength(bytes.length);
for(int l = 0; l < bytes.length; l++)
{
    dataOutput.writeByte(bytes[l]);
}

}catch(Exception e)
{
	e.printStackTrace();
}
finally
{
	response.getOutputStream().close();
}	

%>

</jsp:useBean>	