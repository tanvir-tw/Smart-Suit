<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" import="java.text.*" import="java.util.Calendar"%>
 --%>
<%--  <%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import=" java.text.*" import=" java.util.*" errorPage="" %>
  --%>
  <%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import=" java.text.*" import=" java.util.*" errorPage="" %>
  
<%@ include file="header.jsp" %>
<%@ page import="java.util.Properties,javax.mail.*,javax.mail.internet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.sun.corba.se.spi.orbutil.fsm.Guard.Result"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
           
function Redirect1(value1,value2,value4)
{
	
	alert('Mail Sent Successfully  ','','success');
		  var value1=document.getElementById("ContractorName").value;
var value2=document.getElementById("Id").value;
var value4=document.getElementById("email").value;
//window.location.href="sendmail.jsp?ContractorName="+value1+"&Id="+value2+"&email="+value4;
	window.location.href="ContractMasterSendmail.jsp";
	 //	window.open("billingDetails.jsp?companyName="+value1+"&companyCode="+value2);
	    
	
}
</script>
</head>
<body>
<%!Connection con1, con2;%>

<%
Class.forName(DB_Driver);

con1 = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
Statement stmt1=con1.createStatement(),
stmt2=con1.createStatement(),
stmt3=con1.createStatement(),
stmt4=con1.createStatement(),
stmt5=con1.createStatement(),
stmt6=con1.createStatement(),
stmt7=con1.createStatement(),
stmtinsert=con1.createStatement();
int i=Integer.parseInt(request.getParameter("cntr"));
System.out.println("i is ------->>>>>" + i);
Boolean innerflag=false;
Boolean flag=false;
String entby=session.getAttribute("EmpEmail").toString();
/* String transporter=request.getParameter("transporter");
String vehno=request.getParameter("vehno");

String vid=request.getParameter("vid");

String unitid=request.getParameter("unitid"); */
String Id=request.getParameter("Id");
System.out.println(">>>Id.........is " + Id);

String ContractorName=request.getParameter("ContractorName");
System.out.println(">>>ContractorName...........is " + ContractorName);
String template=request.getParameter("template");
System.out.println(">>>Template...........is " + template);
String description=request.getParameter("description");
System.out.println(">>>description.........is " + description);
String body=request.getParameter("body");
System.out.println("Original body is---------*************"+body);
String CC=request.getParameter("CC");
String file=request.getParameter("file");
System.out.println(">>>CC.........is " + CC);
String  tid=request.getParameter("tid"); 
String fname=(String)session.getAttribute("EmpName");
	String email=request.getParameter("email");
	System.out.println(">>>email.........is " + email);
	Statement stgp=con1.createStatement();
//System.out.println(">>>tid<<<"+tid);
String subject1=request.getParameter("template");
String subject2=request.getParameter("description");
DateFormat df = new SimpleDateFormat("dd-MMM-yyyy HH:mm");
java.util.Date date = new java.util.Date();

String user1=session.getAttribute("EMP_FullNAME").toString();	
String user2=session.getAttribute("EmpEmail").toString();	
System.out.println(">>>FROM id<<<"+ user1);
body=body.replace("'","\'");
body=body.replace("#","<br>");
System.out.println("body is-----???????????????"+body);
//body=body.replaceAll("[']", "\'"). replaceAll("[#]", "<br>" );

//String body1 = body.replaceAll("[']", "\'").replaceAll("[#]", "<br>");
//System.out.println("body1 is-----???????????????"+body1);

boolean a=CC.endsWith(",");
String ComplaintDateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
String SystemName ="",Website="",Logo1="",Logo2="",Signature="",fromLabel="",replyToMailid="",Disclaimer="";
String CurrentDate = new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new java.util.Date());
%>



	<input type="hidden" id="ContractorName" name="ContractorName" value="<%=ContractorName%>">
		
		<input type="hidden" id="Id" name="Id" value="<%=Id%>">
			<input type="hidden" id="email" name="email" value="<%=email%>">
		
