<%@ include file="conn.jsp"%>
<%@page import="java.io.Flushable"%>

<%@page import="java.net.*"%>
<%@page import="java.io.BufferedReader"%>
<%@ page
	import="java.util.Properties,javax.mail.*,javax.mail.internet.*"
	import="javax.mail.Session"%>
<%@page import="java.io.DataInputStream"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.InputStreamReader"%>
<%@page
	import="java.util.Date, 
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
 java.text.ParseException"%>
<%! 
Connection con ;
%>
<%try{
		int customerCode=0;	
        String repName=request.getParameter("repName");       
        String vendor=request.getParameter("vendorcode");
        System.out.println("VENDOR CODE  IS *****************     "+vendor);
        
        String companyName=request.getParameter("companyName");    
        System.out.println("COMPANY IS *****************     "+companyName);
        String companyafteredit=request.getParameter("companyNameafteredit");
        System.out.println("COMPANY AFTER EDIT IS      *****************     "+companyafteredit);
        
        String contactPerson=request.getParameter("contactPerson");  
        String logo=request.getParameter("elemen"+session.getAttribute("CompanyMasterID").toString()+"4"); 
        
        System.out.println("CONTACT PERSON  IS      *****************     "+contactPerson);
        
        String website=request.getParameter("website");              
        String email=request.getParameter("email");                  
        String city=request.getParameter("city");    
        if(city.contains("-") || request.getParameter("newcity")!="")
        {
        	city=request.getParameter("newcity");
        }	
        System.out.println("city is"+city);
        String zip=request.getParameter("zip");             
        String state=request.getParameter("state");         
        String country=request.getParameter("country");     
        String phone=request.getParameter("ph");         
        String fax=request.getParameter("fax");             
        String category=request.getParameter("category");   
        String product=request.getParameter("product");              
        String weeklyOffOn=request.getParameter("weeklyOffOn");      
		String alternateNumber=request.getParameter("alternateNumber");  
		String address=request.getParameter("address");
		String date=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		String mobile=request.getParameter("phone");//
		String mobile1=request.getParameter("mobileno1");
		String mobile2=request.getParameter("mobileno2");
		
		String stdCode=request.getParameter("std"); 
		
		String ocode=request.getParameter("ocode"); 
		String oname=request.getParameter("oname"); 

		String designation=request.getParameter("designation"); 

		
		String addedOn=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
		String potentialValue=request.getParameter("potentialValue").toString().replaceAll(",","");
		String comments=request.getParameter("comments").replaceAll("'"," ");
		String assignedBy=request.getParameter("assignedBy");
		String leadRef=request.getParameter("leadRef");
		String noofunits=request.getParameter("noofunits");
		System.out.println("UNITS ARE *********      "+noofunits);
		String dateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
		
		Class.forName(DB_Driver);
		con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
		Statement stmt=con.createStatement();
		Statement stmt1=con.createStatement();
		Statement stmt2=con.createStatement();
		Statement stmt3=con.createStatement();
		
		if(request.getParameter("assignTo")!=null)
			repName=request.getParameter("assignTo");
									                         
		if(alternateNumber.equalsIgnoreCase(""))
				alternateNumber="0";
		
		if(mobile.equalsIgnoreCase(""))
			mobile="0";
		if(mobile1.equalsIgnoreCase(""))
			mobile1="0";
		if(mobile2.equalsIgnoreCase(""))
			mobile2="0";
				
		if(potentialValue.equalsIgnoreCase(""))
		potentialValue="0";
		System.out.println("22222222222222222222222  ");
		String repcode="";

		try{
		 String sqlrepcode="Select MarketingRepCode from "+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster where MarketingRepName='"+repName+"'";
		 System.out.println(sqlrepcode);
			 
	     ResultSet rscode=stmt1.executeQuery(sqlrepcode);
	     rscode.next();   
		  repcode=rscode.getString("MarketingRepCode");				
			System.out.println("233333333333   3333333333  "+repcode);
		
}catch(Exception e)
{
	e.printStackTrace();
}
String sqlInsert="";
					
			
			
			if(request.getParameter("update")==null) 
			{
				String sqlCode="SELECT MAX(CustomerCode) from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster  ";
				ResultSet rsCode=stmt.executeQuery(sqlCode);
				if(rsCode.next())
					customerCode=rsCode.getInt(1)+1;
				
				sqlInsert = "INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster(CustomerCode,CompanyName, 	Address, 	City, 	Zip, 	State,"+
        		" 	ContactPerson, 	MobileNo, MobileNo1, MobileNo2,	Fax ,	EMail,	WebSite 	,IntrestedProduct ,"+
        		"	CustEnteredByRep ,	WeeklyOffon 	,AddedOnDate, "+
        		"		Category 	,	TelephoneNo2 ,phone,STDCode,ProspCustAddedOn,Country,OpportunityCode,OpportunityName,comments,PotentialValue,NoOfUnits,Assighnedby,leadRef,Allocatedto) VALUES "+
        		"	("+customerCode+",'"+companyName+"','"+address.replaceAll("'"," ")+"','"+city+"','"+zip+"','"+state+"',"+
        		"	'"+logo+" "+contactPerson+"','"+mobile+"','"+mobile1+"','"+mobile2+"','"+fax+"','"+email.replaceAll("'"," ")+"','"+website+"','"+product+"','"+repName+"',"+
        		"    '"+weeklyOffOn+"','"+date+"','"+category+"','"+alternateNumber+"','"+phone+"','"+stdCode+"','"+addedOn+"','"+country+"','"+ocode+"','"+oname+"','"+comments.replaceAll("'"," ")+"',"+
        		"     '"+potentialValue+"','"+noofunits+"','"+assignedBy+"','"+leadRef+"','"+repcode+"')";
			}
					 
			else 
			 	sqlInsert = "UPDATE "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster SET 	CompanyName='"+companyafteredit+"', 	Address='"+address.replaceAll("'"," ")+"', 	City='"+city+"',"+
			 	" 	Zip='"+zip+"', 	State='"+state+"',"+
        		" 	ContactPerson='"+contactPerson+"', 	MobileNo='"+mobile+"', MobileNo1='"+mobile1+"', MobileNo2='"+mobile2+"',	Fax='"+fax+"' ,	EMail='"+email.replaceAll("'"," ")+"',	WebSite='"+website+"',"+
        		" IntrestedProduct='"+product+"' ,"+
        		"	CustEnteredByRep='"+repName+"' ,	WeeklyOffon='"+weeklyOffOn+"' 	,AddedOnDate='"+addedOn+"', "+
        		"		Category='"+category+"' 	,	TelephoneNo2='"+alternateNumber+"' ,phone='"+phone+"',"+
        		" STDCode='"+stdCode+"',ProspCustAddedOn='"+addedOn+"',country='"+country+"' ,OpportunityCode='"+ocode+"',OpportunityName='"+oname+"',comments='"+comments.replaceAll("'"," ")+"', "+
        		" PotentialValue='"+potentialValue+"', NoOfUnits='"+noofunits+"',Assighnedby='"+assignedBy+"' ,leadRef='"+leadRef+"' "+
        		"  WHERE CustomerCode='"+request.getParameter("companyName")+"' limit 1";     
			 	 
			
			
			
			
			
			
			
	        String existedDriver = "";
	        String msg = "";		
       		boolean flag=false;
       		
       		/*
try{

Statement stsms=con.createStatement();

String sqlHistory="";
if(request.getParameter("update")!=null)
{
 
	String reasonForUpdate=request.getParameter("reason");
	
	String sqlSetails=" SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster  WHERE CompanyName='"+request.getParameter("companyName")+"'";
	ResultSet rsDetails= stmt1.executeQuery(sqlSetails);
	System.out.println(")))     "+sqlSetails);
	if(rsDetails.next())
	{  
	  	//String abc=rsDetails.getString("VendorCode");
	  	//System.out.println(">>>>>>>>>>>>>>   " +abc);
	/*sqlHistory="insert into "+session.getAttribute("CompanyMasterID").toString()+"prospecthistory  (CustomerCode,CompanyName,Address,City,	Zip,State,Country,ContactPerson,"+
				 " Phone,Fax,EMail,WebSite,IntrestedProduct,CustEnteredByRep,WeeklyOffon,AddedOnDate,ProspCustAddedOn,SalesCustomerCode,"+
				 " IsDataValid,Category,STDCode,MobileNo,ResiNo,TelephoneNo2,VendorCode,PotentialValue,NoOfUnits,Assighnedby,"+
				 " Comments,leadRef,reasonForUpdate,UpdateDateTime,UpdatedBy ) VALUES "+ 
				 "('"+rsDetails.getString(1)+"','"+rsDetails.getString(2)+"','"+rsDetails.getString(3)+"','"+rsDetails.getString(4)+"' ,"+
				 " '"+rsDetails.getString(5)+"','"+rsDetails.getString(6)+"','"+rsDetails.getString(7)+"','"+rsDetails.getString(8)+"' ,"+
				 " '"+rsDetails.getString(9)+"','"+rsDetails.getString(10)+"','"+rsDetails.getString(11)+"','"+rsDetails.getString(12)+"' ,"+
				 " '"+rsDetails.getString(13).replace("'","")+"','"+rsDetails.getString(14)+"','"+rsDetails.getString(15)+"','"+rsDetails.getString(16)+"' ,"+
				 " '"+rsDetails.getString(17)+"',"+rsDetails.getString(18)+",'"+rsDetails.getString(19)+"','"+rsDetails.getString(20)+"' ,"+
				 " '"+rsDetails.getString(21)+"',"+rsDetails.getString(22)+",'0',"+rsDetails.getString(24)+" ,"+
				 " '"+rsDetails.getString(25)+"','"+rsDetails.getString(26)+"','"+rsDetails.getString(27)+"','"+rsDetails.getString(28)+"' ,"+
				 " "+rsDetails.getString(29)+",'"+rsDetails.getString(30)+"',"+
				 " "+reasonForUpdate+",'"+dateTime+"','"+repName+"'"+
				" ) ";
		 System.out.println(sqlHistory);
		 stmt2.executeUpdate(sqlHistory);*/
		 
	/*	 
		 
		sqlHistory="insert into "+session.getAttribute("CompanyMasterID").toString()+"prospecthistory  (CustomerCode,CompanyName,Address,City,	Zip,State,Country,ContactPerson,"+
		 " Phone,Fax,EMail,WebSite,IntrestedProduct,CustEnteredByRep,WeeklyOffon,AddedOnDate,ProspCustAddedOn,SalesCustomerCode,"+
		 " IsDataValid,Category,STDCode,MobileNo,ResiNo,TelephoneNo2,VendorCode,PotentialValue,NoOfUnits,Assighnedby,"+
		 " Comments,leadRef,reasonForUpdate,UpdateDateTime,UpdatedBy ) VALUES "+ 
		 "(?,?,?,?,?, ?,?,?,"+
		  "?,?,?,?,?, ?,?,?,?,?,"+
		  "?,?,?,?,?, ?,?,?,?,?,"+
		  "?,?,?,?,? "+
		  ") ";

		 java.sql.PreparedStatement stmtmain = con.prepareStatement( sqlHistory );
		 stmtmain.setString(1,rsDetails.getString(1));
		 stmtmain.setString(2,rsDetails.getString(2));
		 stmtmain.setString(3,rsDetails.getString(3));
		 stmtmain.setString(4,rsDetails.getString(4));
		 stmtmain.setString(5,rsDetails.getString(5));
		 stmtmain.setString(6,rsDetails.getString(6));
		 stmtmain.setString(7,rsDetails.getString(7));
		 stmtmain.setString(8,rsDetails.getString(8));
		 stmtmain.setString(9,rsDetails.getString(9));
		 stmtmain.setString(10,rsDetails.getString(10));
		 stmtmain.setString(11,rsDetails.getString(11));
		 stmtmain.setString(12,rsDetails.getString(12));
		 stmtmain.setString(13,rsDetails.getString(13));
		 stmtmain.setString(14,rsDetails.getString(14));
		 stmtmain.setString(15,rsDetails.getString(15));
		 stmtmain.setString(16,rsDetails.getString(16));
		 stmtmain.setString(17,rsDetails.getString(17));
		 stmtmain.setString(18,rsDetails.getString(18));
		 stmtmain.setString(19,rsDetails.getString(19));
		 stmtmain.setString(20,rsDetails.getString(20));
		 stmtmain.setString(21,rsDetails.getString(21));
		 stmtmain.setString(22,rsDetails.getString(22));
		 stmtmain.setString(23,rsDetails.getString(23));
		 stmtmain.setString(24,rsDetails.getString(24));
		 stmtmain.setString(25,rsDetails.getString("vendorCode"));
		 stmtmain.setString(26,rsDetails.getString(26));
		 stmtmain.setString(27,rsDetails.getString(27));
		 stmtmain.setString(28,rsDetails.getString(28));
		 stmtmain.setString(29,rsDetails.getString(29));
		 stmtmain.setString(30,rsDetails.getString(30));	 
		 stmtmain.setString(31,reasonForUpdate);	 
		 stmtmain.setString(32,dateTime);	 
		 stmtmain.setString(33,repName);	 
		 stmtmain.executeUpdate();
		System.out.println(sqlHistory);
		//stmt2.executeUpdate(sqlHistory); 
		 
		 
		 
		 
	
	}
 }   
*/

	 	 
		stmt.executeUpdate(sqlInsert);

		
	
System.out.println(sqlInsert);
 









	if(request.getParameter("update")==null) 
	{
		 int addresscode;
		 String sql="SELECT MAX(AddressCode) FROM "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustaddr";
		 ResultSet rsAdd=stmt3.executeQuery(sql);
		 rsAdd.next();
		 addresscode=rsAdd.getInt(1);
		 System.out.println(addresscode);
		 addresscode++;
		 
 		 String sqlAddress="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustaddr (Customercode ,AddressCode ,IntrestedProduct ,ContactPerson ,Address, "+
         "City,Zip ,State ,Country ,Phone ,Fax ,EMail ,STDCode ,MobileNo ,ResiNo ,TelephoneNo2 ,VendorCode)"     +        
         "VALUES('"+customerCode+"','"+addresscode+"','"+product+"','"+logo+" "+contactPerson+"','"+address.replaceAll("'"," ")+"',"+
         "'"+city+"','"+zip+"','"+state+"','"+country+"','"+phone+"','"+fax+"','"+email.replaceAll("'"," ")+"','"+stdCode+"','"+mobile+"','0','"+alternateNumber+"','0')";
		 stmt.executeUpdate(sqlAddress);
		 
		 
			String sqlcon ="INSERT into "+session.getAttribute("CompanyMasterID").toString()+"contactdet (customercode,contactperson,"+
				"mobileno,mobileno1,mobileno2,AlternetNO,email,phone,fax,zipcode"+
				",address,city,state,country,designation) VALUES ('"+customerCode+"','"+logo+" "+contactPerson+"','"+mobile+"','"+mobile1+"','"+mobile2+"','"+alternateNumber+"','"+email.replaceAll("'"," ")+"','"+phone+"','"+fax+"','"+zip+"','"+address.replaceAll("'"," ")+"','"+city+"','"+state+"','"+country+"','"+designation+"')";
			stmt.executeUpdate(sqlcon);
			 
			 System.out.println("Insert query is "+sqlcon);
			 
	}
 	 
flag=true;

String numbers="NA",sendEmailTo="-";






//For SMS or Mail sent/////////////////////////////////


/*

if(request.getParameter("update")==null )   
{
try{
	
	String repDetails="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster where MarketingRepName='"+repName+"'";
	System.out.println(repDetails);
	ResultSet rsRepDetails=stmt.executeQuery(repDetails);
	if(rsRepDetails.next())
	{
		String msgid = null, sms = "";
		  numbers = rsRepDetails.getString("MarketingRepPhNo");
			if(numbers.length()>9) 
				{
				String nos=mobile;
				if(!(phone.equalsIgnoreCase("") || phone.equalsIgnoreCase("0")))
					nos+=" , "+phone;
				System.out.println(nos + numbers);
				
				if(assignedBy.equalsIgnoreCase(repName))		
					 sms="New Prospect "+companyName+" is added by you. Please contact "+contactPerson+" on "+nos+" ";
				else
				 sms="New Prospect "+companyName+" is assiged to you by "+session.getAttribute("EmpName")+". Please contact "+contactPerson+" on "+nos+" ";
				
				try {
						String sql1 = "";
						sms = sms.replace("]", " ").replace("'", " ").replace(";", " ").replace("&", " ").replace("@", " ").replace("<>", " ").replace("[", " ");
						sms = URLEncoder.encode(sms);
			/*
						String smsurl = null;
			
						smsurl = "http://india.timessms.com/http-api/receiverall.asp?username=Transworld&password=vikram&sender=TransWld&to="
								+ numbers + "&message=" + sms + "&gateway=regular";
						URL url = new URL(smsurl);
						URLConnection connection = url.openConnection();
						connection.connect();
						BufferedReader in = new BufferedReader(
								new InputStreamReader(connection.getInputStream()));
						String line;
						while ((line = in.readLine()) != null) {
							System.out.println(line);
							msgid = line;
						}
							try{
								stsms.executeUpdate("INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"smshistory (SentBy,Msg,DateTime ) VALUES('"+repName+"','"+sms.replace("+"," ")+"','"+new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date())+"')");
							}catch(Exception ee){
								System.out.println("excep in save to t_smshistory"+ee);
							}
					} catch (Exception e) {
						System.out.println(e);
						out.println("SMS Sending Failed("+numbers+")");
					} finally { }
				}
			
			sendEmailTo=rsRepDetails.getString("MarketingRepEMail");
			addedOn=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(addedOn));
			if(!(sendEmailTo.equalsIgnoreCase("-")))
			{
				System.out.println("Sending email....");
				String Data="";
				if(assignedBy.equalsIgnoreCase(repName))
				{
					 Data = "added by "+assignedBy+" on "+addedOn+"<br> <br>";
				}
				else
				{
					Data = "assigned to you by "+assignedBy+" on "+addedOn+"<br> <br>";
				}
				String headerString="",htmlString="";
				int i=1;
				Date today = new Date();
				Calendar cal = Calendar.getInstance();
				cal.setTime(today);
				cal.add(Calendar.DAY_OF_MONTH, -1);
				Date today30 = cal.getTime();
				String todaysDate=new SimpleDateFormat("yyyy-MM-dd").format(today30);
				String todaysDateFormat=new SimpleDateFormat("dd-MMM-yyyy").format(today30);
				headerString = " "; 
				htmlString = "<html><body><span style='margin-left:5%;'><strong>Please verify following details of New Prospective Customer :-<br><br></stong></span>";
				htmlString = htmlString +"<div><table cellpadding='0' cellspacing='2' style='margin-left:5%; font-family:verdana; font-size:14; border:thin solid; border-color:black; '>";
				htmlString = htmlString +"<tr style='border:thin solid;'><td style='background-color: #38469E; color:white;'>Prospect</td><td style='background-color: #D4EEF5;width:250px;'><strong>"+companyName+"</strong></td></tr>";
				htmlString = htmlString +"<tr style='border:thin solid;'><td style='background-color: #38469E; color:white;'>Address:</td><td style='background-color: #D4EEF5;'>"+address+"</td></tr>";
				htmlString = htmlString +"<tr style='border:thin solid;'><td  style='background-color: #38469E; color:white;'>City:</td><td style='background-color: #D4EEF5;'> "+city+" - "+zip+"</td></tr>";
				htmlString = htmlString +"<tr style='border:thin solid;'><td style='background-color: #38469E; color:white;' >State :</td><td style='background-color: #D4EEF5;'> "+state+" ["+country+"]</td></tr>";
				htmlString = htmlString +"<tr style='border:thin solid;height:6px;'><td style='background-color: #FDBD84; color:white;' colspan='2'></td></tr>";
				htmlString = htmlString +"<tr style='border:thin solid;'><td  style='background-color: #38469E; color:white;'>Phone No:</td><td style='background-color: #D4EEF5;'> <strong>"+stdCode+" - "+phone+"</strong> </td></tr>";
				htmlString = htmlString +"<tr style='border:thin solid;'><td style='background-color: #38469E; color:white;'>Alternate Number:</td><td style='background-color: #D4EEF5;'>"+alternateNumber+"</td></tr>";
				htmlString = htmlString +"<tr style='border:thin solid;'><td  style='background-color: #38469E; color:white;'>Website:</td><td style='background-color: #D4EEF5;'> "+website+"</td></tr>";
				htmlString = htmlString +"<tr style='border:thin solid;height:6px;'><td style='background-color: #FDBD84; color:white;' colspan='2'></td></tr>";
				htmlString = htmlString +"<tr style='border:thin solid;'><td style='background-color: #38469E; color:white;' >Contact Person :</td><td style='background-color: #D4EEF5;'><strong>"+contactPerson+"</strong></td></tr>";
				htmlString = htmlString +"<tr style='border:thin solid;'><td style='background-color: #38469E; color:white;' >Mobile no :</td><td style='background-color: #D4EEF5;'>"+mobile+"</td></tr>";
				htmlString = htmlString +"<tr style='border:thin solid;'><td style='background-color: #38469E; color:white;'  >Email:</td><td style='background-color: #D4EEF5;'><strong>"+email+"</strong></td></tr>";
				htmlString = htmlString +"<tr style='border:thin solid;height:6px;'><td style='background-color: #FDBD84; color:white;' colspan='2'></td></tr>";
				htmlString = htmlString +"<tr style='border:thin solid;'><td  style='background-color: #38469E; color:white;'>Intrested In Product :</td><td style='background-color: #D4EEF5;'> "+product+"</td></tr>";
				htmlString = htmlString +"<tr style='border:thin solid;'><td style='background-color: #38469E; color:white;' >Potential Value:</td><td style='background-color: #D4EEF5;'> "+potentialValue+" </td></tr>";
				htmlString = htmlString +"<tr style='border:thin solid;'><td style='background-color: #38469E; color:white;'>Weekly Off On:</td><td style='background-color: #D4EEF5;'> "+weeklyOffOn+" </td></tr>";
				htmlString = htmlString +"<tr style='border:thin solid;'><td style='background-color: #38469E; color:white;' >Comments:</td><td style='background-color: #D4EEF5;'> "+comments+"</td> </tr>";
				htmlString = htmlString +"<tr style='border:thin solid;height:6px;'><td style='background-color: #FDBD84; color:white;' colspan='2' ></td></tr>";
				htmlString = htmlString +"</tr></table><br>";
				htmlString = htmlString +"<span style='margin-left:5%;'><strong>"+Data+"</stong></span> </div></body></html>";
								i=1;
				int sumFollowUp=0;
 

				Data = htmlString;
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
				Message msga = new MimeMessage(session1);
				if(!(assignedBy.equalsIgnoreCase(repName)))
				{
					msga.setSubject("New Lead: "+companyName+" , assigned by "+assignedBy+" ");
				}
				else
				{
					msga.setSubject("New Lead: "+companyName+" added by "+assignedBy+" ");
				}
				msga.setSentDate(new java.util.Date());
				Address recipientAddrs[] = new InternetAddress[1];
				Address recipientAddrsCC[] = new InternetAddress[1];
				recipientAddrs[0] = new InternetAddress(sendEmailTo);
				
				if(!(assignedBy.equalsIgnoreCase(repName)))
				{
					recipientAddrsCC[0] = new InternetAddress(session.getAttribute("EmpEmail").toString());
				}
				msga.addRecipients(Message.RecipientType.TO,recipientAddrs);
				
				if(!(assignedBy.equalsIgnoreCase(repName)))
				{
					msga.addRecipients(Message.RecipientType.CC,recipientAddrsCC);
				}
				
				Address fromAddress=new InternetAddress("avlsupport@mobile-eye.in","Transworld");
				
				msga.setFrom(fromAddress);
				System.out.println(Data);
				msga.setContent(Data,"text/html; charset=ISO-8859-1");
				Transport t = session1.getTransport("smtps");
				msga.saveChanges(); // don't forget this
				try
				{
					t.connect(host, user, pass2);
					System.out.println("SENT*******");
					t.sendMessage(msga, msga.getAllRecipients());
					System.out.println("Your message has been sent");
				}
				catch(Exception e)
				{
					System.out.print("Exception----->"+e);
				} 
				finally 
				{
					t.close();
				} 
				Transport.send(msga);
		}
		else
			sendEmailTo="  (!!! Email Id not available in System.)";
		}	
   }
   catch(Exception e)
   {
		System.out.println(e);	   
   }
}

		msg = "!!!ERROR. Record not saved in system to some problem. Please try again";
 		/*sqlInsert = "update "+session.getAttribute("CompanyMasterID").toString()+"followup SET ()*/
		/*if(flag)
		{
			 msg = "Prospect saved successfully in system.\n Details sent to "+repName+" on "+numbers+"  ";
		}
		response.sendRedirect("alert.jsp?msg="+msg);
}
catch(Exception e)
{
	System.out.println(e);
	msg = "!!!ERROR. Record not saved in system due to some problem. Please try again";
	response.sendRedirect("alert.jsp?msg="+msg);
}*/
if(flag)
{
	//alert("hi");
 System.out.println("flag is " +flag);


}
//response.sendRedirect("addOpportunity.jsp?ck=yes&companyName="+companyName);
response.sendRedirect("alertGoTo.jsp?msg=Opportunity saved successfully in system &goto=home.jsp");

}
catch(Exception e)
{
	System.out.println(e);
	String msg1 = "!!!ERROR. Record not saved in system due to some problem. Please try again";
	response.sendRedirect("alertGoTo.jsp?msg=+"+msg1+" &goto=addOpportunity.jsp");
	//response.sendRedirect("alert.jsp?msg="+msg1);
}

%>


