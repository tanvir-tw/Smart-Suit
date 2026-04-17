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
boolean flag=false;
String company=request.getParameter("company");
System.out.println(">>>>>>>>>>>>>>    "+company);
String contact="",city="",address="",zip="",email="",phone="",website="",product="",weeklyoff="",suppliercode="",companyname="",fax="",mobile="";
String country="",state="",designation="",areacode="",alternateno="",GSTIN="";
sql1="SELECT *  from "+session.getAttribute("CompanyMasterID").toString()+"supplierdet where SupplierName like ('%"+company+"%') order by SupplierName limit 20 ";
//out.print(sql1);
System.out.println("INSupplier  INSupplier ******       "+sql1);
rs1=stmt1.executeQuery(sql1);
String buffer="<div style='height:120px;width:275px;overflow:auto; '><table style='background-color:#C6DEFF; width:400px; display: block';>";
int i=1;

while(rs1.next())
{

   contact= (rs1.getString("ContactPerson") == null || rs1.getString("ContactPerson").equalsIgnoreCase("") ) ? "-" : rs1.getString("ContactPerson") ;
   city= (rs1.getString("City") == null || rs1.getString("City").equalsIgnoreCase("") ) ? "-" : rs1.getString("City") ;
   address= (rs1.getString("Address") == null || rs1.getString("Address").equalsIgnoreCase("") ) ? "-" : rs1.getString("Address") ;
   zip= (rs1.getString("Zip") == null || rs1.getString("Zip").equalsIgnoreCase("") ) ? "-" : rs1.getString("Zip") ;
   email= (rs1.getString("EMail") == null || rs1.getString("EMail").equalsIgnoreCase("") ) ? "-" : rs1.getString("EMail") ;
   phone= (rs1.getString("Phone") == null || rs1.getString("Phone").equalsIgnoreCase("") ) ? "-" : rs1.getString("Phone") ;
   website= (rs1.getString("WebSite") == null || rs1.getString("WebSite").equalsIgnoreCase("") ) ? "-" : rs1.getString("WebSite") ;
   product= (rs1.getString("SupProduct") == null || rs1.getString("SupProduct").equalsIgnoreCase("") ) ? "-" : rs1.getString("SupProduct") ;
   weeklyoff= (rs1.getString("WeeklyOff") == null || rs1.getString("WeeklyOff").equalsIgnoreCase("") ) ? "-" : rs1.getString("WeeklyOff") ;
   suppliercode= (rs1.getString("SupplierCode") == null || rs1.getString("SupplierCode").equalsIgnoreCase("") ) ? "-" : rs1.getString("SupplierCode") ;
   companyname=  (rs1.getString("SupplierName") == null || rs1.getString("SupplierName").equalsIgnoreCase("") ) ? "-" : rs1.getString("SupplierName") ;
   fax=(rs1.getString("Fax") == null || rs1.getString("Fax").equalsIgnoreCase("") ) ? "-" : rs1.getString("Fax") ;
   mobile=(rs1.getString("Mobile") == null || rs1.getString("Mobile").equalsIgnoreCase("") ) ? "-" : rs1.getString("Mobile") ;
   country=(rs1.getString("Country") == null || rs1.getString("Country").equalsIgnoreCase("") ) ? "-" : rs1.getString("Country") ;
   state=(rs1.getString("State") == null || rs1.getString("State").equalsIgnoreCase("") ) ? "-" : rs1.getString("State") ;
   designation=(rs1.getString("Designation") == null || rs1.getString("Designation").equalsIgnoreCase("") ) ? "-" : rs1.getString("Designation") ;
   areacode=(rs1.getString("AreaCode") == null || rs1.getString("AreaCode").equalsIgnoreCase("") ) ? "-" : rs1.getString("AreaCode") ;
   alternateno=(rs1.getString("ResidencePhoneNo") == null || rs1.getString("ResidencePhoneNo").equalsIgnoreCase("") ) ? "-" : rs1.getString("ResidencePhoneNo") ;
   GSTIN=(rs1.getString("GSTINNo") == null || rs1.getString("GSTINNo").equalsIgnoreCase("") ) ? "-" : rs1.getString("GSTINNo") ;
   
   //flag=true;
   

   out.print("<input type='hidden' name='scontperson"+i+"' id='scontperson"+i+"' value='"+contact+"'>");  
   out.print("<input type='hidden' name='scity"+i+"' id='scity"+i+"' value='"+city+"'>");  
   out.print("<input type='hidden' name='saddress"+i+"' id='saddress"+i+"' value='"+address+"'>");
   out.print("<input type='hidden' name='szip"+i+"' id='szip"+i+"' value='"+zip+"'>");
   out.print("<input type='hidden' name='semail"+i+"' id='semail"+i+"' value='"+email+"'>");
   out.print("<input type='hidden' name='sphone"+i+"' id='sphone"+i+"' value='"+phone+"'>");
   out.print("<input type='hidden' name='swebsite"+i+"' id='swebsite"+i+"' value='"+website+"'>");
   out.print("<input type='hidden' name='sproduct"+i+"' id='sproduct"+i+"' value='"+product+"'>");
   out.print("<input type='hidden' name='sweeklyoff"+i+"' id='sweeklyoff"+i+"' value='"+weeklyoff+"'>");
   out.print("<input type='hidden' name='suppliercode"+i+"' id='suppliercode"+i+"' value='"+suppliercode+"'>");
   out.print("<input type='hidden' name='companyname"+i+"' id='companyname"+i+"' value='"+companyname+"'>");
   out.print("<input type='hidden' name='sfax"+i+"' id='sfax"+i+"' value='"+fax+"'>");
   out.print("<input type='hidden' name='smobile"+i+"' id='smobile"+i+"' value='"+mobile+"'>");
   out.print("<input type='hidden' name='scountry"+i+"' id='scountry"+i+"' value='"+country+"'>");
   out.print("<input type='hidden' name='sstate"+i+"' id='sstate"+i+"' value='"+state+"'>");
   out.print("<input type='hidden' name='sdesignation"+i+"' id='sdesignation"+i+"' value='"+designation+"'>");
   out.print("<input type='hidden' name='sareacode"+i+"' id='sareacode"+i+"' value='"+areacode+"'>");
   out.print("<input type='hidden' name='salternateno"+i+"' id='salternateno"+i+"' value='"+alternateno+"'>");
   out.print("<input type='hidden' name='sGSTIN"+i+"' id='sGSTIN"+i+"' value='"+GSTIN+"'>");
   
   
   
   
   
   
   buffer+="<tr><td><a href='#' onClick='getsupplierDetails("+i+");'  style='color: black;'>"+rs1.getString("SupplierName").replaceAll("(?i)","<font color=blue><u>"+"</u></font>")+"</a></tr></td>";
   i++;
   
}
buffer+="</table></div>";
out.println(buffer);


} catch(Exception e) {  }
finally
{
	con1.close();
}
%>