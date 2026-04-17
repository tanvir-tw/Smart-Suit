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
    Statement st = null, st1 = null,st2=null,st3=null,st4=null, st14=null,st15=null,stlbl=null;

	int groupCode=0;
	int d=0;

	int i=0;
	String groupName="",makeName="",itemCode="",stpercent="",makeCode="";
	String refMakeNameTable="",fromdate="";
	String pfi="",frieght="",grandTotal="";
	String frieghtType="",grandtotal="";
	
	Float u1=0.00f;
	Float m1=0.00f;
	Float Count=0.00f;
	Float Count1=0.00f;
	String sqlDisplayDesc=" ",totalAmount="",totalAmountInWords="",termsconditions="",salesQuoNumber="",status="",statusTD="";
	
	String todaysDate=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new java.util.Date());
	String todaysTime=new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
		
	String a="",b="",c="",h="",u="",m="",n="",o="",p="",q="";
	NumberFormat nf = new DecimalFormat("#0.00");
	String salesquono=request.getParameter("salesQuotation");
	System.out.println(salesquono);
	String salesquono1="";
	try {
	conn = erp.ReturnConnection();
	st = conn.createStatement();
	st2 = conn.createStatement();
	st1 = conn.createStatement();
	st3 = conn.createStatement();
	st4 = conn.createStatement();
	st14 = conn.createStatement();
	st15 = conn.createStatement();
	stlbl = conn.createStatement();
	} catch (Exception e) {
		e.printStackTrace();
	}

	%>
	
<%	

response.setContentType("application/pdf");
String filename="SalesQuotation.pdf";
response.addHeader("Content-Disposition", "attachment;filename="+filename);

///Font catFont = new Font(Font.FontFamily.TIMES_ROMAN, 18, Font.BOLD);

