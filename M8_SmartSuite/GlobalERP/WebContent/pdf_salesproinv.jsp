<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict/aaa/EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="conn.jsp"%>
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



<%@page import="com.lowagie.text.Rectangle"%><jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
 
	<script src="dropdown.js" type="text/javascript"></script>
	<script src="dynamic.js" type="text/javascript"></script>

	
	<script type="text/javascript">
	</script>
	
	
	<body>
		
<%
	erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
%>
<%
System.out.println("dddddddddddddddddddddd");

    Connection conn = null;
    Statement st = null, st1 = null,st2=null,st3=null,st4=null,st5=null,st6=null,stlbl=null;
    double d1=0.00;
	int groupCode=0,makeCode=0;
	int d=0;

	int i=0;
	String groupName="",makeName="",itemCode="",stpercent="";
	String refMakeNameTable="",fromdate="";
	String pfi="",frieght="",grandTotal="";
	String frieghtType="",grandtotal="";
	String sqlDisplayDesc=" ",totalAmount="",totalAmountInWords="",termsconditions="",salesQuoNumber="",status="",statusTD="";
	
	String todaysDate=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new java.util.Date());
	String todaysTime=new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
		
	String a="",b="",c="",h="",u="",m="",n="",o="",p="",q="";
	NumberFormat nf = new DecimalFormat("#0.00");
	String invcrefno=request.getParameter("transactionId");
	System.out.println(invcrefno);
	try {
	conn = erp.ReturnConnection();
	st = conn.createStatement();
	st2 = conn.createStatement();
	st1 = conn.createStatement();
	st3 = conn.createStatement();
	st4 = conn.createStatement();
	st5 = conn.createStatement();
	st6 = conn.createStatement();
	stlbl = conn.createStatement();
	} catch (Exception e) {
	}

	%>
	
<%	

response.setContentType("application/pdf");
String filename="SalesProformaInvoice.pdf";
response.addHeader("Content-Disposition", "attachment;filename="+filename);

///Font catFont = new Font(Font.FontFamily.TIMES_ROMAN, 18, Font.BOLD);

