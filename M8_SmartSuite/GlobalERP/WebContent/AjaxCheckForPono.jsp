<%@page import="java.io.Flushable" import="java.util.Date"%>
<%@ include file="conn.jsp" %>

<%!
Connection con1;
%>

<% 
session.setAttribute("flag","pono");
try 
{
Class.forName(DB_Driver);
con1 = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
Statement stmt1=con1.createStatement();
ResultSet rs1=null;
String sql1="";
String newstring="";
boolean flag=false;
int element=99; 
String pono=request.getParameter("pono");
System.out.println("*&&&&&&&&&&&******&&&&&&&&&&&&*  "+pono);

int k;
int counter=0;
  sql1="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"purchaseorder where PONO='"+pono+"' ";
  System.out.println("><><><><   ????????"+sql1);
  rs1=stmt1.executeQuery(sql1);

 if(rs1.next())
  {
	 System.out.println("IN IF   ");
	  out.println("Yes");
  }else{
	  out.println("No");
  }
	  

}
catch(Exception e)
{ 
  
}
finally
{
  con1.close();
}
%>