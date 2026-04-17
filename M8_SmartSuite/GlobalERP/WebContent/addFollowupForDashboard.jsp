<%@page import="java.util.Date"%>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.jibble.simpleftp.*" %>
<%@ page language="java" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.io.File" %> 
<%@ page import="java.io.*"%>
<%@ page import="java.util.List" %>
<%@ include file="conn.jsp"%>
<%@ page import="javax.mail.*,java.util.Properties"%>
<%@ page import="javax.mail.internet.*,javax.activation.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%
	Connection con = null;
	DecimalFormat twoDForm = new DecimalFormat("#.##");
	Statement st1 = null, st2 = null, st3 = null;
	String todaysDate = new SimpleDateFormat("yyyy-MM-dd")
			.format(new java.util.Date());
	String todaysDateTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
			.format(new java.util.Date());
%>
<%
	String f123 = "";
	String itemName = "", docPath = "";
	int fileCount = 0;
	String msg = "";
	String existedDriver = "";
	String resendMsg = "", customername = "", customercode = "", customerCity = "", customerContactPerson = "", filename = "";
	String paymentFolloywup = "", reply = "", fromdate = "", todate = "", comments = "", code = "", followUpStatus = "", followUptype = "", city = "", conperson = "", company = "", doctype = "";
	String preparation = "", followuptime = "", nextfollowuptype = "", hrs = "", mins = "", inout = "", spokento = "", expectedamnt = "", expectedon = "", expdate = "", remarks = "",selectedEmail="";
	String mailIDofLogger = (String)session.getAttribute("EmpEmail");
	System.out.println("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeemmmmmmmmmail====="+mailIDofLogger);
	boolean isMultipart = ServletFileUpload.isMultipartContent(request);
	if (!isMultipart) {
	} else {

		System.out.println("IN ELSE    +++++   ");
		FileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		List items = null;
		try {
			items = upload.parseRequest(request);
		} catch (FileUploadException e) {
			e.printStackTrace();
		}
		Iterator itr = items.iterator();

		//  String a[]=request.getParameter("");
		String a = "";
		while (itr.hasNext()) {
			FileItem item = (FileItem) itr.next();
			if (item.isFormField()) {
				String name = item.getFieldName();
				String value = item.getString();

				if (name.equals("myfile")) {
					filename = value;
				}
				System.out
						.println("file name is      ************************"
								+ filename);

				if (name.equals("paymentFollowUp")) {
					paymentFolloywup = value;
				}
				System.out
						.println("folloy      ************************"
								+ paymentFolloywup);
				if (name.equals("reply")) {
					reply = value;
				}
				System.out
						.println("reply      ************************"
								+ reply);
				if (name.equals("fromdate")) {
					fromdate = value;
				}
				if (name.equals("todate")) {
					todate = value;
				}
				if (name.equals("comments")) {
					comments = value;
				}
				if (name.equals("followUpStatus")) {
					followUpStatus = value;
				}
				if (name.equals("followUpType")) {
					followUptype = value;
				}

				if (name.equals("maincustomer")) {
					company = value;
				}
				System.out.println(">>>>>>>>>>>    " + company);
				if (name.equals("documentType")) {
					doctype = value;
				}

				if (name.equals("preparation")) {
					preparation = value;
				}
				if (name.equals("followuptime")) {
					followuptime = value;
				}
				if (name.equals("nextfollowUpType")) {
					nextfollowuptype = value;
				}
				if (name.equals("hrs")) {
					hrs = value;
				}
				if (name.equals("mins")) {
					mins = value;
				}
				if (name.equals("inorout")) {
					inout = value;
				}
				if (name.equals("spokento")) {
					spokento = value;
				}
				if (name.equals("expectedamnt")) {
					expectedamnt = value;
				}
				if (name.equals("expectedon")) {
					expectedon = value;
					System.out.println("EXPCTD DTAE IS  " + expectedon);

					if (expectedon.equals("")) {
						System.out.println("in if loop      ");
						expdate = "0000-00-00";
					} else {
						expdate = new SimpleDateFormat("yyyy-MM-dd")
								.format(new SimpleDateFormat(
										"dd-MMM-yyyy")
										.parse(expectedon));
					}

				}
				
				System.out.println("DATE IS  " + expdate);

				if (name.equals("remarks")) {
					remarks = value;
				}

				System.out.println("attched Files============>>"
						+ filename);
				
				if(name.equals("SelectedEmpMail"))
				{
			       selectedEmail = value;
			       System.out.println("---------------------------------------------------((((((()))))))"+selectedEmail);
				}
				// out.println("attched Files============>>"+f123);
			} else {
				try {
					itemName = item.getName();
					File savedFile = new File(config
							.getServletContext().getRealPath("/")
							+ itemName);
					out.println("path==========>>"
							+ (config.getServletContext()
									.getRealPath("/")).toString());

					// completePath=(config.getServletContext().getRealPath("/")+itemName).toString();

					docPath = (config.getServletContext()
							.getRealPath("/")).toString();
					System.out.println("PATH BSI   " + docPath);
					item.write(savedFile);
%><center></table><%
	} catch (Exception e) {
					e.printStackTrace();
				}

			}
		}

		//=====Copy 2 FTP===============================================================================================
		try {
			System.out
					.println("iiiiiiiiiiiiiiiiiiiinnn FTP ((((((*****))))))");
			SimpleFTP ftp = new SimpleFTP();
			ftp.connect("202.38.172.58", 21, "sumedh", "789&*(medh");
			ftp.bin();
			System.out.println();
			//ftp.stor(new FileInputStream(new File(cpyPath)), "/Uploaded/"+itemName+"");
			//	   			f123=f123.substring(1, f123.length());
			out.println("values for FTP*********************" + f123);

			String delims12 = "[,]";
			String[] tokens12 = f123.split(delims12);
			for (String t : tokens12) {
				out.println("==========================>>" + docPath
						+ "/" + t);
				ftp.stor(new FileInputStream(new File(docPath + "/"
						+ itemName)), "/ERPDocuments/" + itemName + "");
				System.out.println("path----------->>" + docPath + "/"
						+ t);
				fileCount++;
			}
		} catch (Exception e) {
			System.out
					.println("Exception Copy File to FTP----------->>"
							+ e);
		}

	}
