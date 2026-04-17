<%@page import="java.util.Date"%>
<%@ include file="conn.jsp"%>


<%
	Connection con=null ;
	DecimalFormat twoDForm = new DecimalFormat("#.##");
	Statement st=null,st1=null,st2=null,st3=null;
	String todaysDate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
	String todaysTime=new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
%>

<%
System.out.print("Insert");
	
	try{	
		Class.forName(DB_Driver);
		con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
		st=con.createStatement();
		st1=con.createStatement();
		st2=con.createStatement();
		st3=con.createStatement();
		
		String status=request.getParameter("newstatus");
		String filename=request.getParameter("filename1");
		System.out.println(status+""+filename);
		
		String updatesql="Update "+session.getAttribute("CompanyMasterID").toString()+"netbankingfiles set UploadStatus='"+status+"',UpdatedOn='"+todaysDate+"' where FileName1='"+filename+"'";
		st.executeUpdate(updatesql);
		System.out.println(updatesql);
		
		response.sendRedirect("alertForFilestatus.jsp?msg=Status Updated Successfully.&goto=Netbankfilestatus.jsp");
		
		}
	
		catch(Exception e)
		{
			response.sendRedirect("alertForFilestatus.jsp?msg=Status is NOT Updated .Please Try Again!!&goto=Netbankfilestatus.jsp");
		}
		finally
		{
		con.close();

		}
%>		

