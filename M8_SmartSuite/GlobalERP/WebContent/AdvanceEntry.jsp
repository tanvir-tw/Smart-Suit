<%@ page language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="moreservlets.listeners.*" errorPage="" %>
<link href="css/ERP.css" rel="stylesheet" type="text/css"></link>
 <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<style type="text/css">@import url(jscalendar-1.0/calendar-blue.css);</style>
<%@ page import = "java.io.FileNotFoundException"%>
<%@ page import = "java.io.FileOutputStream"%>
<%@ page import = " java.io.IOException"%>
<%@ page import="javax.activation.*" %>
<%@ page import=" java.text.DecimalFormat"%>
<html> 
<link rel="stylesheet" href="calendar/datepicker.css">


<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">  

<body onkeypress="hideList(event);" onclick="hideOnClick();">

<%@ include file="header.jsp"%>
<%!
Connection con1;
%>
<% 
DecimalFormat df2 = new DecimalFormat(".##");


String purpose=request.getParameter("purpose");
String customer=request.getParameter("cust");
String amount=request.getParameter("amount");


String category=request.getParameter("cat");




double d=Double.parseDouble(amount);
//System.out.println("--------"+df2.format(d));

DecimalFormat df= new DecimalFormat("0.00");
System.out.println("VALLUE IS"+df.format(d));
String famount=df.format(d);
System.out.println("FIBAL VALUE::"+famount);





StringBuffer sb=new StringBuffer(customer.replace("-HO", ""));
String CustName=sb.toString();
System.out.println("Without HO"+CustName);






String behalf=request.getParameter("bhalf");
String logname=session.getAttribute("EmpName").toString();
System.out.println("Behalf of"+behalf);

System.out.println("logname:"+logname);


System.out.println("hello"+behalf);

if(behalf.equals("Select"))
{
	behalf=" - ";
}

Class.forName(DB_Driver);
con1 = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);

String date=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new Date());

 
Statement st1=null;
Statement st3=null;
Statement st2=null;

st1=con1.createStatement();
st2=con1.createStatement();
st3=con1.createStatement();
//AdvanceClaimMaster
String qury="Insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AdvanceClaimMaster(Category,Amount,Purpose,CustomerName,EntryBy,EntryDate,BehalfOf)Values('"+category+"','"+famount+"','"+purpose+"','"+CustName+"','"+logname+"','"+date+"','"+behalf+"')";
System.out.println(qury);
int j=st1.executeUpdate(qury);
String srno11="select * from "+session.getAttribute("CompanyMasterID").toString()+"AdvanceClaimMaster order by srno desc limit 1";
ResultSet rssrno11=st3.executeQuery(srno11);
int srno123=0;

if(rssrno11.next())
{
	srno123=rssrno11.getInt("SrNo");
}
else
{
	srno123=1;
}


//AdvanceClaimMasterHistory
String query="Insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AdvanceClaimMasterHistory(MasterSrNo,Category,Amount,Purpose,CustomerName,EntryBy,EntryDate,BehalfOf)Values("+srno123+",'"+category+"','"+famount+"','"+purpose+"','"+CustName+"','"+logname+"','"+date+"','"+behalf+"')";

int i=st2.executeUpdate(query);
%>
<%@ include file="footer_new.jsp"%>
<% 
if((i>0)&&(j>0))
{
	 out.println("<script type=\"text/javascript\">");
	   out.println("swal('Advance Request Accepted ','','success');");
	   
	  // swal("Good job!", "You clicked the button!", "success");
	   out.println("location='AdvanceClaimReport.jsp';");
	   out.println("</script>");
}





%>
 

</jsp:useBean>


</body>
</html>

