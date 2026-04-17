<%@page import="org.apache.commons.net.ftp.FTPClient"%>
<%@page import="org.apache.commons.net.ftp.FTP"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.sql.*"%>
<%@page import="com.ConnectionClass"%>
<%@ page language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.io.*"%>
<%@ page import="java.net.URL"%>
<%@ page import="java.net.*"%>
<%@ page
	import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="javax.mail.*" import="java.util.Properties"
	import="javax.mail.internet.InternetAddress"
	import="javax.mail.internet.MimeMessage"%>
<%@ page import="javax.servlet.http.HttpServletRequest"
	import="javax.mail.internet.MimeBodyPart"
	import="javax.mail.internet.MimeMultipart"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="org.apache.commons.fileupload.FileItem"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page
	import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="javax.activation.*"%>
<%@ page import="org.jibble.simpleftp.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title></title>
</head>
<body>


	<% 

boolean MAINFLAG=false;
String getMsg="";

try
{
	
	String inrefno=request.getParameter("inrefno");
	String inno=request.getParameter("inno");
	String from=request.getParameter("from");
	String prno=request.getParameter("prno");
	String to=request.getParameter("to");
	String dept=request.getParameter("dept");
	String cat=request.getParameter("cat");
	String rd=request.getParameter("rd");
	String itemName=request.getParameter("itemName");
	String sub=request.getParameter("sub");
	String data=request.getParameter("data");
	String completePath=request.getParameter("completePath");
	String priority=request.getParameter("priority");
	String docPath=request.getParameter("docPath");
	String AllFileNames=request.getParameter("AllFileNames");
	
	String address=request.getParameter("address");
	String manualref=request.getParameter("manualref");
	//================================================================
	String remark=request.getParameter("remark");
	String blno=request.getParameter("blno");
	String blamt=request.getParameter("blamt");
	String bldate=request.getParameter("bldate");
	String blduedate=request.getParameter("blduedate");
	
	String agreementParty=request.getParameter("agreementParty");
	String agreementDate=request.getParameter("agreementDate");
	String agreementFrom=request.getParameter("agreementFrom");
	String agreementTo=request.getParameter("agreementTo");
	//================================================================
		System.out.println("!!!!!!!!!!!!"+AllFileNames+"!!!!!!!!!!!!");
	System.out.println("inwardEmail===>>>"+inno+"=="+inrefno+"==="+from+"==="+prno+"==="+to+"==="+dept+"===="+cat+"===="+rd+"===="+itemName+"===="+data+"==="+sub+"==="+completePath+"====="+priority+"==="+docPath+"==="+AllFileNames+"====="+remark+"==="+blno+"==="+blamt+"==="+bldate+"==="+blduedate);
	//====URL for File on FTP====================================
	int fileCount=0;
	int cntg=0;
	String emailToId="";
	//String[] tokensEmail =null;
	//ArrayList emailToken=new ArrayList();
	List<String> list=null;
	ConnectionClass connection = new ConnectionClass();
	Statement stmt=null, stmt1=null,st1=null, st2=null;
	Connection con =null;
	try {
		con = connection.getConnect("db_leaveapplication");       
	  
		stmt=con.createStatement();
		stmt1=con.createStatement();
		 st1=con.createStatement();
		  st2=con.createStatement();
	} catch (Exception e) {
	   e.printStackTrace();
	} 
	try
  	{
		
		
		ArrayList a1=new ArrayList();
	    //=======================================================
	    DateFormat dff1=new SimpleDateFormat("HHmmss");
	    String d1=dff1.format(new java.util.Date());
	    //=======================================================
			    	
	    		boolean allFileFlag=false;//remaim false if all files uploaded properly
	    		
	    		String editFiles="";
	    		
	    		String delims12 = "[,]";
			    String[] tokens12 = AllFileNames.split(delims12);
				for (String t : tokens12)
				{
					//***concat current timestamp with file*****************
					  // editFiles="";
					   String s1="";
					   
					   try
					   {
						   s1=t.substring(0,t.lastIndexOf("."))+d1+t.substring(t.lastIndexOf("."), t.length());
					   }
					   catch (Exception e) 
					   {
						   s1=t+d1;
					   }
					   
					   if(editFiles=="" || editFiles.equals(""))
					   {
						   editFiles=s1;
					   }
					   else
					   {
						   editFiles=editFiles+","+s1;
					   }
					   
					   
					  // System.
					   //******************************************************
					
					if(allFileFlag==false)
					{
						boolean flg=false;
						
						//**Check If file Exist On FTP****************************************************
						
					
						
						fileCount++;
				}//end of IF for allFileFlag
				else
				{
					MAINFLAG=true;
					break;
				}
			}//End Of For
			//******Insert Into Database********************************************
				if(allFileFlag==false && a1.size()==0) 	  
                { 	  
					
					//===Email ID of TO=========================================
					cntg=0;
					emailToId="";
				    String[] tokensName = to.split(delims12);
					for (String t : tokensName)
					{
						 cntg++;
						 	String sqlID="select Email from t_leaveadmin where Name='"+t+"'";
							ResultSet rs1=st1.executeQuery(sqlID);
							if(rs1.next())
							{
								String mailIdTo=rs1.getString("Email");
								emailToId=emailToId+""+mailIdTo+",";
							}
					}
					//==========================================================
					
					//====Insert nito Database=========================================
					
					//msg = "Record Successfully Inserted";
					String sqlInsert="",sqlInsert1="";
					java.util.Date today = new java.util.Date();
					String todaydate=new SimpleDateFormat("yyyy-MM-dd").format(today);
					String todaytime=new SimpleDateFormat("HH:mm:ss").format(today);
					DateFormat df1=new SimpleDateFormat("yyyy-MM-dd");
					DateFormat df2=new SimpleDateFormat("dd-MMM-yyyy");
					//**********insert into DB*************************************************************************
					
					int ct=0;
					//String delims12 = "[,]";
					/*tokensEmail = emailToId.split(delims12);
					for(String t : tokensEmail)
					{
						ct++;
					}*/
					list = Arrays.asList(emailToId.split(delims12));

					
					
					
					String delim = "[,]";
					String[] tok = AllFileNames.split(delim);
					out.println("==6===");
					int cnt=0;
					
					//	String ftpLoc="ftp://"+serverid+"/test/";
						String storeName="",storeEmpMail="";
						
						
						for(int k=0;k<=cntg-1;k++)
						{
							if(storeName=="" || storeEmpMail=="")
							{
								storeName=tokensName[k];
								//storeEmpMail=tokensEmail[k];
								storeEmpMail=list.get(k);
							}
							else
							{
								storeName=storeName+","+tokensName[k];
								//storeEmpMail=storeEmpMail+","+tokensEmail[k];
								storeEmpMail=storeEmpMail+","+list.get(k);
							}
						}
						
						agreementDate=df1.format(df2.parse(agreementDate));
						agreementFrom=df1.format(df2.parse(agreementFrom));
						agreementTo=df1.format(df2.parse(agreementTo));
						if(!(cat.equals("Agreement")))
				   		   {
				   				agreementDate="0000-00-00";
				   				agreementFrom="0000-00-00";
				   				agreementTo="0000-00-00";
				   		   }
							
						bldate=df1.format(df2.parse(bldate));
						blduedate=df1.format(df2.parse(blduedate));
						if(!(cat.equals("Bills")))
				   		   {
				   				bldate="0000-00-00";
				   				blduedate="0000-00-00";
				   				blamt="0.00";
				   		   }
						double dblAmt=0;
						try
						{
							dblAmt= Double.parseDouble(blamt);
						}
						catch(Exception e)
						{
							System.out.println("Bill Amt Parse Exception !!!::"+e);
						}
						
						if(rd.equals("link") || rd.equals("attch"))
						{
						//	sqlInsert="INSERT INTO db_leaveapplication.t_inwarddetails (InwardNo ,InwardRefNo ,InwardDate ,InwardTime ,FromParty ,PartyRefNo ,ToEmploy ,ToEmailID ,Subject ,Dept ,Category,FileName ,FileLocation ,Enteredby ,EmailSend, ActionDate,InwrdPriority,InwardStatus)VALUES('"+inno+"', '"+inrefno+"', '"+todaydate+"' , '"+todaytime+"' , '"+from+"', '"+prno+"', '"+storeName+"', '"+storeEmpMail+"', '"+sub+"', '"+dept+"', '"+cat+"','"+AllFileNames+"','"+ftpLoc+"', '"+session.getAttribute("empname")+"', 'Yes','"+data+"','"+priority+"','inwarded')";
						    sqlInsert="INSERT INTO db_leaveapplication.t_inwarddetails (InwardNo ,InwardRefNo,ManualRef ,InwardDate ,InwardTime ,FromParty ,PartyRefNo ,Address ,ToEmploy ,ToEmailID ,Subject ,Dept ,Category,BillNo,BillAmt,BillDate,BillDueDate,agreementParty,agreementDate,agreementFrom,agreementTo,FileName ,FileLocation ,Enteredby, EnteredById, ActionDate,senderRemark,InwrdPriority,InwardStatus)VALUES('"+inno+"', '"+inrefno+"','"+manualref+"' ,'"+todaydate+"' , '"+todaytime+"' , '"+from+"', '"+prno+"', '"+address+"', '"+storeName+"', '"+storeEmpMail+"', '"+sub+"', '"+dept+"', '"+cat+"','"+blno+"','"+dblAmt+"','"+bldate+"','"+blduedate+"','"+agreementParty+"','"+agreementDate+"','"+agreementFrom+"','"+agreementTo+"','"+itemName+"','"+completePath+"', '"+session.getAttribute("leaveempname").toString()+"', '"+session.getAttribute("leaveempID").toString()+"' ,'Yes','"+data+"','"+remark+"','"+priority+"','inwarded')";
							System.out.println(sqlInsert);
							 sqlInsert1="INSERT INTO db_leaveapplication.t_inwarddetailshistory (InwardNo ,InwardRefNo,ManualRef ,InwardDate ,InwardTime ,FromParty ,PartyRefNo ,Address ,ToEmploy ,ToEmailID ,Subject ,Dept ,Category,BillNo,BillAmt,BillDate,BillDueDate,agreementParty,agreementDate,agreementFrom,agreementTo,FileName ,FileLocation ,Enteredby, EnteredById ,EmailSend, ActionDate,senderRemark,InwrdPriority,InwardStatus)VALUES('"+inno+"', '"+inrefno+"','"+manualref+"' ,'"+todaydate+"' , '"+todaytime+"' , '"+from+"', '"+prno+"', '"+address+"', '"+storeName+"', '"+storeEmpMail+"', '"+sub+"', '"+dept+"', '"+cat+"','"+blno+"','"+blamt+"','"+bldate+"','"+blduedate+"','"+agreementParty+"','"+agreementDate+"','"+agreementFrom+"','"+agreementTo+"','"+itemName+"','"+completePath+"', '"+session.getAttribute("leaveempname").toString()+"', '"+session.getAttribute("leaveempID").toString()+"' ,'Yes','"+data+"','"+remark+"','"+priority+"','inwarded')";
								
							
						}
						else
						{
						//	sqlInsert="INSERT INTO db_leaveapplication.t_inwarddetails (InwardNo ,InwardRefNo ,InwardDate ,InwardTime ,FromParty ,PartyRefNo ,ToEmploy ,ToEmailID ,Subject ,Dept ,Category,FileName ,FileLocation ,Enteredby ,EmailSend, ActionDate,,InwrdPriority,InwardStatus)VALUES('"+inno+"', '"+inrefno+"', '"+todaydate+"' , '"+todaytime+"' , '"+from+"', '"+prno+"', '"+storeName+"', '"+storeEmpMail+"', '"+sub+"', '"+dept+"', '"+cat+"','"+AllFileNames+"','"+ftpLoc+"', '"+session.getAttribute("empname")+"', 'No','"+data+"','"+priority+"','inwarded')";
							sqlInsert="INSERT INTO db_leaveapplication.t_inwarddetails (InwardNo ,InwardRefNo,ManualRef ,InwardDate ,InwardTime ,FromParty ,PartyRefNo ,Address ,ToEmploy ,ToEmailID ,Subject ,Dept ,Category,BillNo,BillAmt,BillDate,BillDueDate,agreementParty,agreementDate,agreementFrom,agreementTo,FileName ,FileLocation ,Enteredby,EnteredById ,EmailSend, ActionDate,senderRemark,InwrdPriority,InwardStatus)VALUES('"+inno+"', '"+inrefno+"', '"+manualref+"','"+todaydate+"' , '"+todaytime+"' , '"+from+"', '"+prno+"', '"+address+"', '"+storeName+"', '"+storeEmpMail+"', '"+sub+"', '"+dept+"', '"+cat+"','"+blno+"','"+dblAmt+"','"+bldate+"','"+blduedate+"','"+agreementParty+"','"+agreementDate+"','"+agreementFrom+"','"+agreementTo+"','"+itemName+"','"+completePath+"', '"+session.getAttribute("leaveempname").toString()+"', '"+session.getAttribute("leaveempID").toString()+"' ,'No','"+data+"','"+remark+"','"+priority+"','inwarded')";
							System.out.println(sqlInsert);
							sqlInsert1="INSERT INTO db_leaveapplication.t_inwarddetailshistory (InwardNo ,InwardRefNo,ManualRef ,InwardDate ,InwardTime ,FromParty ,PartyRefNo ,Address ,ToEmploy ,ToEmailID ,Subject ,Dept ,Category,BillNo,BillAmt,BillDate,BillDueDate,agreementParty,agreementDate,agreementFrom,agreementTo,FileName ,FileLocation ,Enteredby,EnteredById ,EmailSend, ActionDate,senderRemark,InwrdPriority,InwardStatus)VALUES('"+inno+"', '"+inrefno+"', '"+manualref+"','"+todaydate+"' , '"+todaytime+"' , '"+from+"', '"+prno+"', '"+address+"', '"+storeName+"', '"+storeEmpMail+"', '"+sub+"', '"+dept+"', '"+cat+"','"+blno+"','"+blamt+"','"+bldate+"','"+blduedate+"','"+agreementParty+"','"+agreementDate+"','"+agreementFrom+"','"+agreementTo+"','"+itemName+"','"+completePath+"', '"+session.getAttribute("leaveempname").toString()+"', '"+session.getAttribute("leaveempID").toString()+"' ,'No','"+data+"','"+remark+"','"+priority+"','inwarded')";
							
						}
						st2.executeUpdate(sqlInsert);
						System.out.println("##########inserted########");
						st2.executeUpdate(sqlInsert1);
					//***code to insert records in inward Followup***************************************
					    String d2 = "[,]";
					    String[] t2 = to.split(d2);
						for (String t : t2)
						{
							String inwrdFollowup="insert into db_leaveapplication.t_inwardfollowup(iwrefno,ManualRef,docReceiver, docSender,senderRemarks,actionondoc) values('"+inrefno+"','"+manualref+"','"+t+"','"+session.getAttribute("leaveempname").toString()+"','"+remark+"','inward')";
							st2.executeUpdate(inwrdFollowup);
						}
					
					//***********************************************************************************
				//=================================================================
                }
			//**********************************************************************
				out.println("\n%%%%%%%%%%%%%"+allFileFlag+"%%%%%%%%%%%%%");
				out.println("\n%%%%%%%%%%%%%"+a1+"%%%%%%%%%%%%%");
  	}
  	catch(Exception e)
  	{
  		MAINFLAG=true;
  		System.out.println("Exception Copy File to FTP----------->>"+e);
  		out.println("Exception Copy File to FTP----------->>"+e);
  	}
	
	//=====Taken frm DB=========================================
	//String ftpURL="ftp://"+serverid+"/../test/"+itemName;
	//==========================================================
	//====Send Mail if Link or Attch==================================
		
		  if(MAINFLAG==false)
		  {
						if(rd.equals("link") || rd.equals("attch"))
						{
       						 boolean flag=false;
						        try
						       {
						             String Data="";
						              if(rd.equals("link"))
							       	  {
						            	  Data="There is a New Document For You \n Please find the details.\n\n";
							       	  }
						       	  	  else
							       	  {
						       	  		Data="There is a New Document For You \n Please find the attachment.\n\n";
							       	  }
						             Properties props = new Properties();
						       //      String host="smtp.transworld-compressor.com";
						       		 String host="smtpout.secureserver.net";
						             String protocol="smtp";
						             String user="tripend@mobile-eye.in";
						             String pass="transworld";
						             props.put("mail.smtp.starttls.enable","true");
						             props.put("mail.smtp.auth", "true");
						             props.put("mail.smtp.user", "user");
						             props.put("mail.smtp.password", "pass");  
						             props.put("mail.store.protocol", protocol);
						             props.put("mail.smtps.host", host);
						             //java.security.Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());
						             Session session1 = Session.getDefaultInstance(props,null);
						             // Construct the message
						              Message msg = new MimeMessage(session1);
						         //     msg.setSubject("New Document From:"+session.getAttribute("empname").toString()+"; Subject:"+sub+". This is a " +"autogenerated mail please do not reply to it.");
						         msg.setSubject(sub+" From "+from);
						              msg.setSentDate(new java.util.Date());
             						  out.println("==1===");
                                 		//  mail id-------------
                                //========================================================================= 	
						            Address recipientAddrs[] = new InternetAddress[cntg];
                                 	for(int k=0; k<=cntg-1; k++)
                                 	{
                                 		recipientAddrs[k] = new InternetAddress(list.get(k));
                                 	}
                                 	out.println("==2===");
						       //=========================================================================
						              msg.addRecipients(Message.RecipientType.TO,recipientAddrs);
						          
						              Address fromAddress = new InternetAddress("noreply@transworld-compressor.com","ERP TW Doc"); // in
						         
						              msg.setFrom(fromAddress);
						              
						              // ------------ code for sending attachment------------------
              
							           // Create the message part
							           String urlFile=completePath;
							              out.println("==3===");
							              
							              BodyPart messageBodyPart = new MimeBodyPart();
							              
						            	  out.println("==4===");
						
						              // Fill the message
						              if(!(remark==null || remark==""))
						              {
						            	  if(manualref.equals("") || manualref.equalsIgnoreCase("NULL") || manualref=="" || manualref==null)
						            	  {
						            	  	messageBodyPart.setText(Data+"\nInward Ref.No.:"+inrefno+"\nFrom:"+from+"\nParty Ref.No.:"+prno+"\nSubject:"+sub+"\nCategory:"+cat+"\nAction Date:"+data+"\nPriority:"+priority+"\nRemark:"+remark+"\n\n Thanks and Regards,\n Transworld Team");
						            	  }
						            	  messageBodyPart.setText(Data+"\nInward Ref.No.:"+inrefno+"\nManual Ref:"+manualref+"\nFrom:"+from+"\nParty Ref.No.:"+prno+"\nSubject:"+sub+"\nCategory:"+cat+"\nAction Date:"+data+"\nPriority:"+priority+"\nRemark:"+remark+"\n\n Thanks and Regards,\n Transworld Team");
						              }
						              else
						              {
						            	  if(manualref.equals("") || manualref.equalsIgnoreCase("NULL") || manualref=="" || manualref==null)
						            	  {
						            		  messageBodyPart.setText(Data+"\nInward Ref.No.:"+inrefno+"\nFrom:"+from+"\nParty Ref.No.:"+prno+"\nSubject:"+sub+"\nCategory:"+cat+"\nAction Date:"+data+"\nPriority:"+priority+"\n\n Thanks and Regards,\n Transworld Team");
						            	  }
						            	  messageBodyPart.setText(Data+"\nInward Ref.No.:"+inrefno+"\nManual Ref:"+manualref+"\nFrom:"+from+"\nParty Ref.No.:"+prno+"\nSubject:"+sub+"\nCategory:"+cat+"\nAction Date:"+data+"\nPriority:"+priority+"\n\n Thanks and Regards,\n Transworld Team");  
						              }
						              	  
							              out.println("==5===");
							              
							              Multipart multipart = new MimeMultipart();
							              multipart.addBodyPart(messageBodyPart);
				
              	if(!(rd.equals("link")))
              	{
					String delims = "[,]";
				    String[] tokens1 = AllFileNames.split(delims);
				    out.println("==6===");
				    int cnt1=0;
					for (String t1 : tokens1)
					{
						out.println("attch files=====>>>"+t1);
		              //  addAttachment(multipart,docPath+"/"+t1,cnt);
		                
		              //**************************************************
						try
						{
							String de= "[,]";
						    String[] tok1 = AllFileNames.split(de);
						    int cnt2=0;
						    messageBodyPart = new MimeBodyPart();
							DataSource source = new FileDataSource(docPath+"/"+t1);
					        messageBodyPart.setDataHandler(new DataHandler(source));
					        messageBodyPart.setFileName(t1);
					        multipart.addBodyPart(messageBodyPart);
						}
						catch(Exception e)
						{
							System.out.println("Exception Attch======>>"+e);
						}
						//**************************************************
		                
					}
					
					out.println("==7===");
              	}
              // Put parts in message
              msg.setContent(multipart);
              out.println("==8===");
               //--------------------------- end of logic---------------------------------
              // Send the message
              
              
              Transport t = session1.getTransport("smtps");
              msg.saveChanges(); // don't forget this
              
                 
              try
              {
                   t.connect(host, user, pass);
                   out.println("==9===");
                   t.sendMessage(msg, msg.getAllRecipients());
                   // t.sendMessage(msg1, msg1.getAllRecipients());
                   flag=true;
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
                       
              Transport.send(msg);
                                                      
       }// end of inner try
       catch(Exception e)
       {
               
               //System.out.println("Sorry, your mail cannot be sent due to Congestion");
               

       }
    	//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	}
	//================================================================
	
	getMsg="Documents Inwarded Successfully";
	}//MAINFLAG if close
	else
	{
		getMsg="Unable to Inward due to server side congetion";
	}
		  response.sendRedirect("inward.jsp?getMsg="+getMsg);
}
catch(Exception e)
{
	getMsg="Unable To Insert Record";
	System.out.println("Exception=Inward Email======>>"+e);
	response.sendRedirect("inward.jsp?getMsg="+getMsg);
}
%>
</body>
</html>