Document document = new Document();
try{
ByteArrayOutputStream buffer = new ByteArrayOutputStream();
PdfWriter writer=PdfWriter.getInstance(document, buffer);
Font headFont = new Font(Font.TIMES_ROMAN,13,Font.BOLD);
Font catFont = new Font(Font.TIMES_ROMAN,12,Font.BOLD);
Font NormalFont = new Font(Font.TIMES_ROMAN,8);
Font underline=new Font(Font.TIMES_ROMAN,10,Font.UNDERLINE);
Font NormalFont1 = new Font(Font.TIMES_ROMAN,8,Font.BOLD);
Font Fontforname = new Font(Font.TIMES_ROMAN,9,Font.BOLD);
Font new3=new Font(Font.TIMES_ROMAN,8,Font.BOLD);
Font NormalFont21 = new Font(Font.TIMES_ROMAN,8);
Font smallfont2 = new Font(Font.TIMES_ROMAN,8);
Font Normal = new Font(Font.TIMES_ROMAN,8,Font.BOLD);
Font NF = new Font(Font.TIMES_ROMAN,1,Font.NORMAL);
Font forterms = new Font(Font.TIMES_ROMAN,9,Font.BOLD);
Font smallfont = new Font(Font.TIMES_ROMAN,6,Font.BOLD);
document.setPageSize(PageSize.A4);
document.setMargins(20,20,11,11);
document.setMarginMirroring(false);

document.open();

String SqlQuoDet="SELECT InvoiceNo,CustomerCode,InvoiceDate,TheGroup,Total,Discount,CST,PFI,FreightAmt,GrandTotal,Terms,TotalInWords,PONo,PODate,DespatchMode,FreightType,PaymentMode,Insurance,ShippedBy,ShipmentDate,DespCheckListCheckedBy,PackingSlipCheckedBy,DocketFilledBy,InvoiceCancelled,RevofInvoiceNo,NoofRevisions,ReasonForCancelling,SEandSQRefNo,InvoiceTime,InvoiceRaisedby,Annexure,ExpIECno,RBIcodeNo,OtherExpInfo,BuyerOtherThanConsig,CountryOfOrigin,CountryOfFinalDestin,PreCarriageBy,PlaceofRecptByPreCar,PortOfLoading,PortOfDischarge,FinalDestination,NoandKindOfPacking,WeightInKgs,CurrType,CurrValue,TWSalesOrderNo,DebitNote,TWEmpName,InvoiceGenerated,AddressCode,CompanyName,ContactPerson,Address,city,Zip,State,country,Phone,Fax,invoiceRefNo,TWSalesorderRefNo,RevOfinvoiceRefNo,InvoiceType,InvoicePrinted,Newcustomercode,Newcompanyname,CustPurON,CustPurDT,InvRaisedBillAdd,InvRaisedShipAdd,InvRaisedConDet,InvRaisedCompName,HSNCode,SACCode,CGSTRate,CGSTValue,SGSTRate,SGSTValue,IGSTRate,IGSTValue,BillingGSTIN,ShippingGSTIN,CASE WHEN FromDate ='0000-00-00' THEN null ELSE FromDate END as FromDate,CASE WHEN ToDate ='0000-00-00' THEN null ELSE ToDate END as ToDate,CASE WHEN DeliveryDate ='0000-00-00' THEN null ELSE DeliveryDate END as DeliveryDate,CASE WHEN DueDate ='0000-00-00' THEN null ELSE DueDate END as DueDate from "+session.getAttribute("CompanyMasterID").toString()+"performainvoicedet WHERE invoiceRefNo='"+invcrefno+"' ";
	System.out.println(">>>>>>>>>>>      "+SqlQuoDet);
	ResultSet rsInvDet=st4.executeQuery(SqlQuoDet);
		if(rsInvDet.next()){
			String fdate=rsInvDet.getString("FromDate");
			if(fdate==null || fdate=="null" || fdate.equals("null"))
			{
				System.out.println("fdate null  =======>" + fdate);
				fdate="-";

			}
			else
			{
			System.out.println("fdate   "+fdate);
			fdate = new SimpleDateFormat("dd-MMM-yyyy")
					.format(new SimpleDateFormat("yyyy-MM-dd")
							.parse(fdate)); 
			}
			String tdate=rsInvDet.getString("ToDate");
			if(tdate==null || tdate=="null" || tdate.equals("null"))
			{
				System.out.println("tdate null  =======>" + tdate);
				tdate="-";

			}
			else
			{
			System.out.println("tdate   "+tdate);
			tdate = new SimpleDateFormat("dd-MMM-yyyy")
					.format(new SimpleDateFormat("yyyy-MM-dd")
							.parse(tdate)); 
			}
			String ddate=rsInvDet.getString("DueDate");
			if(ddate==null || ddate=="null" || ddate.equals("null"))
			{
				System.out.println("ddate null  =======>" + ddate);
				ddate="-";

			}
			else
			{
			System.out.println("ddate   "+ddate);
			ddate = new SimpleDateFormat("dd-MMM-yyyy")
					.format(new SimpleDateFormat("yyyy-MM-dd")
							.parse(ddate)); 
			}
			
			
			String del=rsInvDet.getString("DeliveryDate");
			if(del==null || del=="null" || del.equals("null"))
			{
				System.out.println("ddate null  =======>" + del);
				del="-";

			}

			String PFI=rsInvDet.getString("PFI");
			System.out.println("PFI null  =======>" + PFI);
			if(PFI==null || PFI=="null" || PFI.equals("null"))
			{
				System.out.println("ddate null  =======>" + PFI);
				PFI="-";

			}
			String FreightAmt=rsInvDet.getString("FreightAmt");
			System.out.println("FreightAmt null  =======>" + FreightAmt);
			Double FreightAmt1=Double.parseDouble(FreightAmt);
			if(FreightAmt==null || FreightAmt=="null" || FreightAmt.equals("null"))
			{
				System.out.println("ddate null  =======>" + FreightAmt);
				FreightAmt="-";

			}

			
		/* 	if(del==null || del=="null" || del.equals("null"))
			{
				System.out.println("ddate null  =======>" + del);
				del="-";

			}
			 */
PdfContentByte canvas1 = writer.getDirectContent();
Rectangle rect1 = new Rectangle(10, 10, 583, 830);
rect1.setBorder(Rectangle.BOX);
rect1.setBorderWidth(1);
canvas1.rectangle(rect1);

String companydata="select * from CompanyMaster where companymid="+session.getAttribute("CompanyMasterID").toString();
ResultSet rsdata=st.executeQuery(companydata);
rsdata.next();
String companyname=rsdata.getString("Companyname");


String address=rsdata.getString("address");
String phone=rsdata.getString("phone");
String mail=rsdata.getString("emailid");
String website=rsdata.getString("website");
String fax=rsdata.getString("fax");
String godownaddress=rsdata.getString("godownaddress");     
String GSTINNO=rsdata.getString("GSTINNO");
String InvRaisedCompName=rsInvDet.getString("InvRaisedCompName");
String InvRaisedBillAdd=rsInvDet.getString("InvRaisedBillAdd");
String InvRaisedShipAdd=rsInvDet.getString("InvRaisedShipAdd");
String InvRaisedConDet=rsInvDet.getString("InvRaisedConDet");



Paragraph preface = new Paragraph(15);

preface.add(new Paragraph(InvRaisedCompName,catFont));
preface.setAlignment("center");
preface.add(new Paragraph(InvRaisedBillAdd,smallfont2));
preface.setAlignment("center");
preface.add(new Paragraph(InvRaisedConDet,smallfont2));
preface.setAlignment("center");

document.add(preface);

Paragraph NF2 = new Paragraph();
NF2.add(new Paragraph("",NF));
NF2.setAlignment("Right");

Paragraph preface2 = new Paragraph();
preface2.add(new Paragraph("BILLING & DESPATCH OFFICE : "+ address,new3));
preface2.setAlignment("center");
document.add(preface2);

Paragraph preface3 = new Paragraph();
preface3.add(new Paragraph("GSTIN NO : "+ GSTINNO,new3));
preface3.setAlignment("center");
document.add(preface3);

document.add(NF2);	

			totalAmount=rsInvDet.getString("Total");
			totalAmountInWords=rsInvDet.getString("TotalinWords");
			termsconditions=rsInvDet.getString("Terms");
	//	System.out.println(">>     ....   "+rsInvoiceDet.getString("InvoiceDate"));

	
String billdetails="Select * from "+session.getAttribute("CompanyMasterID").toString()+"customerdet where CustomerCode='"+rsInvDet.getString("CustomerCode")+"' ";
		ResultSet rsbilldetails=st6.executeQuery(billdetails);
		
		System.out.println("Billing Details    "+billdetails);
		
		String billstate="",shipstate="",billgstin="",shipgstin="";
		if(rsbilldetails.next())
		{
			billstate=rsbilldetails.getString("BillingState");
			shipstate=rsbilldetails.getString("ShippingState");
			billgstin=rsbilldetails.getString("BillingGSTN");
			shipgstin=rsbilldetails.getString("ShippingGSTN");
		}
			
	
	PdfPTable tableFirst = new PdfPTable(2);

	tableFirst.setWidthPercentage(100);
	tableFirst.getDefaultCell().setBorder(Rectangle.NO_BORDER);
	tableFirst.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
	tableFirst.getDefaultCell().setVerticalAlignment(Element.ALIGN_MIDDLE);
	

	PdfPCell firstcell = new PdfPCell();
	firstcell.setFixedHeight(150f);
	firstcell.addElement(new Paragraph("Name     :     "+rsInvDet.getString("CompanyName") +" " ,Fontforname));
	firstcell.addElement(new Paragraph("Address :     "+rsInvDet.getString("Address")  +"",Fontforname));
	firstcell.addElement(new Paragraph("City        :     "+rsInvDet.getString("city")  +"",Fontforname));
	firstcell.addElement(new Paragraph("Zip         :     "+rsInvDet.getString("Zip")  +"",Fontforname));
	firstcell.addElement(new Paragraph("Fax        :     "+rsInvDet.getString("Fax") +" ",Fontforname));
	firstcell.addElement(new Paragraph("Phone    :     "+rsInvDet.getString("Phone") +" ",Fontforname));
	firstcell.addElement(new Paragraph("Billing State    :     "+billstate +" ",Fontforname));
	firstcell.addElement(new Paragraph("Billing GSTIN    :     "+billgstin +" ",Fontforname));
	tableFirst.addCell(firstcell);

	PdfPCell firstcell1 = new PdfPCell();
	
	firstcell1.addElement(new Paragraph("Date        : "+new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsInvDet.getString("InvoiceDate"))),Fontforname ));
	firstcell1.setHorizontalAlignment(Element.ALIGN_RIGHT);
	
	firstcell1.addElement(new Paragraph("PO No     : "+rsInvDet.getString("CustPurON"),Fontforname));
	firstcell1.setHorizontalAlignment(Element.ALIGN_RIGHT);
	
	firstcell1.addElement(new Paragraph("From       : "+fdate,Fontforname));
	firstcell1.setHorizontalAlignment(Element.ALIGN_RIGHT);
	
	firstcell1.addElement(new Paragraph("To            : "+tdate,Fontforname));
	firstcell1.setHorizontalAlignment(Element.ALIGN_RIGHT);
	
	firstcell1.addElement(new Paragraph("DueDate  : "+ddate,Fontforname));
	firstcell1.setHorizontalAlignment(Element.ALIGN_RIGHT);
	
	
	firstcell1.addElement(new Paragraph("Delivery Date: "+del,Fontforname));
	firstcell1.setHorizontalAlignment(Element.ALIGN_RIGHT);
	
	if(rsInvDet.getString("CustPurDT").toString().equals("-") || rsInvDet.getString("CustPurDT") == null)
	{
		firstcell1.addElement(new Paragraph("PO Date  : ",Fontforname));
	}
	else
	{
		firstcell1.addElement(new Paragraph("PO Date  : "+new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsInvDet.getString("CustPurDT"))),Fontforname));
	}
	firstcell1.setHorizontalAlignment(Element.ALIGN_RIGHT);
	firstcell1.addElement(new Paragraph("Shipping State  : "+shipstate,Fontforname));
	firstcell1.setHorizontalAlignment(Element.ALIGN_RIGHT);
	firstcell1.addElement(new Paragraph("Shipping GSTIN  : "+shipgstin,Fontforname));
	firstcell1.setHorizontalAlignment(Element.ALIGN_RIGHT);
	tableFirst.addCell(firstcell1);

	document.add(tableFirst);
		
	Paragraph Subject = new Paragraph();
	Subject.add(new Paragraph("Proforma Invoice :"+rsInvDet.getString("invoiceRefNo")+" ",underline));
	Subject.setAlignment("Center");
	document.add(Subject);
	
	Paragraph contact = new Paragraph();
	contact.add(new Paragraph("Kind Atten :"+rsInvDet.getString("ContactPerson") +" ",NormalFont));
	contact.setAlignment("Center");
	document.add(contact);
	
	Paragraph para2 = new Paragraph();
	para2.add(new Paragraph("Dear Sir, ",NormalFont));
	para2.add(new Paragraph("We are forwarding the Proforma Invoice for your above mentioned PO. Please process the same for the payment.",NormalFont));
	document.add(para2);
	//addEmptyLine(preface, 2);
	document.add( Chunk.NEWLINE );
	
		
	//float[] widths = {0.02f, 0.06f, 0.05f, 0.05f,0.04f,0.05f, 0.02f, 0.04f, 0.04f,0.03f,0.04f};
	float[] widths = {0.02f,0.05f, 0.04f,0.04f, 0.04f, 0.04f,0.04f,0.04f,0.04f,0.04f,0.04f,0.04f,0.04f,0.03f,0.04f};
	
	PdfPTable table = new PdfPTable(widths);
	table.setWidthPercentage(100);
	// t.setBorderColor(BaseColor.GRAY);
	// t.setPadding(4);
	// t.setSpacing(4);
	// t.setBorderWidth(1);

	PdfPCell c1 = new PdfPCell(new Phrase("Sr No",NormalFont1));
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(c1);

	/* c1 = new PdfPCell(new Phrase("Group",NormalFont1));
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(c1); */
	
	String sqllbl="select * from LableMaster where CompanyId="+session.getAttribute("CompanyMasterID").toString();		
	ResultSet rslbl=stlbl.executeQuery(sqllbl);
	while(rslbl.next()){
	
		/* c1 = new PdfPCell(new Phrase(rslbl.getString("Make"),NormalFont1));
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(c1);

	c1 = new PdfPCell(new Phrase(rslbl.getString("Model"),NormalFont1));
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(c1);


	c1 = new PdfPCell(new Phrase(rslbl.getString("PartNo"),NormalFont1));
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(c1);
 */
	c1 = new PdfPCell(new Phrase(rslbl.getString("Description"),NormalFont1));
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(c1);

	}
	
	c1 = new PdfPCell(new Phrase("HSN/ \n SAC",NormalFont1));
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(c1); 
	
	c1 = new PdfPCell(new Phrase("Qty",NormalFont1));
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(c1);
	
	c1 = new PdfPCell(new Phrase("Rate",NormalFont1));
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(c1);
	
	c1 = new PdfPCell(new Phrase("Amount",NormalFont1));
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(c1);
	
	c1 = new PdfPCell(new Phrase("Discount",NormalFont1));
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(c1);
	
	c1 = new PdfPCell(new Phrase("Taxable \n Amt",NormalFont1));
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(c1);
	
	
	c1 = new PdfPCell(new Phrase("CGST \n Rate",NormalFont1));
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(c1);
	
	c1 = new PdfPCell(new Phrase("CGST \n Amt",NormalFont1));
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(c1);
	
	c1 = new PdfPCell(new Phrase("SGST \n Rate",NormalFont1));
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(c1);
	c1 = new PdfPCell(new Phrase("SGST \n Amt",NormalFont1));
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(c1);
	
	c1 = new PdfPCell(new Phrase("IGST \n Rate",NormalFont1));
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(c1);
	c1 = new PdfPCell(new Phrase("IGST \n Amt",NormalFont1));
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(c1);
	
	c1 = new PdfPCell(new Phrase("Total",NormalFont1));
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(c1);
	
	double tax=0,discount=0.00 ,total=0.00;
	String HSNCode="",SACCode="";
