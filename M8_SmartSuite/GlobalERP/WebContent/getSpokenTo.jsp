<%@page import="java.io.Flushable"%>
<%@ include file="conn.jsp" %>
<%!
Connection con1;
%>

<% 
try 
{
Class.forName(DB_Driver);
con1 = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
Statement stmt1=con1.createStatement();
ResultSet rs1=null;
String sql1="";
String p_code="",SpokenToi = "";
String company=request.getParameter("company");
//String company=session.getAttribute("flag").toString();
System.out.println("*&&&&&&&&&&&***getSpokenTo***&&&&&&&&&&&&*  "+company);

//System.out.println("IN SQL Query CONDOTIOn-------");
  
	  sql1="SELECT SpokenTo from "+session.getAttribute("CompanyMasterID").toString()+"followup where ProspCustName = '"+company+"' and SpokenTo != '' and SpokenTo != '-' order by `FollowUpDate` desc , `FollowUpTime` desc limit 1";  
  //    System.out.println("**************************************"+sql1);

  //System.out.println("><><><><   ????????"+sql1);
	//newstring="select replace('sql1',' ','')";	
  rs1=stmt1.executeQuery(sql1);
  //System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");

  while(rs1.next())
  {
  SpokenToi = rs1.getString("SpokenTo");
  }   
out.print(SpokenToi);   
   
} catch(Exception e) { 
out.print("");
}
finally
{
	con1.close();
}
%>