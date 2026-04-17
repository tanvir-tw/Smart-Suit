<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" import=" java.text.*" import=" java.util.*"%>
<%@ page import="java.util.Properties,javax.mail.*,javax.mail.internet.*" %>

<%@ page import=" java.util.Date"%>
 <%@page import="com.ConnectionClass"%> 

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>GlobalERP</title>
<script src="js/sweetalert.js"></script>
</head>
<body>
<% 
// Connection Initialization
Connection conn = null;
Statement st = null,st1=null,st2=null,st3=null,stInsrt=null;

try {
	ConnectionClass connection= new ConnectionClass();

	conn = connection.getConnect("db_leaveapplication");    
   st = conn.createStatement();
   st1=conn.createStatement();
   st2=conn.createStatement();
   st3=conn.createStatement();
   stInsrt=conn.createStatement();
 
} catch (Exception e) {
   e.printStackTrace();
} 
 %>
<%
String emailid="",HOD="",name="",firstdayofleave="",dateofreporting="",leaveType="",empDept="";
String Data="";

Boolean innerflag=false;
String sql=null;
String sqlHistory="";
Boolean flag=false;

java.util.Date d= new java.util.Date();
System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
out.println(d);
String datetoday=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(d);
System.out.println(datetoday);
String srno=request.getParameter("rid");
System.out.println("srno::::::::::;"+srno);
String index=request.getParameter("index");
System.out.println("index"+index);
String type=request.getParameter("type");
System.out.println("type"+type);


System.out.println("==="+srno+"====="+index+"======="+type+"=====");
//out.println("\n\n==="+srno+"====="+index+"======="+type+"=====");

