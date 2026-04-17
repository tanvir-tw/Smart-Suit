<%@page import="com.erp.beans.EmailTemp"%>
<%@page import="java.util.Date"%>
<%@ include file="conn.jsp"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<%@ page import="java.util.Properties,javax.mail.*,javax.mail.internet.*" import="javax.mail.Session"%>
<%@ page contentType="text/html; charset=UTF-8" language="java"
	import="java.sql.*" import=" java.text.*" import=" java.util.*"
	errorPage=""%>
	<%@ page import="javax.activation.DataHandler,javax.activation.DataHandler,        
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
 java.text.ParseException,      
 org.apache.poi.hssf.usermodel.HSSFCell,     
org.apache.poi.hssf.usermodel.HSSFCellStyle,
org.apache.poi.hssf.usermodel.HSSFFont,     
org.apache.poi.hssf.usermodel.HSSFRow,      
org.apache.poi.hssf.usermodel.HSSFSheet,    
org.apache.poi.hssf.usermodel.HSSFWorkbook
  " %>
 <%!
 
 
 Connection conn;
 Statement st;
 Statement st1;
 %>
 	<%
		erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
	%>
<%
 
try{
		
	  System.out.println("st --------------");

	  FileOutputStream fileOutputStream = null;
	  File savedir = null;
	  File savefile = null;
	  String fname = "";
	 
	  HSSFWorkbook workbook = null;
	  HSSFSheet sheet = null;
	  HSSFRow row = null;
	  HSSFFont font = null;
	  HSSFCellStyle cellStyle = null;
	  HSSFCell cell1 = null;
	HSSFCell cell = null;
	  int rowcnt = 2;
	  System.out.println(" 0 --------------");

		  String arr[] = { "Sr.No", "Sign","Follow-Up Date.", "Status", 
			"Comments", "Follow-Up Type", "Next follow-Up date.","Payment Follow-Up" ,"Reply" };
	
		  String fromDate=request.getParameter("fromDate");
		  String toDate=request.getParameter("todate");
		  int emailCounter=0;
		  DateFormat frmt=new SimpleDateFormat("dd-MMM-yyyy");
		  DateFormat prse=new SimpleDateFormat("yyyy-MM-dd");

		  String fromDateFormat=frmt.format(prse.parse(fromDate));
		  String toDateFormat=frmt.format(prse.parse(toDate));
		  System.out.println("1 --------------");

		//savedir = new File("/usr/share/tomcat6/webapps/ERP");
		//savedir = new File("/home/karan/Desktop/temp");
		savedir = new File("/home/javaprg/ERPPDF");
			savedir.mkdirs();
			
			Date d1=new Date();
			int year=d1.getYear()+1900;
			int month=d1.getMonth()+1;
			int dt=d1.getDate();
			int h=d1.getHours();
			int min=d1.getMinutes();
			int s=d1.getSeconds();
			
// 			SimpleDateFormat form1 = new SimpleDateFormat("dd MM yyyy HH mm");
// 			    System.out.println(form1.format(d1));
// 			    String datename = form1.format(d1); // or if you want to save it in String str
// 			    System.out.println("STR---"+datename);
// 			    String []fn=datename.split(" ");
// 			    String y="",mn="",dt="",
// 			    for(int i=0;i<=fn.length;i++){
// 			    	try{
			    		
// 			    	}
// 			    }
		
			
			String filename = "Follow_Up_Report"+year+month+dt+h+min+s;
			
			
			try {
				//savefile = File.createTempFile(filename + "_", ".xls", savedir);
				savefile=new File(savedir+"/"+filename+".xls");
				System.out.println("***file ->  "+filename+"--"+savefile);
			} catch (Exception e1) {
				e1.printStackTrace();
			}
			  System.out.println("2 --------------"+savefile.getName()+"-------"+savedir);
			  String filenameToBeSend=savefile.getName();
			  String AttachedFilePath=savedir+"/"+filenameToBeSend;

			fname = "" + savefile;

			try {
				fileOutputStream = new FileOutputStream(savefile);

			} catch (FileNotFoundException e) {
				System.out.println("File not found in the specified path.");
				//out.println(e);
				e.printStackTrace();
			}
			workbook = new HSSFWorkbook();
			sheet = workbook.createSheet("Java Excels");
			// set font style
			font = workbook.createFont();
			font.setBold(true);
			font.setColor(HSSFFont.COLOR_NORMAL);

			cellStyle = workbook.createCellStyle();
			cellStyle.setFont(font);
			
			row = sheet.createRow(0);
			row.setHeightInPoints(12.75f);
			cell1 = row.createCell(0);
			cell1.setCellStyle(cellStyle);

			cell1.setCellValue("Follow Up report of "+request.getParameter("customerName")+" from "+fromDateFormat+" to "+toDateFormat);

			row = sheet.createRow(2);
			row.setHeightInPoints(12.75f);
			for (int i = 0; i < arr.length; i++) {
				HSSFCell cell11 = row.createCell(i);

				cell11.setCellStyle(cellStyle);
				cell11.setCellValue(arr[i]);
			}

	
	Connection conn = null;
	Statement st = null;
	Statement st1 = null;
	Statement st2 = null;

  String extraEmailIds=request.getParameter("ExtraEmail");
  //System.out.println("EXTRA EMAIl   --  "+extraEmailIds);
  if(extraEmailIds.equalsIgnoreCase(""))
	  extraEmailIds=null;
  String copyManager=request.getParameter("manager");
  String copyAccounts=request.getParameter("accounts");
  String body=request.getParameter("body");
  String copySales=request.getParameter("sales");
  String copyMD=request.getParameter("MD");
  String cust=request.getParameter("customer");
  
  String customerEmail=null;
 
  	 customerEmail=request.getParameter("companyEmail");
 	 customerEmail=customerEmail.replace("(","").replace(")","").replace(" ","");
 
  System.out.println("customerEmail--"+customerEmail);
  


			
  String customerName=request.getParameter("customerName");
	try {
		conn = erp.ReturnConnection();
		st = conn.createStatement();
		st1 = conn.createStatement();
		st2 = conn.createStatement();
	} catch (Exception e) {System.out.println(e);
	}
	
	            
	 String htmlString="",s1="",s2="",s3="";
	 String headerString;
	 boolean notifyR_D;
	 Object htmlStringForR_D;
	 String headerStringForR_D;
	 
String openingBalance="0.00";


//System.out.print("=======OPENING BAL"+openingBalance);
	
int k=0  ;

 System.out.println("EMAIL++++"+fromDate+" - "+toDate+customerName +" ## "+customerEmail+" ## "+extraEmailIds+" ## "+copySales+" ## "+copyManager+"-##-"+copyAccounts+"-##-"+copyMD+"##");
	try {
 System.out.print("SENDING EMAIL*******");
	
	

		 	
 
				
	//System.out.println(htmlString);
 
	String sqlDetails = " SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"followup AS a LEFT OUTER JOIN   "+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster "+
	"  AS b ON ( a.MarketingRepCode = b.MarketingRepCode )			"+
	"where a.ProspCustName='"+customerName+"'  and followupdate between '"+fromDate+"' and "+
	" '"+toDate+"'  ORDER BY  a.followupdate DESC ";
 

htmlString = "<HTML><BODY>";
htmlString = htmlString+"<table border=1 align=center width=95% cellpadding=0 cellspacing=1 style=^border-collapse: collapse^>";
			htmlString = htmlString+"<tr bgcolor=^#ADDFFF^><td align=left  >Sr.No</td><td align=center >Sign</td><td align=center >Follow-Up date</td><td align=center >Status</td><td align=center >Comments</td><td align=center >Follow-up Type</td><td align=center > Next Follow-Up Date </td><td align=center >Payment Follow-up </td><td align=center >Reply </td></tr> ";

 
			

ResultSet rsDetails = st.executeQuery(sqlDetails);
//System.out.println(sqlDetails);
int i=1;
rowcnt = rowcnt + 1;
String creditAmt="";
while (rsDetails.next()) {
 
	htmlString = htmlString+"<tr><td align=left>"+i+" </td> "+
			"<td align=left>"+rsDetails.getString("MarketingRepName")+"</td>" +
			"<td align=left>"+new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse
					(rsDetails.getString("FollowUpDate")))+"</td>" +
			"<td align=left>"+rsDetails.getString("Status")+"</td>" +
			"<td align=left>"+rsDetails.getString("Comments")+"</td>" +
		
			"<td align=left>"+rsDetails.getString("FollowUpType")+"</td>" +
			"<td align=left> "+new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsDetails
							.getString("NextFollowUpDate")))+" </td>" +
			"<td align=left>"+rsDetails.getString("PaymentFollowup")+"</td>"+
			"<td align=left>"+rsDetails.getString("Reply")+"</td></tr>" ;
			
 
		
		
			try {
 
				String  arr1[] = { ""+i,rsDetails.getString("MarketingRepName"),
						new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsDetails.getString("FollowUpDate"))), 
								rsDetails.getString("Status"),
						rsDetails.getString("Comments"),
						rsDetails.getString("FollowUpType"),
						new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsDetails.getString("NextFollowUpDate"))),
						rsDetails.getString("PaymentFollowup"),
						rsDetails.getString("Reply") };

				rowcnt = rowcnt + 1;
				
				row = sheet.createRow(rowcnt);
				row.setHeightInPoints(12.75f);
				for (k=0 ; k < arr.length; k++) {
					HSSFCell cell2 = row.createCell(k);
					cell2.setCellValue(arr1[k]);
				}

			} catch (Exception e) {
				e.printStackTrace();
			}
			
			
			i++;
	}
