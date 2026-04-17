
<%@ include file="conn.jsp"%>

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

String flag=session.getAttribute("flag").toString();
if (flag.equalsIgnoreCase("company")) {
	sql1="SELECT  count(*)  from "+session.getAttribute("CompanyMasterID").toString()+"followup where "+
	" ProspCustName='"+request.getParameter("Company")+"'  ";
	out.println("#Accept#");	
}
else{
	sql1=" SELECT count( * ) "+
				" FROM "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster AS a                                         "+
				" LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"followup AS b ON ( a.CompanyName = b.ProspCustName )  "+
				" WHERE a.companyname = '"+request.getParameter("Prospect")+"'                                                 "+
				" AND (                                                                       "+
				" a.address = ''                                                              "+
				" OR a.address = '-'                                                          "+
				" OR a.address LIKE (                                                         "+
				" '%    %'                                                                       "+
				" )"+
				" )  ";
	ResultSet rs=stmt1.executeQuery(sql1);
	rs.next();
	if(rs.getInt(1)>=2)
		out.println("#Reject#");
	else
		out.println("#Accept#");	
}

		
} catch(Exception e) {  }
finally
{
	con1.close();
}
%>
