<%@page language="java" import ="java.sql.*" %>
<%@ include file="conn.jsp" %>
<%@page import="com.erp.beans.ERP"%>
<% 
ERP erp = new ERP();
erp.getConnection(DB_Driver,DB_NAME,DB_USERNAME,DB_PASSWORD);
%>
<%
try{
	String repName=request.getParameter("repName");
System.out.println(repName);
	String repCode=null;
	String buffer="";
	
	buffer="<input type='text'	name='repCode' id='search-text' value='' />";
	Connection con=erp.ReturnConnection();
	Statement st1;
	st1= con.createStatement();
	
	String sql1="select MarketingRepCode  from "+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster where MarketingRepName='"+repName+"'";
	ResultSet rs = st1.executeQuery(sql1);
	if(rs.next())
	   {
			 repCode=rs.getString(1); 
			 buffer="Marketing Rep. Code :&nbsp;&nbsp;&nbsp;&nbsp;<input type='text'	name='repCode' id='search-text' value='"+repCode+"' />";

	   }
	System.out.println(repCode+"<<< repCode    buff >>>"+buffer);
out.println(buffer+"#");
con.close();
}
catch(Exception e)
{
	System.out.println(e);
}
%>