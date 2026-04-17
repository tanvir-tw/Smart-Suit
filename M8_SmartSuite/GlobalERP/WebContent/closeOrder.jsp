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
	}catch(Exception e){e.printStackTrace();}
	
	String orderno=request.getParameter("salesorderno");
	System.out.println(orderno);
		
	String cancelreason=request.getParameter("reasonforcancel");
	System.out.println(cancelreason);
	
	String sqlUpdate="UPDATE "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det SET SOCancelled=1 , ReasonForCancellingSO='"+cancelreason+"' where SalesOrderNo='"+orderno+"'";
	System.out.println(sqlUpdate);
		
try{		
	st1.executeUpdate(sqlUpdate);
	boolean flag=false;
	flag=true;
	response.sendRedirect("alertGoTo.jsp?msg=ORDER CLOSED.&goto=showorderlist.jsp?id=Close");
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