System.out.print(htmlString);





try {
	workbook.write(fileOutputStream);
//	workbookR_D.write(fileOutputStreamR_D);

} catch (IOException e) {

	e.printStackTrace();
}



String Data = "<br><div align=^left^>Dear Sir/Madam,<br>Following is Follow-Up Report of <b> "+customerName+" </b> From "+fromDateFormat+" To "+toDateFormat+"<br><br></div>";
Data+="    "+body+"<br>";
Data = Data + "<br>"+htmlString+"</table>";

// 			  Properties props = new Properties();
//               String host="smtp.transworld-compressor.com";
//               String protocol="smtp";
//               String user="tripend@mobile-eye.in"; //jd@mobile-eye.in  tripend@mobile-eye.in
//               String pass2="transworld";
//               props.put("mail.smtp.starttls.enable","true");
//               props.put("mail.smtp.auth", "true");
//               props.put("mail.smtp.user", "user");
//               props.put("mail.smtp.password", "pass");  
//               props.put("mail.store.protocol", protocol);
//               props.put("mail.smtps.host", host);
//                
//               Session session1 = Session.getDefaultInstance(props, null);
//                // Construct the message
//                Message msg = new MimeMessage(session1);
//                msg.setSubject("Transaction Statement for "+customerName+" From "+fromDateFormat+" To "+toDateFormat+"");
//                msg.setSentDate(new java.util.Date());
               String subject="Transaction Statement for "+customerName+" From "+fromDateFormat+" To "+toDateFormat+"";
               //Address recipientAddrs1[] = new InternetAddress[1];
               
               if(!(copyMD==null))
            	   emailCounter++;
               if(!(copyAccounts==null))
            	   emailCounter++;
               if(!(copySales==null))
            	   emailCounter++;
               if(!(copyManager==null))
            	   emailCounter++;
              
               if(!(extraEmailIds==null))
               {
            	   if (extraEmailIds.contains(","))
            	   {
          		     String[] results = extraEmailIds.split( ",\\s*" );  
       		    	  for ( String string : results )
       		         	emailCounter++;
            	   }
            	   else
            		   emailCounter++;
               }
               //System.out.println("T^OCKENSSSSSSSSSSS"+customerEmail);
             String toID="";
               if(!(customerEmail==null))
               {
            	   if (customerEmail.contains(","))
            	   {
            		     String[] results = customerEmail.split( ",\\s*" ); 
            		      for ( String string : results ){
            		        emailCounter++;
            		      toID+=string+",";
            		      }
            	   }
            	   else
            		   emailCounter++;
            	   toID+=customerEmail+",";
               }
               if(!(session.getAttribute("EmpEmail")==null) )  //check for user id
            	   emailCounter++;
               
               Address recipientAddrs[] = new InternetAddress[emailCounter];
               int count=0;
             
               
               if(!(copyMD==null)){
            	   recipientAddrs[count++] = new InternetAddress("md@transworld-compressor.com");
            	  toID+=",md@transworld-compressor.com";
               }
               if(!(copyAccounts==null)){
            	   recipientAddrs[count++] = new InternetAddress("accounts@transworld-compressor.com");
            	   toID+=",accounts@transworld-compressor.com";
               }
               if(!(copySales==null)){
            	   recipientAddrs[count++] = new InternetAddress("sales@transworld-compressor.com");
             toID+=",sales@transworld-compressor.com";
               }
               if(!(copyManager==null)){
            	   recipientAddrs[count++] = new InternetAddress("n_doshi@transworld-compressor.com");
            	   toID+=",n_doshi@transworld-compressor.com";   
               }
               if(!(extraEmailIds==null))
               {
            	   if (extraEmailIds.contains(","))
            	   {
         		     	String[] results = extraEmailIds.split( ",\\s*" ); // split on commas
       		     	 	for ( String string : results )
            			   recipientAddrs[count++] = new InternetAddress(string);
            	   }
            	   else
            		   recipientAddrs[count++] = new InternetAddress(extraEmailIds);
               }
               else{
            	   System.out.println("NO EXTRA EMAILS");
               }

               if(!(customerEmail==null))
               {
            	   if (customerEmail.contains(","))
            	   {
          		     	String[] results = customerEmail.split( ",\\s*" ); // split on commas
       		     	 	for ( String string : results )
            			   recipientAddrs[count++] = new InternetAddress(string);
            	   }
            	   else
            		   recipientAddrs[count++] = new InternetAddress(customerEmail);
               }
               if(!(session.getAttribute("EmpEmail")==null))  //check for user id
            	   recipientAddrs[count++] = new InternetAddress(session.getAttribute("EmpEmail").toString());
               
          		String ccID="";
               for(int m=0;m<emailCounter;m++)
               {
            	   System.out.println("~~~~~~~~~~~~~"+recipientAddrs[m]);
            	   ccID+=","+recipientAddrs[m];
               }
 