//String sql2="select * from t_leaverequest where srno='"+srno+"'";
ArrayList hodList=new ArrayList();
ArrayList empEmail=new ArrayList();
ArrayList appliedDays=new ArrayList(); 
ArrayList frstDay=new ArrayList();
ArrayList typeLeave=new ArrayList();
ArrayList statusLeave=new ArrayList();
ArrayList nameEmp=new ArrayList();
ArrayList dept=new ArrayList();
String sql2="select * from t_leaverequest where srno in("+srno+")";
System.out.println("SQL===========>>"+sql2);
ResultSet rs1=st1.executeQuery(sql2);
	while(rs1.next())
	{
		emailid=rs1.getString("emailid");
		HOD=rs1.getString("HOD");
		name=rs1.getString("name");
		firstdayofleave =rs1.getString("firstdayofleave");
		dateofreporting =rs1.getString("dateofreporting");
		leaveType=rs1.getString("typeofleave");
		empDept=rs1.getString("TypeValue");
		
		appliedDays.add(rs1.getString("daysapplied"));
		frstDay.add(rs1.getString("firstdayofleave"));
		typeLeave.add(rs1.getString("typeofleave"));
		empEmail.add(rs1.getString("emailid"));
		nameEmp.add(rs1.getString("name"));
		dept.add(rs1.getString("TypeValue"));
		
		System.out.println("==="+emailid+"====="+HOD+"======="+name+"===="+firstdayofleave+"====="+dateofreporting+"======"+leaveType+"========"+empDept+"=========");
	}
	System.out.println("\n#################"+appliedDays+"==="+frstDay+"==="+empEmail+"======"+frstDay+"======"+typeLeave.size()+"========"+nameEmp.size()+"=========="+dept.size());
	
	if(type=="update"||type.equalsIgnoreCase("update"))
	{
		System.out.println("==update=");
		sql="update t_leaverequest set status='Approved',updateddatetime='"+datetoday+"' where srno in ("+srno+") ";
		System.out.println("sql--->"+sql);
		
		for(int a1=0; a1<appliedDays.size(); a1++)
		{
			String sqlDt="select Email from t_leaveadmin where Name='"+nameEmp.get(a1)+"'";
			System.out.println(sqlDt);
			ResultSet rsDt=stInsrt.executeQuery(sqlDt);
			if(rsDt.next())
			{
				emailid=rsDt.getString("Email");
			}
			HOD="-";
			String sqlHod="select * from t_leaverequest where emailid='"+empEmail.get(a1)+"' and firstdayofleave='"+frstDay.get(a1)+"' and daysapplied='"+appliedDays.get(a1)+"' ";
			System.out.println(sqlHod);
			ResultSet rsHod=stInsrt.executeQuery(sqlHod);
			if(rsHod.next())
			{
				HOD=rsHod.getString("HOD");
			}
			sqlHistory="insert into t_leaveApplicationHostory (FirstDayOfLeave, leaveType, empName, empMail, dept, HOD, changedBy, updatedStatus) values ('"+frstDay.get(a1).toString()+"','"+typeLeave.get(a1)+"','"+nameEmp.get(a1)+"','"+emailid+"','"+dept.get(a1)+"','"+HOD+"','"+session.getAttribute("leaveempname").toString()+"','Accepted')";
			System.out.println("sql--->"+sqlHistory);
			int p=stInsrt.executeUpdate(sqlHistory);
		}
		
		Data="Dear "+name+",<br><br>leave is approved from "+firstdayofleave+"<br>You have to report on duty on "+dateofreporting+"<br><br>";
		innerflag=true;
	}
	
	else if(type=="not"||type.equalsIgnoreCase("not"))
	{
		sql="update t_leaverequest set status='NotApproved',updateddatetime='"+datetoday+"' where srno in ("+srno+") ";
		System.out.println("sql--->"+sql);
		
		for(int a1=0; a1<appliedDays.size(); a1++)
		{
			String sqlDt="select Email from t_leaveadmin where Name='"+nameEmp.get(a1)+"'";
			ResultSet rsDt=stInsrt.executeQuery(sqlDt);
			if(rsDt.next())
			{
				emailid=rsDt.getString("Email");
			}
			HOD="-";
			String sqlHod="select * from t_leaverequest where emailid='"+empEmail.get(a1)+"' and firstdayofleave='"+frstDay.get(a1)+"' and daysapplied='"+appliedDays.get(a1)+"' ";
			System.out.println(sqlHod);
			ResultSet rsHod=stInsrt.executeQuery(sqlHod);
			if(rsHod.next())
			{
				HOD=rsHod.getString("HOD");
			}
			sqlHistory="insert into t_leaveApplicationHostory (FirstDayOfLeave, leaveType, empName, empMail, dept, HOD, changedBy, updatedStatus) values ('"+frstDay.get(a1).toString()+"','"+typeLeave.get(a1)+"','"+nameEmp.get(a1)+"','"+emailid+"','"+dept.get(a1)+"','"+HOD+"','"+session.getAttribute("leaveempname").toString()+"','NotAccepted')";
			System.out.println("sql--->"+sqlHistory);
			int p=stInsrt.executeUpdate(sqlHistory);
		}
		
		Data="Dear "+name+",<br><br>leave is not approved from "+firstdayofleave+"<br><br>";
		innerflag=true;
	}
	else if(type=="revert"||type.equalsIgnoreCase("revert"))
	{
		sql="update t_leaverequest set status='Pending',updateddatetime='"+datetoday+"' where srno in ("+srno+") ";
		System.out.println("sql--->"+sql);
		for(int a1=0; a1<appliedDays.size(); a1++)
		{
			String sqlDt="select Email from t_leaveadmin where Name='"+nameEmp.get(a1)+"'";
			ResultSet rsDt=stInsrt.executeQuery(sqlDt);
			if(rsDt.next())
			{
				emailid=rsDt.getString("Email");
			}
			HOD="-";
			String sqlHod="select * from t_leaverequest where emailid='"+empEmail.get(a1)+"' and firstdayofleave='"+frstDay.get(a1)+"' and daysapplied='"+appliedDays.get(a1)+"' ";
			System.out.println(sqlHod);
			ResultSet rsHod=stInsrt.executeQuery(sqlHod);
			if(rsHod.next())
			{
				HOD=rsHod.getString("HOD");
			}
			sqlHistory="insert into t_leaveApplicationHostory (FirstDayOfLeave, leaveType, empName, empMail, dept, HOD, changedBy, updatedStatus) values ('"+frstDay.get(a1).toString()+"','"+typeLeave.get(a1)+"','"+nameEmp.get(a1)+"','"+emailid+"','"+dept.get(a1)+"','"+HOD+"','"+session.getAttribute("leaveempname").toString()+"','Pending')";
			System.out.println("sql--->"+sqlHistory);
			int p=stInsrt.executeUpdate(sqlHistory);
		}
		innerflag=false;
	}
	else
	{
		sql="update t_leaverequest set status='Cancel',updateddatetime='"+datetoday+"' where srno in ("+srno+") ";
		System.out.println("sql--->"+sql);
		
		for(int a1=0; a1<appliedDays.size(); a1++)
		{
			String sqlDt="select Email from t_leaveadmin where Name='"+nameEmp.get(a1)+"'";
			ResultSet rsDt=stInsrt.executeQuery(sqlDt);
			if(rsDt.next())
			{
				emailid=rsDt.getString("Email");
			}
			HOD="-";
			String sqlHod="select * from t_leaverequest where emailid='"+empEmail.get(a1)+"' and firstdayofleave='"+frstDay.get(a1)+"' and daysapplied='"+appliedDays.get(a1)+"' ";
			System.out.println(sqlHod);
			ResultSet rsHod=stInsrt.executeQuery(sqlHod);
			if(rsHod.next())
			{
				HOD=rsHod.getString("HOD");
			}
			sqlHistory="insert into t_leaveApplicationHostory (FirstDayOfLeave, leaveType, empName, empMail, dept, HOD, changedBy, updatedStatus) values ('"+frstDay.get(a1).toString()+"','"+typeLeave.get(a1)+"','"+nameEmp.get(a1)+"','"+emailid+"','"+dept.get(a1)+"','"+HOD+"','"+session.getAttribute("leaveempname").toString()+"','Cancel')";
			System.out.println("sql--->"+sqlHistory);
			int p=stInsrt.executeUpdate(sqlHistory);
		}
		
		Data="Dear "+name+",<br><br>leave is canceled from "+firstdayofleave+"<br><br>";
		innerflag=true;
	}
	
