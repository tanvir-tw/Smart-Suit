<%@page import="com.ConnectionClass"%>
<%@page import="java.sql.*"%>
<%@ page import="java.io.*" import="java.text.*" import="java.util.*"
	import="javax.mail.Address" import="javax.mail.BodyPart"
	import="javax.mail.Message" import="javax.mail.Multipart"
	import="javax.mail.Session" import="javax.mail.Transport"
	import="javax.mail.internet.InternetAddress"
	import="javax.activation.*" import="javax.mail.*"
	import="javax.mail.internet.MimeBodyPart"
	import="javax.mail.internet.MimeMessage"
	import="javax.mail.internet.MimeMultipart" errorPage=""%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Inward Report</title>
</head>
<body
	onload="window.opener.location.reload();setTimeout('self.close()',5);">
	<%!
	Connection conn= null;
	Statement st=null;
	Statement stmt=null,st1=null;
	ResultSet rs=null;
%>
	<%
	ConnectionClass connection = new ConnectionClass();
	conn = connection.getConnect("db_leaveapplication");
	
String inwrdRef=request.getParameter("rd");
String dept=request.getParameter("dept");
String[] toName=request.getParameterValues("to");
String senderCmts=request.getParameter("senderCmts");

String user2=session.getAttribute("email").toString();
st=conn.createStatement();
System.out.println("========"+inwrdRef+"====="+dept+"=============="+toName+"====="+senderCmts+"====="+user2);

String iwDate="", iwTime="", fParty="", pRef="", toEmp="", toEmailid="",sub="",dept1="",cat="",fname="",floc="",entBy="",mailSend="",aDate="",senderMail="",remark="",blno="",blamt="",bldate="",blduedate="";
//InwardNo InwardRefNo InwardDate InwardTime FromParty PartyRefNo ToEmploy ToEmailID Subject Dept Category FileName FileLocation Enteredby EmailSend

DateFormat dChk= new SimpleDateFormat("yyyy-MM-dd");
iwDate=dChk.format(new java.util.Date());

DateFormat tChk= new SimpleDateFormat("HH:mm:ss");
iwTime=tChk.format(new java.util.Date());

//out.println("======="+i+"==="+refno+"======"+iwDate+"======="+iwTime+"===");
//======Geting sender details======================================================================
//String sql1="select * from t_inwarddetails where ToEmailID like '"+user1+"' and InwardRefNo='"+inwrdRef+"'";
String sql1="select * from t_inwarddetails where InwardRefNo='"+inwrdRef+"'";
System.out.println("############"+sql1);

rs=st.executeQuery(sql1);
while(rs.next())
{
	fParty=rs.getString("FromParty");
	pRef=rs.getString("PartyRefNo");
//	toEmp=rs.getString("");
//	toEmailid=rs.getString("");
	sub=rs.getString("Subject");
//	dept1=rs.getString("");
	cat=rs.getString("Category");
	fname=rs.getString("FileName");
	floc=rs.getString("FileLocation");
	blno=rs.getString("BillNo");
	blamt=rs.getString("BillAmt");
	try
	{
		System.out.println("<<-------------------try------------------->>");
		bldate=rs.getString("BillDate");
		blduedate=rs.getString("BillDueDate");
	}
	catch(Exception e)
	{
		System.out.println("<<-------------------Exception------------------->>");
		/*
		bldate="0000-00-00";
		blduedate="0000-00-00";*/
		bldate=null;
		blduedate=null;
	}
	
	
	
	
//	entBy=rs.getString("");
	mailSend="Yes";//rs.getString("");//default yes, as we are sending intimation
	aDate=rs.getString("ActionDate");
	remark=rs.getString("senderRemark");
}
//=====Get Name of sender=====================================
		entBy=session.getAttribute("empname").toString();
		senderMail=session.getAttribute("email").toString();
//============================================================
	
//====Get details of to=======================================
	for(int k=0;k<toName.length;k++)
	{
		           	System.out.println("=====>>"+toName[k]);
		           	String sqlData="select * from t_leaveadmin where Name like '"+toName[k]+"'";
		        	st1=conn.createStatement();
		        	ResultSet rs1=st1.executeQuery(sqlData);
		        	if(rs1.next())
		        	{
		        		if(toEmailid=="" || toEmailid==null)
		        		{
		        			toEmailid=rs1.getString("UName");	
		        		}
		        		else
		        		{
		        			toEmailid=toEmailid+","+rs1.getString("UName");
		        		}
		        		
		        		
		        		if(toEmp=="" || toEmp==null)
		        		{
		        			toEmp=toName[k];
		        		}
		        		else
		        		{
		        			toEmp=toEmp+","+toName[k];
		        		}
		        	}
	}
	
	
	dept1=dept;
