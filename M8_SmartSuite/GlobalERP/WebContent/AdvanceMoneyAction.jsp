<%@ page language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="moreservlets.listeners.*" errorPage="" %>
<link href="css/ERP.css" rel="stylesheet" type="text/css"></link>
 <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<style type="text/css">@import url(jscalendar-1.0/calendar-blue.css);</style>
<%@ page import = "java.io.FileNotFoundException"%>
<%@ page import = "java.io.FileOutputStream"%>
<%@ page import = " java.io.IOException"%>
<%@ page import="javax.activation.*" %>
<html> 
<head>
<style>

</style>

<%@ include file="header.jsp"%>

<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page"> 
<title></title>
</head>
<body>



<%!
Connection con1;

%>
<% 

Class.forName(DB_Driver);
con1 = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);

 Statement stmt1=con1.createStatement();

Statement stmt2=con1.createStatement();


String id=request.getParameter("id").toString();

String action=request.getParameter("Action").toString();














String logname=session.getAttribute("EmpName").toString();
System.out.println("----->"+id+"--------->"+action);



if(action.equals("Approve"))
{
	
	String ApproveAmount=request.getParameter("ApproveAmount");
	String ApproveComments=request.getParameter("ApproveComments");
	Double d1=Double.parseDouble(ApproveAmount);

	String Aamount=new DecimalFormat("0.00").format(d1);
	
	
	 String query="Update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AdvanceMoneyMaster set Status='"+action+"d',ApprovedBy='"+logname+"',ApprovedAmount='"+Aamount+"',ApproveComment='"+ApproveComments+"' Where AdvanceID='"+id+"'";
	int i=stmt1.executeUpdate(query);

	String query1="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AdvanceMoneyMasterHistory(Category,PersonsTravel,CostCenter,Amount,Purpose,CustomerName,Status,EntryBy,DepartureDate,ReturnDate,ApprovedBy,Comments,AdvanceMasterId,EntryDate,Department,ApproveComment,ApprovedAmount) select Category,PersonsTravel,CostCenter,Amount,Purpose,CustomerName,Status,EntryBy,DepartureDate,ReturnDate,ApprovedBy,Comments,AdvanceID,EntryDate,Department,ApproveComment,ApprovedAmount from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AdvanceMoneyMaster where AdvanceID='"+id+"'";
	int j=stmt2.executeUpdate(query1); 	
	
	System.out.println("Inside Approve Action");
	
		
	if(i>0 && j>0)
	{
		 out.println("<script type=\"text/javascript\">");
		   out.println("swal('Advance "+action+"','','success');");
		   
		  // swal("Good job!", "You clicked the button!", "success");
		   out.println("location='AdvanceClaimReport.jsp';");
		  
		  
		   out.println("</script>");
	}
	
}

if(action.equals("Reject"))
{
	String reason=request.getParameter("Reason").toString();
	System.out.println("REASON::"+reason);
	int i=0,j=0;
	
	String query="Update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AdvanceMoneyMaster set Status='"+action+"ed',RejectedReason='"+reason+"',RejectedBy='"+logname+"'  where AdvanceID ='"+id+"'  ";
	 i=stmt1.executeUpdate(query);
	
	
	String query1="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AdvanceMoneyMasterHistory(Category,PersonsTravel,CostCenter,Amount,Purpose,CustomerName,Status,EntryBy,DepartureDate,ReturnDate,RejectedBy,RejectedReason,Comments,AdvanceMasterId,EntryDate,Department) select Category,PersonsTravel,CostCenter,Amount,Purpose,CustomerName,Status,EntryBy,DepartureDate,ReturnDate,RejectedBy,RejectedReason,Comments,AdvanceID,EntryDate,Department from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AdvanceMoneyMaster where AdvanceID='"+id+"'";
	j=stmt2.executeUpdate(query1);
	
	
	if(i>0 && j>0)
	{
		 out.println("<script type=\"text/javascript\">");
		   out.println("swal('Advance "+action+"','','success');");
		   
		  // swal("Good job!", "You clicked the button!", "success");
		   out.println("location='AdvanceClaimReport.jsp';");
		   out.println("</script>");
	}
}


else if(action.equals("Cancel"))
{
	
	int i=0,j=0;
	
	String query="Update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AdvanceMoneyMaster Set Status='"+action+"led' where AdvanceID='"+id+"'";
	
	 i=stmt1.executeUpdate(query);

	
	 String query1="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AdvanceMoneyMasterHistory(Category,PersonsTravel,CostCenter,Amount,Purpose,CustomerName,Status,EntryBy,DepartureDate,ReturnDate,Comments,AdvanceMasterId,EntryDate,Department) select Category,PersonsTravel,CostCenter,Amount,Purpose,CustomerName,Status,EntryBy,DepartureDate,ReturnDate,Comments,AdvanceID,EntryDate,Department from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AdvanceMoneyMaster where AdvanceID='"+id+"'";
	 j=stmt2.executeUpdate(query1);
	 
	System.out.println("query is:"+query);
	 
	if(i>0 && j>0)
	{
		 out.println("<script type=\"text/javascript\">");
		   out.println("swal('Advance "+action+"','','success');");
		   
		  // swal("Good job!", "You clicked the button!", "success");
		   out.println("location='AdvanceClaimReport.jsp';");
		   out.println("</script>");
	}
	
	
} 




















%>



</jsp:useBean>
</body>
</html>