String model="";
	String sqlInvItems="SELECT * FROM  "+session.getAttribute("CompanyMasterID").toString()+"performainvoice_items WHERE InvoiceNo='"+rsInvDet.getString("InvoiceNo")+"'";
	System.out.println(sqlInvItems);
	ResultSet rsInvItems=st1.executeQuery(sqlInvItems);
	i=1;
	double TotTaxableValue=0.00;
	double TotCGSTValue=0.00;
	double TotSGSTValue=0.00;
	double TotIGSTValue=0.00;
	double TotGST=0.00;
	double TotAmount=0.00;
		while(rsInvItems.next())
		{
			groupName="";makeName="";refMakeNameTable="";
			groupCode=rsInvItems.getInt("TheGroup");
			makeCode=rsInvItems.getInt("Make");
			itemCode=rsInvItems.getString("ItemCode");
			HSNCode=rsInvItems.getString("HSNCode");
			SACCode=rsInvItems.getString("SACCode");
			
			String  sqlGroup="SELECT TheGroupName from "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster WHERE TheGroupCode='"+groupCode+"'";
			ResultSet rsGroup=st2.executeQuery(sqlGroup);
			System.out.println(sqlGroup);
			if(rsGroup.next())
			groupName=rsGroup.getString("TheGroupName");
			System.out.println(groupName);
			if(groupCode<5)
			{
				refMakeNameTable=session.getAttribute("CompanyMasterID").toString()+"tbl_"+groupName.substring(0,5)+"makemaster";
				String sqlMakename="SELECT MakeName FROM "+refMakeNameTable.toLowerCase()+"  WHERE makecode='"+makeCode+"' ";
				ResultSet rsMakeName=st3.executeQuery(sqlMakename);
				if(rsMakeName.next())
				makeName=rsMakeName.getString(1);
				else
				makeName="-";
						      
				sqlDisplayDesc="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_"+groupName.substring(0,5).toLowerCase()+"im_make"+makeCode+" where ItemCode='"+itemCode+"'";
			}
			else
			{
				sqlDisplayDesc="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+groupCode+" where ItemCode='"+itemCode+"' ";
				makeName="-"  ;
			}
			%>
			<script type="text/javascript">
			document.getElementById('groupTop').value='<%=groupName%>';
			document.getElementById('MakeTop').value='<%=makeName%>';
			</script>
			<%  
			ResultSet rsDisplayDesc=st3.executeQuery(sqlDisplayDesc);
			
			if(rsDisplayDesc.next())
			{
				
				model=rsDisplayDesc.getString("Model");
				
				System.out.println("IN IF   ");
				
				String selprice=rsInvItems.getString("SellingPrice");
				if(selprice.equals("-"))
						{
					selprice="0.00";
						}
				String disprice=rsInvItems.getString("DiscountPercent");
				if(disprice.equals("-"))
				{
					disprice="0.00";
				}
				
				String cgstrate=rsInvItems.getString("CGSTRate");
			      System.out.println(" cgstrate :- "+cgstrate);

				if(cgstrate.equals("-"))
				{
					cgstrate="0.00";
				}
				String sgstrate=rsInvItems.getString("SGSTRate");
				if(sgstrate.equals("-"))
				{
					sgstrate="0.00";
				}
				String igstrate=rsInvItems.getString("IGSTRate");
				if(igstrate.equals("-"))
				{
					igstrate="0.00";
				}
				
				  double sp=Double.parseDouble(selprice);
			      double dp=Double.parseDouble(disprice);
			      double stper=Double.parseDouble(cgstrate);
			      double stper1=Double.parseDouble(sgstrate);
			      double stper2=Double.parseDouble(igstrate);
			      
			      System.out.println(" CGST Rate :- "+stper);
			      System.out.println(" CGST Rate :- "+stper1);
			      System.out.println(" CGST Rate :- "+stper2);


				System.out.println("3333333333333333333333333333333333333333333333");
		    a=rsDisplayDesc.getString("Partno");
			System.out.println(a);
	    b=rsInvItems.getString("ItemDescription") ;
		System.out.println(b);
		    c=rsInvItems.getString("Quantity") ;
			System.out.println(c);
		   h=rsInvItems.getString("SellingPrice") ;
			System.out.println(h);
		    u=rsInvItems.getString("DiscountPercent");
			System.out.println(u);
		    m=rsInvItems.getString("STPercent");
			System.out.println(m);
		    n=nf.format((rsInvItems.getDouble("SellingPrice")-((rsInvItems.getDouble("DiscountPercent")/100)*rsInvItems.getDouble("SellingPrice"))
				    +((rsInvItems.getDouble("STPercent")/100)*rsInvItems.getDouble("SellingPrice")))*rsInvItems.getInt("Quantity"));
			
			 //double sp=rsInvItems.getDouble("SellingPrice");
		      //double dp=rsInvItems.getDouble("DiscountPercent");
		      //double stper=rsInvItems.getDouble("STPercent");
		      
		      double qty=rsInvItems.getInt("Quantity");
		      //double disval=(sp-((dp/100)*sp));
		      //System.out.println("disc value-->"+disval);
		      //double tot1=((sp-((dp/100)*sp))+((stper/100)*disval))*qty;
		      //double tot = (double) Math.round(tot1 * 100) / 100;
		      //System.out.println("(("+sp+"-(("+dp+"/100)*"+sp+"))+(("+stper+"/100)*"+sp+"))*"+qty+"====>"+tot);
		      
		      double amt=(sp*qty);
		      double discamt=((dp/100)*sp);
		      double taxableamount=(sp*qty)-((dp/100)*sp);
		      double cgsttax=taxableamount*stper/100;
		      double sgsttax=taxableamount*stper1/100;
		      double igsttax=taxableamount*stper2/100;
		      double totamt=taxableamount+cgsttax+sgsttax+igsttax;
		      System.out.println("totamt totamt-->"+totamt);
		      double pf=Double.parseDouble(PFI);
		       d1=(totamt*pf)/100;
		      System.out.println("d1->"+d1);

		      
		      double disval=(sp-((dp/100)*sp));
		      System.out.println("disc value-->"+disval);
		      double tot1=((sp-((dp/100)*sp))+((stper/100)*disval))*qty;
		      double tot = (double) Math.round(tot1 * 100) / 100;
		      System.out.println("(("+sp+"-(("+dp+"/100)*"+sp+"))+(("+stper+"/100)*"+sp+"))*"+qty+"====>"+tot);
		    
		      System.out.println(n);
			    o=makeName;
				System.out.println(o);
			    p=groupName;
				System.out.println(p);
			    q=rsDisplayDesc.getString("Model");
				System.out.println(q);
				
				String cgsttaxrate="";
				String sgsttaxrate="";
				String igsttaxrate="";
				
				cgsttaxrate=rsInvDet.getString("CGSTRate");
				System.out.println("CGST Rate :-"+cgsttaxrate);
				if(cgsttaxrate.equals("-"))
				{
					cgsttaxrate="0.00";
				}
				sgsttaxrate=rsInvDet.getString("SGSTRate");
				System.out.println("CGST Rate :-"+cgsttaxrate);
				if(sgsttaxrate.equals("-"))
				{
					sgsttaxrate="0.00";
				}
				igsttaxrate=rsInvDet.getString("SGSTRate");
				System.out.println("CGST Rate :-"+cgsttaxrate);
				if(igsttaxrate.equals("-"))
				{
					igsttaxrate="0.00";
				}
				
				double CGSTRate=Double.parseDouble(cgsttaxrate);
				double SGSTRate=Double.parseDouble(sgsttaxrate);
				double IGSTRate=Double.parseDouble(igsttaxrate);

			   c1 = new PdfPCell(new Phrase(""+ i++ +"",NormalFont21));
				c1.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table.addCell(c1);
				
				 /* c1 = new PdfPCell(new Phrase(""+ p +"",NormalFont21));
					c1.setHorizontalAlignment(Element.ALIGN_LEFT);
					table.addCell(c1);	
			    
					 c1 = new PdfPCell(new Phrase(""+ o +"",NormalFont21));
						c1.setHorizontalAlignment(Element.ALIGN_LEFT);
						table.addCell(c1);	
						
						 c1 = new PdfPCell(new Phrase(""+ q +"",NormalFont21));
							c1.setHorizontalAlignment(Element.ALIGN_LEFT);
							table.addCell(c1);
							
							 c1 = new PdfPCell(new Phrase(""+ a +"",NormalFont21));
								c1.setHorizontalAlignment(Element.ALIGN_LEFT);
								table.addCell(c1); */
								
								
								
				c1 = new PdfPCell(new Phrase(""+ b +"",NormalFont21));
				c1.setHorizontalAlignment(Element.ALIGN_LEFT);
				table.addCell(c1);
				
				c1 = new PdfPCell(new Phrase(""+ SACCode +"",NormalFont21));
				c1.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table.addCell(c1);
				
				 c1 = new PdfPCell(new Phrase(""+ c +"",NormalFont21));
					c1.setHorizontalAlignment(Element.ALIGN_RIGHT);
					table.addCell(c1);
					
					 c1 = new PdfPCell(new Phrase(""+ h +"",NormalFont21));
						c1.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table.addCell(c1);
						
						c1 = new PdfPCell(new Phrase(""+ nf.format(amt) +"",NormalFont21));
						c1.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table.addCell(c1);
						 
						 c1 = new PdfPCell(new Phrase(""+ nf.format(discamt)+"",NormalFont21));
							c1.setHorizontalAlignment(Element.ALIGN_RIGHT);
							table.addCell(c1);
							
							c1 = new PdfPCell(new Phrase(""+ nf.format(amt-discamt) +"",NormalFont21));
							c1.setHorizontalAlignment(Element.ALIGN_RIGHT);
							table.addCell(c1);
							
							
							 c1 = new PdfPCell(new Phrase(""+ nf.format(stper) +"%",NormalFont21));
								c1.setHorizontalAlignment(Element.ALIGN_RIGHT);
								table.addCell(c1);
								
								c1 = new PdfPCell(new Phrase(""+ nf.format(cgsttax) +"",NormalFont21));
								c1.setHorizontalAlignment(Element.ALIGN_RIGHT);
								table.addCell(c1);
								
								c1 = new PdfPCell(new Phrase(""+ nf.format(stper1) +"%",NormalFont21));
								c1.setHorizontalAlignment(Element.ALIGN_RIGHT);
								table.addCell(c1);
								
								c1 = new PdfPCell(new Phrase(""+ nf.format(sgsttax) +"",NormalFont21));
								c1.setHorizontalAlignment(Element.ALIGN_RIGHT);
								table.addCell(c1);
								
								c1 = new PdfPCell(new Phrase(""+ nf.format(stper2) +"%",NormalFont21));
								c1.setHorizontalAlignment(Element.ALIGN_RIGHT);
								table.addCell(c1);
								
								c1 = new PdfPCell(new Phrase(""+ nf.format(igsttax) +"",NormalFont21));
								c1.setHorizontalAlignment(Element.ALIGN_RIGHT);
								table.addCell(c1);
								
								 c1 = new PdfPCell(new Phrase(""+  nf.format(totamt) +"",NormalFont21));
									c1.setHorizontalAlignment(Element.ALIGN_RIGHT);
									table.addCell(c1);
									
									TotTaxableValue=TotTaxableValue+(amt-discamt);
									TotCGSTValue=TotCGSTValue+cgsttax;
									TotSGSTValue=TotSGSTValue+sgsttax;
									TotIGSTValue=TotIGSTValue+igsttax;
									System.out.println("TotSGSTValue Rate :-"+TotSGSTValue);

}


}
TotGST=TotCGSTValue+TotSGSTValue+TotIGSTValue;
TotAmount=TotGST+TotTaxableValue+FreightAmt1+d1;
TotAmount=Math.round(TotAmount);

		document.add(table);

		
		/* Paragraph paratotal=new Paragraph();
		paratotal.add(new Paragraph(" Total (Rs)  : "+totalAmount+" ",Normal));
		paratotal.setAlignment("Right");
		document.add(paratotal);

		Paragraph parapfi=new Paragraph();
		parapfi.add(new Paragraph(" P & F & I (%)  : "+rsInvDet.getString("PFI")+" ",Normal));
		parapfi.setAlignment("Right");
		document.add(parapfi);

		Paragraph parafright=new Paragraph();
		parafright.add(new Paragraph(" Freight Amt : "+rsInvDet.getString("FreightAmt")+" ",Normal));
		parafright.setAlignment("Right");
		document.add(parafright);

		Paragraph paragtotal=new Paragraph();
		paragtotal.add(new Paragraph(" Grand Total : "+rsInvDet.getString("GrandTotal")+" ",Normal));
		paragtotal.setAlignment("Right");
		document.add(paragtotal);
 */		
		Paragraph paratotal=new Paragraph();
		paratotal.add(new Paragraph(" Total Amount Before Tax : "+nf.format(TotTaxableValue)+" ",Normal));
		paratotal.setAlignment("Right");
		document.add(paratotal);

		 

		Paragraph paratotal11=new Paragraph();
		paratotal11.add(new Paragraph(" Total CGST : "+nf.format(TotCGSTValue)+" ",Normal));
		paratotal11.setAlignment("Right");
		document.add(paratotal11);

		Paragraph paratotal12=new Paragraph();
		paratotal12.add(new Paragraph(" Total SGST : "+nf.format(TotSGSTValue)+" ",Normal));
		paratotal12.setAlignment("Right");
		document.add(paratotal12);

		Paragraph paratotal13=new Paragraph();
		paratotal13.add(new Paragraph(" Total IGST : "+nf.format(TotIGSTValue)+" ",Normal));
		paratotal13.setAlignment("Right");
		document.add(paratotal13);

		Paragraph paratotal14=new Paragraph();
		paratotal14.add(new Paragraph(" Total GST : "+nf.format(TotGST)+" ",Normal));
		paratotal14.setAlignment("Right");
		document.add(paratotal14);
		
		Paragraph paratotal15=new Paragraph();
		paratotal15.add(new Paragraph(" P & F & I(%)  : "+PFI+" ",Normal));
		paratotal15.setAlignment("Right");
		document.add(paratotal15);

		Paragraph paratotal16=new Paragraph();
		paratotal16.add(new Paragraph("FreightAmt  : "+FreightAmt+" ",Normal));
		paratotal16.setAlignment("Right");
		document.add(paratotal16);
		

		Paragraph paratotal17=new Paragraph();
		paratotal17.add(new Paragraph(" Total Amount After Tax  : "+nf.format(TotAmount)+" ",Normal));
		paratotal17.setAlignment("Right");
		document.add(paratotal17);



		Paragraph paratotalInWords=new Paragraph();
		paratotalInWords.add(new Paragraph(totalAmountInWords,Normal));
		paratotalInWords.setAlignment("Right");
		document.add(paratotalInWords);


		Paragraph parabottom1=new Paragraph();
		parabottom1.add(new Paragraph("For "+ InvRaisedCompName,Normal));
		parabottom1.setAlignment("Right");
		document.add(parabottom1);

		try
		{
		Image image1=null;
		PreparedStatement ps = conn.prepareStatement("Select Signature from db_GlobalERP.UserMaster where EMPName='"+rsInvDet.getString("TWEmpName")+"'");

		ResultSet rs = ps.executeQuery();

		if (rs != null)
		{
			System.out.println("RSSSSSS NOOOOTTT Nulll");
			while(rs.next()) 
			{
				image1 = Image.getInstance(rs.getBytes("Signature"));
				image1.setWidthPercentage(100f);
				image1.setDpi(50,50);
			}
		}
		SimpleTable table321 = new SimpleTable();
		table321.setWidthpercentage(100f);
		table321.setBorder(Rectangle.NO_BORDER);
		SimpleCell row = new SimpleCell(SimpleCell.ROW);

		SimpleCell cellforname12 = new SimpleCell(SimpleCell.CELL);
		cellforname12 = new SimpleCell(SimpleCell.CELL);
		cellforname12.setWidth(0.30f);
		cellforname12.add("");
		row.add(cellforname12);

		SimpleCell cellforname123 = new SimpleCell(SimpleCell.CELL);
		cellforname123 = new SimpleCell(SimpleCell.CELL);
		cellforname123.setWidth(0.30f);
		cellforname123.add("");
		row.add(cellforname123);

		SimpleCell cellforname1234 = new SimpleCell(SimpleCell.CELL);
		cellforname1234 = new SimpleCell(SimpleCell.CELL);
		cellforname1234.setWidth(0.30f);
		cellforname1234.add("");
		row.add(cellforname1234);


		SimpleCell cellforname = new SimpleCell(SimpleCell.CELL);
		cellforname = new SimpleCell(SimpleCell.CELL);
		cellforname.add(image1);
		cellforname.setWidth(100f);
		cellforname.setWidth(0.10f);
		cellforname.setWidthpercentage(100f);
		cellforname.setHorizontalAlignment(Element.ALIGN_LEFT);
		row.add(cellforname);
		table321.addElement(row);
		document.add(table321);
		}
		catch(Exception ex)
		{
			System.out.print(ex);
			document.add(Chunk.NEWLINE );
			document.add(Chunk.NEWLINE );
			document.add(Chunk.NEWLINE );
			
		}




		Paragraph signature=new Paragraph();
		signature.add(new Paragraph(" "+rsInvDet.getString("TWEmpName")+" ",Normal));
		signature.setAlignment("Right");
		document.add(signature);

		Paragraph parabottom2=new Paragraph();
		parabottom2.add(new Paragraph("(Authorised Signature)",Normal));
		parabottom2.setAlignment("Right");
		document.add(parabottom2);




