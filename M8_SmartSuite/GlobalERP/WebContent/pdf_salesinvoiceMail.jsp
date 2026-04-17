<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict/aaa/EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%-- <%@page import="com.erp.beans.EmailTemplate"%> --%>
<%@page import="java.util.Date"%>
<%@page import="com.erp.beans.TestTemplate"%>
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
String emailTo="";
String data="";
out.println("Sending Mail......!!!");
	erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
	String ss="";
	String ss1="";
	String ss2="";
	String mainMailTo="";
	String mainMailCc="";
	try{
	
	emailTo=request.getParameter("emailTo");
	ss1=request.getParameter("email");
	ss2=request.getParameter("emailTo");
	ss=request.getParameter("extraemail");
	
	mainMailTo=ss1;
	mainMailCc=ss;
	
	/* String[] email=emailToget.split(",");
	String emailTo="";
	for(int i=0;i<=email.length;i++){
		emailTo=emailTo+email[i]+",";
	} */
	System.out.println("EMAIL EXTRA   "+emailTo);
	}catch(Exception e){System.out.println("No Extra Mail Ids");}
	
	
	String pgname="";
	String reportno="";
	try{
		data=request.getParameter("data");
		data=data.replaceAll("__12__", "\"");
		data=data.replaceAll("_and_", "&");
		data=data.replaceAll("__per__", "%");
		data=data.replaceAll("_1_", "'");
		data=data.replaceAll("_1k_", "&#94;");
		data=data.replaceAll("_plus_", "&#43;");
		data=data.replaceAll("_ll_", "<");
		data=data.replaceAll("_rr_", ">");
		data=data.replaceAll("_123A_", "#");
		data=data.replaceAll("_rupee_", "&#x20B9;");
		data=data.replaceAll(" ", "&nbsp;");
		
		
		data="<font size=^2^ face=^Arial^>"+data+"</font>";
		pgname=request.getParameter("pagename");
		reportno=request.getParameter("reportnumber");
		System.out.println("Data   "+data+"--"+reportno+"--"+pgname);
		out.println("Data   "+data+"--"+reportno+"--"+pgname);
	}catch(Exception e){System.out.println("No Extra Mail Ids");}
	
%>
<%
 
    Connection conn = null;
    Statement st = null, st1 = null,st2=null,st3=null,st4=null,stlbl=null;
	String email_to="",msg="";
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
		
	String a="",b="",c="",h="",u="",m="",n="",o="",p="",q="";
	
	String invoicerefno=request.getParameter("transactionId");
	System.out.println(invoicerefno);
	out.println("invoicerefno"+invoicerefno);
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

//response.setContentType("application/pdf");
String filename="SalesInvoice.pdf";
//response.addHeader("Content-Disposition", "attachment;filename="+filename);

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
Font smallfont2 = new Font(Font.TIMES_ROMAN,6);
document.setPageSize(PageSize.A4);
document.setMargins(20,20,11,11);
document.setMarginMirroring(false);


document.open();

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

Paragraph preface = new Paragraph();
preface.add(new Paragraph(companyname,catFont));
preface.setAlignment("center");
preface.add(new Paragraph(address,NormalFont));
preface.setAlignment("center");
preface.add(new Paragraph("Tel: "+phone+"  Fax: "+fax+"  "+mail+"  "+website+"",NormalFont));
preface.setAlignment("center");

document.add(preface);

Paragraph NF2 = new Paragraph();
NF2.add(new Paragraph("",NF));
NF2.setAlignment("Right");

Paragraph preface2 = new Paragraph();
preface2.add(new Paragraph("BILLING & DESPATCH OFFICE : "+ address,new3));
preface2.setAlignment("center");
document.add(preface2);

document.add(NF2);	

