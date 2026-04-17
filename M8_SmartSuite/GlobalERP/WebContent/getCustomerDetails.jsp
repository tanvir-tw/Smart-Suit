em<%@page language="java" import ="java.sql.*" %>
<%@ include file="conn.jsp" %>
<%@page import="com.erp.beans.ERP"%>
<% 
ERP erp = new ERP();
erp.getConnection(DB_Driver,DB_NAME,DB_USERNAME,DB_PASSWORD);
%>
<%
try{
	session.setAttribute("flag","customer");

	String customerName=request.getParameter("customerName");
System.out.println(customerName);
	String repCode=null;
	String buffer="";
	
	buffer="<input type='text'	name='companyCity' id='search-text' value='' />";
	Connection con=erp.ReturnConnection();
	Statement st1;
	st1= con.createStatement();
	
	String sql1="select CustomerCode,ContactPerson,IntrestedProduct,WeeklyOffon,City,Phone,EMail,CustEnteredByRep  from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where CompanyName='"+customerName+"'";
	ResultSet rs = st1.executeQuery(sql1);
	if(rs.next())
	   {
			 buffer=" Code :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+
					" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+
					" &nbsp;&nbsp;&nbsp;&nbsp;<input type='text' name='customerCode'"+
						" id='search-text' value='"+rs.getString(1)+"' style='width: 120px; height: 12px' />";

	   
			buffer+="#Contact Person: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input"+
				" type='text' name='customerContactPerson' id='search-text'"+
					" value='"+rs.getString(2)+"' style='width: 120px;' />";
		
			
			buffer+="#Intrested In Product :&nbsp;"+
			" <input"+
			"		type='text' name='customerProduct' id='search-text'"+
			"		value='"+rs.getString(3)+"' style='width: 120px;' />";
			
			buffer+="#Weekly off on :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+
				" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input"+
				" type='text' name='customerWeeklyOff' id='search-text'"+
				" value='"+rs.getString(4)+"' style='width: 120px;' />";
			
			buffer+="#City :"+
				"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+
				"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+
				"<input type='text' name='customerCity' id='search-text'"+
				"	value='"+rs.getString(5)+"' style='width :120px; height: 12px;' />";

			
			buffer+="#Phone"+
				" Number :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input"+
				" type='text' name='customerPhoneNumber' id='search-text'"+
				" value='"+rs.getString(6).toString()+"'style='width :120px; height: 12px;' />";

			
			buffer+="#E-mail :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+
				" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type='text' name='customerEmail'"+
				"	id='search-text' value='"+rs.getString(7)+"' style='width :120px; height: 12px;'/>";

			
			buffer+="#Entered By :&nbsp;"+
				" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+
				" <input type='text' name='customerEnteredBy'"+
				"	id='search-text' value='"+rs.getString(8)+"' style='width :120px; height: 12px;'/>";

System.out.println(rs.getString(1)+rs.getString(2)+rs.getString(3)+rs.getString(4)+rs.getString(5)+rs.getString(6)+rs.getString(7)+rs.getString(8));
	
	   }
	out.println(buffer+"#");
	con.close();
}
catch(Exception e)
{
	System.out.println(e);
}
%>