
<%@page import="javax.mail.Session"%><%@page language="java" import ="java.sql.*" %>
<%@ include file="conn.jsp" %>
<%@page import="com.erp.beans.ERP"%>
<% 
ERP erp = new ERP();
erp.getConnection(DB_Driver,DB_NAME,DB_USERNAME,DB_PASSWORD);
%>
<%
try{
	session.setAttribute("flag","company");
	
	String companyName=request.getParameter("companyName");
System.out.println(companyName);
	String repCode=null;
	String buffer="";
	
	Connection con=erp.ReturnConnection();
	Statement st1;
	st1= con.createStatement();
	
	String sql1="select CustomerCode,BillingCity,BillingPhone,IntrestedProduct  from "+session.getAttribute("CompanyMasterID").toString()+"customerdet where CompanyName='"+companyName+"'";
	ResultSet rs = st1.executeQuery(sql1);
	if(rs.next())
	   {
			 repCode=rs.getString(1); 

			 buffer+="Code :&nbsp;"+
				"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+
				"&nbsp;&nbsp;&nbsp;&nbsp;<input type='text' name='companyCode' id='search-text' value='"+repCode+"' style='width: 50px;' />";
			 
			 buffer+="#City :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+
			 "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	"+
			 "<input type='text' name='companyCity' id='search-text'	value='"+rs.getString(2)+"' style='height: 12px;' />";
			 

				buffer+="#Phone Number :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+
				"<input	type='text' name='companyPhoneNumber' id='search-text'	value='"+rs.getString(3)+"' />";
				
				buffer+="#Intrested	In Product :&nbsp;<input type='text' name='companyProduct'	id='search-text' value='"+rs.getString(4)+"' />";
			 
			 
	   }

	
	
	out.println(buffer+"#");
con.close();
}
catch(Exception e)
{
	System.out.println(e);
}

%>