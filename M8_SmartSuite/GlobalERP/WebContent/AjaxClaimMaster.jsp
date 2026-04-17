<%@ include file="conn.jsp"%>
<%@page import="java.util.Date"%>
<%
Connection con1 = null;
%>
<%
try 
{
System.out.println("\n>>>>>$$$$$$$$$$$$$>>>In AjaxClaimMaster.jsp>>>>>>>>>>>>>>>>");	
Class.forName(DB_Driver);
con1 = DriverManager.getConnection(DB_NAME, DB_USERNAME,DB_PASSWORD);
Statement stmt1 = con1.createStatement();
Statement stmt2 = con1.createStatement();
Statement st1 = con1.createStatement();
String EMPName=session.getAttribute("EmpName").toString();
System.out.println(">>>>>>>>>>>EMPName:"+EMPName);  
String SqlDeleteMaster="",SqlClaimDet="";
String id=request.getParameter("id");
System.out.println(">>>>>>>>id:"+id);


if(request.getParameter("action").equals("delete"))
{
	
	SqlDeleteMaster="Update "+session.getAttribute("CompanyMasterID").toString()+"claim_master Set Cancel='0' where CLMRefNumber='"+id+"' and Cancel='1' ";
	System.out.println(">>>>>>>>SqlDeleteMaster:"+SqlDeleteMaster);
	stmt1.executeUpdate(SqlDeleteMaster);
	
	SqlClaimDet="Update "+session.getAttribute("CompanyMasterID").toString()+"claim_det Set Cancel='0' where CLMRefNumber='"+id+"' and Cancel='1' ";
	System.out.println(">>>>>>>>SqlClaimDet:"+SqlClaimDet);
	st1.executeUpdate(SqlClaimDet);
	
	out.println("#Yes");
}

} 
catch (Exception e) {
System.out.println("AjaxClaimMaster.jsp error  table > "+e);
out.println("#NO");
} finally {
	con1.close();

}

%>