//	iwno=iwno+1;
//============================================================
System.out.println("===="+inwrdRef+"===="+iwDate+"======="+iwTime+"====="+fParty+"====="+pRef+"===="+toEmp+"====="+toEmailid+"======"+sub+"===="+dept1+"====="+cat+"======"+fname+"====="+floc+"==="+entBy+"====="+mailSend+"====="+remark);
//============================================================
	try
	{
		String sqlInsrt="";
		String d2 = "[,]";
	    String[] t2 = toEmp.split(d2);
		for (String t : t2)
		{
			sqlInsrt="insert into db_leaveapplication.t_inwardfollowup(iwrefno,docReceiver, docSender,senderRemarks,actionondoc) values('"+inwrdRef+"','"+t+"','"+session.getAttribute("empname").toString()+"','"+senderCmts+"','forward')";
			st.executeUpdate(sqlInsrt);
		}
	}
	catch(Exception e)
	{
		System.out.println("Insert Exception============>>"+e);
	}
//============================================================
	String redirectMsg="";
//===Send Mail================================================
	
	try
	{
			 	  String Data="There is a New Document For You \n Please find the details.\n\n";
				
	  		      Properties props = new Properties();
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
	              
	              Session session1 = Session.getDefaultInstance(props, null);
	               // Construct the message
	               Message msg = new MimeMessage(session1);
	               msg.setSubject(sub+" From "+fParty);
		           msg.setSentDate(new java.util.Date());
					//=========================================================================
		           Address recipientAddrs[] = new InternetAddress[toName.length];
		           int ct=0;
		           String delims12 = "[,]";
			   		String[] tokensEmail = toEmailid.split(delims12);
			   		for(String t : tokensEmail)
			   		{
			   			ct++;
			   		}
			   		
			   		for(int m=0;m<=ct-1;m++)
			   		{
			   			System.out.println("email======"+ct+"===="+tokensEmail[m]);
			   			recipientAddrs[m] = new InternetAddress(tokensEmail[m]);
			   		}
		           
	               msg.addRecipients(Message.RecipientType.TO,recipientAddrs);
	               //=========================================================================
			       Address fromAddress=new InternetAddress("avlsupport@mobile-eye.in","ERP TW Doc");
	               msg.setFrom(fromAddress);
	               BodyPart messageBodyPart = new MimeBodyPart();
	               if(cat.equals("Bills"))
	               {
	            	   messageBodyPart.setText(Data+"\nInward Ref.No.:"+inwrdRef+"\nFrom:"+fParty+"\nParty Ref.No.:"+pRef+"\nSubject:"+sub+"\nCategory:"+cat+"\nBill No:"+blno+"\nBill Amt:"+blamt+"\nBill Date:"+bldate+"\nBill Due Date:"+blduedate+"\nAction Date:"+aDate+"\n\n\n Thanks and Regards, \n Transworld Team");
	               }
	               else
	               {
	            	   messageBodyPart.setText(Data+"\nInward Ref.No.:"+inwrdRef+"\nFrom:"+fParty+"\nParty Ref.No.:"+pRef+"\nSubject:"+sub+"\nCategory:"+cat+"\nAction Date:"+aDate+"\n\n\n Thanks and Regards, \n Transworld Team");   
	               }
	               
	               Multipart multipart = new MimeMultipart();
	               multipart.addBodyPart(messageBodyPart);
	               messageBodyPart = new MimeBodyPart();
	              
	                msg.setContent(multipart); 
	                Transport t = session1.getTransport("smtps");
	                msg.saveChanges(); // don't forget this
	               try
	               {
	            		t.connect(host, user, pass);
	                    t.sendMessage(msg, msg.getAllRecipients());
	                //    flag=true;
	                    System.out.println("Your message has been sent");
	               }
	           	  catch(Exception e)
	               {
	                   System.out.print("Exception----->"+e);
	                   redirectMsg="Please try again";
	               } 
	               finally 
	               {
	                   t.close();
	               } 
	          		
	               Transport.send(msg);
	}
	catch(Exception e)
	{
		System.out.println("Exec--"+e);
		
	} 
	response.sendRedirect("inwardReport.jsp?&redirectMsg="+redirectMsg);
//=============================================================
%>

</body>
</html>