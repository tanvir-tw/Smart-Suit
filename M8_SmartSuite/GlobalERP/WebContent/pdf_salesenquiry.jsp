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

	int groupCode=0;
	int d=0;

	int i=0;
	String groupName="",makeName="",itemCode="",stpercent="",makeCode="";
	String refMakeNameTable="",fromdate="";
	String pfi="",frieght="",grandTotal="";
	String frieghtType="",grandtotal="";
	String sqlDisplayDesc=" ",totalAmount="",totalAmountInWords="",termsconditions="",salesQuoNumber="",status="",statusTD="";
	
	String todaysDate=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new java.util.Date());
	String todaysTime=new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
		
	String a="",b="",c="",h="",u="",m="",n="",o="",p="",q="",bc="";
	NumberFormat nf = new DecimalFormat("#0.00");
	String enqno="";
	String enqrefno=request.getParameter("senqrefno");
	System.out.println(enqrefno);
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
String filename="SalesEnquiry.pdf";
response.addHeader("Content-Disposition", "attachment;filename="+filename);

///Font catFont = new Font(Font.FontFamily.TIMES_ROMAN, 18, Font.BOLD);

Document document = new Document();
try{
ByteArrayOutputStream buffer = new ByteArrayOutputStream();
PdfWriter writer=PdfWriter.getInstance(document, buffer);
	
Font catFont = new Font(Font.TIMES_ROMAN,12,Font.BOLD);
Font NormalFont = new Font(Font.TIMES_ROMAN,8);
Font underline=new Font(Font.TIMES_ROMAN,10,Font.UNDERLINE);
Font Fontforname = new Font(Font.TIMES_ROMAN,9,Font.BOLD);
Font NormalFont21 = new Font(Font.TIMES_ROMAN,8);
Font forterms = new Font(Font.TIMES_ROMAN,9,Font.BOLD);
Font NF = new Font(Font.TIMES_ROMAN,1,Font.NORMAL);
Font NormalFont1 = new Font(Font.TIMES_ROMAN,8,Font.BOLD);
Font smallfont = new Font(Font.TIMES_ROMAN,6,Font.BOLD);
Font new3=new Font(Font.TIMES_ROMAN,8,Font.BOLD);
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
document.add( Chunk.NEWLINE );
Paragraph preface = new Paragraph();
preface.add(new Paragraph(companyname.trim(),catFont));
preface.setAlignment("center");
preface.add(new Paragraph(address.trim(),NormalFont));
preface.setAlignment("center");
preface.add(new Paragraph("Tel: "+phone+"  Fax: "+fax+"  "+mail+"  "+website+"",NormalFont));
preface.setAlignment("center");

document.add(preface);

Paragraph preface2 = new Paragraph();
preface2.add(new Paragraph("BILLING & DESPATCH OFFICE : "+ address,new3));
preface2.setAlignment("center");
document.add(preface2);

document.add( Chunk.NEWLINE );
Paragraph NF2 = new Paragraph();
NF2.add(new Paragraph("",NF));
NF2.setAlignment("Right");

Paragraph Subject = new Paragraph();
Subject.add(new Paragraph("Sales Enquiry",underline));
Subject.setAlignment("Center");
document.add(Subject);

document.add( Chunk.NEWLINE );
String SqlEnqDet = "SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det WHERE SalesEnqRefNo='"+enqrefno+"' ";
System.out.println(">>>>>>>>>>>      " + SqlEnqDet);
ResultSet rsEnqDet = st4.executeQuery(SqlEnqDet);
if (rsEnqDet.next()) {
	enqno=rsEnqDet.getString("SalesEnqNo");    
	PdfPTable tableFirst1 = new PdfPTable(2);

	tableFirst1.setWidthPercentage(100);
	tableFirst1.getDefaultCell().setBorder(Rectangle.NO_BORDER);
	tableFirst1.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
	tableFirst1.getDefaultCell().setVerticalAlignment(Element.ALIGN_MIDDLE);
	

	PdfPCell firstcell12 = new PdfPCell();
	firstcell12.setFixedHeight(90f);
	firstcell12.addElement(new Paragraph("Name     :     "+rsEnqDet.getString("CompanyName") +" " ,Fontforname));
	firstcell12.addElement(new Paragraph("Address :     "+rsEnqDet.getString("Address")  +"",Fontforname));
	firstcell12.addElement(new Paragraph("City        :     "+rsEnqDet.getString("city")  +"",Fontforname));
	firstcell12.addElement(new Paragraph("Zip         :     "+rsEnqDet.getString("Zip")  +"",Fontforname));
	firstcell12.addElement(new Paragraph("Fax        :     "+rsEnqDet.getString("Fax") +" ",Fontforname));
	firstcell12.addElement(new Paragraph("Phone    :     "+rsEnqDet.getString("Phone") +" ",Fontforname));
	tableFirst1.addCell(firstcell12);

	PdfPCell firstcell1 = new PdfPCell();
	firstcell1.setFixedHeight(70f);

	firstcell1.addElement(new Paragraph("Date        :     "+new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsEnqDet.getString("SalesEnqDate"))),Fontforname ));
	firstcell1.addElement(new Paragraph("Enq No.  :     "+rsEnqDet.getString("SalesEnqRefNo")+" ",Fontforname));
	firstcell1.setHorizontalAlignment(Element.ALIGN_RIGHT);
	tableFirst1.addCell(firstcell1);

	document.add(tableFirst1);

	
			
}
		
	Paragraph para2 = new Paragraph();
	preface.add(new Paragraph("Dear Sir, ",NormalFont));
	preface.add(new Paragraph("As per Your order,we are sending you the required material.",NormalFont));
	document.add(para2);
	//addEmptyLine(preface, 2);
	document.add( Chunk.NEWLINE );
	
	PdfPTable table = new PdfPTable(7);
	table.setWidthPercentage(100);
	// t.setBorderColor(BaseColor.GRAY);
	// t.setPadding(4);
	// t.setSpacing(4);
	// t.setBorderWidth(1);

	PdfPCell c1 = new PdfPCell(new Phrase("Sr No",new3));
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(c1);

	String sqllbl="select * from LableMaster where CompanyId="+session.getAttribute("CompanyMasterID").toString();		
	ResultSet rslbl=stlbl.executeQuery(sqllbl);
	while(rslbl.next()){
		
	
	c1 = new PdfPCell(new Phrase(rslbl.getString("Make"),new3));
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(c1);

	c1 = new PdfPCell(new Phrase(rslbl.getString("Model"),new3));
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(c1);
	
	c1 = new PdfPCell(new Phrase(rslbl.getString("PartNo"),new3));
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(c1);

	c1 = new PdfPCell(new Phrase(rslbl.getString("Description"),new3));
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(c1);
	}
	c1 = new PdfPCell(new Phrase("Quantity",new3));
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(c1);

	c1 = new PdfPCell(new Phrase("Unit Price",new3));
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(c1);
	
	double tax = 0, discount = 0.00, total = 0.00;

	String sqlEnqItems = "SELECT * FROM  "+session.getAttribute("CompanyMasterID").toString()+"salesenq_items WHERE SalesEnqNo='"+enqno+"'";
	System.out.println(sqlEnqItems);
	ResultSet rsEnqItems = st1.executeQuery(sqlEnqItems);
	i = 1;
	while (rsEnqItems.next())
		{
			groupName = "";
			makeName = "";
			refMakeNameTable = "";
			groupCode = rsEnqItems.getInt("TheGroup");
			makeCode = rsEnqItems.getString("Make");
			itemCode = rsEnqItems.getString("ItemCode");
	
			String sqlGroup = "SELECT TheGroupName from "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster WHERE TheGroupCode='"
					+ groupCode + "'";
			ResultSet rsGroup = st2.executeQuery(sqlGroup);
			if (rsGroup.next())
				groupName = rsGroup.getString("TheGroupName");
			if (groupCode < 5) {
				refMakeNameTable = session.getAttribute("CompanyMasterID").toString()+"tbl_" + groupName.substring(0, 5)
						+ "makemaster";
				String sqlMakename = "SELECT MakeName FROM "
						+ refMakeNameTable.toLowerCase()
						+ "  WHERE makecode='" + makeCode + "' ";
				ResultSet rsMakeName = st3.executeQuery(sqlMakename);
				if (rsMakeName.next())
					makeName = rsMakeName.getString(1);
				else
					makeName = "-";
				sqlDisplayDesc = "SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_"
						+ groupName.substring(0, 5).toLowerCase()
						+ "im_make" + makeCode + " where ItemCode='"
						+ itemCode + "'";
			} else {
				sqlDisplayDesc = "SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"
						+ groupCode + " where ItemCode='" + itemCode
						+ "' ";
				makeName = "-";
			}
	        System.out.println(sqlDisplayDesc);
			ResultSet rsDisplayDesc = st3.executeQuery(sqlDisplayDesc);
	
			if (rsDisplayDesc.next())
			{
				    
			    a=makeName;
				System.out.println(a);
				bc=rsDisplayDesc.getString("Model");
		        b=rsDisplayDesc.getString("Partno");
		      	System.out.println(b);
			    c=rsDisplayDesc.getString("Description");
				System.out.println(c);
			    h=rsEnqItems.getString("Quantity") ;
				System.out.println(h);
			    if(rsDisplayDesc.getString("SellingPrice")==null)
			    {
					u="0.00";
			    }
			    else
			    {
			    	u=rsDisplayDesc.getString("SellingPrice");
				    	
			    }
				System.out.println(u);
			    
			    table.addCell(new Phrase(""+ i++ +"", FontFactory.getFont(FontFactory.TIMES_ROMAN, 8)));
			    table.addCell(new Phrase(""+ a +"", FontFactory.getFont(FontFactory.TIMES_ROMAN, 8)));
			    table.addCell(new Phrase(""+ bc +"", FontFactory.getFont(FontFactory.TIMES_ROMAN, 8)));
			    table.addCell(new Phrase(""+ b +"", FontFactory.getFont(FontFactory.TIMES_ROMAN, 8)));
			    table.addCell(new Phrase(""+ c +"", FontFactory.getFont(FontFactory.TIMES_ROMAN, 8)));
			    table.addCell(new Phrase(""+ h +"", FontFactory.getFont(FontFactory.TIMES_ROMAN, 8)));
			    table.addCell(new Phrase(""+ u +"", FontFactory.getFont(FontFactory.TIMES_ROMAN, 8)));
			   
			}
				
		}

		document.add(table);

		
		Paragraph parabottom1=new Paragraph();
		parabottom1.add(new Paragraph("For "+ companyname,new3));
		parabottom1.setAlignment("Right");
		document.add(parabottom1);

		try
		{
		Image image1=null;
		PreparedStatement ps = conn.prepareStatement("Select Signature from db_GlobalERP.UserMaster where EMPName='"+rsEnqDet.getString("TWEmpName")+"'");

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
		signature.add(new Paragraph(" "+rsEnqDet.getString("TWEmpName")+" ",new3));
		signature.setAlignment("Right");
		document.add(signature);

		Paragraph parabottom2=new Paragraph();
		parabottom2.add(new Paragraph("(Authorised Signature)",new3));
		parabottom2.setAlignment("Right");
		document.add(parabottom2);

		Paragraph parathanks=new Paragraph();
		parathanks.add(new Paragraph("Thanking You For Your Enquiry.",NormalFont1));
		parathanks.setAlignment("Left");
		document.add(parathanks);
		Paragraph parabottom3=new Paragraph();
		parabottom3.add(new Paragraph("*  Brand names & Trademarks belongs to their respective owners only. The use of original manufacturer part numbers and names quoted are provided for reference purpose only. It is not intended to imply that Transworld parts are supplied by the original equipment manufacturer nor indeed is this the case.",NormalFont21));
		parabottom3.setAlignment("Left");
		document.add(parabottom3);

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
		parabottom31.add(new Paragraph("Queries regarding this Enquiry to be addressed to "+mail+" Tel "+phone+"",NormalFont21));
		parabottom31.setAlignment("Left");
		document.add(parabottom31);


document.close();

DataOutput dataOutput = new DataOutputStream(response.getOutputStream());
byte[] bytes = buffer.toByteArray();
response.setContentLength(bytes.length);
for(int l = 0; l < bytes.length; l++)
{
dataOutput.writeByte(bytes[l]);
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