<%
String getEmailDetails="select * from db_gps.t_EmailReportSettings where System='ERP"+session.getAttribute("CompanyMasterID").toString()+"' ";
Statement stmt11=con1.createStatement();
ResultSet rs=stmt11.executeQuery(getEmailDetails);
// String html ="<html><head><style type=text/css>table.mytable{font:13px arial,sans-serif;border-collapse: collapse; border: 1px solid #839E99;background: #f1f8ee;}</style> </head>"+
//		"<body><table    border=^18^  bordercolor=^#E6E6FA^ align=^center^ width=^60%^><tr align=^center^><td align=^left^ style=^border: 0px;^ width=^100%^>"+
//		"<table  style=^margin-left: 1em;margin-right: 1em;width: 100%;height: 100%;^><tr><td width=^100%^><table width = ^97%^ ><tr><td><a href= target=^_blank^>"+
//		"<img src="+Logo1+" style=^height: 80px; width: 300px;^ id=^logo^ alt=^Logo^ /></a></td><td  align = ^right^ >"+
//		"<img src="+Logo2+"  style=^height: 80px; width: 300px;^ /></td></tr></table> <font style=^color: #D8D8D8^>"+
//		"________________________________________________________________________________________________________________________________________________</font><br><div width = ^100%^><font size = ^2^ face = ^Arial^>"+
////		" <u><a href=http://"+Website+"></u>"+Website+"</a>"+ df.format(new Date())+"<br>"+"\n "+ReportName+": "+displayedReportNo+"</font><table>"+
//		"<tr><td align=left><font size=2 face=arial> Dear "+EmpName+",</font></br></td></tr><tr><td align=left><font size=2 face=arial> Please Approve Below New Purchase Request. </font></br></td></tr>";


while(rs.next())
{
	SystemName=rs.getString("System");
	Website=rs.getString("Website");
	Logo1=rs.getString("Logo1");
	Logo2=rs.getString("Logo2");
	Signature=rs.getString("Signature");
	fromLabel=rs.getString("fromLabel");
	replyToMailid=rs.getString("replyToMailid");
	Disclaimer=rs.getString("Disclaimer");

}


String comdate=new SimpleDateFormat("dd-MMM-yyyy HH:MM:SS").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(ComplaintDateTime));
String Data="";
Data = Data + "<html><head><body><style type=text/css>table.mytable{font:13px arial,sans-serif;border-collapse: collapse; border: 1px solid #839E99;background: #f1f8ee;}</style> </head>"+
"<table    border=^18^  bordercolor=^#E6E6FA^ align=^center^ width=^60%^><tr align=^center^><td align=^left^ style=^border: 0px;^ width=^100%^>"+
"<table  style=^margin-left: 1em;margin-right: 1em;width: 100%;height: 100%;^><tr><td width=^100%^><table width = ^97%^ ><tr><td><a href= target=^_blank^>"+
"<img src="+Logo2+" style=^height: 80px; width: 174px;^ id=^logo^ alt=^Logo^ /></a></td>"+
"<td  align = ^right^ >"+"<img src="+Logo1+" style=^height: 80px; width: 174px;^ /></td></tr></table> <font style=^color: #D8D8D8^>"+
"________________________________________________________________________________________________________________________________________________</font><br><div width = ^100%^><font size = ^3^ face = ^Arial^>"+
" <u><a href=http://"+Website+"></u>"+Website+"</a>&nbsp;"+ df.format(date) +"<br>"+"<br>"+ body ;



Data = Data + "<tr><td align = left><table align= left><br></br><tr><td><font size=^3^ face=^Arial^>Transworld Global ERP Team</font></td></tr><tr><td><font size=^3^ face=^Arial^>Phone: +91-20-41214444  +91-9762174221</font></td></tr><tr><td></td></tr><tr><td><font size=^3^ face=^Arial^>"+Disclaimer+"</font></td></tr></table></td></tr></table></div></td></tr></table></td></tr></table></body></html>";

//String subject=""+subject1+" ,"+subject2+" , Received from  "+entby+" on "+df.format(date)+".";

String subject=""+subject2+" ";

