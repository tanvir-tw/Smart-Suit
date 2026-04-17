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
		String name=request.getParameter("staffname");
		System.out.println("Name=>"+name);
		String branch=request.getParameter("branch");
		String contact=request.getParameter("contact");
		
		System.out.println("contact=>"+contact);
		
		String email=request.getParameter("email");
		System.out.println("Email=>"+email);
		
		String commission=request.getParameter("commission");
		String location=request.getParameter("loc");
		String validfrom=request.getParameter("fromdate");
		String validto=request.getParameter("todate");
		
		String from= new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(validfrom));
		String to= new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(validto));
		String remark=request.getParameter("remark");
		String EntryBy=session.getAttribute("EmpName").toString(); 
		System.out.println("Entry By=>"+EntryBy);
		
		System.out.println("Commission"+commission);
		System.out.println("Location"+location);

		
		System.out.println("remark"+remark);
		Class.forName(DB_Driver);
		con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
	
		
		String compQuery="insert into "+session.getAttribute("CompanyMasterID").toString()+"collectionStaffMaster (name, branch, contact, email, commission, Location, validfrom, validto, remark, EntryBy) values (?,?,?,?,?,?,?,?,?,?)";

		java.sql.PreparedStatement stmt = con.prepareStatement( compQuery );

		stmt.setString(1,name);
		stmt.setString(2,branch);
		stmt.setString(3,contact);
		stmt.setString(4,email);
		stmt.setString(5,commission);
		stmt.setString(6,location);
		stmt.setString(7,from);
		stmt.setString(8,to);
		stmt.setString(9,remark);
		stmt.setString(10,EntryBy);
		
		System.out.println("Query"+compQuery);
		stmt.executeUpdate(); 
		
		response.sendRedirect("alertGoTo.jsp?msg=New Collection Staff Added Successfully&goto=collectionStaffReport.jsp");
		
}
catch(Exception e)
{
	System.out.println(e);
	//String msg1 = "!!!ERROR. Record not saved in system due to some problem. Please try again";
	//response.sendRedirect("addNewCustomer.jsp?msg="+msg1);
	response.sendRedirect("alertGoTo.jsp?msg=Record Not Saved In System Due To Some Problem. Please Try Again.&goto=addCollectionStaff.jsp");
}
%>