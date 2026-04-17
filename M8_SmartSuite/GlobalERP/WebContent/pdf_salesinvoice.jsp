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
 
    Connection conn = null;
    Statement st = null, st1 = null,st2=null,st3=null,st4=null,stlbl=null;

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
	// NumberFormat nf = new DecimalFormat("#0.00");
	System.out.println(invoicerefno);
	try {
	conn = erp.ReturnConnection();
	st = conn.createStatement();
	st2 = conn.createStatement();
	st1 = conn.createStatement();
	st3 = conn.createStatement();
	st4 = conn.createStatement();
	stlbl = conn.createStatement();
	} catch (Exception e) {
	}

%>
	
<%	

response.setContentType("application/pdf");
String filename="SalesInvoice.pdf";
response.addHeader("Content-Disposition", "attachment;filename="+filename);

///Font catFont = new Font(Font.FontFamily.TIMES_ROMAN, 18, Font.BOLD);

Document document = new Document();
try{
ByteArrayOutputStream buffer = new ByteArrayOutputStream();
PdfWriter writer=PdfWriter.getInstance(document, buffer);
	
Font catFont = new Font(Font.TIMES_ROMAN,10,Font.BOLD);
Font headFont = new Font(Font.TIMES_ROMAN,8,Font.BOLD);
Font new1=new Font(Font.TIMES_ROMAN,10,Font.BOLD);
Font new2=new Font(Font.TIMES_ROMAN,10,Font.BOLD);
Font new3=new Font(Font.TIMES_ROMAN,8,Font.BOLD);

Font NormalFont = new Font(Font.TIMES_ROMAN,10);
Font NormalFont1 = new Font(Font.TIMES_ROMAN,8,Font.BOLD);
Font Normal = new Font(Font.TIMES_ROMAN,8,Font.BOLD);
Font NormalFont21 = new Font(Font.TIMES_ROMAN,8);

Font underline=new Font(Font.TIMES_ROMAN,10,Font.UNDERLINE);
Font Fontforname = new Font(Font.TIMES_ROMAN,8,Font.BOLD);
Font forterms = new Font(Font.TIMES_ROMAN,8,Font.BOLD);
Font smallfont = new Font(Font.TIMES_ROMAN,6,Font.BOLD);
Font NF = new Font(Font.TIMES_ROMAN,1,Font.NORMAL);
Font smallfont2 = new Font(Font.TIMES_ROMAN,8);
document.setPageSize(PageSize.A4);
document.setMargins(20,20,11,11);
document.setMarginMirroring(false);


document.open();

String SqlQuoDet="SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet WHERE invoiceRefNo='"+invoicerefno+"' ";
System.out.println(">>>>>>>>>>>      "+SqlQuoDet);
ResultSet rsInvDet=st4.executeQuery(SqlQuoDet);
	if(rsInvDet.next()){
PdfContentByte canvas1 = writer.getDirectContent();
Rectangle rect1 = new Rectangle(10, 10, 583, 830);
rect1.setBorder(Rectangle.BOX);
rect1.setBorderWidth(1);
canvas1.rectangle(rect1);


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
preface2.add(new Paragraph("BILLING & DISPATCH OFFICE : "+ InvRaisedShipAdd,new3));
preface2.setAlignment("center");
document.add(preface2);

// Chunk chunk = new Chunk("This is a sentence ");

// Phrase phrase = new Phrase(10);

// phrase.add(chunk);
// phrase.add(chunk);
// phrase.add(chunk);
// phrase.add(chunk);
// phrase.add(chunk);
// phrase.add(chunk);

// document.add(phrase);


document.add(NF2);	


			totalAmount=rsInvDet.getString("Total");
			totalAmountInWords=rsInvDet.getString("TotalinWords");
			termsconditions=rsInvDet.getString("Terms");


	
	PdfPTable tableFirst = new PdfPTable(2);

	tableFirst.setWidthPercentage(100);
	tableFirst.getDefaultCell().setBorder(Rectangle.NO_BORDER);
	tableFirst.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
	tableFirst.getDefaultCell().setVerticalAlignment(Element.ALIGN_MIDDLE);
	

	PdfPCell firstcell = new PdfPCell();
	firstcell.setFixedHeight(90f);
	firstcell.addElement(new Paragraph("Name     :     "+rsInvDet.getString("CompanyName") +" " ,Fontforname));
	firstcell.addElement(new Paragraph("Address :     "+rsInvDet.getString("Address")  +"",Fontforname));
	firstcell.addElement(new Paragraph("City        :     "+rsInvDet.getString("city")  +"",Fontforname));
	firstcell.addElement(new Paragraph("Zip         :     "+rsInvDet.getString("Zip")  +"",Fontforname));
	firstcell.addElement(new Paragraph("Fax        :     "+rsInvDet.getString("Fax") +" ",Fontforname));
	firstcell.addElement(new Paragraph("Phone    :     "+rsInvDet.getString("Phone") +" ",Fontforname));
	tableFirst.addCell(firstcell);

	PdfPCell firstcell1 = new PdfPCell();
	firstcell1.setFixedHeight(70f);

	firstcell1.addElement(new Paragraph("Date        :     "+new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsInvDet.getString("InvoiceDate"))),Fontforname ));
	firstcell1.setHorizontalAlignment(Element.ALIGN_RIGHT);
	firstcell1.addElement(new Paragraph("PO No     :     "+rsInvDet.getString("CustPurNO"),Fontforname));
	firstcell1.setHorizontalAlignment(Element.ALIGN_RIGHT);
	if(rsInvDet.getString("CustPurDT").toString().equals("-") || rsInvDet.getString("CustPurDT") == null)
	{
		firstcell1.addElement(new Paragraph("PO Date  :     ",Fontforname));
	}
	else
	{
		firstcell1.addElement(new Paragraph("PO Date  :     "+new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsInvDet.getString("CustPurDT"))),Fontforname));
	}
	firstcell1.setHorizontalAlignment(Element.ALIGN_RIGHT);
	tableFirst.addCell(firstcell1);

	document.add(tableFirst);
	
	
	
	Paragraph Subject = new Paragraph();
	Subject.add(new Paragraph("Invoice Cum Delivery Challan No. :"+rsInvDet.getString("invoiceRefNo")+" ",underline));
	Subject.setAlignment("Center");
	document.add(Subject);
	
	Paragraph contact = new Paragraph();
	contact.add(new Paragraph("Kind Attn :"+rsInvDet.getString("ContactPerson") +" ",NormalFont));
	contact.setAlignment("Center");
	document.add(contact);
	
	Paragraph NF1 = new Paragraph();
	NF1.add(new Paragraph("",NF));
	NF1.setAlignment("Right");
	document.add(NF1);
	
	
	/* PdfPTable tableFirst3 = new PdfPTable(2);

	tableFirst3.setWidthPercentage(100);
	tableFirst3.getDefaultCell().setBorder(Rectangle.NO_BORDER);
	tableFirst3.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
	tableFirst3.getDefaultCell().setVerticalAlignment(Element.ALIGN_MIDDLE);

	float[] widths1 = {0.02f, 0.06f, 0.05f, 0.05f,0.04f,0.05f, 0.02f, 0.04f, 0.04f,0.03f,0.04f};
	PdfPTable table1 = new PdfPTable(widths1);
	table1.setWidthPercentage(100);


	PdfPCell c3 = new PdfPCell(new Phrase("Sr No",NormalFont1));
	c3.setHorizontalAlignment(Element.ALIGN_CENTER);
	table1.addCell(c3);

	c3 = new PdfPCell(new Phrase("VehRegNo",NormalFont1));
	c3.setHorizontalAlignment(Element.ALIGN_CENTER);
	table1.addCell(c3); */

	/* String sqllbl1="select * from LableMaster where CompanyId="+session.getAttribute("CompanyMasterID").toString();		
	ResultSet rslbl1=stlbl.executeQuery(sqllbl1);
	while(rslbl1.next()){
		

	c3 = new PdfPCell(new Phrase(rslbl1.getString("Make"),NormalFont1));
	c3.setHorizontalAlignment(Element.ALIGN_CENTER);
	table1.addCell(c3);

	c3 = new PdfPCell(new Phrase(rslbl1.getString("Model"),NormalFont1));
	c3.setHorizontalAlignment(Element.ALIGN_CENTER);
	table1.addCell(c3);

	c3 = new PdfPCell(new Phrase(rslbl1.getString("PartNo"),NormalFont1));
	c3.setHorizontalAlignment(Element.ALIGN_CENTER);
	table1.addCell(c3);

	c3 = new PdfPCell(new Phrase(rslbl1.getString("Description"),NormalFont1));
	c3.setHorizontalAlignment(Element.ALIGN_CENTER);
	//c1.setFixedWidth(); 
	table1.addCell(c3);
	}

	c3 = new PdfPCell(new Phrase("Qty",NormalFont1));
	c3.setHorizontalAlignment(Element.ALIGN_CENTER);
	table1.addCell(c3);

	c3 = new PdfPCell(new Phrase("Unit Price",NormalFont1));
	c3.setHorizontalAlignment(Element.ALIGN_CENTER);
	table1.addCell(c3);

	c3 = new PdfPCell(new Phrase("Discount",NormalFont1));
	c3.setHorizontalAlignment(Element.ALIGN_CENTER);
	table1.addCell(c3); */

	// document.add(table1);
	
	float[] widths = {0.02f, 0.06f, 0.05f, 0.05f,0.04f,0.05f, 0.02f, 0.04f, 0.04f,0.03f,0.04f};
	PdfPTable table = new PdfPTable(widths);
	table.setWidthPercentage(100);
	// t.setBorderColor(BaseColor.GRAY);
	// t.setPadding(4);
	// t.setSpacing(4);
	// t.setBorderWidth(1);

	PdfPCell c1 = new PdfPCell(new Phrase("Sr No",NormalFont1));
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(c1);
	
	c1 = new PdfPCell(new Phrase("Group",NormalFont1));
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(c1);
	
	String sqllbl="select * from LableMaster where CompanyId="+session.getAttribute("CompanyMasterID").toString();		
	ResultSet rslbl=stlbl.executeQuery(sqllbl);
	while(rslbl.next()){
		
	
	c1 = new PdfPCell(new Phrase(rslbl.getString("Make"),NormalFont1));
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(c1);
	
	c1 = new PdfPCell(new Phrase(rslbl.getString("Model"),NormalFont1));
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(c1);
	
	c1 = new PdfPCell(new Phrase(rslbl.getString("PartNo"),NormalFont1));
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(c1);
	
	c1 = new PdfPCell(new Phrase(rslbl.getString("Description"),NormalFont1));
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	//c1.setFixedWidth(); 
	table.addCell(c1);
	}
	
	c1 = new PdfPCell(new Phrase("Qty",NormalFont1));
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(c1);
	
	c1 = new PdfPCell(new Phrase("Unit Price",NormalFont1));
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(c1);
	
	c1 = new PdfPCell(new Phrase("Discount",NormalFont1));
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(c1);
	
	c1 = new PdfPCell(new Phrase("Tax",NormalFont1));
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(c1);
	
	c1 = new PdfPCell(new Phrase("Amount",NormalFont1));
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(c1);
	
 	double tax=0,discount=0.00 ,total=0.00;
 	String model="";

	String sqlInvItems="SELECT * FROM  "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items WHERE InvoiceNo='"+rsInvDet.getString("InvoiceNo")+"'";
	System.out.println(sqlInvItems);
	ResultSet rsInvItems=st1.executeQuery(sqlInvItems);
	i=1;
		while(rsInvItems.next())
		{
			groupName="";makeName="";refMakeNameTable="";
			groupCode=rsInvItems.getInt("TheGroup");
			makeCode=rsInvItems.getInt("Make");
			itemCode=rsInvItems.getString("ItemCode");
			  
			String  sqlGroup="SELECT TheGroupName from "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster WHERE TheGroupCode='"+groupCode+"'";
			ResultSet rsGroup=st2.executeQuery(sqlGroup);
			if(rsGroup.next())
			groupName=rsGroup.getString("TheGroupName");
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
			else{
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
			//
			 double sp=rsInvItems.getDouble("SellingPrice");
				      double dp=rsInvItems.getDouble("DiscountPercent");
				      double stper=rsInvItems.getDouble("STPercent");
				      double qty=rsInvItems.getInt("Quantity");
				      double disval=(sp-((dp/100)*sp));
				      System.out.println("disc value-->"+disval);
				      double tot1=((sp-((dp/100)*sp))+((stper/100)*disval))*qty;
				      double tot = (double) Math.round(tot1 * 100) / 100;
				      System.out.println("(("+sp+"-(("+dp+"/100)*"+sp+"))+(("+stper+"/100)*"+sp+"))*"+qty+"====>"+tot);
				    
				    
			/*
		    n=nf.format((rsInvItems.getDouble("SellingPrice")-((rsInvItems.getDouble("DiscountPercent")/100)*rsInvItems.getDouble("SellingPrice"))
				    +((rsInvItems.getDouble("STPercent")/100)*rsInvItems.getDouble("SellingPrice")))*rsInvItems.getInt("Quantity"));
			*/
			System.out.println(tot);
		    o=makeName;
			System.out.println(o);
		    p=groupName;
			System.out.println(p);
		    q=rsDisplayDesc.getString("Model");
			System.out.println(q);
		    
		    
		    c1 = new PdfPCell(new Phrase(""+ i++ +"",NormalFont21));
			c1.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c1);
			
			 c1 = new PdfPCell(new Phrase(""+ p +"",NormalFont21));
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
							table.addCell(c1);
							
							 c1 = new PdfPCell(new Phrase(""+ b +"",NormalFont21));
								c1.setHorizontalAlignment(Element.ALIGN_LEFT);
								table.addCell(c1);
								
								 c1 = new PdfPCell(new Phrase(""+ c +"",NormalFont21));
									c1.setHorizontalAlignment(Element.ALIGN_RIGHT);
									table.addCell(c1);
									
									 c1 = new PdfPCell(new Phrase(""+ h +"",NormalFont21));
										c1.setHorizontalAlignment(Element.ALIGN_RIGHT);
										table.addCell(c1);
										
										 c1 = new PdfPCell(new Phrase(""+ u +"",NormalFont21));
											c1.setHorizontalAlignment(Element.ALIGN_RIGHT);
											table.addCell(c1);
											
											 c1 = new PdfPCell(new Phrase(""+ m +"",NormalFont21));
												c1.setHorizontalAlignment(Element.ALIGN_RIGHT);
												table.addCell(c1);
												
												 c1 = new PdfPCell(new Phrase(""+  nf.format(tot) +"",NormalFont21));
													c1.setHorizontalAlignment(Element.ALIGN_RIGHT);
													table.addCell(c1);
												
			}
		   }

