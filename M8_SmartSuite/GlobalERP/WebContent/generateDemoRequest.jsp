<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="conn1.jsp"%>
<%@ page import="java.util.Properties,javax.mail.*,javax.mail.internet.*" import="javax.mail.Session"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" 
import="java.io.BufferedWriter"
 import="java.io.FileWriter,
	com.lowagie.text.Chunk,             
	com.lowagie.text.Document,          
	com.lowagie.text.DocumentException, 
	com.lowagie.text.Element,           
	com.lowagie.text.Font,              
	com.lowagie.text.FontFactory,       
	com.lowagie.text.HeaderFooter,      
	com.lowagie.text.Image,             
	com.lowagie.text.Paragraph,         
	com.lowagie.text.Phrase,            
	com.lowagie.text.Rectangle,         
	com.lowagie.text.pdf.BaseFont,      
	com.lowagie.text.pdf.PdfPCell,      
	com.lowagie.text.pdf.PdfPTable,     
	com.lowagie.text.pdf.PdfWriter,     
	java.awt.Color,                     
	java.io.FileOutputStream,           
	java.io.IOException,                
	java.net.MalformedURLException,
	javax.activation.DataHandler,javax.activation.DataHandler,        
	javax.activation.DataSource,         
	javax.activation.FileDataSource,     
	javax.mail.Address,                  
	javax.mail.BodyPart,                 
	javax.mail.Message,                  
	javax.mail.Multipart,                
	javax.mail.Session,                  
	javax.mail.Transport,                
	javax.mail.internet.InternetAddress, 
	javax.mail.internet.MimeBodyPart,    
	javax.mail.internet.MimeMessage,     
	javax.mail.internet.MimeMultipart,
	java.io.File,                  
	java.io.FileNotFoundException, 
	java.io.FileOutputStream,      
	java.io.IOException,           
	java.text.ParseException"
import="java.text.*" import="java.util.Calendar"%>

<jsp:useBean id="demoRequest" class="com.transactions.beans.DemoRequest" scope="page">
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
	<%
		erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
	Connection conn = null;
		Statement st = null, st1 = null;
		File savedir=null,savefile=null;
	%>
  <%
 	 conn = erp.ReturnConnection();
	st = conn.createStatement();
	st1 = conn.createStatement();
	
	String companyName=request.getParameter("companyName");
  	String Location=request.getParameter("location");
  	String fromDate=request.getParameter("fromdate");
  	String duration=request.getParameter("duration");
  	String noOfDemoUnits=request.getParameter("numberOfUnits");
  	String typeOfUnit=request.getParameter("numberOfUnits");
  	String amount=request.getParameter("amount");
  	
  	String companyCode="_______",companyAddress="_______",city="_______",zip="_______",state="_______",country="_______",name="_______";
  	String designation="_______",phone="_______",fax="_______",email="_______",place="_______";
  	
  String sqlCompany="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where CompanyName='"+companyName+"'";	
  ResultSet rsCompany=st1.executeQuery(sqlCompany);
  if(rsCompany.next())
  {
	  companyCode=rsCompany.getString("CustomerCode");
	  companyAddress=rsCompany.getString("Address");
	  city=rsCompany.getString("City");
	  zip=rsCompany.getString("Zip");
	  state=rsCompany.getString("State");
	  country=rsCompany.getString("Country");
	  name=rsCompany.getString("ContactPerson");
	  phone=rsCompany.getString("Phone")+"    "+rsCompany.getString("MobileNo");
	  fax=rsCompany.getString("Fax");
	  email=rsCompany.getString("EMail");
  }
  
	Document document = new Document();
	PdfWriter writer=PdfWriter.getInstance(document, 
    new FileOutputStream("/home/manjit/Desktop/aaa.pdf"));
	document.open();
	Image logo = Image.getInstance("/home/manjit/Desktop/logo.jpg");
	logo.setAlignment(Image.LEFT);
	logo.scaleAbsoluteHeight(95);
	logo.scaleAbsoluteWidth(70);
	logo.scalePercent(77);
	    
	Chunk chunk = new Chunk(logo,0,-35);
	HeaderFooter header = new HeaderFooter(new Phrase(chunk), false);
	header.setAlignment(Element.ALIGN_LEFT);
	header.setBorder(Rectangle.NO_BORDER);
	document.setHeader(header);
      
	String srt="I/We "+companyName+" (“Company”) am/are interested in the above products and request you for a Demo of the above products at "+Location+" location. Date:"+fromDate+" Duration: "+duration+" days. No. of demo units "+noOfDemoUnits+". " +
			"We do not deal in these particular products nor do we intend to do so in future. We will issue a successful demo project completion certificate after the successful completion of the demonstration project. " +
			"" +
			"We hereby declare and undertake that we will not copy, reverse engineer or otherwise attempt to acquire the design or software in any manner. We shall not part with the unit or disclose any information including username and password, with any other person or entity for any reason & we conform that the sole purpose of this demo is to evaluate the product and solution for our own use or for the use of our contract vendors / contracted associates in such an event we will ensure the same protection as committed by us. All the demo units will be returned in good working condition to Transworld by the company, in case of loss/damage of the unit, the Company undertakes to pay Rs.18000/- per unit to Transworld." +
			"Company declares and agrees that Transworld exclusively owns the designs, intellectual property including but not limited to material, software and information that comprises or is a part of Vehicle Tracking and Location Systems and the product known as the Mobile Eye, that is provided to the Company and the Company acknowledges the same.";

	BaseFont bf_courier = BaseFont.createFont(BaseFont.TIMES_ROMAN, "Cp1257", false);

