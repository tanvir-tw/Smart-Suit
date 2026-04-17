<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@page import="com.ConnectionClass"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
</head>
<body>
<%
Connection con = null;
Statement  st1=null, st2=null;
try {
 ConnectionClass connection = new ConnectionClass();
	 con = connection.getConnect("db_leaveapplication");
	System.out.println("con :::::::::::::::::: " + con);

    
    st1 = con.createStatement();
    st2 = con.createStatement();

} catch (Exception e) {
    e.printStackTrace();
}
%>

<%
ResultSet rs1=null,rs=null;
String sql1="",sql="";
boolean flag=false;
String buffer="",hodname="";
String empName=request.getParameter("hodname");

	sql1="SELECT *  from t_leaveadmin where  Status='Yes' and Name like ('%"+empName+"%') order by Name limit 20 ";

  System.out.println("Emp name **********  ******       "+sql1);
  rs1=st1.executeQuery(sql1);
   buffer="<div style='height:120px;width:275px;overflow:auto; '><table style='background-color:white; width:400px; display: block';>";
 int i=1;
	 while(rs1.next())
	   {
		 hodname=  (rs1.getString("Name") == null || rs1.getString("Name").equalsIgnoreCase("") ) ? "-" : rs1.getString("Name") ;
		   out.print("<input type='hidden' name='hodname"+i+"' id='hodname"+i+"' value='"+hodname+"'>");
		   buffer+="<tr><td><a href='#' onClick='getsupplierDetails("+i+");'  style='color: black;'>"+rs1.getString("Name").replaceAll("(?i)","<font color=blue><u>"+"</u></font>")+"</a></tr></td>";
		   i++;
	   } 
   buffer+="</table></div>";
   System.out.print("buffer"+buffer);

out.print(buffer);

%>