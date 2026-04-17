<%@page import="java.util.Date"%>
<%@page language="java" import="java.sql.*"  import=" java.text.*" import=" java.util.*" errorPage="close.jsp" 
%>
<%@ include file="conn.jsp" %>
<!DOCTYPE html>
<%@page import="com.erp.beans.*"%> --%>
<%@page import="com.erp.beans.TestTemplate"%>
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

	<head>
	<script type="text/javascript">
	function fun(){
		alert("Error");
	//	window.close();
	}
	</script>
	</head>
	
	
	
	<body onload="fun()"> 
		
<%
erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
String emailTo="";
String data="";
String ss="";
String ss1="";
String ss2="";
String mainMailTo="";
String mainMailCc="";
try{

emailTo=request.getParameter("CcMail2");
//ss1=request.getParameter("email");
//ss2=request.getParameter("emailTo");
ss=request.getParameter("CcMail1");

mainMailTo=emailTo;
mainMailCc=ss;
/* String[] email=emailToget.split(",");
String emailTo="";
for(int i=0;i<=email.length;i++){
	emailTo=emailTo+email[i]+",";
} */
if(emailTo==null){
	emailTo="";
}
System.out.println("EMAIL EXTRA   "+emailTo);
}catch(Exception e){System.out.println("No Extra Mail Ids");}
String pgname="";
String reportno="";
try{
// 	data=request.getParameter("data");
// 	data=data.replaceAll("\"", "^");
// 	data=data.replaceAll("_and_", "&");
// 	data=data.replaceAll("__per__", "%");
// 	data=data.replaceAll("_1_", "'");

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
		//data=data.replaceAll(" ", "&nbsp;");
		
		
		data="<font size=^2^ face=^Arial^>"+data+"</font>";







	pgname=request.getParameter("pagename");
	reportno=request.getParameter("reportnumber");
	System.out.println("Data   "+data+"--"+reportno+"--"+pgname);
	out.println("Data   "+data+"--"+reportno+"--"+pgname+" end");
	out.println("<br>2");
}catch(Exception e){System.out.println("No Extra Mail Ids");}
%>
<%
//out.println("564654");
String msg="";
    Connection conn = null;
    Statement st = null, st1 = null,st2=null,st3=null,st4=null,st14=null,st15=null, stlbl=null;

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
		
	String a="",b="",c="",h="",u="",m="",n="",o="",p="",q="";
	NumberFormat nf = new DecimalFormat("#0.00");
	String salesquono=request.getParameter("salesQuotation");
	String salesquono1="";
	System.out.println(salesquono);
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
//response.setContentType("application/pdf");
String filename="SalesQuotation.pdf";
//response.addHeader("Content-Disposition", "attachment;filename="+filename);
///Font catFont = new Font(Font.FontFamily.TIMES_ROMAN, 18, Font.BOLD);
out.println("<br>3");
Document document = new Document();

