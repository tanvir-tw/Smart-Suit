<%@page import="java.util.Date"%>
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
<%
	Connection con=null ;
	DecimalFormat twoDForm = new DecimalFormat("#.##");
	Statement st=null,st1=null,st2=null,st3=null;
	String todaysDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	String todaysTime=new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
%>

<%
System.out.print("Insert");
	
  try
  {	
		Class.forName(DB_Driver);
		con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
		st=con.createStatement();
		st1=con.createStatement();
		st2=con.createStatement();
		st3=con.createStatement();
		
		System.out.println("ID IS   ::::::     "+request.getParameter("id"));
		String id=request.getParameter("id");
		String email="",PaymentRequestedby="",party="",billdt="",bino="",amnt="",Accntcmnt="";
		if(id.equals("Update") || id.contains("Update"))
		
		{
			System.out.println("IN If  ");
			String approvalcomm=request.getParameter("commentsbyhod");
			System.out.println(">>>>>>>>>     >>>>>>>>>>    "+approvalcomm);
			String approvedamnt=request.getParameter("approveamount");
			System.out.println(">>>>>>>>>     >>>>>>>>>>    "+approvedamnt);
			String payno=request.getParameter("paymentno");
			String SqlUpdate="Update "+session.getAttribute("CompanyMasterID").toString()+"paymentEntryDet SET Approvalcomments='"+approvalcomm+"',Approvedby='"+session.getAttribute("EmpName")+"',ApprovedDate='"+todaysDate+"',Status='Approved',ApprovedAmount='"+approvedamnt+"'"+
							 " where PaymentEntryNO='"+payno+"'";
			System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>    "+SqlUpdate);
			st1.executeUpdate(SqlUpdate);
			
			
			String sql="Select * from "+session.getAttribute("CompanyMasterID").toString()+"paymentEntryDet where PaymentEntryNO='"+payno+"'";
			ResultSet rsSql=st.executeQuery(sql);
			System.out.println("<>   "+sql);
			if(rsSql.next())
			{
				PaymentRequestedby=rsSql.getString("PaymentRequestedby");	
				party=rsSql.getString("PartyName");
				billdt=rsSql.getString("BillDate");
				bino=rsSql.getString("BillNo");
				amnt=rsSql.getString("Amount");
				Accntcmnt=rsSql.getString("AccountComments");
				
				
				String sql1="Select email from "+session.getAttribute("CompanyMasterID").toString()+"security where EmpName='"+PaymentRequestedby+"' And ActiveStatus='Yes'";
				ResultSet rsmail=st1.executeQuery(sql1);
				System.out.println(""+sql1);
				rsmail.next();
				email=rsmail.getString("email");
				System.out.println("EMAIL ID IS "+email);
			}	
			
			String Data = "";
			Data+="<br><br>  Following are Payment Details Approved  .<br><br><br> "+
			"\n Payment Entry Date :"+todaysDate+" <br>"+
			"\n Party Name :"+party+" <br>"+
			"\n Bill Date  :"+billdt+" <br>"+
			"\n Bill No :"+bino+" <br>"+
			"\n Amount :"+amnt+" <br>"+
			"\n Approved Amount :"+approvedamnt+" <br>"+
			"\n Account Comments :"+Accntcmnt+" <br>"+
			"\n HOD Comments :"+approvalcomm+" <br>"+
			"\n Due Date   " ;
			
			String sqlMail="Insert Into db_gps.t_allpendingmailtable (MailName ,Description,	MailBody ,subjectline ,Toid ,Tocc ,Tobcc ,EntryDateTime ,MailStatus,"+
						   "SendDateTime,SenderName ,FileName,AttachFilePath) "+
					       "Values ('PaymentApproval','-','"+Data+"','Payment Approval','"+email+"','-','-','"+todaysDate+" "+todaysTime+"','send',"+
					       "'"+todaysDate+" "+todaysTime+"','"+session.getAttribute("EmpName")+"','-','-')";
			System.out.println(">>>>>>>>>>>   "+sqlMail);
			st.executeUpdate(sqlMail);
			
			response.sendRedirect("alert.jsp?msg=Payment Request From : "+PaymentRequestedby+" Is Approved.  &goto=Accounts.jsp");
				
		}
		else if(id.equals("new") || id.contains("new"))
		{
		System.out.println("IN ELSE IF    ");
		String paymententryon=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("paymententryon")));
		System.out.println("PAYMENT EB+NTERY DATE   "+paymententryon);
		String paymententrytime=request.getParameter("todaystime");
		String partyname=request.getParameter("companyNames");
		String billdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("billdate")));
		System.out.println("BILL DATE   "+billdate);
		String billno=request.getParameter("billno");
		String duedate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("duedate")));
		System.out.println("DUIE DATE      "+duedate);
		String amount=request.getParameter("amount");
		System.out.println("AMount      "+amount);
		String accountcomments=request.getParameter("accountcomments");
		
		String mailto=request.getParameter("mailto");
		System.out.println("DMAIL ID         "+mailto);
		
		String SqlInsert="Insert into "+session.getAttribute("CompanyMasterID").toString()+"paymentEntryDet (EntryDate,EntryTime,PartyName,BillNo,BillDate,DueDate,Amount,AccountComments,MailTo,Status,PaymentRequestedby) "+
						 "values('"+paymententryon+"','"+paymententrytime+"','"+partyname+"','"+billno+"','"+billdate+"','"+duedate+"','"+amount+"','"+accountcomments+"','"+mailto+"','Pending','"+session.getAttribute("EmpName")+"')";		
		System.out.println(SqlInsert);
		st.executeUpdate(SqlInsert);
				
		String Data = "";
		Data+="<br><br>  Following are Payment Details .<br><br><br> "+
		"\n Payment Entry Date :"+paymententryon+" <br>"+
		"\n Party Name :"+partyname+" <br>"+
		"\n Bill Date  :"+billdate+" <br>"+
		"\n Bill No :"+billno+" <br>"+
		"\n Amount :"+amount+" <br>"+
		"\n Account Comments :"+accountcomments+" <br>"+
		"\n Due Date  :"+duedate+" " ;
		
		String SqlInsertMail="Insert Into db_gps.t_allpendingmailtable (MailName ,Description,	MailBody ,subjectline ,Toid ,Tocc ,Tobcc ,EntryDateTime ,MailStatus,"+
					"SendDateTime,SenderName ,FileName,AttachFilePath) "+
					"Values ('PaymentMail','-','"+Data+"','PaymentDetails','"+mailto+"','-','-','"+todaysDate+" "+todaysTime+"','send',"+
							"'"+todaysDate+" "+todaysTime+"','-','-','-')";
		System.out.println("MAIL QUERY >>>> "+SqlInsertMail);			
		st1.executeUpdate(SqlInsertMail);
		
		
		response.sendRedirect("alert.jsp?msg=Your Payment Entry Is Send For Approval Request  On Email ID: "+mailto+" &goto=Accounts.jsp");
		}
		
		
	}
	catch(Exception e)
	{
		System.out.println( "Exception ::"+e );
		e.printStackTrace();
		response.sendRedirect("alertGoTo.jsp?msg=!!!! ERROR Inserting Record.Please try again. \n\n \n\n   "+e.toString().replace("'"," --")+"&goto=javascript:history.back()");
	}
	finally
	{
	    con.close();
	}
%>	
</jsp:useBean>