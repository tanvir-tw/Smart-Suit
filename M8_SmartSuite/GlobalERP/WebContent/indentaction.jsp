<%@ page language="java" import="java.sql.*" import="java.util.*" import="java.text.*" errorPage=""
    pageEncoding="ISO-8859-1"%>
    <%@ include file="header.jsp" %>
   <jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script >
function Redirect()
{
	  
	  var action=document.getElementById("action").value;
	  
	  
		 alert("Purchase Request Is "+action+" Successfully ");
		 
		 window.location="PurchaseIndentReport.jsp";
		 
			 
	    	   

	
	
}

function Redirect1()
{
	  var action=document.getElementById("action").value;
	alert("Purchase Request Is Not "+action+" ");
	 
	 window.location="PurchaseIndentReport.jsp";
}


</script>

<body>


<%!
Connection conn=null;
%>

<%
//////////



//conn=erp.ReturnConnection();
//Statement st=conn.createStatement();
//Statement st1=conn.createStatement();

Connection conn = null, conn1=null;
Statement sterp = null, sterp1 = null, sterp2=null, sterp3=null, sterp4=null, sterp5=null, stqr=null, stsql1=null,stsql2=null;
ResultSet rs = null;
//String DB_NAME="jdbc:mysql://103.8.126.138:3306/db_gps";
//String DB_NAME="jdbc:mysql:// twdb.fleetview.in/db_gps";
String DB_NAME123="jdbc:mysql://"+host1+"/db_gps";
//String DB_NAME1="jdbc:mysql://103.8.126.138:3306/twsql_twalldata";
//String DB_NAME1="jdbc:mysql://twdb.fleetview.in/twsql_twalldata";
String DB_NAME11234="jdbc:mysql://"+host1+"/db_GlobalERP";
String DB_USERNAME1=user1;
String DB_PASSWORD1=pass1;
Class.forName("com.mysql.cj.jdbc.Driver");
//conn=DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
conn1=DriverManager.getConnection(DB_NAME11234,DB_USERNAME1,DB_PASSWORD1);
sterp = conn1.createStatement();
sterp1 = conn1.createStatement();
sterp2 = conn1.createStatement();
sterp3 = conn1.createStatement();
sterp4 = conn1.createStatement();
sterp5 = conn1.createStatement();
stsql1= conn1.createStatement();
stsql2= conn1.createStatement();

Statement st=conn1.createStatement();
Statement st1=conn1.createStatement();
String role="";
String Id="";
String Amcfromdate="",Amctodate="",Ownername="",toDate1="",InvoiceNumber="",action="";
String EntryBy="";

%>
<%

try{
	
Id=request.getParameter("Id");

role=request.getParameter("role");

action=request.getParameter("action");

System.out.println(" ID :- "+Id+ "  Role :- "+role+" Action :- "+action);
String updateaction="";
if(action.equals("Approve"))
{
	updateaction="Approved";
}
else
{
	updateaction="Processed";
}

%>

<input type="hidden" id="requestid" name="requestid" value="<%=Id%>" />
<input type="hidden" id="role" name="role" value="<%=role%>" />
<input type="hidden" id="action" name="action" value="<%=action%>" />

<%  


String sql="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"PurchaseIndentRequestData where RequestId='"+Id+"'";
ResultSet rssql=st.executeQuery(sql);
String insert1="";
String update="";
if(rssql.next())
{
	if(action.equals("Approve"))
	{
	//insert1="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"PurchaseIndentDataHistory (RequestId,RequestDate,ItemSpecification,Make,PartNo,Quantity,UnitOfMeasure,SpecialInstructions,Department,Project,CostCenter,DeliveryDate,SuggestedVendor,SuggestedVendorAddress,SuggestedVendorContact,SuggestedVendorEmail,EntryBy,Rate,ApprovedBy) values ('"+rssql.getString("RequestId")+"','"+rssql.getString("RequestDate")+"','"+rssql.getString("ItemSpecification")+"','"+rssql.getString("Make")+"','"+rssql.getString("PartNo")+"','"+rssql.getString("Quantity")+"','"+rssql.getString("UnitOfMeasure")+"','"+rssql.getString("SpecialInstructions")+"','"+rssql.getString("Department")+"','"+rssql.getString("Project")+"','"+rssql.getString("CostCenter")+"','"+rssql.getString("DeliveryDate")+"','"+rssql.getString("SuggestedVendor")+"','"+rssql.getString("SuggestedVendorAddress")+"','"+rssql.getString("SuggestedVendorContact")+"','"+rssql.getString("SuggestedVendorEmail")+"','"+rssql.getString("EntryBy")+"','"+rssql.getString("Rate")+"','"+session.getAttribute("EmpName").toString()+"')";
	
	//st1.executeUpdate(insert1);
	
		update="update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"PurchaseIndentRequestData set ApprovedBy='"+session.getAttribute("EmpName").toString()+"' , Status='"+updateaction+"'  where  RequestId='"+Id+"' ";
	}
	else
	{
		//insert1="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"PurchaseIndentDataHistory (RequestId,RequestDate,ItemSpecification,Make,PartNo,Quantity,UnitOfMeasure,SpecialInstructions,Department,Project,CostCenter,DeliveryDate,SuggestedVendor,SuggestedVendorAddress,SuggestedVendorContact,SuggestedVendorEmail,EntryBy,Rate,ProcessedBy) values ('"+rssql.getString("RequestId")+"','"+rssql.getString("RequestDate")+"','"+rssql.getString("ItemSpecification")+"','"+rssql.getString("Make")+"','"+rssql.getString("PartNo")+"','"+rssql.getString("Quantity")+"','"+rssql.getString("UnitOfMeasure")+"','"+rssql.getString("SpecialInstructions")+"','"+rssql.getString("Department")+"','"+rssql.getString("Project")+"','"+rssql.getString("CostCenter")+"','"+rssql.getString("DeliveryDate")+"','"+rssql.getString("SuggestedVendor")+"','"+rssql.getString("SuggestedVendorAddress")+"','"+rssql.getString("SuggestedVendorContact")+"','"+rssql.getString("SuggestedVendorEmail")+"','"+rssql.getString("EntryBy")+"','"+rssql.getString("Rate")+"','"+session.getAttribute("EmpName").toString()+"')";
		
		
		//st1.executeUpdate(insert1);
		
		//update="update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"PurchaseIndentRequestData set ProcessedBy='"+session.getAttribute("EmpName").toString()+"' , Status='Processed'  where RequestId='"+Id+"'";
		
		update="update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"PurchaseIndentRequestData set ProcessedBy='"+session.getAttribute("EmpName").toString()+"' , Status='"+updateaction+"'  where  RequestId='"+Id+"' ";
		
	}
	
	
}

/* System.out.println("Insert Query :- "+insert1);
st1.executeUpdate(insert1);
System.out.println("Insert Query :- "+insert1); */

System.out.println("Update Query :- "+update);
sterp.executeUpdate(update);
System.out.println("Update Query :- "+update);


out.println("<script>  Redirect();</script>");


}
catch(Exception e)
{
	e.printStackTrace();
	out.println("<script>  Redirect1();</script>");

}
%>
</body>
</html>
</jsp:useBean>