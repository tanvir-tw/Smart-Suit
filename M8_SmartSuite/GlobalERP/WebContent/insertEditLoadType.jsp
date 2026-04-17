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
		String srno=request.getParameter("Id");
		System.out.println("srno=>"+srno);
		
		String loadType=request.getParameter("loadType");
		System.out.println("loadType=>"+loadType);
		
		String description=request.getParameter("description");
		
		System.out.println("Description=>"+description);
	

		String EntryBy=session.getAttribute("EmpName").toString(); 
		System.out.println("Entry By=>"+EntryBy);
		
		
		Class.forName(DB_Driver);
		con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
		
		String sql="select * from t_loadTypeMaster where loadType='"+loadType+"' ";
		Statement st=con.createStatement();
		ResultSet rs1=st.executeQuery(sql);
		if(rs1.next()){
			
			%>
			<jsp:forward page="alertGoTo.jsp">
			 <jsp:param name="msg" value="This Load Type Is Already Exist  " ></jsp:param>
			  <jsp:param name="goto" value="AddNewLoadType.jsp" ></jsp:param>
			 
			 </jsp:forward>
			 <% System.out.println("after forword");%>
			 
			<% 
			
		}else{
		
		String compQuery="update "+session.getAttribute("CompanyMasterID").toString()+"loadTypeMaster set loadType=?, description=?, EntryBy=?  where srno='"+ srno+"'";

		java.sql.PreparedStatement stmt = con.prepareStatement( compQuery );

		stmt.setString(1,loadType);
		stmt.setString(2,description);
		stmt.setString(3,EntryBy);
		
		
		System.out.println("Query"+compQuery);
		stmt.executeUpdate(); 
		
		response.sendRedirect("alertGoTo.jsp?msg=Load Type Updated successfully&goto=loadTypeMaster.jsp");
		}
}
catch(Exception e)
{
	System.out.println(e);
	//String msg1 = "!!!ERROR. Record not saved in system due to some problem. Please try again";
	//response.sendRedirect("addNewCustomer.jsp?msg="+msg1);
	response.sendRedirect("alertGoTo.jsp?msg=Record Not Saved In System Due To Some Problem. Please Try Again.&goto=AddNewLoadType.jsp");
}
%>
