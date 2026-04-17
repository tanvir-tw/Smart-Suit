<%@ include file="conn.jsp" %>
<%
Connection con1=null;
%>
<% 
try {
Class.forName(DB_Driver);
con1 = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
Statement stmt1=con1.createStatement();
Statement stmt2=con1.createStatement();
ResultSet rs1=null;
ResultSet rs2=null;
String sql1="";
String company="";
		  company=request.getParameter("supplierCode");
 		  sql1="SELECT *  from "+session.getAttribute("CompanyMasterID").toString()+"supplierdet where SupplierCode = ('"+company+"') limit 1 ";
  rs1=stmt1.executeQuery(sql1);
  
  String buffer="",category="-",mobile="";
   if(rs1.next())
   {
	   if(rs1.getString("Mobile")!=null) mobile=rs1.getString("Mobile")+" , ";
	   
	   String sqlGroup="SELECT TheGroupName from "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster where TheGroupCode='"+rs1.getString("SupCategory")+"'";
	   rs2=stmt2.executeQuery(sqlGroup);
	   if(rs2.next())
		   category=rs2.getString(1);
     buffer+="<label>"+rs1.getString("SupplierName")+"</label> # "+
     "<label>"+rs1.getString("ContactPerson")+"</label># "+
     "<label>"+rs1.getString("Address")+"</label># "+
     "<label>"+mobile+rs1.getString("Phone")+"</label># "+
     "<label>"+rs1.getString("City")+"  &nbsp;("+rs1.getString("State")+" , "+rs1.getString("Country")+")</label># "+
     "<label>"+rs1.getString("Email")+"</label># "+
     "<label>"+rs1.getString("SupProduct")+"</label>#"+
     "<label>"+category+"</label># "+
     "<label>"+rs1.getString("Fax")+"</label>#"+
     "<label>"+rs1.getString("WebSite")+"</label>";
    } 
out.println(buffer);



} catch(Exception e) {  }
finally
{
	con1.close();
}
%>
