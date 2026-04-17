<%@ include file="conn.jsp"%>
<%@page import="java.util.Date"%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>


</head>

<script >
function Redirect()
{
	alert("Record Successfully Updated");
    window.location="collectionStaffReport.jsp";
	
}
</script>

<%
Connection con1 = null;
%>
<%
try 
{
	System.out.println("\n>>>>>$$$$$$$$$$$$$>>>In AjaxCollectionDelete.jsp>>>>>>>>>>>>>>>>");	
Class.forName(DB_Driver);
con1 = DriverManager.getConnection(DB_NAME, DB_USERNAME,DB_PASSWORD);
Statement stmt1 = con1.createStatement();
Statement stmt2 = con1.createStatement();

ResultSet rs1 = null,rsClaimNo=null;
String buffer = "",SqlUpdate;
System.out.println("\n>>>>>$$$$$$$$$$$$$>>>In AjaxOpportunityDelete.jsp>>>>>>>>>>>>>>>>"+con1);

String id=request.getParameter("Id");
System.out.println(">>>>>>>>id:"+id);

if(request.getParameter("action").equals("delete"))
{	
	SqlUpdate="UPDATE "+session.getAttribute("CompanyMasterID").toString()+"collectionStaffMaster SET Status ='Deactivate' WHERE srno='"+id+"' limit 1 ";
		System.out.println(">>>>>>>>SqlDeleteMaster:"+SqlUpdate);
		stmt1.executeUpdate(SqlUpdate);
		System.out.println(">>>>>>>>SqlDeleteMaster:"+SqlUpdate);
	//out.println("#Yes");
	
	out.println("<script>  Redirect();</script>");
	
}

} 
catch (Exception e) {
System.out.println("collectionCancel.jsp error  table > "+e);
out.println("#NO");
} finally {
	con1.close();

}
%>