System.out.println("Disclaimer is *****************" + Disclaimer);	
System.out.println("Data is *****************" + Data);	
System.out.println("subject is :---->>>>>>>>>>>>" + subject);
if(i>0){

try{

/* if(innerflag==true)
	 { */

try
               {

/* String tocc="rpsupport@mobile-eye.in";
Multipart multipart = new MimeMultipart();
MimeBodyPart Data1 = new MimeBodyPart();
Data1.setContent(Data,"text/html; charset=UTF-8"); */
 
                    String q2 = "insert into db_GlobalERP.t_allpendingmailtableERP(MailName,Description,MailBody,subjectline,Toid,Tocc,EntryDateTime,MailStatus,SenderName,UserName,AttachFilePath,SenderMailId ) values ('TransworldHR','"
                    	+template
                    	+ "','"
                    	+ Data
						+ "','"
						+ subject
						+ "','"
						+ email
						+ "','"
						+ CC
						+ "','"
						+ CurrentDate + "','Pending','"+user1+"','"+ContractorName+"','"+body+"','"+user2+"')";
              
              System.out.println("q2All_PendingMail>>>> :" + q2);
				stgp.executeUpdate(q2);
				
				String q4 = "insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"HrEmailMaster(template,mailbody,subject,Toid,Tocc,EntryDateTime ,MailStatus,SenderName,ReceiverName,body,fromid ) values ('"
                    	+template
                    	+ "','"
                    	+ Data
						+ "','"
						+ subject
						+ "','"
						+ email
						+ "','"
						+ CC
						+ "','"
						+ CurrentDate + "','Pending','"+user1+"','"+ContractorName+"','"+body+"','"+user2+"')";
              
              System.out.println("q4 HrEmailMasterquery >>>> :" + q4);
				stgp.executeUpdate(q4);		
				
				System.out.println("inserted in all pending mail >>> 1234"); 
                    flag=true;
                    System.out.println("Your message has been sent");
               }
               catch(Exception e)
               {
                   System.out.print("Exception----->"+e);
                  
               } 
               finally 
               {
                //   t.close();
               } 
          		
           //    Transport.send(msg);
             //  System.out.println("Your message has been sent");      
             
//response.sendRedirect("sendmail.jsp?ContractorName="+ContractorName+"&Id="+Id+"&email="+email);
out.println("<script>  Redirect1();</script>");
		}
//}
catch(Exception e){
			
		}        		              
 }

/* StringTokenizer st=null;
if(true==a){
	 int index=CC.length();
	 //System.out.println(CC);
	 CC=CC.substring(0, index-1);
	  //System.out.println(CC);
	   st=new StringTokenizer(CC,",");
	  i=st.countTokens();
	  //System.out.println("i===>"+i);
}else{
	 st=new StringTokenizer(CC,",");
	  i=st.countTokens();
	  //System.out.println("i===>"+i);
}
//out.println(entby);
//out.println(transporter);
//out.println(template);
//out.println(vehno);
//out.println(unitid);out.println(description +body);

String cntr=request.getParameter("cntr");
////System.out.println(cntr);
int cntrint=Integer.parseInt(cntr);
////System.out.println(cntrint);
String to="";
String[] uncntchk = new String[cntrint];
int chkdcntr1=0, chkdcntr=0;

for(int k=0; k<cntrint; k++) 
{
		uncntchk[k] = request.getParameter("emailid"+k);
	//	//System.out.println(uncntchk[k]+k);
		
	if(uncntchk[k]==null)
		{
 
		} 
		else
		{
		chkdcntr1++;
		//System.out.println(chkdcntr1);
		to=to+","+uncntchk[k];

		}
}

Boolean flag=false;
try{
	              Properties props = new Properties();
	              
	              
	              /*
	              String host="a.mobileeye.in";
	              String protocol="smtp";
	              final    String user="tripend@mobile-eye.in"; 
	              final    String pass="transworld";
	              props.put("mail.smtp.starttls.enable","true");
	              props.put("mail.smtp.auth", "true");
	              props.put("mail.smtp.user", "user");
	              props.put("mail.smtp.password", "pass");  
	              props.put("mail.store.protocol", protocol);
	              props.put("mail.smtps.host", host);
	              props.put("mail.smtp.port", "25");
	               // Construct the message
	             */
	             
	           /*   String host = "a.mobileeye.in";

	             String protocol = "smtp";

	           final  String user = "9100";
	           final String pass = "transworld";

	             props.put("mail.smtp.starttls.enable", "true");
	             props.put("mail.smtp.auth", "true");
	             props.put("mail.smtp.user", user);
	             props.put("mail.smtp.password", pass);
	             props.put("mail.store.protocol", protocol);
	             props.put("mail.smtp.host", "a.mobileeye.in");
	             props.put("mail.smtp.port", "25");
	               
	               
	               
	                
	              Session session1 = Session.getDefaultInstance(props, null);
		              
		              session1 = Session.getInstance(props,
				                new javax.mail.Authenticator() {

				                    protected PasswordAuthentication getPasswordAuthentication() {
				                        return new PasswordAuthentication(user, pass);
				                    }
				                });

				      session1.setDebug(true);
	               
	               
	               
	               
	               Message msg = new MimeMessage(session1);
	               msg.setSubject(description);
	               msg.setSentDate(new java.util.Date());
	              // Address add1=new InternetAddress(email,email2);
	         //     	//System.out.println("stp1"+chkdcntr1);
	            			  //  mail id-------------
	            	      Address recipientAddrs[] = new InternetAddress[chkdcntr1];
	            	  for(int m=0; m<cntrint; m++){
	            			
	            		  recipientAddrs[m] = new InternetAddress(uncntchk[m]);
	            			//System.out.println("stp1"+recipientAddrs[m]+m);
	            		 
	            		
	            	  }
	            int j=i+2;
	          System.out.println("j===>"+j);
				   Address recipientAddrs1[] = new InternetAddress[j];
		               recipientAddrs1[0] = new InternetAddress(entby);
		               recipientAddrs1[1] = new InternetAddress("Avlsupport@mobile-Eye.in");
		               for(int m=2; m<j; m++){
		            	   System.out.println("m===>"+m);
		            	   if(st.hasMoreTokens()) {
		            	        // //System.out.println(st.nextToken());
		            	   recipientAddrs1[m] = new InternetAddress(st.nextToken());
		            			//System.out.println("stp1"+recipientAddrs1[m]);
		            		 
		            	   }
		            	  }
		         	//System.out.println("stp2"+recipientAddrs1);
	             //  Address add1=new InternetAddress(mailid);
	               msg.addRecipients(Message.RecipientType.TO,recipientAddrs);
	              msg.addRecipients(Message.RecipientType.CC,recipientAddrs1);
	        // System.out.println("stp3");
	               Address fromAddress=new InternetAddress(entby,"Transworld"); // in second "", it is short name
	       // System.out.println("stp4");
	               msg.setFrom(fromAddress);
	       //  System.out.println("stp5");UTF-8
	      // msg.setContent(body,"text/html; charset=UTF-8"); 
	               
	              msg.setContent(body,"text/html; charset=ISO-8859-1"); 
	               // Send the message
	               Transport t = session1.getTransport("smtps");
	               msg.saveChanges(); // don't forget this
	      //  System.out.println("stp6");
	             
	               try
	               {
	       // System.out.println("stp7");
	                   t.connect(host, user, pass);
	        //System.out.println("stp8>>>>>>>>>>>>>>>.");
	                    t.sendMessage(msg, msg.getAllRecipients());
	         System.out.println("stp9**********************");
	                   // t.sendMessage(msg1, msg1.getAllRecipients());
	                    flag=true;
	      System.out.println("Your message has been sent@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
	               }/*catch(SMTPSendFailedException smp)
	               {
	            	   System.out.print("Error:--"+smp.getCommand()+smp.getReturnCode());
	               }*/
	               /* catch(Exception e)
	               {
	                   System.out.print("Exception----mail sendingggggggggggg->"+e);
	                  
	               } 
	               finally 
	               {
	                   t.close(); 
	               } 
	          		try{
	          			 Transport.send(msg);
	          		}catch(Exception e){
	          			
	          		}   */
	              
	          				               
	              // Transport.send(msg1);
	              // String sql="";
	             // if(tid==null || tid.equals("null") ||  tid.equals("-")){
	           //  sql="insert into t_emailmaster (vahno,transporter,subject,body,template,fromid,Toid,UnitID) values ('"+vehno+"','"+transporter+"','"+description+"','"+body+"','"+template+"','"+entby+"','"+to+"','"+unitid+"')";
	               
	            //  }else{
	            	  	            	  
	           //	  sql="insert into t_emailmaster (TicketID,vahno,transporter,subject,body,template,fromid,Toid,UnitID) values ('"+tid+"','"+vehno+"','"+transporter+"','"+description+"','"+body+"','"+template+"','"+entby+"','"+to+"','"+unitid+"')"; 
	            	  
	          //    }
	              //System.out.println(sql);
	             //  stmt2.executeUpdate(sql);
	               
	              
	            //   if(tid==null || tid.equals("null") ||  tid.equals("-")){
	            	   
	            	   
	           //    }else{
	               
	         //   String sqlths="insert into db_gps.t_tickethistorytest (TicketID,Action,ActionComment,ActionBy,Vehid,VehRegNo,Transporter) values ('"+tid+"','Send Mail','"+description+"','"+user1+"','"+vid+"','"+vehno+"','"+transporter+"') ";
	        //	stmt1.executeUpdate(sqlths);
	        //   	System.out.println(">>>sqlths<<<"+sqlths);
	              
	        //       }
/* 	       
}catch(Exception e){
	e.printStackTrace();
} */

//response.sendRedirect("sendmail.jsp?ContractorName="+ContractorName+"&Id="+Id+"&email="+email);
%>
</body>
</html>