document.add(table);
		
Paragraph paratotal=new Paragraph();
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
terms.add(new Paragraph("TERMS & CONDITIONS :",NormalFont1));
terms.add(new Paragraph(""+termsconditions.trim()+" ",NormalFont21));
terms.setAlignment("Left");
document.add(terms);

document.add(NF2);
Paragraph parathanks=new Paragraph();
parathanks.add(new Paragraph("Thanking You For Your Order.",NormalFont1));
parathanks.setAlignment("Left");
document.add(parathanks);
Paragraph parabottom3=new Paragraph();
parabottom3.add(new Paragraph("*  Brand names & Trademarks belongs to their respective owners only. The use of original manufacturer part numbers and names quoted are provided for reference purpose only. It is not intended to imply that Transworld parts are supplied by the original equipment manufacturer nor indeed is this the case.",NormalFont21));
parabottom3.setAlignment("Left");
document.add(parabottom3);

document.add(NF2);

Paragraph parabottom4=new Paragraph();
parabottom4.add(new Paragraph("I/We hereby certify that my/our registration certificate under the Maharashtra Value Added Tax Act 2002 is in force on the date on which the sales of the goods specified in this tax invoice is made by me/us and that this transaction of sales covered by this tax invoice has been effected by me /us and is shall be accounted for in the turnover of sales while filling of return and the due tax.If any payable on the sales has been paid or shall be paid.  ",NormalFont21));
parabottom4.setAlignment("Left");
document.add(parabottom4);