try{
ByteArrayOutputStream buffer = new ByteArrayOutputStream();
PdfWriter writer=PdfWriter.getInstance(document, buffer);

Font Normal = new Font(Font.TIMES_ROMAN,8,Font.BOLD);
Font catFont = new Font(Font.TIMES_ROMAN,12,Font.BOLD);
Font NormalFont = new Font(Font.TIMES_ROMAN,8);
Font underline=new Font(Font.TIMES_ROMAN,10,Font.UNDERLINE);
Font Fontforname = new Font(Font.TIMES_ROMAN,9,Font.BOLD);
Font forterms = new Font(Font.TIMES_ROMAN,9,Font.BOLD);
Font smallfont = new Font(Font.TIMES_ROMAN,6,Font.BOLD);
Font headFont = new Font(Font.TIMES_ROMAN,13,Font.BOLD);
Font fortotal=new Font(Font.BOLD,10,Font.UNDERLINE);
Font new3=new Font(Font.TIMES_ROMAN,8,Font.BOLD);
Font NF = new Font(Font.TIMES_ROMAN,1,Font.NORMAL);
document.open();
PdfContentByte canvas1 = writer.getDirectContent();
Rectangle rect1 = new Rectangle(10, 10, 583, 830);
rect1.setBorder(Rectangle.BOX);
rect1.setBorderWidth(1);
canvas1.rectangle(rect1);

//Image image1 = Image.getInstance("/home/sumedh/Desktop/UKAS BSI Logo.bmp");
//Image image1 = Image.getInstance("/home/r_kunjir/Desktop/homepage.jpg");
 //Image image1 = Image.getInstance("/usr/share/tomcat6/webapps/ERP/images/UKAS BSI Logo.bmp");

//image1.setWidthPercentage(40f);
//image1.setDpi(50,50);

SimpleTable table321 = new SimpleTable();
table321.setWidthpercentage(100f);
table321.setBorder(Rectangle.NO_BORDER);
SimpleCell row = new SimpleCell(SimpleCell.ROW);
SimpleCell cellforname = new SimpleCell(SimpleCell.CELL);
String email_to="";
String companydata="select * from CompanyMaster where companymid="+session.getAttribute("CompanyMasterID").toString();
ResultSet rsdata=st.executeQuery(companydata);
rsdata.next();
Float u1=0.00f;
Float m1=0.00f;
Float Count=0.00f;
Float Count1=0.00f;
String sqlQuoItems1="SELECT * FROM  "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items WHERE SalesQuoNo='"+salesquono+"'";
ResultSet rsdata1=st3.executeQuery(sqlQuoItems1);
while(rsdata1.next())
{
	u1=rsdata1.getFloat("DiscountPercent");
	 m1=rsdata1.getFloat("STPercent");
}


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
	
	filename=rsQuoDet.getString("TWSalesRefNo");
	filename=filename.replaceAll("/", "_");
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
		

	String sqlQuoItems3="SELECT Count(*) as count FROM  "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items WHERE SalesQuoNo='"+salesquono1+"' and DiscountPercent > '0.00f'";
	ResultSet rsdata3=st14.executeQuery(sqlQuoItems3);
	while(rsdata3.next())
	{
		Count=rsdata3.getFloat("count");
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
	
	//table=new PdfPTable(11);

	
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
	out.println("hereeee");
	
	
	PdfPCell c1;
	

	c1 = new PdfPCell(new Phrase("Sr No",NormalFont));
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(c1);

	c1 = new PdfPCell(new Phrase("Group",NormalFont));
	c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(c1);

	String sqllbl="select * from LableMaster where CompanyId="+session.getAttribute("CompanyMasterID").toString();		
	ResultSet rslbl=stlbl.executeQuery(sqllbl);
	while(rslbl.next()){
	
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
	
	out.println("hereeee next u1");
	
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

	out.println("hereeee n211");
	
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
	
	
    out.println("hereeee after");
    
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
			out.println("<br>4");
			ResultSet rsDisplayDesc=st3.executeQuery(sqlDisplayDesc);
			System.out.println("*****************************************************************888");
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
			System.out.println(m);
			

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
		    out.println("hereeee n554");
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
		out.println("hereeee 574");
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
		table321 = new SimpleTable();
		table321.setWidthpercentage(100f);
		table321.setBorder(Rectangle.NO_BORDER);
		 row = new SimpleCell(SimpleCell.ROW);

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


		cellforname = new SimpleCell(SimpleCell.CELL);
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

/* ServletOutputStream out1 = response.getOutputStream();

response.reset();


DataOutput dataOutput = new DataOutputStream(out1);

byte[] bytes = buffer.toByteArray();
response.setContentLength(bytes.length);
for(int l = 0; l < bytes.length; l++)
{
dataOutput.writeByte(bytes[l]);
}
 */

 
 /* String krnPath=System.getProperty("user.home");
out.println("krn"); */
//FileOutputStream dataOutput1 = new FileOutputStream("/home/karan/Desktop/test/"+filename+".pdf");
FileOutputStream dataOutput1 = new FileOutputStream("/home/javaprg/ERPPDF/"+filename+".pdf");
 
byte[] bytes1 = buffer.toByteArray();
response.setContentLength(bytes1.length);
for(int x = 0; x < bytes1.length; x++)
{
dataOutput1.write(bytes1[x]); 
//System.out.println("->"+bytes1[x]);
}
 dataOutput1.flush();
dataOutput1.close();
/* out.println("<br>1");
String uname="";
String pwd="";
String sid="";
String sql_scp="select * from 100000ftpconnection where ServerID='103.8.126.138'";
out.println("<br>2");
Statement st_scp=conn.createStatement();
ResultSet rs_scp=st_scp.executeQuery(sql_scp);
while(rs_scp.next()){
	out.println("<br>3");
	sid=rs_scp.getString("ServerID");
	uname=rs_scp.getString("Username");
	pwd=rs_scp.getString("Password");
	out.println("<br>4"+sid+"--"+uname+"--"+pwd);
}
String host=sid;
String user=uname;
String password=pwd;
String command1="ls -ltr";
String path = "/home/c_kapade/Quotation/";
out.println("<br>5");
StandardFileSystemManager fsManager = new StandardFileSystemManager();
fsManager.init();
try{
	out.println("<br>6");
	String upFile = "SalesQuotation.pdf";//reader.readLine();
	String hostname1 = sid;
	String username1 = uname;
	String password1 = pwd;
	out.println("<br>7");
	//System.out.println(uname+"--"+sid+"--"+pwd);
	String upDestination = "/home/c_kapade/Quotation/";
	 SshParameters params1 = new SshParameters("103.8.126.138","c_kapade","kapade_c");
	Scp scp = new Scp(params1);
	System.out.println("--"+params1);
	out.println("--"+params1);
	// register event listener
	//SCPDemo ss=new SCPDemo();
	System.out.println("5-");
	//scp.addListener(ss);
	// establish connection (and disconnect, below)
	System.out.println("1-");
	out.println("<br>8");
	
	scp.connect();
	
	out.println("<br>9");
	
	System.out.println("2-");
	// UPLOAD. The first argument is a File, the second is a String.
	//scp.upload(new File("/home/karan/Desktop/"+filename+".pdf"),upDestination);
	scp.upload(new File("/home/c_kapade/"+filename+".pdf"),upDestination);
	scp.disconnect();  */
	//String mailname="Karan Rajput";
	ResultSet rs_email1=null;
	Statement st_email1=conn.createStatement();
	String mailname=(String)session.getAttribute("EmpName");
	String Description="About Quotations";
	String MailBody=data;//"Dear Customer,<br>Thank you for your enquiry.<br> Please find attached quotation.<br>Waiting for your valuable order.Thank You";
	
	String sql_email1="select * from db_GlobalERP.CompanyMaster where  companymid='"+session.getAttribute("CompanyMasterID").toString()+"'";
	rs_email1=st_email1.executeQuery(sql_email1);
	
	while(rs_email1.next()){
		companyname=rs_email1.getString("Companyname");
		
	} 
	companyname=companyname.replaceAll("\n"," ");
	String comid=session.getAttribute("CompanyMasterID").toString();
	/* if(comid.equalsIgnoreCase("100000")){
		companyname="Transworld Technologies Ltd";
	} */
	String dt_sub=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new Date());
	String subjectline="Quotation from "+companyname;
	
	//String Toid="k_rajput@transworld-compressor.com";
	String Toid=emailTo;
// 	if(emailTo!="" || emailTo!=null){
// 		Toid=Toid+","+emailTo;
// 	}
	if(Toid.contains("null")){
		Toid=Toid.replaceAll("null", "");
	}
	
	String Tocc="";
	//String Tocc="k_rajput@transworld-compressor.com";
	String AttachFilePath="/home/javaprg/ERPPDF/"+filename+".pdf";
	//String AttachFilePath="/home/karan/Desktop/test/"+filename+".pdf";
	/* //String AttachFilePath="/home/karan/Desktop/"+filename+".pdf"; */
	String FileName=filename+".pdf";
	String SenderName="Karan Rajput";
	System.out.println("File PAth----"+AttachFilePath);
	
	ERPEmailTemplate template=new ERPEmailTemplate();
	//TestTemplate template=new TestTemplate();
	System.out.println("0");
	String date1="";
	String date2="";
	//String date3=new SimpleDateFormat("dd/MM/yyyy").format(new SimpleDateFormat(new Date().parse("")));
	String displayedReportNo=pgname+" : "+reportno;
	System.out.println("0.2");
	String ReportName=subjectline;
	System.out.println("0.5");
	StringBuffer htmlstr=new StringBuffer(MailBody);
	System.out.println("1");
	//htmlstr=MailBody.
			/* String comid=(String)session.getAttribute("CompanyMasterID"); */
			
	//String krn="k_rajput@transworld-compressor.com,r_patil@transworld-compressor.com,"+emailTo;
	String krn="k_rajput@transworld-compressor.com,r_patil@transworld-compressor.com,";
	//boolean isSend=template.sendmail(htmlstr, krn, Tocc, subjectline,subjectline, date1, date2, displayedReportNo, ReportName, FileName, AttachFilePath,comid);
	boolean isSend=template.sendmail(htmlstr,mainMailTo,mainMailCc,subjectline,subjectline,date1,date2,displayedReportNo,ReportName,FileName,AttachFilePath,comid,"","");
	System.out.println("2");
	//String sql_allpendingmail="insert  into db_gps.t_allpendingmailtable(MailName,MailStatus,Description,MailBody,subjectline,Toid,Tocc,AttachFilePath,SenderName,FileName) values('"+mailname+"','Pending','"+Description+"','"+MailBody+"','"+subjectline+"','"+Toid+"','"+Tocc+"','"+AttachFilePath+"','"+SenderName+"','"+FileName+"')";
	
	
	/* 
	String DB_Driver1="com.mysql.cj.jdbc.Driver";
	String DB_NAME2="jdbc:mysql://103.8.126.138:3306/db_gps";
	String usermail="erp";
	String passmail="1@erp"; */
	
	/* Connection con_mail=null;
	Class.forName(DBDriver_mail);
	con_mail=DriverManager.getConnection(DBNAME_mail,DBUSERNAME_mail,DBPASSWORD_mail);
	
	Statement st_mail=con_mail.createStatement();
	int x=st_mail.executeUpdate(sql_allpendingmail);
	if(x>0){
		System.out.println("Mail Send ");
		
	}else{
		System.out.println("Mail Not Send ");
	} */
	
	if(isSend)
	{
		msg="Mail Records Saved Sucessfully To"+mainMailTo+","+mainMailCc;
	}
	else
	{
		msg="Mail Records Saved please try again...!!!!";
	}
	System.out.println(msg);
	
	System.out.println("krn"+msg);
	System.out.println("*****************************");
			
	 response.sendRedirect("home.jsp");
	 //response.sendRedirect("alert.jsp?msg="+msg+"&goto=viewQuotation.jsp?salesQuotation="+salesquono+"&condition=View");
			//?salesQuotation=10735&condition=View
/* }catch(IOException e){
	System.out.println("kkkkk");
	out.println("<br>KKKKK<br>");
	out.println(e);
	out.println("<br>"+e.getMessage());
	e.printStackTrace();
	
} */}}catch(Exception e){
	out.println("<br>RRRRR<br>");
	System.out.print("rrrr");
	out.println(e);
	e.printStackTrace();
	//response.sendRedirect("close.jsp");
}
%>

	
	</body>
	</html>
</jsp:useBean>-