int i=st.executeUpdate(sql);
System.out.println("IIIIIIIIIIIIIIIIIIIIII iiiiiiiii    "+i);
//int p=stInsrt.executeUpdate(sqlHistory);

if(i>1)
{
	System.out.println(appliedDays.size()+"***************Rows Updated*********************>>"+i);
	try{
		
		 flag=false;
		 if(innerflag==true)
		 {
		              Properties props = new Properties();
		         //     String host="smtp.transworld-compressor.com";
		     /*    String host="smtpout.secureserver.net";
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
		              
		              */
		              
		              String host = "a.mobileeye.in";
		              
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
                        
                        
                        
                      //   
                       Session session1 = Session.getDefaultInstance(props,
 null);
                               
                               session1 = Session.getInstance(props,
                                                 new javax.mail.Authenticator() {
 
                                                     protected PasswordAuthentication
 getPasswordAuthentication() {
                                                         return new PasswordAuthentication(user,
 pass);
                                                     }
                                                 });
 
                                       session1.setDebug(true);
 
 
		               // Construct the message
		               Message msg = new MimeMessage(session1);
		               msg.setSubject("Leave/Travel Application Approval");
		               msg.setSentDate(new java.util.Date());
		               Address recipientAddrs[] = new InternetAddress[1];
		               Address recipientAddrs1[] = new InternetAddress[1];
		               recipientAddrs1[0] = new InternetAddress(session.getAttribute("leaveemail").toString());
		               
		               //----HR mail-------------------------------------------------
		               String hr="";
		               String sqlHR="select * from t_leaveadmin where URole='HR' and Status='Yes'";
		               ResultSet rsHR=st.executeQuery(sqlHR);
		               if(rsHR.next())
		               {
		            	   hr=rsHR.getString("Email");
		               }
		               //------------------------------------------------------------
		               
		               recipientAddrs[0] = new InternetAddress(hr);
		               msg.addRecipients(Message.RecipientType.TO,recipientAddrs1);
		           //    msg.addRecipients(Message.RecipientType.CC,recipientAddrs);
		               Address fromAddress=new InternetAddress("noreply@transworld-compressor.com","Transworld"); // in second "", it is short name
		               msg.setFrom(fromAddress);
		               
		               
		             //****************************************************************************************
		               String chkStat="";
		               if(type.equals("not"))
		               {
		            	   chkStat="Rejected"; 
		               }
		               else
		               {
		            	   chkStat="Approved";
		               }
		               System.out.println(">>>>>>>>>>>"+chkStat);
		               
		               DateFormat df1=new SimpleDateFormat("dd-MM-yyyy");
		               DateFormat df2=new SimpleDateFormat("yyyy-MM-dd");
		               
		               
		               String b1="<html><body><table><tr><td>Following user's leaves are "+chkStat+"</td></tr></table><br>";
		               String b2="<table border='1' cellspacing='0' cellpadding='0'><tr bgcolor='#ADDFFF'><td align='center'><b>Sn</b></td><td align='center'><b>Name</b></td><td align='center'><b>Dept</b></td><td align='center'><b>First Day of Leave</b></td><td align='center'><b>Applied Days</b></td><td align='center'><b>Status</b></td><td align='center'><b>Type</b></td></tr>";
		               String b3="";
		               try
		               {
			               for(int al=0; al<appliedDays.size(); al++)
			               {
			            	   int h=al+1;
			             	   b3=b3+"<tr><td align='right'>"+h+"</td><td align='left'>"+nameEmp.get(al)+"</td><td align='left'>"+dept.get(al)+"</td><td align='right'>"+df1.format(df2.parse(frstDay.get(al).toString()))+"</td><td align='right'>"+appliedDays.get(al)+"</td><td >"+chkStat+"</td><td>"+typeLeave.get(al)+"</td></tr>";
			               }
		               }										
		               catch(Exception e)
		               {
		            	   System.out.println(e);
		               }
		               b3=b1+b2+b3+"</table><br>";
		               //****************************************************************************************
		               
		               
		               
		               msg.setContent(b3+"<table width='100%'><tr><td>Thanks and Regards</td></tr></table></body></html>" ,"text/html; charset=ISO-8859-1"); 
		               // Send the message
		               Transport t = session1.getTransport("smtps");
		               msg.saveChanges(); // don't forget this
		               try
		               {
		            	  
		                    t.connect(host, user, pass);
		                    t.sendMessage(msg, msg.getAllRecipients());
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
		               } 
		          		
		               Transport.send(msg);
		              // Transport.send(msg1);
		              
		 }//if innerflag
		       
		 
		 
	}catch(Exception e){
		
	} 
	response.sendRedirect("leaveRequestReport.jsp");
}