Paragraph terms=new Paragraph();
terms.add(new Paragraph("  TERMS & CONDITIONS :",forterms));
terms.add(new Paragraph(""+termsconditions+" ",NormalFont));
terms.setAlignment("Left");
document.add(terms);



Paragraph parabottom5=new Paragraph();
parabottom5.add(new Paragraph("Subject to Pune Jurisdiction ",forterms));
parabottom5.setAlignment("Left");
document.add(parabottom5);

/* Paragraph parabottom6=new Paragraph();

PreparedStatement ptx=conn.prepareStatement("select VAT_TINNO,cstno, PANNo, ServiceCategory, ServiceTax from CompanyMaster where companymid=?");
ptx.setInt(1,Integer.parseInt(session.getAttribute("CompanyMasterID").toString()));
ResultSet rstx=ptx.executeQuery();
while(rstx.next())
{
parabottom6.add(new Paragraph("VAT TIN NO.: "+rstx.getString(1)+",             Pan No.: "+rstx.getString(3)+",               Service Category:"+rstx.getString(4)+".  ",NormalFont));
parabottom6.add(new Paragraph("CST TIN NO.: "+rstx.getString(2)+",            Service Tax No.: "+rstx.getString(5)+"  " ,NormalFont));
parabottom6.setAlignment("Left");
}
document.add(parabottom6);
 */