Document document = new Document();
try{
ByteArrayOutputStream buffer = new ByteArrayOutputStream();
PdfWriter writer=PdfWriter.getInstance(document, buffer);
	
Font catFont = new Font(Font.TIMES_ROMAN,12,Font.BOLD);
Font NormalFont = new Font(Font.TIMES_ROMAN,8);
Font Normal = new Font(Font.TIMES_ROMAN,8,Font.BOLD);
Font underline=new Font(Font.TIMES_ROMAN,10,Font.UNDERLINE);
Font Fontforname = new Font(Font.TIMES_ROMAN,9,Font.BOLD);
Font forterms = new Font(Font.TIMES_ROMAN,9,Font.BOLD);
Font smallfont = new Font(Font.TIMES_ROMAN,6,Font.BOLD);
Font headFont = new Font(Font.TIMES_ROMAN,13,Font.BOLD);
Font fortotal=new Font(Font.BOLD,10,Font.UNDERLINE);
Font new3=new Font(Font.TIMES_ROMAN,8,Font.BOLD);
Font NF = new Font(Font.TIMES_ROMAN,1,Font.NORMAL);
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

Paragraph Subject = new Paragraph();
Subject.add(new Paragraph("Sales Quotation",underline));
Subject.setAlignment("Center");
document.add(Subject);



document.add(Chunk.NEWLINE);


	String SqlQuoDet="SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det WHERE SalesQuoNo='"+salesquono+"' ";
 	System.out.println(">>>>>>>>>>>      "+SqlQuoDet);
 	ResultSet rsQuoDet=st4.executeQuery(SqlQuoDet);
 		if(rsQuoDet.next()){
 			totalAmount=rsQuoDet.getString("Total");
 			totalAmountInWords=rsQuoDet.getString("TotalinWords");
 			termsconditions=rsQuoDet.getString("TermsAndConditions");
 			salesquono1=rsQuoDet.getString("SalesQuoNo");
	
	PdfPTable tableFirst = new PdfPTable(2);

	tableFirst.setWidthPercentage(100);
	tableFirst.getDefaultCell().setBorder(Rectangle.NO_BORDER);
	tableFirst.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
	tableFirst.getDefaultCell().setVerticalAlignment(Element.ALIGN_MIDDLE);


	PdfPCell firstcell = new PdfPCell();
	//firstcell.setFixedHeight(100f);
	firstcell.addElement(new Paragraph("Ref NO  :     "+rsQuoDet.getString("TWSalesRefNo")+" " ,Fontforname));
	firstcell.addElement(new Paragraph("Name     :     "+rsQuoDet.getString("CompanyName") +" " ,Fontforname));
	firstcell.addElement(new Paragraph("Address :     "+rsQuoDet.getString("Address")  +"",Fontforname));
	firstcell.addElement(new Paragraph("City        :     "+rsQuoDet.getString("city")  +"",Fontforname));
	firstcell.addElement(new Paragraph("Zip         :     "+rsQuoDet.getString("Zip")  +"",Fontforname));
	firstcell.addElement(new Paragraph("Fax         :     "+rsQuoDet.getString("Fax") +" ",Fontforname));
	firstcell.addElement(new Paragraph("Phone    :     "+rsQuoDet.getString("Phone") +" ",Fontforname));
	
	tableFirst.addCell(firstcell);

	PdfPCell firstcell1 = new PdfPCell();
	//firstcell1.setFixedHeight(100f);

	firstcell1.addElement(new Paragraph("Date                     :     "+new SimpleDateFormat(
	"dd-MMM-yyyy")
	.format(new SimpleDateFormat( 
			"yyyy-MM-dd")
			.parse(rsQuoDet.getString("SalesQuoDate")))+"   ",Fontforname ));
	firstcell1.addElement(new Paragraph("Quotation No.     :     "+rsQuoDet.getString("SalesQuoNo")+"      " ,Fontforname));
	firstcell1.addElement(new Paragraph("Quotation Ref     :     "+rsQuoDet.getString("SalesquoRefNo")+"      " ,Fontforname));
	firstcell1.addElement(new Paragraph("Kind Attn            :     "+rsQuoDet.getString("ContactPerson")+"      " ,Fontforname));
	firstcell1.addElement(new Paragraph("Phone                   :     "+((rsQuoDet.getString("Phone")!=null) ? rsQuoDet.getString("Phone") : "-") +"    ",Fontforname));

	tableFirst.addCell(firstcell1);

	document.add(tableFirst);
	
	

	
	Paragraph para2 = new Paragraph();
	para2.add(new Paragraph("Dear Sir, ",NormalFont));
	para2.add(new Paragraph("We thank you for your valuable enquiry forwarded to us. Kindly find enclosed our lowest quote for the same;",NormalFont));
	document.add(para2);
	//addEmptyLine(preface, 2);
	document.add( Chunk.NEWLINE );
	
		try
	{
		

	String sqlQuoItems1="SELECT Count(*) as count FROM  "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items WHERE SalesQuoNo='"+salesquono1+"' and DiscountPercent > '0.00f'";
	ResultSet rsdata1=st14.executeQuery(sqlQuoItems1);
	while(rsdata1.next())
	{
		Count=rsdata1.getFloat("count");
		 //m1=rsdata1.getFloat("STPercent");
	}

	String sqlQuoItems2="SELECT Count(*) as count1 FROM  "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items WHERE SalesQuoNo='"+salesquono1+"' and STPercent > '0.00f'";
	ResultSet rsdata2=st15.executeQuery(sqlQuoItems2);
	while(rsdata2.next())
	{
		Count1=rsdata2.getFloat("count1");
		 //m1=rsdata1.getFloat("STPercent");
	}
	
	
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
	
	
	boolean DisFlag=false;
	boolean TaxFlag=false;
	
	PdfPTable table;
	out.println("hereeee1234");
	
	table=new PdfPTable(11);

	
	int columncount=11;
	if(Count > 0.00f)
	{
		DisFlag=true;
		System.out.println("-----11----------"+Count);
	}
	
	if(Count1 > 0.00f)
	{
		TaxFlag=true;
		System.out.println("-----12----------"+Count1);
	}
	
    if(Count == 0.00f)	
    {
	columncount--;
    }
    
    if(Count1 == 0.00f)	
    {
	columncount--;
    }
    
	table=new PdfPTable(columncount);
	
	System.out.println("final count------------>"+columncount);
	
	 
	
	out.println("hereeee next");
	
	table.setWidthPercentage(100);
	
	
	
	//table.setWidthPercentage(100);
	// t.setBorderColor(BaseColor.GRAY);
	// t.setPadding(4);
	// t.setSpacing(4);
	// t.setBorderWidth(1);
	
	PdfPCell c1;
	

	c1 = new PdfPCell(new Phrase("Sr No",NormalFont));
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(c1);

	c1 = new PdfPCell(new Phrase("Group",NormalFont));
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(c1);

	String sqllbl="select * from LableMaster where CompanyId="+session.getAttribute("CompanyMasterID").toString();		
	ResultSet rslbl=stlbl.executeQuery(sqllbl);
	while(rslbl.next())
	
	{
	
	c1 = new PdfPCell(new Phrase(rslbl.getString("Make"),NormalFont));
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(c1);

	c1 = new PdfPCell(new Phrase(rslbl.getString("Model"),NormalFont));
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(c1);
	
	c1 = new PdfPCell(new Phrase(rslbl.getString("PartNo"),NormalFont));
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(c1);

	c1 = new PdfPCell(new Phrase(rslbl.getString("Description"),NormalFont));
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(c1);
	}
	
	
	
	c1 = new PdfPCell(new Phrase("Quantity",NormalFont));
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(c1);

	c1 = new PdfPCell(new Phrase("Unit Price",NormalFont));
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(c1);
	
	
	
	if(DisFlag==true)
	{
	c1 = new PdfPCell(new Phrase("Discount(%)",NormalFont));
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(c1);
	}
	
	out.println("hereeee next m1");
	
	if(TaxFlag==true)
	{
	c1 = new PdfPCell(new Phrase("Tax(%)",NormalFont));
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(c1);
	}
	
	c1 = new PdfPCell(new Phrase("Amount",NormalFont));
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(c1);
	
	
	

     if(TaxFlag==true && DisFlag==true)
     {
    	 
    	 System.out.println("----11------------");
	 float[] columnWidths = new float[] {15f, 30f, 30f, 30f,30f, 30f, 20f, 30f,30f, 30f, 30f};
    table.setWidths(columnWidths); 
     }
	 if(TaxFlag == false && DisFlag == false)
	 {
    	 System.out.println("----09------------");
		 float[] columnWidths = new float[] {15f, 30f, 30f, 30f,30f, 30f, 20f, 30f,30f};
	    table.setWidths(columnWidths); 
	 }
	 
	 if((TaxFlag == true && DisFlag == false) || (TaxFlag == false && DisFlag == true))
	 {
    	 System.out.println("----10------------");
		 float[] columnWidths = new float[] {15f, 30f, 30f, 30f,30f, 30f, 20f, 30f,30f, 30f};
		    table.setWidths(columnWidths); 
		 
	 }
	
 	double tax=0,discount=0.00 ,total=0.00;

	String sqlQuoItems="SELECT * FROM  "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items WHERE SalesQuoNo='"+salesquono+"'";
	System.out.println(sqlQuoItems);
	ResultSet rsQuoItems=st1.executeQuery(sqlQuoItems);
	i=1;
		while(rsQuoItems.next())
		{
			groupName="";makeName="";refMakeNameTable="";
			groupCode=rsQuoItems.getInt("TheGroup");
			makeCode=rsQuoItems.getString("Make");
			itemCode=rsQuoItems.getString("ItemCode");
			  
			String  sqlGroup="SELECT TheGroupName from "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster WHERE TheGroupCode='"+groupCode+"'";
			System.out.println(sqlGroup);
			ResultSet rsGroup=st2.executeQuery(sqlGroup);
			if(rsGroup.next())
			groupName=rsGroup.getString("TheGroupName");
			if(groupCode<5)
			{
				refMakeNameTable=session.getAttribute("CompanyMasterID").toString()+"tbl_"+groupName.substring(0,5)+"makemaster";
				String sqlMakename="SELECT MakeName FROM "+refMakeNameTable.toLowerCase()+"  WHERE makecode='"+makeCode+"' ";
				System.out.println(sqlMakename);
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
	  	document.getElementById('makeTop').value='<%=makeName%>';
	  </script>
			<%
			ResultSet rsDisplayDesc=st3.executeQuery(sqlDisplayDesc);
			System.out.println("*****************************************************************888");
			System.out.println("----------Count----------------"+Count+"-------------Count1----"+Count1);
			if(rsDisplayDesc.next())
			{
				System.out.println("IN IF   ");

		    
		    a=rsDisplayDesc.getString("Partno");
			System.out.println(a);
	    	b=rsDisplayDesc.getString("Description") ;
			System.out.println(b);
		    c=rsQuoItems.getString("Quantity") ;
			System.out.println(c);
		   	h=rsQuoItems.getString("SellingPrice") ;
			System.out.println(h);
			if(DisFlag==true)
			{
		    u=rsQuoItems.getString("DiscountPercent");
			}
			
			System.out.println(u);
			if(TaxFlag==true)
			{
		    m=rsQuoItems.getString("STPercent");
			}
			
			out.println(m);
			

			 double sp=rsQuoItems.getDouble("SellingPrice");
				      double dp=rsQuoItems.getDouble("DiscountPercent");
				      double stper=rsQuoItems.getDouble("STPercent");
				      double qty=rsQuoItems.getInt("Quantity");
				      double disval=(sp-((dp/100)*sp));
				      System.out.println("disc value-->"+disval);
				      double tot1=((sp-((dp/100)*sp))+((stper/100)*disval))*qty;
				      double tot = (double) Math.round(tot1 * 100) / 100;
				      System.out.println("(("+sp+"-(("+dp+"/100)*"+sp+"))+(("+stper+"/100)*"+sp+"))*"+qty+"====>"+tot);
				    
				      /*
		    n=nf.format((rsQuoItems.getDouble("SellingPrice")-((rsQuoItems.getDouble("DiscountPercent")/100)*rsQuoItems.getDouble("SellingPrice"))
				    +((rsQuoItems.getDouble("STPercent")/100)*rsQuoItems.getDouble("SellingPrice")))*rsQuoItems.getInt("Quantity"));
				      
				      */
			System.out.println(n);
		    o=makeName;
			System.out.println(o);
		    p=groupName;
			System.out.println(p);
		    q=rsDisplayDesc.getString("Model");
			System.out.println(q);
		    
		    
		    

			c1 = new PdfPCell(new Phrase(""+ i++ +"", FontFactory.getFont(FontFactory.TIMES_ROMAN, 8)));
			c1.setHorizontalAlignment(Element.ALIGN_RIGHT); /* Align Center */
		    table.addCell(c1);  
			
		    c1 = new PdfPCell(new Phrase(""+ p +"", FontFactory.getFont(FontFactory.TIMES_ROMAN, 8)));
		    c1.setHorizontalAlignment(Element.ALIGN_LEFT); /* Align Center */
		    table.addCell(c1);
		    
		    c1 = new PdfPCell(new Phrase(""+ o +"", FontFactory.getFont(FontFactory.TIMES_ROMAN, 8)));
		    c1.setHorizontalAlignment(Element.ALIGN_LEFT); /* Align Center */
		    table.addCell(c1);
		    
		    c1 = new PdfPCell(new Phrase(""+ q +"", FontFactory.getFont(FontFactory.TIMES_ROMAN, 8)));
		    c1.setHorizontalAlignment(Element.ALIGN_LEFT); /* Align Center */
		    table.addCell(c1);
		    
		    c1 = new PdfPCell(new Phrase(""+ a +"", FontFactory.getFont(FontFactory.TIMES_ROMAN, 8)));
		    c1.setHorizontalAlignment(Element.ALIGN_LEFT); /* Align Center */
		    table.addCell(c1);
		    
		    c1 = new PdfPCell(new Phrase(""+ b +"", FontFactory.getFont(FontFactory.TIMES_ROMAN, 8)));
		    c1.setHorizontalAlignment(Element.ALIGN_LEFT); /* Align Center */
		    table.addCell(c1);
		    
		    c1 = new PdfPCell(new Phrase(""+ c +"", FontFactory.getFont(FontFactory.TIMES_ROMAN, 8)));
		    c1.setHorizontalAlignment(Element.ALIGN_RIGHT); /* Align Center */
		    table.addCell(c1);
		    
		    c1 = new PdfPCell(new Phrase(""+ h +"", FontFactory.getFont(FontFactory.TIMES_ROMAN, 8)));
		    c1.setHorizontalAlignment(Element.ALIGN_RIGHT); /* Align Center */
		    table.addCell(c1);
		    
		    if(DisFlag==true)
			{
		    c1 = new PdfPCell(new Phrase(""+ u +"", FontFactory.getFont(FontFactory.TIMES_ROMAN, 8)));
		    c1.setHorizontalAlignment(Element.ALIGN_RIGHT); /* Align Center */
		    table.addCell(c1);   
			}
		    out.println("hereeee 561");
		    if(TaxFlag==true)
			{
		    c1 = new PdfPCell(new Phrase(""+ m +"", FontFactory.getFont(FontFactory.TIMES_ROMAN, 8)));
		    c1.setHorizontalAlignment(Element.ALIGN_RIGHT); /* Align Center */
		    table.addCell(c1);   
			}
			
		    
		    c1 = new PdfPCell(new Phrase(""+ nf.format(tot) +"", FontFactory.getFont(FontFactory.TIMES_ROMAN, 8)));
		    c1.setHorizontalAlignment(Element.ALIGN_RIGHT); /* Align Center */
		    table.addCell(c1);     
		   }
			
		   }

		document.add(table);

		
		Paragraph paratotal=new Paragraph();
		paratotal.add(new Paragraph(" Total (Rs)  : "+totalAmount+" ",Normal));
		paratotal.setAlignment("Right");
		document.add(paratotal);

		
		Paragraph paragtotal=new Paragraph();
		paragtotal.add(new Paragraph(" Grand Total : "+rsQuoDet.getString("GrandTotal")+" ",Normal));
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
		PreparedStatement ps = conn.prepareStatement("Select Signature from db_GlobalERP.UserMaster where EMPName='"+rsQuoDet.getString("TWEmpName")+"'");

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
		signature.add(new Paragraph(" "+rsQuoDet.getString("TWEmpName")+" ",Normal));
		signature.setAlignment("Right");
		document.add(signature);

		Paragraph parabottom2=new Paragraph();
		parabottom2.add(new Paragraph("(Authorised Signature)",Normal));
		parabottom2.setAlignment("Right");
		document.add(parabottom2);

		Paragraph parathanks=new Paragraph();
		parathanks.add(new Paragraph("We hope our offer falls in the line of your requirement & look forward to the pleasure of receiving your valuable purchase order .",NormalFont));
		parathanks.add(new Paragraph("Thanking You",NormalFont));

		parathanks.setAlignment("Left");
		document.add(parathanks);
Paragraph terms=new Paragraph();
terms.add(new Paragraph("Terms & Condition :",forterms));
terms.add(new Paragraph(""+termsconditions+" ",NormalFont));
terms.setAlignment("Left");
document.add(terms);
PdfContentByte canvas12 = writer.getDirectContent();
Rectangle rect12 = new Rectangle(10, 10, 583, 830);
rect12.setBorder(Rectangle.BOX);
rect12.setBorderWidth(1);
canvas12.rectangle(rect1);

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