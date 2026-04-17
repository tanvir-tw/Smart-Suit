 <%@ include file="conn.jsp" %>
<%@ include file="ConnForIncident.jsp"%>
<%!
Connection con1;
%>

<% 
try
{
Class.forName(DB_Driver);
con1 = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
Statement stmt1=con1.createStatement();
Statement stleave=conn.createStatement();

ResultSet rs1=null;
String sql1="";
boolean flag=false;
String company=request.getParameter("company");
String type=request.getParameter("type");
System.out.println(type+" ...  "+company);
String contact="",city="",address="",zip="",email="",phone="",website="",product="",weeklyoff="",suppliercode="",companyname="",fax="",mobile="";
String country="",state="",designation="",areacode="",alternateno="";


if(type.equals("Contractor Fee"))
{
	System.out.println("IN CONTRACTOR");
	sql1="SELECT * from db_leaveapplication.t_leaveadmin where Name like ('%"+company+"%') order by Name";
	rs1=stleave.executeQuery(sql1);
	String buffer="<div style='height:120px;width:275px;overflow:auto; '><table style='background-color:#C6DEFF; width:400px; display: block';>";
	int i=1;
	while(rs1.next())
	{
	   companyname=  (rs1.getString("Name") == null || rs1.getString("Name").equalsIgnoreCase("") ) ? "-" : rs1.getString("Name") ;
	   out.print("<input type='hidden' name='companyname"+i+"' id='companyname"+i+"' value='"+companyname+"'>");
	   buffer+="<tr><td><a href='#' onClick='getsupplierDetails("+i+");'  style='color: black;'>"+rs1.getString("Name").replaceAll("(?i)","<font color=blue><u>"+"</u></font>")+"</a></tr></td>";
	   i++;
	}
	buffer+="</table></div>";
	out.println(buffer);
}
if(type.equals("Claims"))
{
	System.out.println("IN claims");
	sql1="SELECT * from db_leaveapplication.t_leaveadmin where Name like ('%"+company+"%') order by Name";
	rs1=stleave.executeQuery(sql1);
	String buffer="<div style='height:120px;width:275px;overflow:auto; '><table style='background-color:#C6DEFF; width:400px; display: block';>";
	int i=1;
	while(rs1.next())
	{
	   companyname=  (rs1.getString("Name") == null || rs1.getString("Name").equalsIgnoreCase("") ) ? "-" : rs1.getString("Name") ;
	   out.print("<input type='hidden' name='companyname"+i+"' id='companyname"+i+"' value='"+companyname+"'>");
	   buffer+="<tr><td><a href='#' onClick='getsupplierDetails("+i+");'  style='color: black;'>"+rs1.getString("Name").replaceAll("(?i)","<font color=blue><u>"+"</u></font>")+"</a></tr></td>";
	   i++;
	}
	buffer+="</table></div>";
	out.println(buffer);
}
/*
if(type.equals("contractor"))
{
	System.out.println("IN CONTRACTOR");
	sql1="SELECT * from db_leaveapplication.t_leaveadmin where Name like ('%"+company+"%') order by Name";
	rs1=stleave.executeQuery(sql1);
	String buffer="<div style='height:120px;width:275px;overflow:auto; '><table style='background-color:#C6DEFF; width:400px; display: block';>";
	int i=1;
	while(rs1.next())
	{
	   companyname=  (rs1.getString("Name") == null || rs1.getString("Name").equalsIgnoreCase("") ) ? "-" : rs1.getString("Name") ;
	   out.print("<input type='hidden' name='companyname"+i+"' id='companyname"+i+"' value='"+companyname+"'>");
	   buffer+="<tr><td><a href='#' onClick='getsupplierDetails("+i+");'  style='color: black;'>"+rs1.getString("Name").replaceAll("(?i)","<font color=blue><u>"+"</u></font>")+"</a></tr></td>";
	   i++;
	}
	buffer+="</table></div>";
	out.println(buffer);
}

else if(type.equals("vendor"))
{
	System.out.println("IN VENDOR");
	sql1="SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"supplierdet where SupplierName like ('%"+company+"%') order by SupplierName";
	rs1=stmt1.executeQuery(sql1);
	String buffer="<div style='height:120px;width:275px;overflow:auto; '><table style='background-color:#C6DEFF; width:400px; display: block';>";
	int i=1;
	while(rs1.next())
	{
	  companyname=  (rs1.getString("SupplierName") == null || rs1.getString("SupplierName").equalsIgnoreCase("") ) ? "-" : rs1.getString("SupplierName") ;
	  out.print("<input type='hidden' name='companyname"+i+"' id='companyname"+i+"' value='"+companyname+"'>");
	  buffer+="<tr><td><a href='#' onClick='getsupplierDetails("+i+");'  style='color: black;'>"+rs1.getString("SupplierName").replaceAll("(?i)","<font color=blue><u>"+"</u></font>")+"</a></tr></td>";
	  i++;
	}
	buffer+="</table></div>";
	out.println(buffer);
}

else if(type.equals("statutory")) 
{
	System.out.println("IN STATUTORY   ");
	sql1="SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"statutorydet where StatutoryName like ('%"+company+"%') order by StatutoryName";
	rs1=stmt1.executeQuery(sql1);
	String buffer="<div style='height:120px;width:275px;overflow:auto; '><table style='background-color:#C6DEFF; width:400px; display: block';>";
	int i=1;
	while(rs1.next())
	{
	   companyname=  (rs1.getString("StatutoryName") == null || rs1.getString("StatutoryName").equalsIgnoreCase("") ) ? "-" : rs1.getString("StatutoryName") ;
	   out.print("<input type='hidden' name='companyname"+i+"' id='companyname"+i+"' value='"+companyname+"'>");
	   buffer+="<tr><td><a href='#' onClick='getsupplierDetails("+i+");'  style='color: black;'>"+rs1.getString("StatutoryName").replaceAll("(?i)","<font color=blue><u>"+"</u></font>")+"</a></tr></td>";
	   i++;
	}
	buffer+="</table></div>";
	out.println(buffer);
}*/
}
catch(Exception e) 
{
}
finally
{
	con1.close();
}
%>