Paragraph parabottom6=new Paragraph();
PreparedStatement ptx=conn.prepareStatement("select VAT_TINNO,cstno, PANNo, ServiceCategory, ServiceTax from CompanyMaster where companymid=?");
ptx.setInt(1,Integer.parseInt(session.getAttribute("CompanyMasterID").toString()));
ResultSet rstx=ptx.executeQuery();
while(rstx.next())
{
//parabottom6.add(new Paragraph("MVAT NO. - "+rstx.getString(1)+",  CST NO. - "+rstx.getString(2)+"",NormalFont21));
parabottom6.add(new Paragraph("PAN No.- "+rstx.getString(3)+", GSTIN NO - "+GSTINNO+" " ,NormalFont21));
parabottom6.setAlignment("Left");
document.add(parabottom6);
}


Paragraph parathanks=new Paragraph();
parathanks.add(new Paragraph("Thanking you for your order.",forterms));

parathanks.setAlignment("Left");
document.add(parathanks);

Paragraph parabottom3=new Paragraph();
parabottom3.add(new Paragraph("*  Brand names & Trademarks belongs to their respective owners only. The use of original manufacturer part numbers and names quoted are provided",NormalFont));
parabottom3.add(new Paragraph("for reference purpose only. It is not intended to imply that Transworld parts are supplied by the original equipment manufacturer nor indeed is this the case.",NormalFont));
parabottom3.setAlignment("Left");
document.add(parabottom3);
PdfContentByte canvas12 = writer.getDirectContent();
Rectangle rect12 = new Rectangle(10, 10, 583, 830);
rect12.setBorder(Rectangle.BOX);
rect12.setBorderWidth(1);
canvas12.rectangle(rect12);
document.close();



DataOutput dataOutput = new DataOutputStream(response.getOutputStream());
byte[] bytes = buffer.toByteArray();
response.setContentLength(bytes.length);
for(int l = 0; l < bytes.length; l++)
{
dataOutput.writeByte(bytes[l]);
}
 		}
}catch(Exception e){
	e.printStackTrace();
	}
	finally
	{
		response.getOutputStream().close();
	}	
%>	
	</body>
	</html>
</jsp:useBean>