HeaderFooter footer = new HeaderFooter(
            new Phrase("Transworld Compressor Technologies Ltd.   ", new Font(bf_courier)), true);

footer.setBorder(Rectangle.NO_BORDER);
footer.setAlignment(Element.ALIGN_CENTER);
document.setFooter(footer);
	document.open();

	Paragraph p2=new Paragraph("Transworld Compressor Technologies Ltd.");
	p2.font().setStyle(Font.BOLD);
	p2.setAlignment("center");
	document.add(p2);
	
	Paragraph p3=new Paragraph(" C-3/8,Rakshalekha, Koregaon Park, Pune 411 011. INDIA ",  FontFactory.getFont(FontFactory.HELVETICA, 10
	           ));
	p3.font().setStyle(Font.UNDERLINE);
	p3.setAlignment("center");
	document.add(p3);

	Paragraph pAnchor=new Paragraph(new Chunk("www.Mobile-Eye.in",
			FontFactory.getFont(FontFactory.COURIER, 10, Font.BOLD, new Color(102, 102, 200))).setAnchor("http://www.Mobile-Eye.in"));
	pAnchor.setAlignment("center");
	document.add(pAnchor);
	
	document.add(Chunk.NEWLINE);
	Paragraph p1=new Paragraph("DEMO REQUEST FORM",
			FontFactory.getFont(FontFactory.HELVETICA, 14, Font.BOLD, new Color(104, 104, 210)));
	p1.setAlignment("center");
	document.add(p1);
	
	Paragraph p=new Paragraph(srt);
	document.add(p);
	document.add(Chunk.NEWLINE);
	PdfPCell cell = new PdfPCell();
	cell.addElement(new Paragraph("PRODUCT & DESCRIPTION"));
	cell.setBackgroundColor(Color.LIGHT_GRAY);
	PdfPTable table1 = new PdfPTable(1);
	table1.setHorizontalAlignment(Element.ALIGN_LEFT);
	table1.addCell(cell);
	document.add(table1);
	
	  p1=new Paragraph("Demo of the vehicle tracking software,hardware," +
			"peripherals,accessories and services related to it.",
			FontFactory.getFont(FontFactory.HELVETICA, 12, Font.NORMAL, new Color(104, 104, 210)));
	p1.setAlignment("center");
	document.add(p1);
	document.add(Chunk.NEWLINE);
	
	cell = new PdfPCell();
	cell.addElement(new Paragraph("COMPANY DETAILS"));
	cell.setBackgroundColor(Color.LIGHT_GRAY);
	table1 = new PdfPTable(1);
	table1.setHorizontalAlignment(Element.ALIGN_LEFT);
	table1.addCell(cell);
	document.add(table1);
	
	PdfPTable table = new PdfPTable(4);
	table.getDefaultCell().setBorder(0);

	table.addCell(demoRequest.getCell("Company Name :",true,false));
	table.addCell(demoRequest.getCell(companyName,false,true));
	table.addCell(demoRequest.getCell("Address :",true,false));
	table.addCell(demoRequest.getCell(companyAddress,false,true));
	table.addCell(demoRequest.getCell("City",true,false));
	table.addCell(demoRequest.getCell(city,false,false));
	table.addCell(demoRequest.getCell("Zip",true,false));
	table.addCell(demoRequest.getCell(zip,false,false));
	table.addCell(demoRequest.getCell("State :",true,false));
	table.addCell(demoRequest.getCell(state,false,false));
	table.addCell(demoRequest.getCell("Country :",true,false));
	table.addCell(demoRequest.getCell(country,false,false));
	table.addCell(demoRequest.getCell("Name :",true,false));
	table.addCell(demoRequest.getCell(name,false,false));
	table.addCell(demoRequest.getCell("Designation :",true,false));
	table.addCell(demoRequest.getCell(designation,false,false));
	table.addCell(demoRequest.getCell("Phone :",true,false));
	table.addCell(demoRequest.getCell(phone,false,false));
	table.addCell(demoRequest.getCell("Fax :",true,false));
	table.addCell(demoRequest.getCell(fax,false,false));
	table.addCell(demoRequest.getCell("Email :",true,false));
	table.addCell(demoRequest.getCell(email,false,false));	
	table.addCell(demoRequest.getCell("Amount :",true,false));
	table.addCell(demoRequest.getCell(amount,false,false));
	table.addCell(demoRequest.getCell("Date :",true,false));
	table.addCell(demoRequest.getCell(fromDate,false,false));
	table.addCell(demoRequest.getCell("   ",true,false));
	table.addCell(demoRequest.getCell("",false,false));
	table.addCell(demoRequest.getCell("Palce :",true,false));
	table.addCell(demoRequest.getCell(place,false,true));
	
	table.addCell(demoRequest.getCell(" ",true,false));	table.addCell(demoRequest.getCell(" ",true,false));
	table.addCell(demoRequest.getCell(" ",true,false));	table.addCell(demoRequest.getCell(" ",true,false));		
 	
	
	table.addCell(demoRequest.getCell("",true,false));
	table.addCell(demoRequest.getCell("___________",false,false));
	table.addCell(demoRequest.getCell("",true,false));
	table.addCell(demoRequest.getCell("___________",false,false));
	table.addCell(demoRequest.getCell("",true,false));
	table.addCell(demoRequest.getCell("Signature",false,false));
	table.addCell(demoRequest.getCell("",true,false));
	table.addCell(demoRequest.getCell("Company Seal",false,false));
	
	document.add(table);    
	
	document.close();
	
	try{
	
	String Data = " <br><br>Please find attachment for Demo request from<br>";
	Data+="   <br>";
	Data = Data + "<br></table>";

				  Properties props = new Properties();
	              String host="smtp.transworld-compressor.com";
	              String protocol="smtp";
	              String user="tripend@mobile-eye.in"; //jd@mobile-eye.in  tripend@mobile-eye.in
	              String pass2="transworld";
	              props.put("mail.smtp.starttls.enable","true");
	              props.put("mail.smtp.auth", "true");
	              props.put("mail.smtp.user", "user");
	              props.put("mail.smtp.password", "pass");  
	              props.put("mail.store.protocol", protocol);
	              props.put("mail.smtps.host", host);
	               
	              Session session1 = Session.getDefaultInstance(props, null);
	               // Construct the message
	               Message msg = new MimeMessage(session1);
	               msg.setSubject("Demo Request Form ");
	               msg.setSentDate(new java.util.Date());
	               
	               Address recipientAddrs[] = new InternetAddress[1];
	               
	               recipientAddrs[0]=new InternetAddress("m_kolekar@transworld-compressor.com");
	               
	               msg.addRecipients(Message.RecipientType.TO,recipientAddrs);
	               Address fromAddress=new InternetAddress("avlsupport@mobile-eye.in","Transworld"); // in second "", it is short name
	               msg.setFrom(fromAddress);
	          	   System.out.println(Data);
	           	   msg.setContent(Data,"text/html; charset=ISO-8859-1");
	 
			
	               try{
	               
					BodyPart messageBodyPart = new MimeBodyPart();

					// Fill the message
					messageBodyPart.setContent(Data +"<br><br><br> Thanks and Regards, <br> Transworld Team", "text/html");
						
					
					Multipart multipart = new MimeMultipart();
					multipart.addBodyPart(messageBodyPart);

					savefile=new File( "/usr/share/tomcat6/webapps/ERPTEST/aaa.pdf" );

					messageBodyPart = new MimeBodyPart();
					DataSource source = new FileDataSource(savefile);
					messageBodyPart.setDataHandler(new DataHandler(source));
					
	 
					String filename = "aaa.pdf" ;
					messageBodyPart.setFileName(filename);
					multipart.addBodyPart(messageBodyPart);

					msg.setContent(multipart);
	               }
	               catch(Exception e){
	            	   out.print(e);
	               }

				Transport t = session1.getTransport("smtps");
				msg.saveChanges(); // don't forget this
	               
	               try
	               {
	                    t.connect(host, user, pass2);
	                    System.out.println("SENT*******");
	                    t.sendMessage(msg, msg.getAllRecipients());
	                    System.out.println("Your message has been sent");
	               }
	               catch(Exception e)
	               {
	                   System.out.print("Exception----->"+e);
	                 //  out.print("Email not sent, please check Email-Id's");
	               } 
	               finally 
	               {
	                   t.close();
	               } 
	               Transport.send(msg);
	           } catch (Exception e) {
	       		out.println("Email sent successfully   "+e);
	       		System.out.println("E-mail Sending Failed"+e);
	       	}
  
  %>
 </jsp:useBean>
</jsp:useBean>