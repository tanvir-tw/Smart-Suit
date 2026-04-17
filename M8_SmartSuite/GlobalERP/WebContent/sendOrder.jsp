
<%@ include file="conn.jsp"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<%@ page import="java.util.Properties,javax.mail.*,javax.mail.internet.*" import="javax.mail.Session,javax.io.*"%>
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
org.apache.poi.hssf.usermodel.HSSFWorkbook" 
%>

<%
 
 Connection conn;
 Statement st=null;
 Statement st1=null;
 Statement st2 =null;
 Statement st3=null , st4=null ,st5=null;
	
%>
 
<%
	erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
%>

<%
try{
	
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
		
	int emailCounter=0;
	double sumAmount=0,total=0;
	double total1=0;
	int groupCode=0,makeCode=0,a=0;
	String groupName="",makeName="",itemCode="";
	String refMakeNameTable="";
	String sqlDisplayDesc=" ";
	String words="",salesorderno="";
	String sellingPrice="" ,priceAccepted="",quantity="";
	String salesquono="";
 	String sqno=request.getParameter("salesquono");	
	System.out.println(">>>>> &&&&&&&&&&&       "+sqno);
	String comp=request.getParameter("company");
	System.out.println(":???????? ^^^^^^        "+comp);
	String customerEmail=null;
	
try {
	conn = erp.ReturnConnection();
	st = conn.createStatement();
	st2 = conn.createStatement();
	st1 = conn.createStatement();
	st3 = conn.createStatement();
	st4 = conn.createStatement();
	st5 = conn.createStatement();
	} catch (Exception e) {
	}
	
	//savedir = new File("/usr/share/tomcat6/webapps/ERP");
	 	savedir = new File("/home/manjit/Desktop");
	//	savedir = new File("/home/shweta/Desktop/PowerON_OFF_Aler"+session.getAttribute("CompanyMasterID").toString()+"CalcuttaExpress");
	savedir.mkdirs();
	String filename = "Sales_Order";
	
	try {
	savefile = File.createTempFile(filename + "_", ".xls", savedir);
			//out.println("***file ->  "+filename);
	} catch (IOException e1) {
	e1.printStackTrace();
	}
	
	fname = "" + savefile;
	
	try {
	fileOutputStream = new FileOutputStream(savefile);
	
	} catch (FileNotFoundException e) {
	System.out.println("File not found in the specified path.");
			//out.println(e);
	e.printStackTrace();
	}
		
	String extraEmailIds=request.getParameter("ExtraEmail");
		  //System.out.println("EXTRA EMAIl   --  "+extraEmailIds);
	if(extraEmailIds.equalsIgnoreCase(""))
	extraEmailIds=null;
	String copyManager=request.getParameter("manager");
	String copyAccounts=request.getParameter("accounts");
	String body=request.getParameter("body");
	String copySales=request.getParameter("sales");
	String copyMD=request.getParameter("MD");
		  
	String htmlstring="",s1="",s2="",s3="";
	String headerString;
	boolean notifyR_D;
	Object htmlStringForR_D;
	String headerStringForR_D;
			 
	int k=0  ;
	
			 //System.out.println("EMAIL++++"+fromDate+" - "+toDate+customerName +"  "+customerEmail+" "+extraEmailIds+" "+copySales+" "+copyManager+"--"+copyAccounts+"--"+copyMD+"");
	try {
	System.out.print("SENDING EMAIL*******");
	htmlstring = "<HTML><BODY>";
	
	htmlstring = htmlstring+" <div align=center style=font-size:1.8em;><a>Transworld Compressor Technologies Ltd.<br>"+
		
			"</a></div>";

	htmlstring=htmlstring+"<br/>";
	
	htmlstring=htmlstring+" <div align=center style=font-size:1.8em;><a>SALES ORDER<br>"+

	"</a></div>";

	String SqlDet="SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det WHERE SalesQuoNo='"+sqno+"' ";
	System.out.println(SqlDet);
	ResultSet rsDet=st.executeQuery(SqlDet);
	while(rsDet.next()){
	salesorderno=rsDet.getString("SalesOrderNo");
	
	htmlstring = htmlstring+"<table border =1>"+
	"<tr>"+
	"<td  style=font-size: 1.0em;>Ref No:</td><td  style=font-size: 1.0em;>"+rsDet.getString("SalesorderRefNo")+" </td>"+
	"</tr>"+
	"<tr>"+
	"<td style=font-size: 1.0em;>DATE : </td><td style=font-size: 1.0em;>"+rsDet.getString("SalesOrderDate")+"</td>"+
	"<td style=font-size: 1.0em;>DATE : </td><td style=font-size: 1.0em;>"+rsDet.getString("SalesOrderTime")+"</td>"+
	"</tr>"+
	"<tr>"+
	"<td  style=font-size: 1.0em;>CUSTOMER : </td><td  style=font-size: 1.0em;>"+comp+"</td>"+
	"</tr>";

	}
	htmlstring=htmlstring+"</table>";
	htmlstring=htmlstring+"<br>";
	htmlstring=htmlstring+"<div align=left><input type=text value=- id=groupTop  name=groupTop style=border: none; /></div>";
	htmlstring=htmlstring+"<br>";

	htmlstring=htmlstring+"<table border=1px  class=sortable>"+
	"<tr>"+
	"<th>Option No</th>"+
	"<th>Insert Or</th>"+
	"<th>Make</th>"+
	"<th>Part No</th>"+													
	"<th>Description</th>"+
	"<th>Quantity</th>"+
	"<th>Unit prize</th>"+
	"<th>Discount %</th>"+
	"<th>Tax %</th>"+
	"<th>Amount</th>"+	
	"</tr>";
		
	
	String sqlEnq="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items WHERE SalesOrderNo='"+salesorderno+"'";
	
	System.out.println(">>>    "+sqlEnq);
	int i=0;
	ResultSet rsEnq=st1.executeQuery(sqlEnq);
	while(rsEnq.next()){

	groupName="";makeName="";refMakeNameTable="";

	double amount=0.00;
	
	groupCode=rsEnq.getInt("TheGroup");

	makeCode=rsEnq.getInt("Make");
	itemCode=rsEnq.getString("ItemCode");
     
//System.out.println("++++++++++++++++++++++++++++++++++++");
     
	String sqlGroup="SELECT TheGroupName from "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster WHERE TheGroupCode='"+groupCode+"'";
	ResultSet rsGroup=st2.executeQuery(sqlGroup);
	if(rsGroup.next())
	groupName=rsGroup.getString("TheGroupName");
	if(groupCode<5){
	refMakeNameTable=session.getAttribute("CompanyMasterID").toString()+"tbl_"+groupName.substring(0,5)+"makemaster";
   	  	
	String sqlMakename="SELECT MakeName FROM "+refMakeNameTable.toLowerCase()+"  WHERE makecode='"+makeCode+"' ";
		     
	ResultSet rsMakeName=st3.executeQuery(sqlMakename);
	if(rsMakeName.next())
	makeName=rsMakeName.getString(1);
	else
	makeName="-";


	htmlstring=htmlstring+"<script type=text/javascript>"+
	"document.getElementById('groupTop').value="+groupName+";"+

	"</script>";

	sqlDisplayDesc="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_"+groupName.substring(0,5).toLowerCase()+"im_make"+makeCode+" where ItemCode='"+itemCode+"'";
	}
	else{
	sqlDisplayDesc="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+groupCode+" where ItemCode='"+itemCode+"' ";
	makeName="-"  ;
	}
     
	System.out.print("?????"+sqlDisplayDesc);
	 
	System.out.println(">>>>>>>>>  "+sqlDisplayDesc);
	ResultSet rsDetails1=st.executeQuery(sqlDisplayDesc);
	while(rsDetails1.next()){
	
	String Sql="SELECT * FROM "+rsEnq.getString("TheTableToBeAccessed").toLowerCase()+" WHERE ItemCode='"+itemCode+"' ";

//System.out.println("22222222222222222222222222222");
	System.out.println(Sql);
	ResultSet rsSql=st2.executeQuery(Sql);
	
	while(rsSql.next()){

	htmlstring=htmlstring+"	<tr>"+
	"<td><div align=right><"+rsEnq.getString("TheOptionNo")+"</div></td>"+
		
	"<td><div align=left>"+rsEnq.getString("InsertOR")+"</div></td>"+
	
	"<td>"+makeName+"</td>"+
	
	"<td><div align=left>"+rsSql.getString("Partno")+"</div></td>"+
	
	"<td>"+ rsSql.getString("Description")+"</td>"+

	"<td>"+ rsEnq.getString("Quantity")+"</td>"+
	
	"<td>"+rsEnq.getString("SellingPrice")+"</td>"+
	
	"<td>"+rsEnq.getString("DiscountPercent")+"</td>"+
	
	"<td>"+rsEnq.getString("STPercent")+"</td>";
	
	double t=rsEnq.getDouble("STPercent")/100;
	double tax1=t*rsEnq.getDouble("SellingPrice")*rsEnq.getDouble("Quantity") ;
	System.out.println(tax1);
	
	double d=rsEnq.getDouble("DiscountPercent")/100;
	double discount1=d*rsEnq.getDouble("SellingPrice")*rsEnq.getDouble("Quantity") ;
	
	amount=rsEnq.getDouble("SellingPrice")*rsEnq.getDouble("Quantity")+tax1-discount1;	
	
	htmlstring=htmlstring+"<td>"+ amount +"</td>"+
	
	"</tr>";
	
	i++;
	}
	}
	
	}
	
	htmlstring = htmlstring+"</table>";
	htmlstring = htmlstring+"<br>";
	htmlstring = htmlstring+"<br>";
	
	htmlstring = htmlstring+"<div style=font-size: 1.3em>TERMS & CONDITIONS :<br></div>";
	htmlstring = htmlstring+"<br>";
	
	htmlstring = htmlstring+"<br>";
	htmlstring = htmlstring+"<div align=right style=font-size: 1.3em;>For Sales Dept.</div>";
	htmlstring = htmlstring+"<br>";
	
	htmlstring=htmlstring+"<div align=right style=font-size: 1.3em;>K.K.Manoj<br>(Authorised Signatory)</div>";
	
	String Data = " <br><br>Following is Order Statement for <b> "+comp+" </b>";
	Data+="    "+body+"<br>";
	Data = Data + "<br>"+htmlstring+"</table>";
	
	
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
    msg.setSubject("ORDER Statement for "+comp+" ");
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