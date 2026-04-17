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

			
		String porderno=request.getParameter("purorderno");
		System.out.println(porderno);
		String company=request.getParameter("companyName");
		String cancelreason=request.getParameter("reasonforcancel");
		System.out.println(cancelreason);
		
		String sql1="UPDATE  "+session.getAttribute("CompanyMasterID").toString()+"purchaseorder SET POCancelled='1',ReasonForCancelling='"+cancelreason+"' where PONo='"+porderno+"'  ";
		
		System.out.println(sql1);
		st.executeUpdate(sql1);
		
		response.sendRedirect("alertGoTo.jsp?msg=Purchase Order No:"+porderno+" is  Closed with Reason :"+cancelreason+".&goto=PurchaseOrderList.jsp");
	}
	catch(Exception e)
	{
		System.out.println("Exception ::"+e);
		e.printStackTrace();
		response.sendRedirect("alertGoTo.jsp?msg=!!!! ERROR Inserting Record.Please try again.&goto=PODetails.jsp");
	}
	finally
	{
		con.close();
	
	}
%>	