<%@ page language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="moreservlets.listeners.*" errorPage="" %>
<link href="css/Fleetview.css" rel="stylesheet" type="text/css"></link>
<style type="text/css">@import url(jscalendar-1.0/calendar-blue.css);</style>
<%@ page import = "java.io.FileNotFoundException"%>
<%@ page import = "java.io.FileOutputStream"%>
<%@ page import = " java.io.IOException"%>
<%@ page import="javax.activation.*" %>
<link rel="stylesheet" href="calendar/datepicker.css">
<script type="text/javascript" language="javascript" src="calendar/behaviors.js"></script> 
<jsp:useBean id="centconn" class="FormToolConnection.FormToolConn" scope="page">
<script>
</script>
<%
Connection con1 = null;
Statement stdynamicdrop = null;
Statement st = null,stmt=null,stmt1=null,stmt2=null,stmt3=null,stmt4=null,stmt5=null;
String datenew1="",datenew2="",datenew3="";
datenew1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
datenew3=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date());
datenew2=datenew1;
centconn.getConnection();
int count=0;
%>
<%
con1=centconn.ReturnConnection();
stdynamicdrop=con1.createStatement();
stmt = con1.createStatement();
stmt1 = con1.createStatement();
stmt2 = con1.createStatement();
stmt3 = con1.createStatement();
stmt4 = con1.createStatement();
stmt5 = con1.createStatement();
String sqlinsert="";
String value0=request.getParameter("element_3_1"); String value1=request.getParameter("element_3_2"); String value2=request.getParameter("element_3_3"); String value3=request.getParameter("element_3_4"); String value4=request.getParameter("element_3_5"); String value5=request.getParameter("element_3_6"); String value6=request.getParameter("element_3_7"); String value7=request.getParameter("element_3_8"); String value8=request.getParameter("element_3_9"); String value9=request.getParameter("element_3_10"); 
String value10=request.getParameter("element_3_11");
String value11=request.getParameter("element_3_12");
String value12=request.getParameter("element_3_13");
String value13=request.getParameter("element_3_14");
String value14=request.getParameter("element_3_15");
    String contact_id =request.getParameter("contact_id");
    System.out.println("sqlinsert:-value15value15value15"+contact_id);
    ResultSet rs2;
    
    
    
    String sql2="select * from db_GlobalERP.UserMaster  where Empcode='"+session.getAttribute("EmpCode").toString()+"'";
    rs2=stmt5.executeQuery(sql2);

   while(rs2.next()){
   	
   	String EmpName=rs2.getString("EmpName");
   	
   	//Sign=rs_email2.getString("Signature");
   	//Email1=rs_email2.getString("email");

    
    
    
    
if(request.getParameter("CustOfType").equals("Customer"))
{
 sqlinsert="UPDATE db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"contactdet SET salesCustomerCode='"+request.getParameter("customercode")+"',contactperson='"+value0+"',designation='"+value1+"',Address='"+value2+"',country='"+value3+"',state='"+value4+"',city='"+value5+"',zipcode='"+value6+"',email='"+value7+"',phone='"+value8+"',mobileno='"+value9+"',fax='"+value10+"',Email1='"+value11+"',Email2='"+value12+"',mobileno1='"+value13+"',mobileno2='"+value14+"',EntryBy='"+EmpName+"' where salescustomercode="+request.getParameter("customercode")+"  and contact_id="+request.getParameter("contact_id")+"";
 System.out.println("sqlinsert:-"+sqlinsert);
}else{
	 sqlinsert="UPDATE db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"contactdet SET CustomerCode='"+request.getParameter("customercode")+"',contactperson='"+value0+"',designation='"+value1+"',Address='"+value2+"',country='"+value3+"',state='"+value4+"',city='"+value5+"',zipcode='"+value6+"',email='"+value7+"',phone='"+value8+"',mobileno='"+value9+"',fax='"+value10+"',Email1='"+value11+"',Email2='"+value12+"',mobileno1='"+value13+"',mobileno2='"+value14+"',EntryBy='"+EmpName+"' where customercode="+request.getParameter("customercode")+" and contact_id="+request.getParameter("contact_id")+" ";
	 System.out.println("sqlinsert:-"+sqlinsert);
}
try{ 
 count=stmt.executeUpdate(sqlinsert);
 System.out.println("sqlinsert:-"+sqlinsert);
 String isclose=request.getParameter("isclose");
 System.out.println("isclose:-"+isclose);
 String redirectString="";
 if(request.getParameter("CustOfType").equals("Customer"))
 {
 	System.out.println("Ready To redirect to Customer");
 	if(isclose.equalsIgnoreCase("true")){
 		redirectString="alert.jsp?msg=Record Saved Successfully&goto=close.jsp";
 	}else{
 		redirectString="contactdetails.jsp?Type=Customer&save=yes&customercode="+request.getParameter("customercode")+"&companyname="+request.getParameter("companyname");
 	}
 	
 	response.sendRedirect(redirectString);
 }
 else
 {
 	
 	if(isclose.equalsIgnoreCase("true")){
 	
 		redirectString="alert.jsp?msg=Record Saved Successfully&goto=close.jsp";
 	}else{
 		redirectString="contactdetails.jsp?Type=Prospect&save=yes&customercode="+request.getParameter("customercode")+"&companyname="+request.getParameter("companyname");
 	}
 	System.out.println("Ready To redirect to Prospects");
 	response.sendRedirect(redirectString);
 }
 }catch(Exception e){
    e.printStackTrace();
    out.println("Exception occure while insert data:-"+e);
}


  if(count==1)
   {%>
 <!-- <script>
alert("Data Saved Sucessfully...");
 </script> -->
     <%//response.sendRedirect("addcontact.jsp?inserted=yes");}else{
       %>
       <!-- <script>
alert("Data Not Saved...");
 </script> -->
     <%
      } 
   }

%>
<table border="0" width="400" align="center" class="sortable_entry">
<tr>
<td>
<!--1,1-->
</td>
</tr>
</table>
</jsp:useBean>
<%-- <%@ include file="footernew.jsp" %> --%>