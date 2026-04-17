<%@ page language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="moreservlets.listeners.*" errorPage="" %>
<style type="text/css">@import url(jscalendar-1.0/calendar-blue.css);</style>
<%@ page import = "java.io.FileNotFoundException"%>
<%@ page import = "java.io.FileOutputStream"%>
<%@ page import = " java.io.IOException"%>
<%@ page import="javax.activation.*" %>
<%-- <jsp:useBean id="centconn" class="FormToolConnection.FormToolConn" scope="page"> --%>
<%@ include file="conn.jsp"%>

<%
Connection con1 = null;
Class.forName(DB_Driver);
con1 = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
Statement stdynamicdrop = null;
Statement st1 = null,st = null,stmt=null,stmt1=null,stmt2=null,stmt3=null,stmt4=null,stmt5=null;
String datenew1="",datenew2="",datenew3="";
datenew1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
datenew3=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date());
datenew2=datenew1;
//centconn.getConnection();
int count=0;
%>
<%
//con1=centconn.ReturnConnection();

stdynamicdrop=con1.createStatement();
stmt = con1.createStatement();
stmt5 = con1.createStatement();
stmt1 = con1.createStatement();
stmt2 = con1.createStatement();
stmt3 = con1.createStatement();
stmt4 = con1.createStatement();
st1 = con1.createStatement();
String sqlinsert="";
String value0=request.getParameter("element_3_1"); String value1=request.getParameter("element_3_2"); String value2=request.getParameter("element_3_3"); String value3=request.getParameter("element_3_4"); String value4=request.getParameter("element_3_5"); String value5=request.getParameter("element_3_6"); String value6=request.getParameter("element_3_7"); String value7=request.getParameter("element_3_8"); String value8=request.getParameter("element_3_9"); String value9=request.getParameter("element_3_10"); String value10=request.getParameter("element_3_11");
String value11=request.getParameter("element_3_12");
String value12=request.getParameter("element_3_13");
String value13=request.getParameter("element_3_14");
String value14=request.getParameter("element_3_15");
ResultSet rs2,rs1;
String CompName="";
String type12="";
String Code="";
String EmpName="";
String comptype="";

 String sql2="select * from db_GlobalERP.UserMaster  where Empcode='"+session.getAttribute("EmpCode").toString()+"'";
 rs2=stmt5.executeQuery(sql2);

while(rs2.next()){
	
 EmpName=rs2.getString("EmpName");
	
	//Sign=rs_email2.getString("Signature");
	//Email1=rs_email2.getString("email");

}
String customercode=request.getParameter("customercode");

//String sql1="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where CompanyName='"+request.getParameter("companyname")+"' and customercode="+customercode+"";
String sql="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where CompanyName='"+request.getParameter("companyname")+"' and customercode="+customercode+" ";
ResultSet rs3=stmt5.executeQuery(sql);
System.out.println("sysyout:-----"+sql);
while(rs3.next())
{
	//CompName = rs3.getString("CompanyName");
	//type12 = rs3.getString("SalesCustomerCode");
	//Code= rs3.getString("CustomerCode");
}
/* if(type12.equals("0") || type12=="0")
{
	  comptype ="Prospect";
	 // custcode = rs.getString("CustomerCode");
}
else	
{
	   comptype ="Customer";
	  // custcode = rs.getString("SalesCustomerCode");
} */

String comptype1=request.getParameter("Type");
 CompName=request.getParameter("Type");
 Code=request.getParameter("customercode");
if( comptype1.equals("Customer"))
{
 sqlinsert="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"contactdet (companyname,salesCustomerCode,contactperson,designation,Address,country,state,city,zipcode,email,phone,mobileno,fax,Email1 ,Email2 ,mobileno1,mobileno2,EntryBy) values('"+CompName+"','"+Code+"','"+value0+"','"+value1+"','"+value2+"','"+value3+"','"+value4+"','"+value5+"','"+value6+"','"+value7+"','"+value8+"','"+value9+"','"+value10+"','"+value11+"','"+value12+"','"+value13+"','"+value14+"','"+EmpName+"')";
 System.out.println("sqlinsert:---------------customer"+sqlinsert);
}
else
{
	sqlinsert="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"contactdet (companyname,customercode,contactperson,designation,Address,country,state,city,zipcode,email,phone,mobileno,fax,Email1 ,Email2 ,mobileno1,mobileno2,EntryBy) values('"+CompName+"','"+Code+"','"+value0+"','"+value1+"','"+value2+"','"+value3+"','"+value4+"','"+value5+"','"+value6+"','"+value7+"','"+value8+"','"+value9+"','"+value10+"','"+value11+"','"+value12+"','"+value13+"','"+value14+"','"+EmpName+"')";
	System.out.println("sqlinsert123:-----------------prospect"+sqlinsert);
}
try{ 
 count=stmt.executeUpdate(sqlinsert);
 }catch(Exception e){
    e.printStackTrace();
    out.println("Exception occure while insert data:-"+e);
}

String isclose=request.getParameter("isclose");
System.out.println("isclose:-"+isclose);
String redirectString="";
if( comptype1.equals("Customer"))
{
	System.out.println("Ready To redirect to Customer");
	if(isclose.equalsIgnoreCase("true")){
		redirectString="alert.jsp?msg=Record Saved Successfully&goto=javascript:history.back()";
	}else{
		redirectString="contactdetails.jsp?Type=Customer&save=yes&customercode="+type12+"&companyname="+request.getParameter("companyname");
	}
	
	response.sendRedirect(redirectString);
}
else
{
	
	if(isclose.equalsIgnoreCase("true")){
	
		redirectString="alert.jsp?msg=Record Saved Successfully&goto=javascript:history.back()";
	}else{
		redirectString="contactdetails.jsp?Type=Prosp&save=yes&customercode="+Code+"&companyname="+request.getParameter("companyname");
	}
	System.out.println("Ready To redirect to Prospects");
	response.sendRedirect(redirectString);
}

%>