//                if(!(emailId==null))
//             	   recipientAddrs[6] = new InternetAddress(emailId);
//                recipientAddrs1[0] = new InternetAddress(emailid);
//                msg.addRecipients(Message.RecipientType.TO,recipientAddrs);
//                Address fromAddress=new InternetAddress("avlsupport@mobile-eye.in","Transworld"); // in second "", it is short name
//           		// : avlsupport@mobile-eye.in
//                msg.setFrom(fromAddress);
//            //    msg.setContent(Data+"\n\n\n<br> Thanks and Regards" ,"text/html; charset=ISO-8859-1");
//            System.out.println(Data);
//            msg.setContent(Data,"text/html; charset=ISO-8859-1");
               // Send the message
 		Data +="<br><br><br><div align=^right^> Thanks and Regards, <br> Transworld Team<div>";
               
               try{
               
// 				BodyPart messageBodyPart = new MimeBodyPart();

// 				// Fill the message
// 				messageBodyPart.setContent(Data +"<br><br><br> Thanks and Regards, <br> Transworld Team", "text/html");
					
				
// 				Multipart multipart = new MimeMultipart();
// 				multipart.addBodyPart(messageBodyPart);

// 				// Part two is attachment
// 				messageBodyPart = new MimeBodyPart();
// 				// filename = "/home/pradnya/Desktop/OR_ER_Count.xls";
// 				DataSource source = new FileDataSource(savefile);
// 				messageBodyPart.setDataHandler(new DataHandler(source));
				
 
// 				filename = "Transaction_Statement.xls" ;
// 				//out.println("***file at send fun->  "+filename);
// 				messageBodyPart.setFileName(filename);
// 				multipart.addBodyPart(messageBodyPart);

// 				// Put parts in message
// 				msg.setContent(multipart);
				
 				System.out.println("CCID--"+extraEmailIds+" TOID--"+toID);
 				
 				Date d = new Date();
 			    SimpleDateFormat form = new SimpleDateFormat("dd-MMM-yyyy");
 			    System.out.println(form.format(d));
 			    String date1 = form.format(d); // or if you want to save it in String str
 			    System.out.println("STR---"+date1);
 				
 				StringBuffer htmlString1=new StringBuffer(Data);
 				String krn="k_rajput@transworld-compressor.com,";
 				System.out.println("Subject line "+subject);
 				EmailTemp emailte=new EmailTemp();
  				//emailtemplate.sendmail(htmlString1, toID, extraEmailIds, "", subject, date1, "", "", "Followup Report", filenameToBeSend, AttachedFilePath);
  				//emailTemplate.sendmail(htmlString1, krn, krn, "", subject, date1, "", "", "Followup Report", filenameToBeSend, AttachedFilePath);
  				emailte.sendmail(htmlString1, toID, extraEmailIds, "", "", date1, "", "", subject, filenameToBeSend, AttachedFilePath,session.getAttribute("CompanyMasterID").toString() );
  				
				System.out.println("Done");
				out.println("Mail Send Successfully");
				
               }
               catch(Exception e){
            	   out.print(e);
               }
				// --------------------------- end of
				// logic---------------------------------
			 
			 
			// Send the message

// 			Transport t = session1.getTransport("smtps");
// 			msg.saveChanges(); // don't forget this
               
//                try
//                {
//                     t.connect(host, user, pass2);
//                     System.out.println("SENT*******");
//                     t.sendMessage(msg, msg.getAllRecipients());
//                     System.out.println("Your message has been sent");
//                }
//                catch(Exception e)
//                {
//                    System.out.print("Exception----->"+e);
//                  //  out.print("Email not sent, please check Email-Id's");
//                } 
//                finally 
//                {
//                    t.close();
//                } 
//                Transport.send(msg);
		 
	} catch (Exception e) {
		out.println("Email sent successfully");
		System.out.println("E-mail Sending Failed"+e);
	} finally {
	}
	if(savefile.exists())
	{
		//savefile.delete();
	}
}catch(Exception e)
{ out.print(e);
	System.out.println(e);
	}
%>
</jsp:useBean>