if(i==1)
{
	System.out.println("***************Rows Updated*********************>>"+i);
//	innerflag=true;
	try{
			
		 flag=false;
		 if(innerflag==true)
		 {
		              Properties props = new Properties();
		          //    String host="smtp.transworld-compressor.com";
		       /*   String host="smtpout.secureserver.net";
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
		              */
		              
		              String host = "a.mobileeye.in";
		              
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
                        
                        
                        
                       //  
                       Session session1 = Session.getDefaultInstance(props,
 null);
                               
                               session1 = Session.getInstance(props,
                                                 new javax.mail.Authenticator() {
 
                                                     protected PasswordAuthentication
 getPasswordAuthentication() {
                                                         return new PasswordAuthentication(user,
 pass);
                                                     }
                                                 });
 
                                       session1.setDebug(true);
 
 
		              
		               // Construct the message
		               Message msg = new MimeMessage(session1);
		               msg.setSubject("Leave/Travel Application Approval ");
		               msg.setSentDate(new java.util.Date());
		               Address recipientAddrs[] = new InternetAddress[1];
		               Address recipientAddrs1[] = new InternetAddress[1];
		               recipientAddrs[0] = new InternetAddress(HOD);
		               recipientAddrs1[0] = new InternetAddress(emailid);
		               msg.addRecipients(Message.RecipientType.TO,recipientAddrs1);
		               msg.addRecipients(Message.RecipientType.CC,recipientAddrs);
		               Address fromAddress=new InternetAddress("noreply@transworld-compressor.com","Transworld"); // in second "", it is short name
		          
		               msg.setFrom(fromAddress);
		               msg.setContent(Data+" Thanks and Regards" ,"text/html; charset=ISO-8859-1"); 
		               // Send the message
		               Transport t = session1.getTransport("smtps");
		               msg.saveChanges(); // don't forget this
		               try
		               {
		                    t.connect(host, user, pass);
		                    t.sendMessage(msg, msg.getAllRecipients());
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
		               } 
		          		
		               Transport.send(msg);
		          				               
		              // Transport.send(msg1);
		 }//if innerflag
		       
		 
		 
	}catch(Exception e){
		
	} 
	response.sendRedirect("leaveRequestReport.jsp");
	
}


%>
</body>
</html>