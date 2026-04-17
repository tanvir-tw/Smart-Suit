<%@page import="java.util.Date"%>
<%@ include file="conn.jsp"%>


<%
	Connection con=null ;
	DecimalFormat twoDForm = new DecimalFormat("#.##");
	Statement st=null,st1=null,st2=null,st3=null;
	String todaysDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	String todaysTime=new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
%>

<%
	
	try
	{	
		Class.forName(DB_Driver);
		con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
		st=con.createStatement();
		st1=con.createStatement();
		st2=con.createStatement();
		st3=con.createStatement();

			
		String pquono=request.getParameter("purquono");
		System.out.println(pquono);
		String company=request.getParameter("companyName");
		String cancelreason=request.getParameter("reasonforcancel");
		System.out.println(cancelreason);
		
		String sql1="UPDATE  "+session.getAttribute("CompanyMasterID").toString()+"purchasequo SET ReasonForCancelling='"+cancelreason+"' where PurQuoNo='"+pquono+"'  ";
		
		System.out.println(sql1);
		st.executeUpdate(sql1);
		
		response.sendRedirect("alertGoTo.jsp?msg=Purchase Quotation No:"+pquono+" is Closed With Reason "+cancelreason+".&goto=PurchaseQuatationList.jsp");
	}
	catch(Exception e)
	{
		System.out.println("Exception ::"+e);
		e.printStackTrace();
		response.sendRedirect("alertGoTo.jsp?msg=!!!! ERROR Inserting Record.Please try again.&goto=PQDetails.jsp");
	}
	finally
	{
		con.close();
	
	}
%>	