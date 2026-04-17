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
<%
try
	{
		String BranchName=request.getParameter("BranchName");
		System.out.println("BranchName=>"+BranchName);
		
		String Adress=request.getParameter("address");
		System.out.println("Adress=>"+Adress);
		
		String Location=request.getParameter("Location");
		System.out.println("Location=>"+Location);
		
		String PhoneNumber=request.getParameter("PhoneNumber");
		System.out.println("PhoneNumber=>"+PhoneNumber);

		String EntryBy=session.getAttribute("EmpName").toString(); 
		System.out.println("Entry By=>"+EntryBy);
		
		String Status="Active";
		
		Class.forName(DB_Driver);
		con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
		
		String compQuery="insert into "+session.getAttribute("CompanyMasterID").toString()+"BranchMaster (BranchName, Address, Location, Phone, EntryBy,status) values (?,?,?,?,?,?)";

		java.sql.PreparedStatement stmt = con.prepareStatement( compQuery );

		stmt.setString(1,BranchName);
		stmt.setString(2,Adress);
		stmt.setString(3,Location);
		stmt.setString(4,PhoneNumber);
		stmt.setString(5,EntryBy);
		stmt.setString(6,Status);
		
		System.out.println("Query"+compQuery);
		stmt.executeUpdate(); 
		
		response.sendRedirect("alertGoTo.jsp?msg=New Branch Added successfully&goto=BranchMaster.jsp");

}
catch(Exception e)
{
	System.out.println(e);
	//String msg1 = "!!!ERROR. Record not saved in system due to some problem. Please try again";
	//response.sendRedirect("addNewCustomer.jsp?msg="+msg1);
	response.sendRedirect("alertGoTo.jsp?msg=Record not saved in system due to some problem. Please try again.&goto=AddNewBranch.jsp");
}
%>