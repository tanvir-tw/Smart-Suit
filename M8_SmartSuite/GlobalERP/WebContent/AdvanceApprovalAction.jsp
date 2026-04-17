<%@ page language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="moreservlets.listeners.*" errorPage="" %>
<link href="css/ERP.css" rel="stylesheet" type="text/css"></link>
 <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<style type="text/css">@import url(jscalendar-1.0/calendar-blue.css);</style>
<%@ page import = "java.io.FileNotFoundException"%>
<%@ page import = "java.io.FileOutputStream"%>
<%@ page import = " java.io.IOException"%>
<%@ page import="javax.activation.*" %>
<%@ page import=" java.text.DecimalFormat"%>
<html> 
<link rel="stylesheet" href="calendar/datepicker.css">


<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">  

<body onkeypress="hideList(event);" onclick="hideOnClick();">

<%@ include file="header.jsp"%>
<%!
Connection con1;
%>
<% 

Statement stmt1=null;
Statement stmt2=null;
Statement stmt3=null;

int srno=0;
String category=null;
double amt;
String amount="";
String purpose=null,cust=null,status=null,entryby=null,approved=null,rejectedby=null;
String rejectedreason=null;
String behalfof=null;

Class.forName(DB_Driver);
con1 = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);

String id=request.getParameter("id").toString();

String action=request.getParameter("Action").toString();




System.out.println("Action:"+action);
System.out.println("id:"+id);

stmt1=con1.createStatement();
stmt2=con1.createStatement();
stmt3=con1.createStatement();

ResultSet rs=null;
ResultSet rs2=null;
String role=session.getAttribute("role").toString();
String logname=session.getAttribute("EmpName").toString();

System.out.println("LogName:"+logname);
String date=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new Date());

String query1="select * from  db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AdvanceClaimMaster where  SrNo='"+id+"'";

rs2=stmt2.executeQuery(query1);
while(rs2.next())
{
	
	 srno=rs2.getInt("SrNo");
	 category=rs2.getString("Category");
	 amt=rs2.getDouble("Amount");
	 amount=new DecimalFormat("0.00").format(amt);
	 purpose=rs2.getString("Purpose");
	 cust=rs2.getString("CustomerName");
	 //status=rs2.getString("Status");
	 //entryby=rs2.getString("EntryBy");
	 //approved=rs2.getString("ApprovedBy");
	 //rejectedby=rs2.getString("RejectedBy");
     //rejectedreason=rs2.getString("RejectedReason");
	 behalfof=rs2.getString("BehalfOf");
	
	 
}


	if(action.equals("Approve"))
	{
		
		
		
		String query="Update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AdvanceClaimMaster set Status='"+action+"d',ApprovedBy='"+role+"' Where SrNo='"+id+"'";
		int i=stmt1.executeUpdate(query);
		
		String qury="Insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AdvanceClaimMasterHistory (Category,Amount,Purpose,CustomerName,EntryBy,ApprovedBy,EntryDate,BehalfOf,MasterSrNo,Status) Values ('"+category+"','"+amount+"','"+purpose+"','"+cust+"','"+logname+"','"+logname+"','"+date+"','"+behalfof+"','"+srno+"','"+action+"')";
		
int j=stmt3.executeUpdate(qury);
		
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
		
		String query="Update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AdvanceClaimMaster set Status='"+action+"ed',RejectedReason='"+reason+"'where SrNo='"+id+"'  ";
		int i=stmt1.executeUpdate(query);
		
		String qury="Insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AdvanceClaimMasterHistory (Category,Amount,Purpose,CustomerName,EntryBy,RejectedBy,RejectedReason,EntryDate,BehalfOf,MasterSrNo,Status) Values ('"+category+"','"+amount+"','"+purpose+"','"+cust+"','"+logname+"','"+logname+"','"+reason+"','"+date+"','"+behalfof+"','"+srno+"','"+action+"')";
		int j=stmt3.executeUpdate(qury);
		
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
		
		String query="Update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AdvanceClaimMaster Set Status='"+action+"led' where SrNo='"+id+"' ";
		int i=stmt1.executeUpdate(query);
		
		String qury="Insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AdvanceClaimMasterHistory (Category,Amount,Purpose,CustomerName,EntryBy,EntryDate,BehalfOf,MasterSrNo,Status) Values ('"+category+"','"+amount+"','"+purpose+"','"+cust+"','"+logname+"','"+date+"','"+behalfof+"','"+srno+"','"+action+"')";
		
int j=stmt3.executeUpdate(qury);
		
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