%>
<%
	try {

		Class.forName(DB_Driver);
		con = DriverManager.getConnection(DB_NAME, DB_USERNAME,
				DB_PASSWORD);
		st1 = con.createStatement();
		st2 = con.createStatement();
		st3 = con.createStatement();

		System.out
				.println("IN THIS PAGE   >)))))))))))))))))))))))))))))))) ");
		//paymentFolloywup="No";reply="No";
		if (!(paymentFolloywup == "")) {
			paymentFolloywup = "Yes";
		} else {
			paymentFolloywup = "No";
		}
		if (!(reply == "")) {
			reply = "Yes";
		} else {
			reply = "No";
		}

		fromdate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy")
						.parse(fromdate));
		String nextfollowupdatesdate = new SimpleDateFormat(
				"yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy")
						.parse(todate));

		String sql = "";
		comments = comments.replaceAll("'", " ").replaceAll("-", " ");
		//company=request.getParameter("maincustomer");
		System.out
				.println("++++++++++++++     ********     " + company);
		String sqldata = "select * from "+session.getAttribute("CompanyMasterID").toString()+"followup where ProspCustName ='"
				+ company + "'";
		System.out.println(sqldata);
		ResultSet rsdata = st2.executeQuery(sqldata);
		rsdata.next();
		String custcode = rsdata.getString("ProspCustCode");
		String city1 = rsdata.getString("City");
		String contactperson = rsdata.getString("ContactPerson");

		if (itemName != "") {
			System.out.println("IN IF ");

			sql = "INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"followup ( "
					+ " 	ProspCustCode, 	FollowUpDate,FollowUpTime ,Status, FollowUpType,FollowUpInOut, "
					+ "	Comments 	,NextFollowUpDate ,NextFollowUpTime,NextFollowUpType,Preparation,"
					+ " 	MarketingRepcode ,	City ,	ContactPerson  ,"
					+ "	ProspCustName , "
					+ "   PaymentFollowup ,SpokenTo ,AmountExpected ,AmountExpectedOn ,Remarks , Reply,DocumentType,DocumentName,DocumentStatus) VALUES "
					+ "   ('"
					+ custcode
					+ "','"
					+ fromdate
					+ "','"
					+ followuptime
					+ "','"
					+ followUpStatus
					+ "','"
					+ followUptype
					+ "','"
					+ inout
					+ "', "
					+ "	'"
					+ comments
					+ "','"
					+ nextfollowupdatesdate
					+ "','"
					+ hrs
					+ ":"
					+ mins
					+ ":00','"
					+ nextfollowuptype
					+ "','"
					+ preparation
					+ "',"
					+ "	'"
					+ session.getAttribute("EmpCode")
					+ "','"
					+ city1
					+ "','"
					+ contactperson
					+ "',"
					+ "	'"
					+ company
					+ "','"
					+ paymentFolloywup
					+ "','"
					+ spokento
					+ "','"
					+ expectedamnt
					+ "','"
					+ expdate
					+ "','"
					+ remarks
					+ "','"
					+ reply
					+ "','"
					+ doctype
					+ "','"
					+ itemName + "','Upload')";
		} else {
			System.out.println("IN ELSE ");
			sql = "INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"followup ( "
					+ " 	ProspCustCode, 	FollowUpDate, FollowUpTime , Status, FollowUpType,FollowUpInOut,  "
					+ "	Comments 	,NextFollowUpDate ,NextFollowUpTime,NextFollowUpType,Preparation,"
					+ " 	MarketingRepcode ,	City ,	ContactPerson  ,"
					+ "	ProspCustName , "
					+ "   PaymentFollowup ,SpokenTo ,AmountExpected ,AmountExpectedOn ,Remarks ,Reply,DocumentType,DocumentName,DocumentStatus) VALUES "
					+ "   ('"
					+ custcode
					+ "','"
					+ fromdate
					+ "','"
					+ followuptime
					+ "','"
					+ followUpStatus
					+ "', "
					+ "	'"
					+ followUptype
					+ "','"
					+ inout
					+ "','"
					+ comments
					+ "','"
					+ nextfollowupdatesdate
					+ "','"
					+ hrs
					+ ":"
					+ mins
					+ ":00','"
					+ nextfollowuptype
					+ "','"
					+ preparation
					+ "',"
					+ "	'"
					+ session.getAttribute("EmpCode")
					+ "','"
					+ city1
					+ "','"
					+ contactperson
					+ "',"
					+ "	'"
					+ company
					+ "','"
					+ paymentFolloywup
					+ "','"
					+ spokento
					+ "','"
					+ expectedamnt
					+ "','"
					+ expdate
					+ "','"
					+ remarks + "','" + reply + "','-','-','-')";

		}
		System.out.println(sql);

		try {
			Class.forName(DB_Driver);
			con = DriverManager.getConnection(DB_NAME, DB_USERNAME,
					DB_PASSWORD);
			Statement stmt = con.createStatement();
			stmt.executeUpdate(sql);
			boolean flag1 = false;

			if (selectedEmail != "" || selectedEmail != null) {
				  try
			       {
						//===============================================Send Email Start (SHOAIB)========================================
					  String Data = "";
					  if(code != "" || company != null)
					  {Data="Respected Sir/Madam,\n\nYour Follow-Up Details Are As Follows.\nCompany Name: "+company+""+
				             "\nFollow-Up Date: "+fromdate+""+
				             "\nFollow-Up Time: "+followuptime+""+
				        		"\nComments: "+comments+""+
				        		"\nNext Follow-Up Date: "+todate+"  "+hrs+":"+mins+""+
				        		"\nSpoken To: "+spokento+""+
				        		"\nContact Person: "+conperson+""+
				        		"\nCity: "+city+""+
				        		"\nRemark: "+remarks+""+
				        		"\nDocument Type: "+doctype+"";
						  System.out.println("in DDDDDDDDDDDDDDDDAta====="+Data);
						  }
					  else if(customercode != "" || customername != null)
					  {
						  Data="Respected Sir/Madam,\n\nYour Follow-Up Details Are As Follows.\nCompany Name: "+company+""+
						  "\nFollow-Up Date: "+fromdate+""+
				             "\nFollow-Up Time: "+followuptime+""+
				        		"\nComments: "+comments+""+
				        		"\nNext Follow-Up Date: "+todate+"  "+hrs+":"+mins+""+
				        		"\nSpoken To: "+spokento+""+
				        		"\nContact Person: "+conperson+""+
				        		"\nCity: "+city+""+
				        		"\nRemark: "+remarks+""+
				        		"\nDocument Type: "+doctype+"";
						  System.out.println("in DDDDDDDDDDDDDDDDAta====="+Data);
					  }
					  
			             Properties props = new Properties();
			             String host="smtp.transworld-compressor.com";
			             String protocol="smtp";
			             String user="tripend@mobile-eye.in";
			             String pass="transworld";
			             props.put("mail.smtp.starttls.enable","true");
			             props.put("mail.smtp.auth", "true");
			             props.put("mail.smtp.user", "user");
			             props.put("mail.smtp.password", "pass");  
			             props.put("mail.store.protocol", protocol);
			             props.put("mail.smtps.host", host);
			              
			             Session session1 = Session.getDefaultInstance(props,null);
			             // Construct the message
			              Message msg1 = new MimeMessage(session1);
			              msg1.setSubject("Follow-Up Details . This is a autogenerated mail please do not reply to it.");
			              msg1.setSentDate(new java.util.Date());
						out.println("==1===");
	               		//  mail id-------------
	              //========================================================================= 	
	               	
			        		Address recipientAddrs[] = new InternetAddress[1];
			        		Address recipientAddrs1[] = new InternetAddress[1];
	               		
			        		System.out.println("0000000000000000000000000000000"+mailIDofLogger);
			        		System.out.println("0000000000000000000000000000000"+selectedEmail);
			        		//recipientAddrs[0] = new InternetAddress(selectedEmail);
	                   	    recipientAddrs[0] = new InternetAddress(mailIDofLogger);//sysAdmin	System Admin
	                   // recipientAddrs1[0] = new InternetAddress("s_joshi@transworld-compressor.com");//hodMail HOD
	                   recipientAddrs1[0] = new InternetAddress(selectedEmail);
	                   	
	                   	msg1.addRecipients(Message.RecipientType.TO,recipientAddrs);
	                   	msg1.addRecipients(Message.RecipientType.CC,recipientAddrs1);
			            
	               	out.println("==2===");
			       //=========================================================================
			              
			              Address fromAddress = new InternetAddress("avlsupport@mobile-eye.in","AVL Support"); // in
			              msg1.setFrom(fromAddress);
				              out.println("==3===");
				              BodyPart messageBodyPart = new MimeBodyPart();
			            	  out.println("==4===");
		            		  messageBodyPart.setText(Data+"\n\n\nThanks and Regards,\n Transworld Team");
				              out.println("==5===");
				              Multipart multipart = new MimeMultipart();
				              multipart.addBodyPart(messageBodyPart);

					          // Part two is attachment
					   ///       messageBodyPart = new MimeBodyPart();
					          if (itemName != "") {
					            messageBodyPart = new MimeBodyPart();
								DataSource source = new FileDataSource(docPath+"/"+itemName);
						        messageBodyPart.setDataHandler(new DataHandler(source));
						        messageBodyPart.setFileName(itemName);
						        multipart.addBodyPart(messageBodyPart);
					          }

		
	//Put parts in message
	msg1.setContent(multipart);
	out.println("==8===");
	//--------------------------- end of logic---------------------------------
	//Send the message
	Transport t = session1.getTransport("smtps");
	msg1.saveChanges(); // don't forget this
	try
	{

	 t.connect(host, user, pass);
	 out.println("==9===");
	 t.sendMessage(msg1, msg1.getAllRecipients());
	 // t.sendMessage(msg1, msg1.getAllRecipients());
	//  flag=true; 
	 System.out.println("Your message has been sent");
	}
	catch(Exception e)
	{
	System.out.print("Exception----->"+e);

	} 
	finally 
	{
	t.close();
	out.println("==10===");
	} 
	     
	Transport.send(msg1);
	                                    
	}// end of inner try
	catch(Exception e)
	{
	System.out.println("Sorry, your mail cannot be sent due to Congestion----->"+e);
	}
}

			System.out.println("IN TRY BLOCKJ   ");

			msg = "Follow Up For " + company
					+ " is added successfully in system.";
			out.println("msg is" + msg);

			response.sendRedirect("alert.jsp?msg=" + msg);
		} catch (Exception e) {
			e.printStackTrace();
			response
					.sendRedirect("alert.jsp?msg=!!! ERROR while inserting Follow up in System/n . Please try  again");
		}

	} catch (Exception e) {
		System.out.println("Exception in Claim Insert ::" + e);
		response
				.sendRedirect("alert.jsp?msg=!!!! ERROR Inserting Record.Please try again.");
	} finally {
		con.close();
	}
%>