document.add(NF2);
PdfContentByte canvas12 = writer.getDirectContent();
Rectangle rect12 = new Rectangle(10, 10, 583, 830);
rect12.setBorder(Rectangle.BOX);
rect12.setBorderWidth(1);
canvas12.rectangle(rect12);

Paragraph parabottom5=new Paragraph();
parabottom5.add(new Paragraph("Subject To Pune Jurisdiction :-",NormalFont1));
parabottom5.setAlignment("Left");
document.add(parabottom5);

Paragraph parabottom6=new Paragraph();
PreparedStatement ptx=conn.prepareStatement("select VAT_TINNO,cstno, PANNo, ServiceCategory, ServiceTax from CompanyMaster where companymid=?");
ptx.setInt(1,Integer.parseInt(session.getAttribute("CompanyMasterID").toString()));
ResultSet rstx=ptx.executeQuery();
while(rstx.next())
{
parabottom6.add(new Paragraph("MVAT NO. - "+rstx.getString(1)+",  CST NO. - "+rstx.getString(2)+"",NormalFont21));
parabottom6.add(new Paragraph("PAN No.- "+rstx.getString(3)+", Service Tax No. - "+rstx.getString(5)+", Service Category - "+rstx.getString(5)+"" ,NormalFont21));
parabottom6.setAlignment("Left");
document.add(parabottom6);
}
Paragraph parabottom31=new Paragraph();
parabottom31.add(new Paragraph("We are a Small Enterprise Under the Micro Medium and Small Enterprise Act 2006. Govt. of India",NormalFont21));
parabottom31.add(new Paragraph("Queries regarding this Invoice to be addressed to "+InvRaisedConDet,NormalFont21));
parabottom31.setAlignment("Left");
document.add(parabottom31);

