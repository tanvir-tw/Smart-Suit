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
	try{
		Class.forName(DB_Driver);
		con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
		st=con.createStatement();
		st1=con.createStatement();
		st2=con.createStatement();
		st3=con.createStatement();
	
		
		String quotationno=request.getParameter("salesquono");
		System.out.println(quotationno);
		String reasoncancel=request.getParameter("reasonforcancel");
		System.out.println(reasoncancel);
					
		String sqlUpdate="UPDATE "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det SET SalesQuoCancelled=1 , ReasonForCancellingQuo='"+reasoncancel+"' where SalesQuoNo='"+quotationno+"'";
		System.out.println(sqlUpdate);
		st1.executeUpdate(sqlUpdate);
		
		response.sendRedirect("alertGoTo.jsp?msg=Quotation Closed.&goto=showquotationlist.jsp?id=Close");
		
}
catch(Exception e)
{
	System.out.println("Exception ::"+e);
	e.printStackTrace();
	response.sendRedirect("alertGoTo.jsp?msg=!!!! ERROR Inserting Record.Please try again.&goto=SEDetails.jsp");
}
finally
{
	con.close();

}
%>		