String SqlQuoDet="SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet WHERE invoiceRefNo='"+invoicerefno+"' ";
	System.out.println(">>>>>>>>>>>      "+SqlQuoDet);
	ResultSet rsInvDet=st4.executeQuery(SqlQuoDet);
		if(rsInvDet.next()){
			totalAmount=rsInvDet.getString("Total");
			totalAmountInWords=rsInvDet.getString("TotalinWords");
			termsconditions=rsInvDet.getString("Terms");


			String sqlemail="SELECT Email from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where CompanyName='"+rsInvDet.getString("CompanyName")+"'";
			Statement st_e=conn.createStatement();
			ResultSet rs_s=st_e.executeQuery(sqlemail);
			if(rs_s.next()){
				email_to=rs_s.getString("Email");
				System.out.println("Email To ------"+email_to);
			}
			
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
	filename=rsInvDet.getString("invoiceRefNo");
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
parabottom1.add(new Paragraph("For "+ companyname,Normal));
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
parabottom6.add(new Paragraph("MVAT NO. -27530019079V CST NO. - 27530019079C",NormalFont21));
parabottom6.add(new Paragraph("PAN No AABCT4318G Service Tax no AABCT 4318G ST001 Service Category - Business Auxiliary Services" ,NormalFont21));
parabottom6.setAlignment("Left");
document.add(parabottom6);

Paragraph parabottom31=new Paragraph();
parabottom31.add(new Paragraph("We are a Small Enterprise Under the Micro Medium and Small Enterprise Act 2006. Govt. of India",NormalFont21));
parabottom31.add(new Paragraph("Queries regarding this Invoice to be addressed to "+mail+" Tel "+phone+"",NormalFont21));
parabottom31.setAlignment("Left");
document.add(parabottom31);

document.close();

/* DataOutput dataOutput = new DataOutputStream(response.getOutputStream());
byte[] bytes = buffer.toByteArray();
response.setContentLength(bytes.length);
for(int l = 0; l < bytes.length; l++)
{
dataOutput.writeByte(bytes[l]);
} */
System.out.println("krn");
FileOutputStream dataOutput1 = new FileOutputStream("/home/javaprg/ERPPDF/"+filename+".pdf");
//FileOutputStream dataOutput1 = new FileOutputStream("/home/karan/Desktop/test/"+filename+".pdf");
byte[] bytes1 = buffer.toByteArray();
response.setContentLength(bytes1.length);
for(int x = 0; x < bytes1.length; x++)
{
dataOutput1.write(bytes1[x]); 
}
dataOutput1.flush();
dataOutput1.close();
String mailname=(String)session.getAttribute("EmpName");
	String Description="About Invoice";
	data.replaceAll("^", "&and;");
	data="<font size=^2^ face=^Arial^>"+data+"</font>";
	String MailBody=data;//"Dear Customer,<br>Thank you for Purchase.<br> Please find attached Invoise for your purchase.";
	String comid=session.getAttribute("CompanyMasterID").toString();
	if(comid.equalsIgnoreCase("100000")){
		companyname="Transworld Technologies Ltd";
	}
	String dt_sub=new SimpleDateFormat("dd-MMM-yyyy hh:mm").format(new Date());
	
	String subjectline="Invoice from "+companyname+" on "+dt_sub;
	//String Toid="k_rajput@transworld-compressor.com";
	String Toid="";//email_to;
	try{
		if(emailTo!="" || emailTo!=null){
			Toid=emailTo;
		}
		//Toid=Toid+","+email_to;
		//Toid=Toid.replace("null,","");
	}catch(Exception e){}
	String Tocc="";
	String AttachFilePath="/home/javaprg/ERPPDF/"+filename+".pdf";
	//String AttachFilePath="/home/karan/Desktop/test/"+filename+".pdf"; 
 	String FileName=filename+".pdf";
	String SenderName="Karan Rajput";
	System.out.println("File PAth----"+AttachFilePath);
	
// 	EmailTemplate template=new EmailTemplate();
TestTemplate template=new TestTemplate();
	String date1="";
	String date2="";
	//String date3=new SimpleDateFormat("dd/MM/yyyy").format(new SimpleDateFormat(new Date().parse("")));
	String displayedReportNo=pgname+" : "+reportno;
	String ReportName=subjectline;
	StringBuffer htmlstr=new StringBuffer(MailBody);
	//htmlstr=MailBody.
	String krn="k_rajput@transworld-compressor.com";
	//mainMailTo, mainMailCc
	boolean isSend=template.sendmail(htmlstr, mainMailTo, mainMailCc, subjectline,subjectline, date1, date2, displayedReportNo, ReportName, FileName, AttachFilePath,comid,"");

	System.out.println("1");
if(isSend){
	if(Tocc==null)
		msg="Mail Sent Successfully to "+mainMailTo+","+mainMailCc;
	else
		msg="Mail Sent Successfully to "+mainMailTo+","+mainMailCc;
	}else{
		msg="Error While Sending Mail please try again...!!!!";
	}
System.out.println(msg);
//out.println(msg);
//",&invoicerefNo="+invoicerefNo+"&invoiceNumber="+invoiceNumber+"
response.sendRedirect("viewInvoice.jsp?msg="+msg+"&InvoiceRefNo="+invoicerefno+"&Invoiceno="+request.getParameter("invoicerefNo")+"&condition=View");
				
//response.sendRedirect("alert.jsp?msg="+msg+"&goto=viewInvoice.jsp?InvoiceRefNo="+request.getParameter("invoicerefNo")+"&Invoiceno="+request.getParameter("invoiceNumber")+"&condition=View");
			//viewInvoice.jsp?InvoiceRefNo=SI050815003&Invoiceno=16601&condition=View
}
}catch(Exception e){
	System.out.print("rrrr");
	out.println("<br>rrrrr "+e.getStackTrace());
	out.println("<br>rrrrr "+e.getMessage());
	e.printStackTrace();
	//response.sendRedirect("close.jsp");
}
%>

	
	</body>
	</html>
</jsp:useBean>-