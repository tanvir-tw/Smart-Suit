

<%@ include file="conn.jsp" %>

<%!
Connection con1;
%>

<% 
try {
	Class.forName(DB_Driver);
	con1 = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
	Statement stmt1=con1.createStatement();
	ResultSet rs1=null;
	String sql1="";
	String output="#No#";
	
	String cust=request.getParameter("companyName");
	sql1="Select * from "+session.getAttribute("CompanyMasterID").toString()+"customerdet where CompanyName='"+cust+"' ";
	rs1=stmt1.executeQuery(sql1);
	if(rs1.next())
	 output="#Yes#";
	
	out.print(output);

} catch(Exception e) { System.out.print(e); }
finally
{
	con1.close();
}
%>

 