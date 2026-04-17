
<%@ include file="conn.jsp"%>

<%@page import="java.awt.Event"%>
 
<%@page import="java.awt.event.KeyListener"%>
<%@page import="java.awt.event.KeyEvent"%><jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
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
if(request.getParameter("customer")!=null)
{
	   System.out.println("COMPANY SELECTED");
}
else{
	  System.out.println("NO COMPANY FOUND**");
}
try{
		
	  System.out.println("IN TRY &******&&&&&&&&&&&&**** &&&&&&&&&&&&*****  ");

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
	
		  String arr[] = { "Sr.No", "Tr Date","Tr Id.", "Debit", 
			"Credit", "Balance(o/s)", "Desc.","Desc Id" ,"Sign" };
	
		  String fromDate=request.getParameter("fromDate");
		  String toDate=request.getParameter("todate");
		  int emailCounter=0;
		  DateFormat frmt=new SimpleDateFormat("dd-MMM-yyyy");
		  DateFormat prse=new SimpleDateFormat("yyyy-MM-dd");

		  String fromDateFormat=frmt.format(prse.parse(fromDate));
		  String toDateFormat=frmt.format(prse.parse(toDate));
		  

		 	 savedir = new File("/usr/share/tomcat6/webapps/ERP");
		 	//	   savedir = new File("/home/s_kapre/Desktop");
		//	savedir = new File("/home/shweta/Desktop/PowerON_OFF_Alert_CalcuttaExpress");
			
		savedir.mkdirs();
			String filename = "Transaction_Statement";

			try {
				savefile = File.createTempFile(filename + "_", ".xls", savedir);
			System.out.println("***file ->  "+filename);
			} catch (IOException e1) {
				System.out.println(e1);
				e1.printStackTrace();
			}

			fname = "" + savefile;

			try {
				fileOutputStream = new FileOutputStream(savefile);

			} catch (FileNotFoundException e) {
				System.out.println("File not found in the specified path.");
				out.println(e);
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

			cell1.setCellValue("Trasaction statement for "+request.getParameter("customerName")+" from "+fromDateFormat+" to "+toDateFormat);

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
  System.out.println("EXTRA EMAIl   --  "+extraEmailIds);
  if(extraEmailIds.equalsIgnoreCase(""))
	  extraEmailIds=null;
  String copyManager=request.getParameter("manager");
  String copyAccounts=request.getParameter("accounts");
  String body=request.getParameter("body").toString().replaceAll("\\r|\\n", "<br>");
  /* String  a="";
  a=;
  if(body.contains(a))
  {
	 System.out.println("IN LOOP ");
	 body.replaceAll("a","<br>");
	  
  } */
  System.out.println("BODY IS  "+body);
  String copySales=request.getParameter("sales");
  String copyMD=request.getParameter("MD");
  
  String customerEmail=null;
  if(request.getParameter("customer")!=null)
  {
	   System.out.println("COMPANY SELECTED");
  	 customerEmail=request.getParameter("companyEmail");
 	 customerEmail=customerEmail.replace("(","").replace(")","").replace(" ","");
  }
  else{
	  System.out.println("NO COMPANY FOUND**");
  }
  System.out.println(customerEmail);

  String customerName=request.getParameter("customerName");
	try {
		conn = erp.ReturnConnection();
		st = conn.createStatement();
		st1 = conn.createStatement();
		st2 = conn.createStatement();
	} catch (Exception e) {System.out.println(e);
	}
	
	            
	 String htmlString="";
	 double s1=0,s2=0;
	 String headerString;
	 boolean notifyR_D;
	 Object htmlStringForR_D;
	 String headerStringForR_D;
	 
String openingBalance="0.00";


System.out.print("=======OPENING BAL"+openingBalance);
	
int k=0  ;

 //System.out.println("EMAIL++++"+fromDate+" - "+toDate+customerName +"  "+customerEmail+" "+extraEmailIds+" "+copySales+" "+copyManager+"--"+copyAccounts+"--"+copyMD+"");
	try {
 System.out.print("SENDING EMAIL*******");
	
		 	
 
				
	//System.out.println(htmlString);
	String sql = "SELECT CustomerCode FROM  "+session.getAttribute("CompanyMasterID").toString()+"customerdet where CompanyName ='"
		+ customerName + "' ";
	System.out.println(sql);
ResultSet rsCode = st1.executeQuery(sql);
if(rsCode.next())
{
	String sqlDetails = "SELECT * FROM  "+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount where CustomerCode='"
		+ rsCode.getString(1)
		+ "' and  TransactionDate between '"
		+ fromDate
		+ "' and '"
		+ toDate
		+ "' ORDER BY  concat(TransactionDate , TransactionId ) ASC";
	System.out.println(sqlDetails);
	
	ResultSet rsBalance=st.executeQuery("SELECT Balance,TransactionDate  FROM  "+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount where CustomerCode='"+ rsCode.getString(1)+"'"+
		 " and  TransactionDate <'"+fromDate+"' order by concat(TransactionDate , TransactionId ) desc limit 1");
if (rsBalance.next())
	openingBalance=rsBalance.getString(1);
rsBalance=null;

htmlString = "<HTML><BODY>";
htmlString = htmlString+"<table border=1 align=center width=100% cellpadding=0 cellspacing=1>";
			htmlString = htmlString+"<tr><td align=left style=background-color:#FFFF00>Sr.No</td>"+
			"<td align=center style=background-color:#FFFF00>Tr.Date</td>"+
			"<td align=center style=background-color:#FFFF00>Tr. Id</td>"+
			"<td align=center style=background-color:#FFFF00>Debit</td>"+
			"<td align=center style=background-color:#FFFF00>Credit</td>"+
			"<td align=center style=background-color:#FFFF00>Balance(o/s)</td>"+
			"<td align=center style=background-color:#FFFF00>Desc </td>"+
			"<td align=center style=background-color:#FFFF00>Desc Id </td>"+
			"<td align=center style=background-color:#FFFF00>Sign </td></tr> ";

			 String credit="0.00",debit="0.00";
 
			
			  if(openingBalance!=null) {
				 if(Double.parseDouble(openingBalance)<0)
					 credit=openingBalance;
				 else if(Double.parseDouble(openingBalance)>0)
				 	debit=openingBalance;
					htmlString+="<tr><td align='right'>1</td>"+
			 	"<td align='right'>"+fromDateFormat +"</td><td>  Opening Balance </td><td align='right'> "+debit+" </div></td> 	<td align='right'>"+credit+" </div></td>"+
			 	"<td align='right'>-</div></td><td>  --- </td><td>  --- </td><td>  --- </td></tr>";
			 	
				row = sheet.createRow(3);
				row.setHeightInPoints(12.75f);
					String ar[] = { "1", fromDateFormat,"Opening Balance", debit, 
							credit, "-", "-","-" ,"-" };
					for (int i = 0; i < ar.length; i++) {
						HSSFCell cel = row.createCell(i);
						cel.setCellValue(ar[i]);
					}
			  }
			  else{
					htmlString+="<tr><td colspan='9'><b>--- NO DATA ---<b></td></tr>";
					row = sheet.createRow(3);
					row.setHeightInPoints(12.75f);
					String ar[] = { "1", "","","NO DATA ", 
							"", "", "","" ,"" };	
					for (int i = 0; i < ar.length; i++) {
						HSSFCell cel = row.createCell(i);
						cel.setCellValue(ar[i]);
					}
			  }
	 	
			  PreparedStatement pstmt = conn.prepareStatement(sqlDetails, ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY );

			  ResultSet rsDetails = pstmt.executeQuery();
System.out.println(sqlDetails);
int i=2;
rowcnt = rowcnt + 1;
String creditAmt="";String id="",trDetails="";
while (rsDetails.next()) {
	
	if(!rsDetails.getString("TransactionDetail").startsWith("S")){
		
		id=rsDetails.getString("TransactionDetail");
		trDetails=rsDetails.getString("PaymentVoucherNo");
	}
	else{
		trDetails=rsDetails.getString("TransactionDetail");
		id="-";
	}
	
	
	if(rsDetails.getString("CreditAmount")!=null)
		creditAmt=rsDetails.getString("CreditAmount");
	else
		creditAmt="0.00";
	htmlString = htmlString+"<tr><td align=right>"+i+" </td> "+
			"<td align=right>"+frmt.format(prse.parse(rsDetails.getString("TransactionDate")))+"</td>" +
			"<td align=right>"+trDetails+"</td>" +
			"<td align=right>"+rsDetails.getString("DebitAmount")+"</td>" +
			"<td align=right>"+creditAmt+"</td>" +
			"<td align=right>"+rsDetails.getString("Balance")+"</td>" +
			"<td align=right> "+rsDetails.getString("TransactionType")+" </td>" +
			"<td align=left> "+id+" </td>" +
			"<td align=right>"+rsDetails.getString("EmpName")+"</td></tr>" ;
			
			s1+=rsDetails.getDouble("DebitAmount");
			s2+=rsDetails.getDouble("CreditAmount");

			try {
 
				String  arr1[] = { ""+i,frmt.format(prse.parse(rsDetails.getString("TransactionDate"))),
						trDetails,
						rsDetails.getString("DebitAmount"), creditAmt,
						rsDetails.getString("Balance"),rsDetails.getString("TransactionType"),
						rsDetails.getString("EmpName") };

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


 
String bal="NA";	
try{
rsDetails.last();bal=rsDetails.getString("Balance");
}catch(Exception e){}
htmlString = htmlString+"<tr>"+
	"<td colspan='3' style='background-color: #C6DEFF;' >Total:"+  
	  "</td>"+
	"<td style='background-color: #C6DEFF;'  > "+new DecimalFormat("0.00").format(s1) +"</div></td>"+
	"<td style='background-color: #C6DEFF;'  > "+new DecimalFormat("0.00").format(s2) +"</div></td>"+
	"<td style='background-color: #C6DEFF;'  > "+bal +"</div></td>"+
	"<td colspan='3' style='background-color: #C6DEFF;' > .</td></tr>";  
	
String arr4[]={"Total","","",""+new DecimalFormat("0.00").format(s1)+"",""+new DecimalFormat("0.00").format(s2)+"",rsDetails.getString("Balance")};
row = sheet.createRow(++rowcnt);
row.setHeightInPoints(12.75f);
for (int m = 0; m < arr4.length; m++) {
	HSSFCell cell4 = row.createCell(m);
	cell4.setCellStyle(cellStyle);
	cell4.setCellValue(arr4[m]);
}

}





try {
	workbook.write(fileOutputStream);
//	workbookR_D.write(fileOutputStreamR_D);

} catch (IOException e) {

	e.printStackTrace();
}


String Data = " <br><br>Following is Transaction Statement for <b> "+customerName+" </b>From "+fromDateFormat+" To "+toDateFormat+"<br><br>";
Data+="   "+body+"<br>";
Data = Data + "<br>"+htmlString+"</table>";

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
               msg.setSubject("Transaction Statement for "+customerName+" From "+fromDateFormat+" To "+toDateFormat+"");
               msg.setSentDate(new java.util.Date());
               
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
               if(!(customerEmail==null))
               {
            	   if (customerEmail.contains(","))
            	   {
            		     String[] results = customerEmail.split( ",\\s*" ); 
            		      for ( String string : results )
            		        emailCounter++;
            	   }
            	   else
            		   emailCounter++;
               }
               if(!(session.getAttribute("EmpEmail")==null) )  //check for user id
            	   emailCounter++;
               
               Address recipientAddrs[] = new InternetAddress[emailCounter];
               int count=0;
             
               if(!(copyMD==null))
            	   recipientAddrs[count++] = new InternetAddress("md@transworld-compressor.com");
               if(!(copyAccounts==null))
            	   recipientAddrs[count++] = new InternetAddress("accounts@transworld-compressor.com");
               if(!(copySales==null))
            	   recipientAddrs[count++] = new InternetAddress("sales@transworld-compressor.com");
             
               if(!(copyManager==null))
            	   recipientAddrs[count++] = new InternetAddress("n_doshi@transworld-compressor.com");
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
               
               for(int m=0;m<emailCounter;m++)
               {
            	   System.out.println("~~~~~~~~~~~~~"+recipientAddrs[m]);
               }
 
               //if(!(emailId==null))
            	 //  recipientAddrs[6] = new InternetAddress(emailId);
           //    recipientAddrs1[0] = new InternetAddress(emailid);
               msg.addRecipients(Message.RecipientType.TO,recipientAddrs);
               Address fromAddress=new InternetAddress("avlsupport@mobile-eye.in","Transworld"); // in second "", it is short name
          		// : avlsupport@mobile-eye.in
               msg.setFrom(fromAddress);
           //    msg.setContent(Data+"\n\n\n<br> Thanks and Regards" ,"text/html; charset=ISO-8859-1");
           System.out.println(Data);
           msg.setContent(Data,"text/html; charset=ISO-8859-1");
               // Send the message
 
               
               try{
               
				BodyPart messageBodyPart = new MimeBodyPart();

				// Fill the message
				messageBodyPart.setContent(Data +"<br><br><br> Thanks and Regards, <br> Transworld Team", "text/html");
					
				
				Multipart multipart = new MimeMultipart();
				multipart.addBodyPart(messageBodyPart);

				// Part two is attachment
				messageBodyPart = new MimeBodyPart();
				// filename = "/home/pradnya/Desktop/OR_ER_Count.xls";
				DataSource source = new FileDataSource(savefile);
				messageBodyPart.setDataHandler(new DataHandler(source));
				
 
				filename = "Transaction_Statement.xls" ;
				//out.println("***file at send fun->  "+filename);
				messageBodyPart.setFileName(filename);
				multipart.addBodyPart(messageBodyPart);

				// Put parts in message
				msg.setContent(multipart);
               }
               catch(Exception e){
            	   out.print(e);
               }
				// --------------------------- end of
				// logic---------------------------------
			 
			 
			// Send the message

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
		out.println("Email sent successfully");
		System.out.println("E-mail Sending Failed"+e);
	} finally {
	}
	if(savefile.exists())
	{
		savefile.delete();
	}
}catch(Exception e)
{ out.print(e);
	System.out.println(e);
	}
%>
</jsp:useBean>