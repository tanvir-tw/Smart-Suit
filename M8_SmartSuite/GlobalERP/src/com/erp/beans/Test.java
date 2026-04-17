package com.erp.beans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class Test {
	
	static Connection conn1 = null;
	static Statement st = null;
	static Statement st1 = null;
	static Statement st2 = null;
	static Statement st3 = null;
	static Statement st4 = null;
	static Statement st5 = null;
	static Statement stMaster=null;
	static Statement stDATE=null;
	static int i=0;


	private static StringBuffer masterBuffer=new StringBuffer ("");
	private static String headerString;
	
	
	public static void GetConnection() 
	{
	  try {
			//System.out.print("Getting conn..." );
			String MM_dbConn_DRIVER = "com.mysql.cj.jdbc.Driver";
			String MM_dbConn_USERNAME = "fleetview";
			String MM_dbConn_PASSWORD = "1@flv";
			//String MM_dbConn= "jdbc:mysql://202.65.131.44:3306/twsql_twalldata";
			String MM_dbConn= "jdbc:mysql:// twdb.fleetview.in/db_GlobalERP";
			Class.forName(MM_dbConn_DRIVER);
			conn1 = DriverManager.getConnection(MM_dbConn,MM_dbConn_USERNAME, MM_dbConn_PASSWORD);

			st =  conn1.createStatement();
			st1 = conn1.createStatement();
			st2=conn1.createStatement();
			st3=conn1.createStatement();
			st4=conn1.createStatement();
			st5=conn1.createStatement();
			stDATE=conn1.createStatement();
			stMaster=conn1.createStatement();
			System.out.print("conn successful..." );
		  } catch (Exception e) {
			System.out.println("GetConnection Exception ---->" + e);}
	}

	public static void CloseConnection() 
	{
		try {
			st.close();
			st1.close();
			st2.close();
			st3.close();
			st4.close();
			st5.close();
			stMaster.close();
			stDATE.close();
			conn1.close();
		}   catch (Exception e)
		{
			System.out.println("CloseConnection Exception---->" + e);
		}
	}
	
	public static void main(String[] args)
	{
		// TODO Auto-generated method stub
	  try {
			GetConnection();
	
				
		String Data = "TESTING ";
				
				
		        //System.out.println("\n\nqqqqqqqqqqqq->>>"+Data);
				try{	
				Properties props = new Properties();
				 String host="mail1.kemhospital.org";
	             String protocol="smtp";
	   //         String user="jd@mobile-eye.in";
	             String user="edp";
                 String pass="edp";
	             props.put("mail.smtp.starttls.enable","true");
	             props.put("mail.smtp.auth", "false");
	             props.put("mail.smtp.user", "user");
	             props.put("mail.smtp.password", "pass");  
	             props.put("mail.store.protocol", protocol);
	             props.put("mail.smtp.host", host);
	             props.put("mail.smtp.port", "25"); 
	            // 
				Session session1 = Session.getDefaultInstance(props, null);
				Message msg = new MimeMessage(session1);
				msg.setSubject("Testing With New Server");
				msg.setSentDate(new java.util.Date());
				
				Address recipientAddrs[] = new InternetAddress[1];
					//recipientAddrs[0] = new InternetAddress(email1);
					recipientAddrs[0] = new InternetAddress("s_kapre@transworld-compressor.com");
				msg.addRecipients(Message.RecipientType.TO,recipientAddrs);
				
				Address fromAddress=new InternetAddress("noreply@a.mobileeye.in","Transworld Accounts"); // in second "", it is short name
				msg.setFrom(fromAddress);
			//	System.out.println(Data);
				msg.setContent(Data,"text/html; charset=ISO-8859-1");
				Transport t = session1.getTransport("smtp");
				msg.saveChanges(); // don't forget this
				try
				{
					t.connect(host, user, pass);
					System.out.println("SENT*******");
					t.sendMessage(msg, msg.getAllRecipients());
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
			
				}catch (Exception e)
				{
					System.out.println("inside while**  "+e);
				} 
				
				
			
				
		
			
			/* ************************************************************************************************************************    */
			
			
		
		
		
			
			

				CloseConnection(); 
		
	  }catch(Exception e)
	  {
		  System.out.println("EXCEPTION !!!  "+e);
		  e.printStackTrace();
	  }
	  }
	
	
}