document.add(NF2);



String InvoiceType=rsInvDet.getString("InvoiceType");
System.out.println("Invoice Type ---->"+InvoiceType);


if(InvoiceType.equals("ASCInvoice") || InvoiceType.equals("ASCShortSummary"))
{
	System.out.println("Inside Annexure ---->");
	
	
	Paragraph parabottom32=new Paragraph();
	parabottom32.add(new Paragraph("Annexure Of Invoice :-",NormalFont1));
	parabottom32.setAlignment("Left");
	document.add(parabottom32);


	Paragraph NF4 = new Paragraph();
	NF4.add(new Paragraph("",NF));
	NF4.setAlignment("Right");
	document.add(NF4);
	
	PdfPTable tableFirst1 = new PdfPTable(3);

	tableFirst1.setWidthPercentage(100);
	tableFirst1.getDefaultCell().setBorder(Rectangle.NO_BORDER);
	tableFirst1.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
	tableFirst1.getDefaultCell().setVerticalAlignment(Element.ALIGN_MIDDLE);


	//float[] widths = {0.02f, 0.06f, 0.05f, 0.05f,0.04f,0.05f, 0.02f, 0.04f, 0.04f,0.03f,0.04f};

	//select * FROM  db_GlobalERP.AnnexureMaster where Invoicetype='ASCInvoice'
	float[] widthss = {0.02f, 0.05f, 0.05f, 0.05f,0.04f,0.05f,0.02f, 0.03f, 0.03f,0.03f,0.02f,0.06f};
	PdfPTable table1 = new PdfPTable(widthss);
	table1.setWidthPercentage(100);

	PdfPCell c2 = new PdfPCell(new Phrase("Sr No",NormalFont1));
	c2.setHorizontalAlignment(Element.ALIGN_CENTER);
	table1.addCell(c2);


	String sqllbl1="select * from AnnexureMaster where Invoicetype='ASCInvoice'";		
	ResultSet rslbl1=stlbl.executeQuery(sqllbl1);
	while(rslbl1.next()){
		

	c2 = new PdfPCell(new Phrase(rslbl1.getString("col1"),NormalFont1));
	c2.setHorizontalAlignment(Element.ALIGN_CENTER);
	table1.addCell(c2);

	c2 = new PdfPCell(new Phrase(rslbl1.getString("col2"),NormalFont1));
	c2.setHorizontalAlignment(Element.ALIGN_CENTER);
	table1.addCell(c2);

	c2 = new PdfPCell(new Phrase(rslbl1.getString("col3"),NormalFont1));
	c2.setHorizontalAlignment(Element.ALIGN_CENTER);
	table1.addCell(c2);

	/* c2 = new PdfPCell(new Phrase(rslbl1.getString("AMC"),NormalFont1));
	c2.setHorizontalAlignment(Element.ALIGN_CENTER);
	//c1.setFixedWidth(); 
	table1.addCell(c2); */

	c2 = new PdfPCell(new Phrase(rslbl1.getString("col5"),NormalFont1));
	c2.setHorizontalAlignment(Element.ALIGN_CENTER);
	//c1.setFixedWidth(); 
	table1.addCell(c2);

	c2 = new PdfPCell(new Phrase(rslbl1.getString("col6"),NormalFont1));
	c2.setHorizontalAlignment(Element.ALIGN_CENTER);
	//c1.setFixedWidth(); 
	table1.addCell(c2);

	c2 = new PdfPCell(new Phrase(rslbl1.getString("col7"),NormalFont1));
	c2.setHorizontalAlignment(Element.ALIGN_CENTER);
	//c1.setFixedWidth(); 
	table1.addCell(c2);
	c2 = new PdfPCell(new Phrase(rslbl1.getString("col8"),NormalFont1));
	c2.setHorizontalAlignment(Element.ALIGN_CENTER);


	//c1.setFixedWidth(); 
	table1.addCell(c2);
	c2 = new PdfPCell(new Phrase(rslbl1.getString("col9"),NormalFont1));
	c2.setHorizontalAlignment(Element.ALIGN_CENTER);
	//c1.setFixedWidth(); 
	table1.addCell(c2);
	c2 = new PdfPCell(new Phrase(rslbl1.getString("col10"),NormalFont1));
	c2.setHorizontalAlignment(Element.ALIGN_CENTER);
	//c1.setFixedWidth(); 
	table1.addCell(c2);
	c2 = new PdfPCell(new Phrase(rslbl1.getString("col10"),NormalFont1));
	c2.setHorizontalAlignment(Element.ALIGN_CENTER);
	//c1.setFixedWidth(); 
	table1.addCell(c2);
	c2 = new PdfPCell(new Phrase(rslbl1.getString("col12"),NormalFont1));
	c2.setHorizontalAlignment(Element.ALIGN_CENTER);
	//c1.setFixedWidth(); 
	table1.addCell(c2);

	//select VehRegNo,InstDt,Captured,IngOff,Total from db_GlobalERP.ASCAnnexureMaster  where invoiceno='18996' and invoicetype='ASCInvoice'

	//String VehRegNo="",InstDt="",Captured="",IngOff="",Total="";


	InvoiceNo=rsInvDet.getString("invoiceRefNo");



	System.out.println("Annexure-----InvoiceRefNo---->"+InvoiceNo);

		
		System.out.println("Inside ASC Annexure");
	// String VehRegNo="",instdate="",warranty="",ASC="",ASCBillFrom="",ASCBillTo="",Days="",Age="",Rate="",Amount="",RatePerDay="",Description="",ASCCovered="";
	 String Annexure="select VehRegNo,Date_Format(InstDt,'%d-%b-%Y') as InstDt,Date_Format(Warranty,'%d-%b-%Y') as Warranty,Date_Format(ASCBillFrom,'%d-%b-%Y') as ASCBillFrom,Date_Format(ASCBillTo,'%d-%b-%Y') as ASCBillTo,Days,Age,Rate,Amount,RatePerDay,Description,Date_Format(ASCCovered,'%d-%b-%Y') as ASCCovered from db_GlobalERP.ASCAnnexureMaster where invoiceno='"+InvoiceNo+"' and invoicetype='ASCInvoice' order by Description";
	//previousString Annexure="select VehRegNo,Date_Format(InstDt,'%d-%b-%Y') as InstDt,Date_Format(Warranty,'%d-%b-%Y') as Warranty,Date_Format(ASCBillFrom,'%d-%b-%Y') as ASCBillFrom,Date_Format(ASCBillTo,'%d-%b-%Y') as ASCBillTo,Days,Age,Rate,Amount,RatePerDay,Description,Date_Format(ASCCovered,'%d-%b-%Y') as ASCCovered from db_GlobalERP.ASCAnnexureMaster where invoicetype='ASCInvoice' order by Description";
	//String Annexure="select VehRegNo,Date_Format(InstDt,'%d-%b-%Y') as InstDt,Date_Format(Warranty,'%d-%b-%Y') as Warranty,Date_Format(ASCBillFrom,'%d-%b-%Y') as ASCBillFrom,Date_Format(ASCBillTo,'%d-%b-%Y') as ASCBillTo,Days,Age,Rate,Amount,RatePerDay,Description,Date_Format(ASCCovered,'%d-%b-%Y') as ASCCovered from db_GlobalERP.ASCAnnexureMaster where invoiceno='SI19920161' and invoicetype='ASCInvoice' order by Description"; //hardcoded
		System.out.println("Annexure--------->"+Annexure);
		ResultSet rs=st1.executeQuery(Annexure);
		i=1;
			while(rs.next())
			{
				VehRegNo=rs.getString("VehRegNo");
				instdate=rs.getString("InstDt");
				warranty=rs.getString("Warranty");
				ASCBillFrom=rs.getString("ASCBillFrom");
				ASCBillTo=rs.getString("ASCBillTo");
				
				Days=rs.getString("Days");
				Age=rs.getString("Age");
				Rate=rs.getString("Rate");
				Amount=rs.getString("Amount");
				RatePerDay=rs.getString("RatePerDay");
				Description=rs.getString("Description");
				//ASCCovered=rs.getString("ASCCovered");
				
				c2 = new PdfPCell(new Phrase(""+ i++ +"",NormalFont21));
				c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table1.addCell(c2);
				
				 c2 = new PdfPCell(new Phrase(""+ VehRegNo+"",NormalFont21));
					c2.setHorizontalAlignment(Element.ALIGN_LEFT);
					table1.addCell(c2);	
			    
					 c2 = new PdfPCell(new Phrase(""+ instdate +"",NormalFont21));
						c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table1.addCell(c2);	
						
						 c2 = new PdfPCell(new Phrase(""+ warranty+"",NormalFont21));
							c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
							table1.addCell(c2);
							
							/* c2 = new PdfPCell(new Phrase(""+ ASCCovered+"",NormalFont21));
							c2.setHorizontalAlignment(Element.ALIGN_LEFT);
							table1.addCell(c2); */
							
							 c2 = new PdfPCell(new Phrase(""+ ASCBillFrom +"",NormalFont21));
								c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
								table1.addCell(c2);
								
								 c2 = new PdfPCell(new Phrase(""+ ASCBillTo +"",NormalFont21));
									c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
									table1.addCell(c2);
									
									c2 = new PdfPCell(new Phrase(""+ Days +"",NormalFont21));
									c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
									table1.addCell(c2);
									
									c2 = new PdfPCell(new Phrase(""+ Age +"",NormalFont21));
									c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
									table1.addCell(c2);
									
									c2 = new PdfPCell(new Phrase(""+ Rate +"",NormalFont21));
									c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
									table1.addCell(c2);
									
									c2 = new PdfPCell(new Phrase(""+ Amount +"",NormalFont21));
									c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
									table1.addCell(c2);
									
									c2 = new PdfPCell(new Phrase(""+ RatePerDay +"",NormalFont21));
									c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
									table1.addCell(c2);
									
									c2 = new PdfPCell(new Phrase(""+ Description +"",NormalFont21));
									c2.setHorizontalAlignment(Element.ALIGN_LEFT);
									table1.addCell(c2);
									
									 
				
			} 

			
			
	}



	document.add(table1);

	Paragraph NF5 = new Paragraph();
	NF5.add(new Paragraph("",NF));
	NF5.setAlignment("Right");
	document.add(NF5);


	Paragraph parabottom34=new Paragraph();
	parabottom34.add(new Paragraph("Short Summary Annexure :-",NormalFont1));
	parabottom34.setAlignment("Left");
	document.add(parabottom34);


	Paragraph NF6 = new Paragraph();
	NF6.add(new Paragraph("",NF));
	NF6.setAlignment("Right");
	document.add(NF6);


	PdfPTable tableFirst2 = new PdfPTable(3);

	tableFirst2.setWidthPercentage(100);
	tableFirst2.getDefaultCell().setBorder(Rectangle.NO_BORDER);
	tableFirst2.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
	tableFirst2.getDefaultCell().setVerticalAlignment(Element.ALIGN_MIDDLE);

	float[] widthss1 = {0.02f, 0.05f, 0.05f, 0.05f,0.04f,0.05f,0.05f};
	PdfPTable table2 = new PdfPTable(widthss1);
	table2.setWidthPercentage(100);

	PdfPCell c3 = new PdfPCell(new Phrase("Sr No",NormalFont1));
	c3.setHorizontalAlignment(Element.ALIGN_CENTER);
	table2.addCell(c3);

	String sqllbl12="select * from AnnexureMaster where Invoicetype='ASCShortSummary'";		
	ResultSet rslbl2=stlbl.executeQuery(sqllbl12);
	while(rslbl2.next()){
		

	c3 = new PdfPCell(new Phrase(rslbl2.getString("col1"),NormalFont1));
	c3.setHorizontalAlignment(Element.ALIGN_CENTER);
	table2.addCell(c3);

	c3 = new PdfPCell(new Phrase(rslbl2.getString("col2"),NormalFont1));
	c3.setHorizontalAlignment(Element.ALIGN_CENTER);
	table2.addCell(c3);

	c3 = new PdfPCell(new Phrase(rslbl2.getString("col3"),NormalFont1));
	c3.setHorizontalAlignment(Element.ALIGN_CENTER);
	table2.addCell(c3);



	c3 = new PdfPCell(new Phrase(rslbl2.getString("col4"),NormalFont1));
	c3.setHorizontalAlignment(Element.ALIGN_CENTER);
	//c1.setFixedWidth(); 
	table2.addCell(c3);

	c3 = new PdfPCell(new Phrase(rslbl2.getString("col5"),NormalFont1));
	c3.setHorizontalAlignment(Element.ALIGN_CENTER);
	//c1.setFixedWidth(); 
	table2.addCell(c3);

	c3 = new PdfPCell(new Phrase(rslbl2.getString("col6"),NormalFont1));
	c3.setHorizontalAlignment(Element.ALIGN_CENTER);
	//c1.setFixedWidth(); 
	table2.addCell(c3);



	String fromDate = new SimpleDateFormat("yyyy-MM-dd")
	.format(new SimpleDateFormat("dd-MMM-yyyy")
			.parse(ASCBillFrom));

	String toDate=new SimpleDateFormat("yyyy-MM-dd")
	.format(new SimpleDateFormat("dd-MMM-yyyy")
	.parse(ASCBillTo));



	String Annexure1="select * from db_GlobalERP.ASCAnnexureMaster where invoicetype='ASCShortSummary' and invoiceno='"+InvoiceNo+"' "; 
	System.out.println("Annexure Short Summary --------->"+Annexure1);
	ResultSet rs=st1.executeQuery(Annexure1);

	String ItemCode="",ItemDescription="",Vehicle="",VehicleDays="",Amount1="",SellingPrice="";
	i=1;
		while(rs.next())
		{
			ItemCode=rs.getString("ItemCode");
			ItemDescription=rs.getString("ItemDescription");
			Vehicle=rs.getString("Vehicle");
			VehicleDays=rs.getString("VehicleDays");
			Amount1=rs.getString("Amount");
			double total1=Double.parseDouble(Amount1);
			SellingPrice=rs.getString("SellingPrice");
			VehicleCount=rs.getString("VehicleCount");
			DaysCount=rs.getString("DaysCount");
			TotalAmount=rs.getString("TotalAmount");
			
			c3 = new PdfPCell(new Phrase(""+ i++ +"",NormalFont21));
			c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table2.addCell(c3);
			
			 c3 = new PdfPCell(new Phrase(""+ ItemCode+"",NormalFont21));
				c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table2.addCell(c3);	
		    
				 c3 = new PdfPCell(new Phrase(""+ ItemDescription +"",NormalFont21));
					c3.setHorizontalAlignment(Element.ALIGN_LEFT);
					table2.addCell(c3);	
					
					 c3 = new PdfPCell(new Phrase(""+ Vehicle+"",NormalFont21));
						c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
						table2.addCell(c3);
						
						/* c2 = new PdfPCell(new Phrase(""+ ASCCovered+"",NormalFont21));
						c2.setHorizontalAlignment(Element.ALIGN_LEFT);
						table1.addCell(c2); */
						
						 c3 = new PdfPCell(new Phrase(""+ VehicleDays +"",NormalFont21));
							c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
							table2.addCell(c3);
							
							 c3 = new PdfPCell(new Phrase(""+ SellingPrice +"",NormalFont21));
								c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
								table2.addCell(c3);
								
								c3 = new PdfPCell(new Phrase(""+nf.format(total1) +"",NormalFont21));
								c3.setHorizontalAlignment(Element.ALIGN_RIGHT);
								table2.addCell(c3);
								
								
								 
			
		} 

	}

	document.add(table2);

	Paragraph paratotal1=new Paragraph();
	paratotal1.add(new Paragraph(" Total (Vehicle)  : "+VehicleCount+" ",Normal));
	paratotal1.setAlignment("Right");
	document.add(paratotal1);

	Paragraph paratotal2=new Paragraph();
	paratotal2.add(new Paragraph(" Total (Days)  : "+DaysCount+" ",Normal));
	paratotal2.setAlignment("Right");
	document.add(paratotal2);



	Paragraph paratotal3=new Paragraph();
	paratotal3.add(new Paragraph(" Total (Amount)  : "+TotalAmount+" ",Normal));
	paratotal3.setAlignment("Right");
	document.add(paratotal3);
	
	
}

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